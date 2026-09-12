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
  - unverified: never seen running
session:      4d536aaf-96f0-461c-b97c-4a62e7d1e98b
updated:      2026-09-12, showcase engraved
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

## What the four unreadable fields mean here

- **`stage: done`** — complete and untested. The run in game is not a manufacturing step; it is
  said by `tested_on` and `workshop`.
- **`tested_on`** — empty. Never launched.
- **`dependencies: declared`** — Vanilla Cooking Expanded is the single dependency, named in
  `modDependencies` and in `loadAfter`. The two other Vanilla Expanded mods upstream declared are
  referenced by none of its defs and were dropped.
- **`remaining`** — one `unverified` line, and it is the only one.

## Why `licence: silent`

The field describes the debt owed upstream, not this repository's own terms. Killer_Diller
published no licence and the mod has not moved since 13 October 2020, so the source is dead and
silent. The `LICENSE` at the root is MIT and covers the port work alone.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source, `alive`
no licence but a living source, `forbidden` a written refusal, `original` owing nothing to anyone.

## Repository

One remote, `origin`, at https://github.com/vbardales/Rimworld-Halloween-Monster-Mash-Renew.
Detached from the `Documents/rimworld` monorepo on 2026-09-12.
