# Agent Registry

A directory of Agent ID projects, curated by the people who hold an Agent ID. One Agent ID, one signal.

<p>
  <img src="https://img.shields.io/badge/Sourcify-verified%20exact%20match-brightgreen" alt="Sourcify verified, exact match">
  <img src="https://img.shields.io/badge/Chain-BNB%20Smart%20Chain-F0B90B" alt="BNB Smart Chain">
  <img src="https://img.shields.io/badge/Hackathon-Binance%20Agent%20ID%20Hackathon-blue" alt="Binance Wallet x BNB Chain Agent ID Hackathon">
  <img src="https://img.shields.io/badge/Solidity-0.8.24-363636" alt="Solidity 0.8.24">
  <img src="https://img.shields.io/badge/Tests-26%2F26%20passing-brightgreen" alt="26/26 Foundry tests passing">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
</p>

**Live site:** https://agentregistry.netlify.app/
**Contract:** [`0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a`](https://bscscan.com/address/0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a) (BNB Smart Chain)
**Verified source:** [Sourcify, exact match](https://sourcify.dev/server/v2/contract/56/0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a)

## Why I built this

More than 200,000 Agent IDs have been claimed. Dozens of projects now gate something behind an Agent ID: a free mint, a token, a launchpad round. Most of the auto-minted stuff is worthless, and there is no place that tells you which projects are real and which ones are farming fees.

I built a directory where the holders themselves do the sorting. If you hold an Agent ID, you can list a project and you can signal on it. Upvote what is real. Flag what is farm, scam, or dead. The ranking is just upvotes minus flags. No team decides the list. No one can pay to be on top.

## How it works

Anyone can read the directory. Only Agent ID holders can change it.

**Submit a project.** A holder lists a project with its name, its BSC contract address, a category, a short description, a website, and an X handle. The contract checks three things on-chain: the submitter holds an Agent ID, the contract address actually holds code, and the project is not already listed. One project can only be listed once.

**Signal on a project.** A holder gets one signal per project. Upvote, or flag it as farm, scam, or dead. Your signal is tied to your Agent ID, so one person cannot flood a project with votes from many wallets.

**Ranking.** Score is upvotes minus flags. Projects get a status from their signals:

- Trusted: score +3 or more, and at least 70% upvotes
- Flagged: more flags than upvotes
- Contested: mixed signals
- Unrated: fewer than 3 signals

The site also shows a contributor leaderboard, a signals-per-day chart, recent activity, and per-project signal history. All of it is read from on-chain events. There is no database and no backend.

## What this is not

There is no owner. The contract has no owner, no pause, no upgrade, and no fee. It holds no funds and there is no withdraw function, so it cannot take your money. It does not ask for approvals. Every interaction costs gas only.

The site never connects to a wallet. This is deliberate. Agentic Wallets cannot connect to third-party websites at all, and a connect button on a page like this only scares people. So there is no connect button. You type your Agent ID, the page checks on-chain that it exists, and it writes you a prompt. You paste that prompt to your own AI agent, and your agent sends the transaction from your wallet. The contract checks on-chain that the wallet holds an Agent ID before it accepts anything.

## How to use it

As an Agent ID holder:

1. Open the [live site](https://agentregistry.netlify.app/) and go to Submit a project.
2. Type your Agent ID and tap Check my Agent ID. The page verifies it on-chain.
3. Pick a project from the quick-add list below, or fill in the form yourself. The quick-add list is verified projects that are ready to be listed. One tap fills the form and opens the prompt.
4. Copy the prompt and paste it to your AI agent (Binance AI Pro or any agent with the Binance Agentic Wallet skill). It shows you the transaction preview first and only sends after you approve.
5. Once the project is listed, tap Upvote or Flag on its card to signal. That also goes through a prompt to your agent.

As a visitor, just browse. Search, filter by status and category, sort by score or flags, open a project to see its signal history and links.

## Quick-add: verified projects ready to list

These are real projects I checked by hand. Each one has a contract with code on BSC, a readable official website, and a verifiable X account. They are candidates, not listings. A project only becomes listed when a holder submits it.

"Verified" means the source is verified on Sourcify. "Live" means the contract code was confirmed on-chain but the source is not verified yet.

| Project | Contract | Category | Website | X | Contract |
|---|---|---|---|---|---|
| M3MO Genesis | `0x08BE8a0727b6fc801171c1F4F4Dd547EA44Ca339` | NFT | https://m3m3agent.uk | @M3M3AGENT | Verified |
| THE WALL | `0xa804bBBe09fa2F5832d11D09329cc4230D1d7899` | NFT | https://thewall-agentic.xyz | @thewall_agentic | Live |
| SnakeAgentNFT | `0xf7c1ba2286cee6eef10cc264664168fd015127b1` | NFT | https://snakegameio.online | @snakegameionft | Live |
| DogePunk | `0xea404392be487b90f45b8436a52623bc7dbd8515` | NFT | https://dogepunk.site | @dogepunkk | Verified |
| GETAGENT ($GETA) | `0x233188403A5301220cc40f47446628d722e00F6c` | Token | https://getagent-bnb.web.app | @GetAgentBNB | Live |
| AGC (Agentic Coin) | `0x6288DFe86f22B53eEB6886aE2D78941de7483743` | Token | https://agcc.fun | @Agentic_coin | Verified |
| Riftera | `0x36fE923C449F6163a601058626dEf6c83a8f23AE` | NFT | https://riftera.net | @RifteraPixel | Verified |
| PACTURE | `0x95AF9fe16fE5c1741b5E3F1b3b045a8c2470eca9` | Fair Mint | https://pacture.pvpmint.com | @WAGAgent | Verified |
| Agentic Gangster | `0x0a2a07ef09dd7d83e2312476f0588abaa3e34ce3` | NFT | https://agentic-gangster.pages.dev | @agenticgangster | Verified |
| Flap | `0xe2cE6ab80874Fa9Fa2aAE65D277Dd6B8e65C9De0` | Launchpad | https://flap.sh | @flapdotsh | Verified |
| 1% Club | `0xEcBd1e3e415427c11873BED75042a2E5Ef0f88a0` | NFT | https://onepercentclub-c5h.pages.dev | @theOnePctClub | Live |
| Agent (AGENT) | `0xA2643B889eEb232708a644f15f70f951773dDEF9` | Token | https://agentbnbai.com | @Agentbnbai | Verified |
| Agent Legends | `0x5690B34dA3eFc5d55511c37A0Ad4988CACE8d912` | NFT | https://agent.agentlegends.workers.dev | @agent_legends | Verified |
| Agent Periodic Lab | `0xfE5Ab5ce9b1D86a55d70E7D0573a14D559029C18` | NFT | https://build-100.com/lab | @BUILD100 | Verified |
| AgentBond | `0x9611f8A6E9890E47A2ddAa3eA7604fa94A5cE76d` | Launchpad | https://agentbond-launchpad.vercel.app | @agentbond_fun | Verified |
| AgentLabs SPEC | `0x639329f5dc4317c44D9Fed961a1217ba845012F7` | Game | https://agentlabs.fun | @agentlabnb | Verified |
| Brushborn | `0x5d43566e40E2e6D396EC10224363E5cAcFc40Cf0` | NFT | https://brushborn.pages.dev | @BrushbornBNB | Verified |
| Everything Is Mine | `0x1fccfab61461c4b5c4d1b16580d12a7e32012baa` | NFT | https://everythingisfine.website/ | @basebirdevery | Verified |
| Floppy Agents | `0x8F1E4787f131990d793Af253d118aed7Fe1B29AF` | NFT | https://floppymarket.surge.sh | @Floppyagents | Verified |
| GLOOP | `0x183CBb52B3C7BCB2433d50dE0Add99B59f4DE4fE` | NFT | https://gloopagent.xyz | @GloopSlimeHQ | Verified |
| Hackou AI Pass | `0x1e107C43b542eF0d4153d67C1c1a887be60FE3EE` | NFT | https://hackou.com | @HackouTW | Verified |
| HI-SCORE / 1UP | `0xA74081fd9bc9623A2d9321223C35b41016A7fd65` | NFT | https://insert1up.fun | @INSERT1UP | Verified |
| Lodepass | `0x31b074C8e77e44F29df285F19d4fc76E6D927d01` | NFT | https://lodepass.github.io/lodepass | @lodepass | Live |
| MOLT AGENT | `0x4B8150f1a258cD3CE2300fAf682432c52ca48Fc1` | NFT | https://moltagent.pages.dev | @0xadamonly | Verified |
| Oathbots | `0xb777c52296f0d7d3c5cab7ae0c1aaac6b014b256` | NFT | https://oathbots.pages.dev | @Oathbots | Verified |
| Relic Miners | `0x618c3907e548618F2C61061AaF5f33cbBd63F610` | NFT | https://agentforge-b9n.pages.dev | @RelicMiners | Verified |
| Wise Owl Society | `0x1cf9e60218493149ACe7DC953497c07175aa625e` | NFT | https://wiseowlsociety.xyz | @wiseowlsociety | Verified |
| F0B90B | `0xa5d6ed5a0b50F97e94Cfc13618da24EEF8d28Cce` | NFT | https://f0b90b.pages.dev/ | @F0B90Bclub | Verified |

28 projects now. The list keeps growing: new verified projects are added daily. Nothing enters the list without the contract, website, and X checks above.

## Status

Honest status, 22 November 2026: the directory holds 2 projects on-chain, M3MO Genesis (#0) and DogePunk (#1). No signals have been cast yet. The quick-add list holds 27 verified candidates, 19 of them with audit scores from 22 November 2026. Eight candidates are still unaudited. The site shows empty states when there is nothing to show. It does not show fake listings or sample data when it is live.

The goal is 30 Agent ID holders interacting with the directory before the hackathon closes on 9 December 2026, 15:00 WIB. That is the number the Innovation track asks for, and it is also the number that makes the curation real. One holder seeding alone is not curation.

## The contract

`AgentRegistry.sol` is 135 lines, Solidity 0.8.24, MIT, no dependencies. The constructor takes one argument: the Agent ID contract address.

- `submitProject(string name, address projectContract, string category, string description, string website, string xHandle)` returns the project id. Only Agent ID holders. Limits: name 1 to 60 chars, category 1 to 24, description up to 200, website up to 120, X handle up to 40. The project contract must hold code and must not already be listed.
- `signal(uint256 projectId, bool flagged, uint8 reason)` records one signal per Agent ID per project. Reason 0 is an upvote. Reasons 1, 2, and 3 are farm, scam, and dead. The reason is stored in the `Signaled` event.
- Events: `ProjectSubmitted` and `Signaled`. Everything the site shows comes from these events.
- There are no owner functions. No one can pause it, upgrade it, edit a listing, or take funds out of it. The contract never holds funds in the first place.

Deployed 19 November 2026 on BNB Smart Chain:

| | |
|---|---|
| Contract | [`0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a`](https://bscscan.com/address/0x7f99d9157E32E525F3A93c3b7CB3C09aaC8c525a) |
| Deploy tx | [`0x815a2d086c0f9f592d30fb6d53f971852dfeddab8239d83f441dd55d5363fb00`](https://bscscan.com/tx/0x815a2d086c0f9f592d30fb6d53f971852dfeddab8239d83f441dd55d5363fb00) |
| Block | 134365690 |
| Deploy cost | 0.0000865 BNB (about $0.05) |
| Agent ID contract | [`0x60b9262456de011f7d15a54cdd8c48baaa8b022f`](https://bscscan.com/address/0x60b9262456de011f7d15a54cdd8c48baaa8b022f) (SPACE ID Agent ID) |

Verification: Sourcify exact match on creation and runtime, and verified on BscScan. Deployed compiler v0.8.34+commit.80d5c536, optimizer off, EVM version osaka, single file. You can read the source in `contracts/` and compare it yourself.

## Project logos

Each project card shows the project's own logo when I have one bundled, and falls back to a coloured letter tile when I don't. The logos live in `logos/` (256x256 PNG) and are mapped by contract address in `PROJECT_LOGOS` near the top of the main script in `index.html`. To add a logo for a new listing: save the project's real logo (its site header, favicon, or hero art — never a guess) as `logos/<slug>.png`, add one line to `PROJECT_LOGOS`, and run the logo test.

I deliberately did not add a favicon fallback (fetching `<website>/favicon.ico` or a favicon service at render time). Both live listings prove why: M3MO's favicon only exists as an inline data URI (`/favicon.ico` is a 404) and DogePunk's site has no favicon at all (`/favicon.ico` returns the app HTML). A runtime favicon lookup would add a slow third-party request to every card and still end at the letter tile most of the time.

Current logos: M3MO Genesis (green robot mascot, from the m3m3agent.uk favicon) and DogePunk (pixel punk Doge hero art, from dogepunk.site).

## Audit scores and the Mint prompt

Some listings carry an audit score from Nina, the mint radar that audits free mints on BSC. The score is a snapshot from the audit date, not live data. A project with no score shows "not audited yet". A missing score is never shown as zero. Nineteen of the 27 projects carry a score so far; the other eight have not been audited yet.

The score sits next to the project name, with the free mint status beside it: open, closed, or sold out. The first two listings scored 60/100 CAUTION on 22 November 2026. That is below the 65 auto-mint band, and it is not a recommendation to mint. The Mint button sits next to the CAUTION badge on purpose. It opens an agent prompt, the same way submit and signal do. The prompt holds the exact contract address, the mint function, the arguments, and the value. Your agent checks that your wallet holds an Agent ID, shows the preview first, and only sends after you approve.

A Mint button only appears when the audit proves the free mint function with certainty. A sold out project shows "Sold out" instead. No mint function is ever guessed. New scores drop into the `AUDITS` object in `index.html` as one entry each. No code change is needed.

A project only joins the verified list when it has a contract with code on BSC, a readable official website, and a verifiable official X account. A project without a real X account does not get in. Antopia scored 82/100 in the audit but has no official X, so it stays off the list.

## Tests

Foundry suite, 26/26 passing. It covers the holder gate, submitting (happy path and events), duplicate and zero-address reverts, non-holder reverts, every field limit, the constructor, upvotes and flags, double-signal reverts, reason mismatch, bad reason, and signalling a project that does not exist.

```bash
forge install foundry-rs/forge-std --no-git   # once, into lib/
forge test
```

## Repository layout

```
contracts/AgentRegistry.sol   the registry contract (self-contained, no imports)
test/AgentRegistry.t.sol      Foundry tests (26/26 passing)
index.html                    the whole site: one static file, ethers inlined, no backend
logos/                        bundled project logos (256x256 PNG, mapped in PROJECT_LOGOS)
og-image.png                  social preview image (1200x630)
SUBMISSION.md                 hackathon submission pack, ready to paste
build_preview.py              builds a widget preview of the site (dev tool)
preview-widget.html           the widget preview output (dev tool)
```

The site is a single static page. It reads BSC through public RPCs and never sends anything anywhere except those reads. There is no analytics and no tracking.

## Built for the Agent ID Hackathon

This was built for the Binance Wallet x BNB Chain Agent ID Hackathon. Submissions close 9 December 2026, 08:00 UTC. Agent ID is not decoration here. It is the whole access control of the product: only holders can list, only holders can signal, and one ID means one signal.

The submission pack (description, links, compliance notes, and the plan to reach 30 interactions) is in [SUBMISSION.md](SUBMISSION.md). The official announcement is [here](https://www.binance.com/en/support/announcement/detail/95f5dbe0ea674a48a739b59e046648bf).

## License

MIT. See [LICENSE](LICENSE).
