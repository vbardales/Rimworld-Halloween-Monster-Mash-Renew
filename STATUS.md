---
mod:          Halloween Monster Mash Renew
packageId:    nelim.halloweenmonstermashrenew
repo:         Rimworld-Halloween-Monster-Mash-Renew
visibility:   public
detached:     yes
stage:        done
licence:      silent
licence_at:   upstream ships no LICENSE, and its Steam description says nothing about reuse
dependencies: declared
showcase:     complete
tested_on:
workshop:
remaining:
  - unverified: execute TF-01 through TF-10 in game; validate sugar correction with TF-05 and TF-06
session:      4d536aaf-96f0-461c-b97c-4a62e7d1e98b
updated:      2026-09-12, automated XML and recipe checks passed; 10 functional scenarios written, none executed
---

# Halloween Monster Mash Renew — status

Lives at the root of the mod, never inside `Mod/`, so the Workshop uploader never receives it.
This thread maintains it.

## Where the mod stands

Killer_Diller's **[KD] Halloween Monster Mash** carried to 1.6: eleven masks, seven decorations,
six sweets, all keeping their original defNames. XML only, no assembly, no Harmony. Tagged 1.0.0
on 2026-09-11. English and French.

The port is complete and the showcase is done — `Mod/About/Preview.png` and `ModIcon.png`, with
their full-resolution sources kept in `Art/` outside `Mod/`. What is left is the one thing this
repository cannot supply: nobody has watched it run. `tested_on` stays empty and `workshop` stays
empty until then, which is what the changelog already says out loud.

The functional test campaign is written in `TESTS.md`: ten manual scenarios with prerequisites,
steps, expected results and a results table. They cover loading and dependencies, mask crafting
and wearing, protection, decorations, sweet recipes and ingredient restrictions, consumption,
French translation, save/reload, and optional Props as Style integration. Scenario writing is
complete, including updated item-count expectations for TF-05. All ten scenarios remain
unexecuted: the functional test campaign itself is not complete and no in-game pass is claimed.

The six sweet recipes now count items instead of nutrition to address the suspected sugar
blocker. Ingredient numbers, work and output are unchanged, but actual costs change. The
original failure was not reproduced in game. Static checks passed: all nine XML files parse,
and all six recipes retain the expected partner counts, four sugar, ten output items and
450 work, with the nutrition getter removed. These checks do not establish in-game success.

Reproducible automated checks passed on 2026-09-12: the shared
`../scripts/Check-XmlFields.ps1` reports five files with no unknown RimWorld 1.6 fields;
`scripts/Test-CandyRecipes.ps1` verifies all six recipes, including ingredient filters and
both stoves. A temporary copy with nutrition counting restored was rejected as expected.
Commands and prerequisites are documented in TESTS.md. Automated checks are complete for
this recipe change; the manual functional campaign remains pending.

Next: execute TF-01 through TF-10 on RimWorld 1.6, recording any inapplicable optional cases.
Prioritize TF-05 and TF-06 to validate cooking, exact consumption on both stoves, ingredient
restrictions and resumption. Record exact game/mod versions, observations and Player.log in
the TESTS.md results table. Fill tested_on only after an actual game run.

## What the four unreadable fields mean here

- **`stage: done`** — complete and untested. The run in game is not a manufacturing step; it is
  said by `tested_on` and `workshop`.
- **`tested_on`** — empty. Never launched.
- **`dependencies: declared`** — Vanilla Cooking Expanded is the single dependency, named in
  `modDependencies` and in `loadAfter`. The two other Vanilla Expanded mods upstream declared are
  referenced by none of its defs and were dropped.
- **`remaining`** — in-game execution of the written scenarios, including sugar correction
  validation; scenario writing and the code correction are complete.

## Why `licence: silent`

The field describes the debt owed upstream, not this repository's own terms. Killer_Diller
published no licence and the mod has not moved since 13 October 2020, so the source is dead and
silent. The `LICENSE` at the root is MIT and covers the port work alone.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source, `alive`
no licence but a living source, `forbidden` a written refusal, `original` owing nothing to anyone.

## Repository

One remote, `origin`, at https://github.com/vbardales/Rimworld-Halloween-Monster-Mash-Renew.
Detached from the `Documents/rimworld` monorepo on 2026-09-12.
