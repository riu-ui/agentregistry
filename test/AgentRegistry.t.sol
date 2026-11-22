// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/AgentRegistry.sol";

/// @notice Agent ID mock with controllable balances, so both the holder
///         path and the non-holder revert can be tested. The production
///         MockAgentID (balanceOf always 1) cannot express a non-holder.
contract MockAgentIDControlled {
    mapping(address => uint256) public balances;

    function setBalance(address who, uint256 bal) external {
        balances[who] = bal;
    }

    function balanceOf(address who) external view returns (uint256) {
        return balances[who];
    }
}

/// @notice Stand-in project contract: any address with code works as a
///         submitted projectContract.
contract Dummy {}

contract AgentRegistryTest is Test {
    AgentRegistry public registry;
    MockAgentIDControlled public agentId;
    Dummy public projectA;
    Dummy public projectB;

    address public holder1 = address(0xA11CE);
    address public holder2 = address(0xB0B);
    address public nonHolder = address(0xBAD);

    function setUp() public {
        agentId = new MockAgentIDControlled();
        agentId.setBalance(holder1, 1);
        agentId.setBalance(holder2, 1);
        agentId.setBalance(nonHolder, 0);
        registry = new AgentRegistry(address(agentId));
        projectA = new Dummy();
        projectB = new Dummy();
    }

    /// @dev Build an ASCII string of exactly n bytes.
    function _s(uint256 n) internal pure returns (string memory) {
        bytes memory b = new bytes(n);
        for (uint256 i; i < n; i++) b[i] = "x";
        return string(b);
    }

    function _submitAs(address who, address proj) internal returns (uint256) {
        vm.prank(who);
        return registry.submitProject(
            "M3MO Genesis", proj, "NFT",
            "NFT Genesis; 1 gratis per Agent ID.", "https://m3m3agent.uk", "M3M3AGENT"
        );
    }

    // ------------------------------------------------------------------
    // submitProject — happy path
    // ------------------------------------------------------------------

    function test_SubmitSucceeds() public {
        uint256 id = _submitAs(holder1, address(projectA));
        assertEq(id, 0);
        assertEq(registry.projectCount(), 1);
        assertTrue(registry.isListed(address(projectA)));
        (string memory name, address pc, string memory cat, string memory desc,
         string memory site, string memory x, address submitter,
         uint256 up, uint256 fl, uint256 createdAt) = registry.getProject(0);
        assertEq(name, "M3MO Genesis");
        assertEq(pc, address(projectA));
        assertEq(cat, "NFT");
        assertEq(desc, "NFT Genesis; 1 gratis per Agent ID.");
        assertEq(site, "https://m3m3agent.uk");
        assertEq(x, "M3M3AGENT");
        assertEq(submitter, holder1);
        assertEq(up, 0);
        assertEq(fl, 0);
        assertGt(createdAt, 0);
    }

    function test_SubmitEmitsEvent() public {
        vm.expectEmit(true, true, false, true, address(registry));
        emit AgentRegistry.ProjectSubmitted(0, holder1, "M3MO Genesis", address(projectA));
        _submitAs(holder1, address(projectA));
    }

    function test_TwoProjectsDistinctIds() public {
        uint256 id0 = _submitAs(holder1, address(projectA));
        uint256 id1 = _submitAs(holder2, address(projectB));
        assertEq(id0, 0);
        assertEq(id1, 1);
        assertEq(registry.projectCount(), 2);
        (, address pc1,,,,,,,,) = registry.getProject(1);
        assertEq(pc1, address(projectB));
    }

    // ------------------------------------------------------------------
    // submitProject — gating and validation
    // ------------------------------------------------------------------

    function test_SubmitNonHolderReverts() public {
        vm.prank(nonHolder);
        vm.expectRevert("Agent ID required");
        registry.submitProject("M3MO Genesis", address(projectA), "NFT", "d", "https://m3m3agent.uk", "M3M3AGENT");
    }

    function test_SubmitDuplicateReverts() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder2);
        vm.expectRevert("already listed");
        registry.submitProject("Other Name", address(projectA), "NFT", "d", "https://example.com", "X");
    }

    function test_SubmitEOAReverts() public {
        address eoa = address(0xE0A);
        assertEq(eoa.code.length, 0);
        vm.prank(holder1);
        vm.expectRevert("not a contract");
        registry.submitProject("Name", eoa, "NFT", "d", "https://example.com", "X");
    }

    function test_SubmitZeroAddressReverts() public {
        vm.prank(holder1);
        vm.expectRevert("zero contract");
        registry.submitProject("Name", address(0), "NFT", "d", "https://example.com", "X");
    }

    function test_SubmitEmptyNameReverts() public {
        vm.prank(holder1);
        vm.expectRevert("bad name");
        registry.submitProject("", address(projectA), "NFT", "d", "https://example.com", "X");
    }

    function test_SubmitNameTooLongReverts() public {
        vm.prank(holder1);
        vm.expectRevert("bad name");
        registry.submitProject(_s(61), address(projectA), "NFT", "d", "https://example.com", "X");
    }

    function test_SubmitNameAtLimitSucceeds() public {
        vm.prank(holder1);
        uint256 id = registry.submitProject(_s(60), address(projectA), "NFT", "d", "https://example.com", "X");
        assertEq(id, 0);
    }

    function test_SubmitCategoryLimitsRevert() public {
        vm.prank(holder1);
        vm.expectRevert("bad category");
        registry.submitProject("Name", address(projectA), "", "d", "https://example.com", "X");
        vm.prank(holder1);
        vm.expectRevert("bad category");
        registry.submitProject("Name", address(projectA), _s(25), "d", "https://example.com", "X");
    }

    function test_SubmitDescriptionTooLongReverts() public {
        vm.prank(holder1);
        vm.expectRevert("description too long");
        registry.submitProject("Name", address(projectA), "NFT", _s(201), "https://example.com", "X");
    }

    function test_SubmitWebsiteTooLongReverts() public {
        vm.prank(holder1);
        vm.expectRevert("website too long");
        registry.submitProject("Name", address(projectA), "NFT", "d", _s(121), "X");
    }

    function test_SubmitXTooLongReverts() public {
        vm.prank(holder1);
        vm.expectRevert("x too long");
        registry.submitProject("Name", address(projectA), "NFT", "d", "https://example.com", _s(41));
    }

    function test_ConstructorZeroAgentIdReverts() public {
        vm.expectRevert("zero agent id");
        new AgentRegistry(address(0));
    }

    // ------------------------------------------------------------------
    // signal — happy path
    // ------------------------------------------------------------------

    function test_SignalUpvote() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder1);
        registry.signal(0, false, 0);
        assertTrue(registry.hasSignaled(0, holder1));
        (,,,,,,, uint256 up, uint256 fl,) = registry.getProject(0);
        assertEq(up, 1);
        assertEq(fl, 0);
    }

    function test_SignalFlagWithReason() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder2);
        registry.signal(0, true, 2); // 2 = scam
        (,,,,,,, uint256 up, uint256 fl,) = registry.getProject(0);
        assertEq(up, 0);
        assertEq(fl, 1);
    }

    function test_SignalEmitsEvent() public {
        _submitAs(holder1, address(projectA));
        vm.expectEmit(true, true, false, true, address(registry));
        emit AgentRegistry.Signaled(0, holder1, true, 1); // 1 = farm
        vm.prank(holder1);
        registry.signal(0, true, 1);
    }

    function test_TwoHoldersTwoSignals() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder1);
        registry.signal(0, false, 0);
        vm.prank(holder2);
        registry.signal(0, false, 0);
        (,,,,,,, uint256 up, uint256 fl,) = registry.getProject(0);
        assertEq(up, 2);
        assertEq(fl, 0);
    }

    // ------------------------------------------------------------------
    // signal — gating and validation
    // ------------------------------------------------------------------

    function test_SignalDoubleReverts() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder1);
        registry.signal(0, false, 0);
        vm.prank(holder1);
        vm.expectRevert("already signaled");
        registry.signal(0, false, 0);
    }

    function test_SignalFlagWithoutReasonReverts() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder1);
        vm.expectRevert("reason mismatch");
        registry.signal(0, true, 0);
    }

    function test_SignalUpvoteWithReasonReverts() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder1);
        vm.expectRevert("reason mismatch");
        registry.signal(0, false, 1);
    }

    function test_SignalBadReasonReverts() public {
        _submitAs(holder1, address(projectA));
        vm.prank(holder1);
        vm.expectRevert("bad reason");
        registry.signal(0, true, 4);
    }

    function test_SignalNoProjectReverts() public {
        vm.prank(holder1);
        vm.expectRevert("no project");
        registry.signal(99, false, 0);
    }

    function test_SignalNonHolderReverts() public {
        _submitAs(holder1, address(projectA));
        vm.prank(nonHolder);
        vm.expectRevert("Agent ID required");
        registry.signal(0, false, 0);
    }

    function test_GetProjectNoProjectReverts() public {
        vm.expectRevert("no project");
        registry.getProject(99);
    }
}
