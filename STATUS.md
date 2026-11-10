---
localization: complete
translation_en: complete
translation_fr: complete
settings_audit: not_applicable
mod:          Halloween Monster Mash Renew (unofficial)
packageId:    nelim.halloweenmonstermash
repo:         Rimworld-Halloween-Monster-Mash-Renew
remote:       https://github.com/vbardales/Rimworld-Halloween-Monster-Mash-Renew.git
local_path:   C:\Users\nelim\Documents\rimworld\HalloweenMonsterMashRenew
visibility:   public
detached:     yes
workflow_stage: playTests[1.0.0]
licence:      silent
port_licence: MIT (port additions only; see LICENSE)
licence_at:   upstream ships no LICENSE, and its Steam description says nothing about reuse
upstream_mod_remotes: N/A
upstream_repository: none; no source link on the Steam page, no .git in the download, no GitHub result (read 2026-09-28, searched again 2026-10-02: only this repo)
dependencies: declared: Vanilla Cooking Expanded; optional: Vanilla Plants Expanded (MayRequire on HMM_Make_SpiderBites + loadAfter, option B, 2026-09-28)
showcase:     complete
automated_tests: Tests/Rule-OwnValues.ps1 (former Test-CandyRecipes) and Check-XmlFields, -ConfigErrors, -DefRefs, -DefInjected rerun green 2026-10-13 at 41743a9 (66 keys, 34 defs, 0 errors); Check-DefInjected notes that the French keys of the guarded recipe are not in a gated folder; Check-DefRefs is blind to ingredient-filter categories
pickle_suite: written 2026-09-28 (Tests/Pickle, 11 features, 57 scenarios, 5 passes of which 4 written), vocabulary checked offline, never run
tested_on:    2026-10-25 (RimWorld 1.6, Pickle in WSL; Mod/ behavior unchanged since 41743a9, only images at 9b1233c and docs after; English sans-facultatifs initial 49 of 54, avec-vpe 50 of 54, avec-props-as-style 4 of 4, 03b-mask-facings ticket 2f08 4 of 4, French only partial: fr-labels 49 of 57 with the 3 English labels red by design; captures of 03b opened 2026-10-31; nothing played by a person)
workshop:     3806767867 (private, created 2026-09-23 by the 0.1.0 prepublication; not public, not tested)
remaining:
  - unverified: the Steam page still carries the 0.1.0 description, which says Vanilla Plants Expanded is unused; corrected in About.xml at dd3224e, reaches Steam only through the CI's update_description or a hand edit
  - unverified: French keys of HMM_Make_SpiderBites have no def to attach to without Vanilla Plants Expanded; Check-DefInjected says they should sit in a gated folder (a LoadFolders.xml, which this mod dropped on purpose); 01-load passed without VPE, the game logged nothing from the mod, so the warning is not observed
  - blocking (done -> tested): door 1, no scenario in @wip: MET, 0 of 61 written scenarios carry the tag
  - blocking (done -> tested): door 2, every conditional scenario has run: per docs/runs/history.md all six ran green on 2026-10-12 to 2026-10-14 (01-load, spider bites cooking with VPE, four Props as Style textures); MET by 03b-mask-facings: ticket 2f08 (sans-facultatifs, 2026-10-25), 4 of 4 passed, exitReason passed, report minified in Tests/Pickle/Evidence/facings (RELEASE.md written) and logged in docs/runs/history.md; its 4 manual screenshots (@review) opened 2026-10-31, facings correct (8.d done for 03b; the other @review captures are not checked); Player.log of that run lost to the minify before reading
  - blocking (done -> tested): door 3, no manual test left to validate: NOT MET; TF-01, 02, 04, 05 are Pickle and ran green, TF-06 not applicable; open: mask facings (03b written, unrun), the child subcase (needs Biotech), sweet stacks at 1, 25 and 75 (no step places a stack at a known cell), an older save holding HMM items, French menu layout, Props as Style's own styles (its repository)
  - French pass: the sans-facultatifs French run stalled (watchdog, 36 of 54), but fr-labels (2026-10-12, French game, 57 scenarios) played 49 passed, 3 red by design (English labels), 5 skipped, kept in Tests/Pickle/Evidence/fr-labels; 01-load and 07-save-reload are green in French and in English (avec-vpe), so the log check of 8.i is covered by LoadAudit and "no errors were logged"
  - "do not load with the original" (11-incompat-original, ticket df42, run 2026-11-03, read 2026-11-10): passed 1 of 1, 0 log findings, but the original (KD.HalloweenMonsterMash) was "incompatible version" and dropped by the game, so no coexistence proof; the run is in Tests/Pickle/Parked/incompat-original with its RELEASE.md; About.xml declares no incompatibleWith, none needed while the original does not load on this version
  - unverified: @review captures never opened, logs never read (mandatory for tested)
  - code review 8.m done 2026-10-31 (Opus sub-agent, whole Mod/ since the first commit): no blocking defect; fixed the About.xml sentence on the mask slot and the French "des draps" typo (3cf315d); open, low: brain cakes take the whole AnimalProductRaw category (eggs, fertilized eggs) while the recipe says sugar and milk, to settle in game or with the owner; ChatGPT review of FRENCH_REVIEW.md 2026-10-31 (page 1 of 1): applied the hockey mask word order and the candy corn "préparation" (with "Elle comble" agreement), diff read, review sha moved to 750734e (revue du diff: texte français seul); declined as faithful to the English: "vous donne l air" in ten mask descriptions and "votre âme" on the reaper; French text changed since Virginie review of 2026-10-11, Virginie read "des draps blancs", the hockey mask and the candy corn lines in FRENCH_REVIEW.md and validated the French review on 2026-10-31 at 750734e
  - 1.7 diagnostic e505 (2026-11-10, read): 20 of 21 passed; the 1 red is a vanilla bill scenario (BlocksSandstone, likely 10 ticks/s on 1.7, PiT); the 21 scenarios do not include this mod features, so HMM is NOT proven on 1.7; tested_1_7 stays empty; run in Tests/Pickle/Parked/diag-17; cause: no -Filter ran the Pickle own 31-feature suite first and hit the 120 min cap before this mod suite; refiled 2026-11-10 as ticket 20261110-112446-525-42ea (1.7, suite name filter, !@lang-fr, !11-incompat-original, sans-facultatifs map, evidence Tests/Pickle/Inbox/diag-17b) at 767cec8
  - waiting (2026-11-10): Audit stamps the Tests/Rule-OwnValues.ps1 row of scripts/LOCAL_SCRIPTS.md (no action here)
  - replay 2026-11-10 open: 8.c (08-labels-fr not rerun after the French edits of 2026-10-31), 8.d (only the 03b captures opened), 8.g, 8.i, 8.k; open outside the chain: Tests/Test-Mod.ps1 + Rule-OwnValues.ps1 conversion (converted 2026-11-10: Tests/Rule-OwnValues.ps1 replaces the deleted Test-CandyRecipes.ps1, references fixed); Translation audit and Settings audit sections absent (records live in STATUS.md only)
  - unverified: 1.0.0 needs the prepublished-stage work (PUBLICATION.md with the description source and change note, thank-you drafts, gallery, dry-run of the exact SHA) before any publish
