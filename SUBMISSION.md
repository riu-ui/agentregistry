# Agent Registry — DoraHacks Submission Pack (ready to paste)

Hackathon: **Binance Wallet × BNB Chain Agent ID Hackathon**
Submit at: https://dorahacks.io/hackathon/agent-id-hackathon/detail
Deadline: **9 December 2026, 08:00 UTC (15:00 WIB)**. No separate registration.
Note: the hackathon announcement does not publish a submission form link.
Watch the official Binance Wallet / BNB Chain channels for the submission
channel during the submission period. The form had not appeared as of
21 Nov 2026.

---

## Project name

Agent Registry

## Tagline (one-liner)

Holder-curated directory of Agent ID ecosystem projects — one Agent ID,
one signal; the community ranks what's real and flags what's farm or scam.

## Description (paste into the project description field)

**The problem.** 100,000+ Agent IDs were claimed by 26 Oct 2026, and the
ecosystem is flooded with Agent ID-gated NFT, pass, and token projects.
Community reporting says most auto-minted output is worthless, and holders
have no trusted signal for what deserves attention — or gas — before they
mint. The usual defences (allowlist snapshots, social tasks, server-side
checks) are off-chain and gameable.

**The solution.** Agent Registry is a community-curated directory of Agent
ID ecosystem projects on BNB Chain. Agent ID holders submit projects (name,
BSC contract address, category, short description, website, X handle) and
signal on them: upvote what's real, flag what's farm, scam, or
dead/abandoned. One Agent ID equals one signal per project, enforced
on-chain. The website ranks projects by score (upvotes minus flags) with
status filters (Trusted / Flagged / Contested / Unrated), a contributor
leaderboard, per-project signal history, and deep links — so any holder can
see community signal at a glance before spending gas on a mint.

**How Agent ID is used.** Agent ID is not decoration here — it *is* the
access-control layer. Both `submitProject` and `signal` require
`balanceOf(msg.sender) > 0` on the official SPACE ID Agent ID contract
(`0x60b9262456de011f7d15a54cdd8c48baaa8b022f`, ERC-721, non-transferable,
one per user). That makes curation sybil-resistant by design: one person,
one signal per project, with no allowlist and no off-chain check. The
frontend resolves a typed `.ai` name on-chain (`ownerOfHandle` + `balanceOf`)
for the holder check; a typed name alone proves nothing — the real check
happens on-chain at transaction time, and the page says so.

**Trust by design.** The contract holds no funds and has NO owner powers:
no mint, no pause, no tax, no freeze, no withdrawal, no upgrade. Listing
rules are enforced on-chain: one entry per contract address (duplicates
rejected) and the submitted address must contain deployed code (plain
wallets rejected). Flag reasons (farm / scam / dead-abandoned) are recorded
in the `Signaled` event.

**No wallet connection — on purpose.** The site never connects a wallet.
Research across the Agent ID ecosystem (Pocket Ai, AETHER, Horror Protocol,
Mintu Bots, Cretivox, AgentBoss) showed the norm is read-only pages plus an
agent prompt, because Binance Agentic Wallets (MPC) cannot connect to
third-party websites at all — and most visitors leave a page that asks to
connect, fearing a drain. So this site hands the visitor a copy-paste prompt
(exact contract, function, arguments, value 0, "show the preview first,
execute only after I approve") for their own AI agent, which sends the
transaction from the visitor's wallet. Every transaction is still signed
and confirmed by the user in their own wallet.

**Status.** Fully deployed and working on BNB Smart Chain mainnet (not a
mockup): contract deployed 19 Nov 2026, source verified on Sourcify (exact
match) and on BscScan, website live on GitHub Pages. Foundry test suite:
**26/26 passing** (holder gate, submit validation, duplicate/code checks,
signal rules, reason enforcement, events). Seeding is underway: a verified
shortlist of 10 Agent ID ecosystem projects is ready (see
`seed-candidates.md`), with the first test submit in progress at the time of
writing — the directory is being filled project by project, each submit a
separate gas-only transaction from an Agent ID holder's wallet.

## How to try it

1. Open the site: https://riu-ui.github.io/agentregistry/
2. Browse the directory, filters, leaderboard, and per-project signal history
   (read-only, no wallet needed).
3. To submit or signal: type your Agent ID (e.g. `yourname.ai`) in the
   "Your Agent ID" box, tap "Check my Agent ID" to verify it on-chain, then
   tap "Get agent prompt" (submit form) or Upvote / Flag on a project card.
   Copy the prompt to your AI agent (Binance AI Pro or any agent with the
   Binance Agentic Wallet skill). The agent shows the transaction preview
   first and executes only after you approve. Value 0 — gas only.
4. Every submit and signal is a public on-chain transaction on the registry
   contract; the site's activity feed and leaderboard update from chain events.

## Contract addresses (BNB Smart Chain)

- Agent Registry: `0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a`
- Agent ID NFT (official, by SPACE ID for Binance Wallet): `0x60B9262456De011F7d15a54CdD8c48BAAA8b022F`

## Links to paste

- Website: https://riu-ui.github.io/agentregistry/
- Contract (BscScan): https://bscscan.com/address/0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a
- Verified source (Sourcify, exact match): https://repo.sourcify.dev/56/0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a
- GitHub repository: https://github.com/riu-ui/agentregistry
- Deploy tx: https://bscscan.com/tx/0x815a2d086c0f9f592d30fb6d53f971852dfeddab8239d83f441dd55d5363fb00
- Contract source (raw): https://raw.githubusercontent.com/riu-ui/agent-registry/main/contracts/AgentRegistry.sol

## Tech stack

Solidity 0.8.24 (self-contained, no external imports), Foundry (tests +
build), single-file HTML/ethers.js frontend (no backend, no database),
deployed via Remix + OKX Wallet, hosted free on GitHub Pages.

## Safety red-line compliance (for the judges)

- No web QR login, no session storage, no orders on behalf of users.
- Every transaction is signed and confirmed by the user in their own wallet.
- No asset transfers at all: the contract never receives or sends funds.
- Contract is open-source; owner permissions (none) are disclosed above.
- No Binance/BNB branding in the name, token, or domain.
- No collection of seed phrases, private keys, API secrets, or pairing codes.
- No promised returns, no "passive income" language anywhere.
- Not a name-lookup tool: only the caller's own Agent ID balance is read.
- Scores are labeled on-site as community signals, not safety guarantees.

## Reaching 30 interacting Agent ID holders (Innovation eligibility)

The Innovation Award requires at least 30 distinct Agent ID addresses
interacting with the contract during the submission period. Plan:

1. Seed the registry with 10–15 verified Agent ID ecosystem projects
   (submissions from the owner's own Agent ID wallet, one gas-only tx each).
2. Post the registry on X from @jejeyezi and invite holders to upvote/flag
   (gas only, no capital needed — matching what the research showed most
   holders can afford).
3. Re-post the ranking as it fills in; each signal is one interacting
   address toward the 30. Submit the Community Promotion survey with the
   post link (#BinanceWalletHackathon + #AgenticWallet).

## What remains before 9 Dec 2026, 15:00 WIB

- [ ] Finish seeding the directory (first test submit in progress, then the
      remaining 9 from the verified shortlist).
- [ ] Reach 30 interacting Agent ID addresses (X post + promotion survey +
      holder outreach).
- [ ] Submit this pack on DoraHacks the moment the submission form appears.
