# Workflow documents read, and what they were worth

Kept so a later session does not reread a document that has not moved, and knows which ones were no use
here. A version is the first ten characters of the file's git blob hash (`git hash-object` in the collection
root) and its modification time. When either differs, reread what the "Read" column says was read, not
everything. "Full" means every line; "Partly" names the lines; "Headings" means only the outline.

Read on 2026-09-28. **The protocol documents are no longer in the monorepo's history**: they live in
`vbardales/Rimworld-protocols` (git dir `../rimworld-protocols.git`, work tree the monorepo root), and a
plain `git log -1 -- AUDIT.md` from the monorepo returns the commit that deleted it, a plausible hash for the
opposite of what is wanted. The log column below was taken with
`git --git-dir=../rimworld-protocols.git --work-tree=. log -1`; three of these files were uncommitted (`M`)
when read, so their blob is the working copy, not that commit.

| Document | Version | Read | Worth | Note |
|---|---|---|---|---|
| `AGENTS.md` | `bb4c08c1e4`, 2026-09-24 08:33, log `3a1d2cb` | Full | Useful | Gate order (settings, translations, `preTest`), evidence retention, publication by CI. |
| `AUDIT.md` | `e9a564da92`, 2026-09-28 11:24, uncommitted | Full | Essential | The chain, the transition criteria, step 12 (the audit goes back down), the session title, `done` needs Pickle **written** and `tested` needs it **run**. Read once, in full, for this session. |
| `PUBLISHING.md` | `323eccec04`, 2026-09-28 08:41, log `95c6dfd` | Full | Essential | Start from the original's repository when it has one (it does not, see `ATTRIBUTION.md`), `0.1.0` prepublication, the tag and release are the CI's, `.dds` and Explorer icons, commit hygiene. Skip the GitHub topics and social-preview section unless publishing. |
| `MOD_SETTINGS.md` | `a61cd54192`, 2026-09-13 00:46, log `b83933b` | Full | Useful once | Only the "no settings" branch applies: verify no empty page and no shortcut. |
| `TRANSLATIONS.md` | `fac8188128`, 2026-09-25 19:19, log `f5c2d9d` | Full | Useful once | The plural rule (2026-09-25) has nothing to bite on here: the mod shows no count. Only the DefInjected paths matter. |
| `STYLE_RIMWORLD.md` | `f64a8fa446`, 2026-09-27 21:24, uncommitted | Lines 1-210 and 340-514 (211-339 not reread: seen only in an older version on 2026-09-12) | Partly useful | About generating the preview and the icon, which nothing here does. Useful: the icon is a control and never a generation, the palette JSON and the 268 px check, Explorer folder icons. |
| `WORKSHOP_COMMENTS.md` | `06ba4a692f`, 2026-09-28 11:26, uncommitted | Full | Not yet | Needed at `prepublished`. Already `posted`: Vanilla Cooking Expanded (2134308519, covered from Flavor Text Extended - Français), so nothing new goes there; the original author's page (2257175849) has no row. |
| `scripts/SEARCHING.md` | `45f0fa13cc`, 2026-09-27 21:14, uncommitted | Lines 1-46 and headings | Not useful | A corpus search tool. One `grep` over the two installed items answered the only question this mod had. |
| `PickleTools/README.md` | `495a6ba602`, 2026-09-25 19:37, log `c771bef` | Full | Useful | The table of shared step tools and how a pass map names them. |
| `PickleTools/docs/steps.md` | `5817e28d17`, 2026-09-28 10:31, log `96eda0f` | Partly (lines 1-140, and the LoadAudit, TextureOwner and ExpansionSteps tables) | Useful | The suite uses Pickle's own vocabulary, which is **not** in the collection: it is on GitHub (`RimWorks/Rimworld-Pickle`, `Docs/steps.md`, fetched 2026-09-28, 602 lines). |
| `PickleTools/Authoring/README.md` | `a6e3e2eac0`, 2026-09-26 22:38, log `8d3ca6d` | Lines 1-140 of 321 | Essential for the suite | Layout of `Tests/Pickle`, the pass matrix, what deserves a running game. Sections after the fold (restarts, evidence, sound) unread. |
| `PickleTools/Headless/README.md` | `c023a674fb`, 2026-09-26 22:52, log `ed4e73a` | Lines 1-130, 195-230, 383-404 of 509 | Useful | Launcher options and exit codes, filter terms, the pass-map trailing newline trap, what happens to a report. Not read: the lock, restart tests, hang at shutdown, traps. Read before the first run. |
| `LoadAudit/README.md` | not hashed | Lines 1-80 | Essential for `01-load` | The step that reads the game log from startup and sees a cross-reference that never resolved. |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `347a0d63b9`, 2026-09-26 23:20, log `3c03f51` | Full | Not yet | Needed before any workflow, tag, release or Steam secret. It says the CI creates the tag and the release; a `v1.0.0` made by hand already exists here. |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `1bdd1eed63`, 2026-09-27 23:25, log `77ca9d7` | Full | Useful | Filter terms, `-DepMap`, submitting a request instead of launching, no `Explorer` icons or `.ico` inside `Mod/`. |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `7ab5e437d4`, 2026-09-26 18:18, log `d07b2b8` | Full | Useful | Every option of `Submit-PickleRun.ps1`, `-EvidenceDir` semantics, exit codes. |

Repository files read on 2026-09-28: `STATUS.md`, `README.md`, `CHANGELOG.md`, `ATTRIBUTION.md` (opening),
`TESTS.md` (the campaign, lines 1-236), `Mod/About/About.xml`, the four Defs files, the recipes and the
French DefInjected samples, `scripts/Test-CandyRecipes.ps1` (opening), `.gitignore`. Not present in this
repository: `PUBLICATION.md`, `BACKLOG.md`, `NOTES.md`, `BUGS.md`. `docs/runs/history.md` and `TESTING.md` were
created on this date; `Tests/Pickle/` was created on this date.

The Ticket Dispatcher keeps its own list in its `docs/DOCS_READ.md`. Not read this session, as not asked for:
`PickleTools/Elsewhere/`, `PickleTools/Release/README.md`, `PickleTools/Upstream/`.

## Not useful here, and what should make me reread it

| Document | Reread when |
|---|---|
| `scripts/SEARCHING.md` | a question needs the whole corpus (who else declares a defName, a class, a texture path). Even then, ask first: the owner banned every search on 2026-09-17 because of her plan, and that includes a pipe into grep. |
| `STYLE_RIMWORLD.md` | a Preview or ModIcon is regenerated, resized or checked at 32 px, or an Explorer icon is remade. Lines 211-339 were not reread this time. |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | anything touches a workflow, a tag, a release, a dry-run or a Steam secret: the `prepublished` step, and the removal of the hand-made `v1.0.0`. |
| `WORKSHOP_COMMENTS.md` | thank-you comments are drafted, at `prepublished`. |
| `MOD_SETTINGS.md`, `TRANSLATIONS.md` | the mod gains code, a setting, a Keyed string or a displayed count. The XML-only, no-text-through-a-key case is settled. |
| `PickleTools/Headless/README.md` (the unread parts) | before the first run is submitted. |