code_review_sha: 750734e518a6e4045420a3e763702ad8ff15d4d8
session:      4d536aaf-96f0-461c-b97c-4a62e7d1e98b
updated:      2026-11-10, replay-audit: stage playTests unchanged, first open 8.c; 1.7 diagnostic ticket e505 queued (owner order); session code HMM
protocols_read_sha: 355ead251709e5b8cd51ba404e8d9d490a8253c4
---

# Halloween Monster Mash Renew - status

Lives at the root of the mod, never inside `Mod/`, so the Workshop uploader never receives it.
This thread maintains it.

## Audit against AUDIT.md - 2026-10-11 (current decision)

**`workflow_stage: playTests[1.0.0]`** (old `done`). 7.g met (French review below). Transitions 1 to 7 checked against files and reruns today:
setupRepo to l10n acquired, detail in `docs/runs/status-history-to-2026-10-02.md`; 4 dependencies declared (Vanilla Cooking Expanded hard, Vanilla Plants Expanded `MayRequire` + `loadAfter`); 5 `settings_audit: not_applicable`, justified; 6 66 keys EN/FR, `FRENCH_REVIEW.md` generated by the shared script.
7.b and 7.c rerun 2026-10-11, green: `Test-CandyRecipes` (now Tests/Rule-OwnValues.ps1), `Check-XmlFields`, `Check-DefInjected` (66 keys, 0 errors; note on the guarded recipe stays), `Check-DefRefs` (only `VCE_Fruit` unresolved without Plants Expanded: expected, the recipe is guarded). 7.d Pickle suite written, never run.
French review: Virginie, 2026-10-11, on 576cafd: no pawn agreement; six corrections applied (cake pops eyes, brain cakes and murder buns number, ghosts, skeleton, Día de los Muertos) plus two CHANGELOG fixes; `translation_fr: complete`.
Done today: shared `Render-Preview.cjs` replaces the local copy (deleted, README updated); history of this file folded into `docs/runs/status-history-to-2026-10-02.md`.
Pickle 2026-10-12: sans-facultatifs EN 49 passed, 0 failed, 5 skipped (`docs/runs/history.md`); `01-load` green (guard works without VPE). FR, avec-vpe and avec-props-as-style tickets queued.
Pickle avec-vpe 2026-10-12: 50 passed, 0 failed, 4 skipped; spider bites cooked, guard confirmed both ways. French pass 0dea stalled (watchdog), `@lang-fr` rerun queued.
Open: `Tests/Pickle/Check-Steps.ps1` verdict (PickleTools session); `Mod/About/ModIcon.png` and `Preview.png` carry uncommitted regenerated images (Preview work). Scenarios now in `TEST_SCENARIOS.md`. Next: initial Pickle ticket (nothing has ever run).

