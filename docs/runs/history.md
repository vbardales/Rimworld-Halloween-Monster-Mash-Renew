# Run history

One text line per run, newest last: date, revision, what ran, verdict. Evidence itself stays on disk in
`Tests/Pickle/Evidence/` and `evidence/`, both ignored by git; this file is what git keeps. A line about a
superseded revision proves nothing about the current one. No run in a game has taken place yet.

2026-09-28 79fd997 offline Check-XmlFields.ps1 PASS 5 files, no unknown 1.6 field
2026-09-28 79fd997 offline Check-ConfigErrors.ps1 PASS 34 of 34 defs, 26 rules, no config error (offline subset of the game's rules, not a Unity run)
2026-09-28 79fd997 offline Check-DefRefs.ps1 PASS 30 defs, 4 parents, no unresolved reference, BUT BLIND: it does not resolve ingredient-filter categories, VCE_Fruit and a bogus VCE_Bogus both pass; the category is defined only by Vanilla Plants Expanded
2026-09-28 79fd997 offline Check-DefInjected.ps1 PASS 66 keys, 0 errors
2026-09-28 79fd997 offline Test-CandyRecipes.ps1 PASS six recipes, item counting, ingredients, filters, products, work, both stoves
2026-09-28 79fd997 offline direct resolution of the four filter categories the recipes name: AnimalProductRaw, EggsUnfertilized, Foods found in the game; VCE_Fruit found ONLY in Vanilla Plants Expanded 1.6, in no Vanilla Cooking Expanded file (defect, STATUS.md)
2026-09-28 79fd997 offline Check-XmlClasses.ps1 NOT RUN: mandatory -TypeLists not supplied and the mod names no class (0 Class= attributes, no worker, comp or driver element)
2026-09-28 79fd997 offline Tests/Pickle/Check-Steps.ps1 PASS 11 features, 85 step lines against Pickle 212 patterns (GitHub main, not the staged build) and PickleTools 100; negative control 4 of 4 faults reported
2026-09-28 79fd997 offline Check-TypeRefs.ps1 PASS 5 XML files, 77 element names searched, 0 type references beyond RimWorld and Unity, no unguarded third-party type