## Why `licence: silent`

The field describes the debt owed upstream, not this repository's own terms. Killer_Diller
published no licence and the mod has not moved since 13 October 2020, so the source is dead and
silent. The `LICENSE` at the root is MIT and covers the port work alone.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source, `alive`
no licence but a living source, `forbidden` a written refusal, `original` owing nothing to anyone.

## Repository location

One remote, `origin`, at https://github.com/vbardales/Rimworld-Halloween-Monster-Mash-Renew.
Detached from the `Documents/rimworld` monorepo on 2026-09-12.

## Preview source migration - 2026-10-03

Preview generation now uses the shared renderer with `Art/Preview.config.json`. Canonical sources and publishable outputs were preserved; transient QA belongs in ignored `Art/.render/`.

## Translation audit

Where the translations live: English is the source side, carried by the Def values themselves (`label`, `description`, recipe and job strings in `Mod/Defs/`); no Keyed text, no code. French ships in `Mod/Languages/French/DefInjected/` (`RecipeDef/Recipes_Candy.xml`, `ThingDef/Candy.xml`, `ThingDef/Decorations.xml`, `ThingDef/Masks.xml`), 66 keys, 0 missing against English (`Check-Translations`, `Check-DefInjected`, 2026-11-10). Known note: the French keys of the guarded `HMM_Make_SpiderBites` have no def to attach to without Vanilla Plants Expanded and sit in the ungated folder (no `LoadFolders.xml`, dropped on purpose); the game logged nothing from the mod without it.

- Virginie, 2026-10-11, revision 576cafd: no pawn agreement needed; six corrections applied (cake pops eyes, brain cakes and murder buns number, ghosts, skeleton, Dia de los Muertos) plus two CHANGELOG fixes.
- Virginie, 2026-10-31, revision 750734e: read "des draps blancs", the hockey mask and the candy corn lines in `FRENCH_REVIEW.md` (now `TRANSLATION_REVIEW.md`) and validated the French review; ChatGPT review of the same day applied (hockey mask word order, candy corn "préparation" with "Elle comble" agreement), declined as faithful to the English: "vous donne l'air" in ten mask descriptions and "votre âme" on the reaper.
