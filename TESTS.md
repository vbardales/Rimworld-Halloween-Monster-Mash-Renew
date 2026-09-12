# Halloween Monster Mash Renew: what to check in game

## Contrôles automatiques

Depuis la racine du dépôt, avec PowerShell 7 :

```powershell
pwsh -NoProfile -File ../scripts/Check-XmlFields.ps1 -ModPath ./Mod
pwsh -NoProfile -File ./scripts/Test-CandyRecipes.ps1
```

Le premier utilise l'utilitaire partagé du dossier parent `rimworld/scripts` et les
assemblages de RimWorld installés (chemin personnalisable avec `-Managed`). Il ne fait
pas partie de ce dépôt. Le second est autonome et accepte `-ModPath` pour une autre copie.
Il contrôle les six recettes, le comptage par objet, les ingrédients et leurs filtres,
les quantités, les produits, le travail et les deux cuisinières. Un échec termine avec
un code non nul.

Résultats du 2026-09-12 : 5 fichiers sans champ XML inconnu pour RimWorld 1.6 ; six
recettes conformes. Une copie temporaire réintroduisant le getter nutritionnel a été
rejetée comme attendu. Ces contrôles ne remplacent pas une exécution en jeu.

## Campagne de tests fonctionnels

Les scénarios ci-dessous sont à exécuter manuellement sur RimWorld 1.6. **Aucun résultat
en jeu n'est acquis.** Les contrôles statiques et le diagnostic historique détaillés plus bas
ne remplacent pas cette campagne. En particulier, le blocage du sucre décrit au scénario 5
est une hypothèse documentée, non reproduite pendant la rédaction de ces scénarios.

### Préparation

- Utiliser une colonie de test et une copie de toute sauvegarde existante.
- Charger Core, Vanilla Cooking Expanded et ses propres dépendances, puis ce mod.
  Désactiver le mod original. Installer le dossier `Mod/`, pas la racine du dépôt.
- Activer le mode développeur pour préparer les stocks et consulter le journal.
  Désactiver la construction instantanée pour mesurer les consommations et le travail.
- Préparer un adulte disponible, capable de construire, fabriquer et cuisiner ; autoriser
  ces travaux. Rendre les ingrédients accessibles, autorisés et dans le rayon des ordres.
- Relever les versions exactes du jeu et des mods, la langue, les DLC et l'ordre de chargement.
- Pour chaque cas : consigner `Non exécuté`, `Réussi`, `Échoué` ou `Bloqué`, le résultat
  observé et une capture ou un extrait de `Player.log` en cas d'écart.

### TF-01 — Chargement et dépendance

**Préconditions :** configuration de base ci-dessus, sans DLC ni Props as Style.

1. Ouvrir la liste des mods et vérifier le nom, l'icône, la bannière et la dépendance VCE.
2. Redémarrer le jeu avec cette configuration et créer la colonie de test.
3. Consulter le journal, les menus de fabrication et l'onglet Divers.
4. Dans une configuration séparée, désactiver VCE et vérifier l'avertissement de dépendance
   dans la liste des mods ; rétablir ensuite la configuration de base avant de jouer.

**Attendu :** chargement sans erreur imputable à HMM, onze masques, sept décorations et six
recettes disponibles aux ateliers correspondants. L'absence de VCE est signalée ; ce n'est
pas une configuration de jeu supportée.

### TF-02 — Fabrication des onze masques aux trois ateliers

**Préconditions :** aucune recherche ; emplacement de fabrication, établi de couture manuel
et établi électrique alimenté ; au moins 990 tissus pour les 33 fabrications.

1. À chaque atelier, vérifier les onze ordres : diable, clown, sorcière, Frankenstein,
   momie, loup-garou, hockey, crâne, zombie, chat et pirate.
2. Ajouter un ordre « fabriquer une fois » de chaque masque et laisser le colon travailler.
3. Comparer le stock avant/après chaque fabrication et consulter la fiche de l'objet.

**Attendu :** un objet du modèle demandé par ordre, 30 tissus consommés, aucun choix de
matériau ni recherche supplémentaire. Le travail nominal est 1400, pas une durée fixe
en secondes ; la vitesse du colon et de l'atelier intervient. Aucun graphisme manquant.

### TF-03 — Port, orientations et protection

**Préconditions :** onze masques neufs à 100 % de durabilité, adulte sans autre couvre-chef.

1. Forcer le port de chaque masque, puis déplacer le colon au nord, à l'est, au sud et à
   l'ouest pour observer ses quatre orientations ; régler l'affichage des couvre-chefs.
2. Ouvrir la fiche du masque et relever les quatre statistiques de protection.
3. Équiper un chapeau vanilla occupant `Overhead` et `UpperHead`, puis remettre le masque.
4. Avec Biotech actif et un enfant disponible, répéter le port des onze masques.

**Attendu :** rendu correct dans les quatre orientations ; remplacement du couvre-chef
incompatible. Pour chaque masque neuf : armure tranchante 7,2 %, armure chaleur 3,6 %,
isolation froid 1,8 °C et chaleur 0,9 °C. Port autorisé aux adultes et aux enfants.
Sans Biotech, consigner la partie enfant comme non exécutée avec son motif.

### TF-04 — Construction et comportement des sept décorations

**Préconditions :** aucune recherche, 35 bois disponibles, constructeur et sol constructible.

1. Dans Architecte → Divers, placer araignée, fantômes, chauves-souris, squelette,
   faucheuse, arbre et citrouille non éclairée.
2. Laisser construire chaque objet, puis relever le coût et les statistiques.
3. Faire traverser un passage dont une décoration occupe la seule case de passage.
4. Observer les objets de nuit et vérifier l'absence de commande de carburant ou d'énergie.

**Attendu :** sept objets distincts, 5 bois chacun, travail nominal 50, beauté 1,
40 points de vie et empreinte d'une case. Passage possible, sans exiger une vitesse inchangée.
Les objets sont des accessoires inertes ; la citrouille ne produit aucune lumière.
Le dessin peut dépasser l'empreinte au sol. Les différences d'ombres décrites plus bas
ne constituent pas un échec.

### TF-05 — Cuisson des six confiseries et validation du comptage par objet

**Préconditions :** cuisinière électrique alimentée puis cuisinière à bois alimentée ;
cuisinier disponible ; sucre VCE et ingrédients partenaires en quantité suffisante selon
les quantités d'objets du tableau. Vérifier aussi les filtres et le rayon des ordres.

| Recette / produit | Partenaire autorisé | Objets partenaires consommés | Objets sucre consommés | Sortie |
|---|---|---:|---:|---:|
| `HMM_Make_BloodshotCakePops` / `HMM_BloodshotCakePops` | œufs non fécondés | 4 | 4 | 10 |
| `HMM_Make_CoffinBars` / `HMM_CoffinBars` | chocolat | 4 | 4 | 10 |
| `HMM_Make_SpiderBites` / `HMM_SpiderBites` | catégorie `VCE_Fruit` | 25 | 4 | 10 |
| `HMM_Make_BrainCakes` / `HMM_BrainCakes` | catégorie `AnimalProductRaw`, utiliser du lait | 4 | 4 | 10 |
| `HMM_Make_MurderBuns` / `HMM_MurderBuns` | farine VCE | 40 | 4 | 10 |
| `HMM_Make_CandyCorn` / `HMM_CandyCorn` | maïs brut | 40 | 4 | 10 |

Ces valeurs comptent désormais des objets, indépendamment de leur nutrition. Préparer exactement les quantités du tableau pour chaque fournée et vérifier leur consommation complète.

1. Sur chaque cuisinière, ajouter un seul ordre « fabriquer une fois » pour chaque recette,
   en procédant recette par recette pour identifier clairement les consommations.
2. Vérifier que sucre et partenaire sont cochés dans les filtres de l'ordre.
3. Demander au colon de cuisiner, observer le démarrage et conserver les messages du journal.
4. Si l'ordre aboutit, relever les ingrédients consommés et compter le produit obtenu.

**Attendu fonctionnel :** chaque ordre démarre et produit dix unités du bon produit,
avec un travail nominal de 450. Aucun avertissement de quantité invalide.

**Validation de la correction :** chaque fournée doit consommer exactement les quantités du tableau, dont 4 sucres même si leur nutrition est nulle. Relever la version de VCE, la nutrition du sucre et les consommations réelles. Un ordre bloqué malgré des conditions correctes, une consommation différente ou un avertissement de quantité invalide constitue un échec.

### TF-06 — Ingrédients absents, interdits et reprise

**Préconditions :** mêmes ateliers et ordres que TF-02 et TF-05.

1. Pour un masque, ne laisser que 29 tissus accessibles ; demander sa fabrication.
2. Ajouter le trentième tissu et demander de nouveau la fabrication.
3. Pour chaque confiserie, retirer le sucre, puis retirer seulement le partenaire.
4. Réintroduire les stocks, interdire le sucre dans le filtre de l'ordre, puis le réautoriser.

**Attendu :** aucune fabrication ni consommation partielle quand les ingrédients requis
manquent ou sont exclus. Le masque devient fabricable avec 30 tissus. La confiserie devrait
reprendre quand tout est disponible ; si TF-05 échoue à cause du sucre, consigner cette
dernière vérification comme bloquée par le même défaut, sans la déclarer réussie.

### TF-07 — Affichage, empilage et consommation des confiseries

**Préconditions :** créer les produits en mode développeur pour rendre ce cas indépendant
de TF-05 ; adulte pouvant manger, besoins de nourriture et de loisirs non saturés.

1. Pour chacun des six produits, créer des piles de 1, 25 et 75 et observer les sprites.
2. Faire transporter et fusionner deux piles du même produit sans dépasser 75 par pile.
3. Consulter la fiche : nutrition 0,1 et loisir propre au produit.
4. À état initial comparable, demander au colon de consommer chaque produit ; relever
   la diminution du stock et l'évolution des besoins. Réinitialiser les besoins entre essais.

**Attendu :** textures valides aux trois tailles, empilage et transport possibles, produit
consommable et besoins augmentés. Valeurs de loisir dans la définition : 0,25 pour les barres
cercueil, 0,05 pour les bonbons maïs, 0,15 pour les quatre autres. Ne pas exiger que le besoin
de loisirs augmente exactement de ces nombres : saturation et tolérance peuvent intervenir.

### TF-08 — Traduction française et retour à l'anglais

**Préconditions :** objets des cas précédents et ordres disponibles.

1. Passer en français et effectuer le redémarrage demandé par le jeu.
2. Vérifier noms et descriptions des onze masques, sept décorations et six confiseries.
3. Vérifier noms, descriptions et texte de travail des six recettes ; si la cuisson est
   bloquée, relever séparément les textes de travail non observables.
4. Repasser en anglais et vérifier les mêmes menus et fiches.

**Attendu :** textes français complets, accents corrects, aucune clé brute ni mélange de langue
dans les champs traduits ; retour aux textes anglais après changement de langue.

### TF-09 — Sauvegarde et rechargement

**Préconditions :** colon portant un masque, sept décorations construites, six confiseries
créées et ordres de fabrication présents. Garder les mêmes mods et versions.

1. Noter les modèles, positions, quantités et durabilités, puis sauvegarder.
2. Quitter le jeu, relancer et charger cette sauvegarde.
3. Comparer l'état des objets, de l'équipement et des ordres ; reprendre transport et fabrication.

**Attendu :** aucun objet disparu ou remplacé, données conservées et actions encore possibles,
sans nouvelle erreur HMM. Le défaut de cuisson, s'il est confirmé, reste suivi séparément.
Ce test ne démontre pas la migration d'une ancienne sauvegarde 1.2.

### TF-10 — Intégration optionnelle avec Props as Style

**Préconditions :** configuration séparée avec Props as Style et ses dépendances/DLC requis
par la version installée. Relever leurs versions. Ce cas ne conditionne pas le test sans DLC.

1. Vérifier que le groupe de styles Halloween est proposé.
2. Appliquer les quatre styles cités au scénario 7 aux bâtiments vanilla correspondants.
3. Construire la petite sculpture, la lampe torche, le feu de camp et le brasero avec ces styles.
4. Comparer leurs fonctions à celles des mêmes bâtiments sans style : carburant, lumière,
   chaleur et cuisson lorsque le bâtiment vanilla propose cette fonction.
5. Sauvegarder et recharger, puis vérifier les quatre apparences.

**Attendu :** gargouille, citrouille éclairée, chaudron et bougie correctement dessinés ;
comportement du bâtiment vanilla conservé. La citrouille non éclairée HMM reste un objet
distinct. Les quatre styles ne deviennent pas quatre constructions HMM supplémentaires.
Si l'intégration n'est pas installée, consigner ce cas comme non exécuté avec son motif.

### Fiche de résultats

| Cas | Statut initial | Observation / preuve |
|---|---|---|
| TF-01 | Non exécuté | |
| TF-02 | Non exécuté | Détailler les 11 modèles × 3 ateliers |
| TF-03 | Non exécuté | Détailler orientations, statistiques et partie enfant |
| TF-04 | Non exécuté | Détailler les 7 décorations |
| TF-05 | Non exécuté | Détailler les 6 recettes × 2 cuisinières |
| TF-06 | Non exécuté | |
| TF-07 | Non exécuté | Détailler les 6 produits |
| TF-08 | Non exécuté | |
| TF-09 | Non exécuté | |
| TF-10 | Non exécuté | Configuration optionnelle |

La recette du mod exige la réussite des cas applicables TF-01 à TF-09. Un blocage confirmé
de TF-05 est un défaut fonctionnel de cuisson, même si les produits créés en mode développeur
passent TF-07. Conserver le journal et une sauvegarde de reproduction pour chaque anomalie.

---

## Notes techniques du brouillon initial

Les notes suivantes sont conservées comme contexte historique. Leurs prédictions et références
à des contrôles antérieurs n'ont pas été revérifiées pendant cette rédaction.

Five static checks pass on this mod, run on 2026-09-12:

| checker | result |
|---|---|
| `Check-DefRefs` | 30 defs, 4 parents, every reference resolves |
| `Check-XmlFields` | 5 files, every element maps to a 1.6 field |
| `Check-ConfigErrors` | 34 defs, 26 rules, no config error |
| `Check-DefInjected` | 66 French keys, none dead |
| textures | 73 files, every `texPath` has something behind it |

None of them can load the game, and none of them looks at whether a recipe can ever be filled.
Historical scenario 5 describes the suspected failure before the item-count correction.
Use TF-05 and TF-06 above to validate the corrected recipes in game.

The mod has never run. Junction `HalloweenMonsterMashRenew/Mod` into `RimWorld/Mods` — the `Mod`
folder, not the repository root; the junction already exists. Play with dev mode on and keep the
log:

```
C:\Users\nelim\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log
```

---

## 1. It loads

Enable Core, Vanilla Cooking Expanded and this mod. No DLC and no Harmony are needed. Vanilla
Cooking Expanded is a hard dependency: without it the six recipes name defs that do not exist, and
a `RecipeDef` whose ingredient filter names a missing thing does not degrade quietly, it throws and
takes its file with it.

**Expect:** `Halloween Monster Mash Renew` in the list, its icon beside it, its banner on the mod
page. No red text at startup.

**Fails if:** any `XML error`, `Could not resolve cross-reference` or `Could not find type` naming
`HMM_`. A def that fails to load is silently absent afterwards, so a clean start is what every
scenario below rests on.

## 2. The eleven masks are made and worn

Build a crafting spot. All eleven bills should be there with no research done at all — the mod
overrides `recipeUsers` to add `CraftingSpot` to the two tailoring benches, and neither
`ApparelMakeableBase` nor `HatMakeableBase` carries a research prerequisite.

Make one of each: 30 cloth, 1400 work. Put them on a pawn and rotate the camera.

**Expect:** the mask drawn over the upper head from all four facings. It competes with hats, not
with helmets, because it sits on the `Overhead` layer over `UpperHead`.

**Fails if:** a pink box appears at any facing. Each mask ships three textures, `_north`, `_east`
and `_south`, and the game mirrors east for west; a missing one shows as pink. Forty-four mask
textures in eleven folders.

**Also check:** put one on a child. `developmentalStageFilter` is `Child, Adult`, which vanilla
headgear carries and the 1.2 originals did not.

## 3. The masks protect, for the first time

This is the port's largest change and the only one a player can measure. The originals declared
`costStuffCount` and three `StuffEffectMultiplier` stats with no `stuffCategories` anywhere in the
ancestry, so `MadeFromStuff` was false and all four lines were inert: the protection eleven
descriptions promise was exactly zero. They are replaced by the flat values those multipliers
would have produced on cloth.

Select a mask → **Information** tab.

| stat | this mod | where the number comes from |
|---|---|---|
| Armor - Sharp | 0.072 | cloth 0.36 x 0.2, the multiplier every cloth hat in Core uses |
| Armor - Heat | 0.036 | cloth 0.18 x 0.2, same |
| Insulation - Cold | 1.8 | cloth 18 x 0.1, the cowboy hat, bowler hat and tribal headdress figure |
| Insulation - Heat | 0.9 | cloth 18 x 0.05, the war mask and war veil figure |

So a mask is a cloth cowboy hat for sharp damage and for cold, and a tenth of one for heat. For
scale, a cloth tuque insulates 9 degrees of cold, five times a mask; a cloth mask insulates 0.36,
a fifth of one. "Mediocre" is the right word.

**Fails if:** any of the four reads zero. That is the 1.2 behaviour and would mean the flat values
did not take.

**One thing the changelog says loosely.** It calls the multipliers "the vanilla hat block, copied".
Each of the three numbers is a vanilla hat's number, but no single vanilla hat in 1.6 combines
0.2 armour with 0.1 cold and 0.05 heat — the hats at 0.1 cold all give more heat, and the two that
give 0.05 heat give 0.05 cold. Nothing to fix in the defs; the sentence is what overstates.

## 4. The seven decorations build

Architect → **Misc**. Seven entries: fake spider, ghosts, bats, skeleton, reaper, haunted tree,
jack-o-lantern. Five wood each, 50 work, no research, no power, no material choice.

**Expect:** each one built and drawn, `Beauty 1` on its information card, pawns walking through it
rather than around it — `passability` is `PassThroughOnly` at 30 % fill.

**Fails if:** a pink box, or a missing entry. Eleven decoration textures ship; only seven have a
`ThingDef`, and that is scenario 7.

**Not a fault:** the ghosts, the bats and the skeleton cast no drop shadow while the spider, the
tree, the reaper and the jack-o-lantern do. That is the author's own inconsistency, carried
deliberately.

## 5. Historical diagnosis before the item-count correction

The following describes the earlier nutrition-based recipes, not the current XML. The failure was never reproduced in game. The chosen correction removes the getter and keeps the numbers as item counts. Validate current behavior with TF-05 and TF-06.

### Original predicted failure

**This is the scenario to run first, and it is expected to fail.** It was found by writing this
document rather than by playing, and the game's own code says why.

Build a stove, stock raw sugar and any of the six partner ingredients, and add a bill for any of
the six sweets.

**Predicted:** the bill is never started. A cook walks to the stove, finds the bill unfillable and
leaves. `Player.log` fills with a yellow warning at each attempt:

```
Tried to set ThingCount stack count to -2147483648. thing=Sugar...
```

**Why, read off `Assembly-CSharp.dll` rather than assumed.** All six recipes ask for their
ingredients by nutrition, not by item count — `IngredientValueGetter_Nutrition`, which the author
wrote and the port carried unchanged. That getter returns an ingredient's `Nutrition` stat, and
zero for anything that is not a nutrition-giving ingestible. **Vanilla Cooking Expanded's sugar has
`Nutrition` 0.** It is a condiment: it feeds nobody and it is `NeverForNutrition`.

Every recipe asks for 4 units of it. The search adds sugar to the basket, subtracts `count x value
per unit` from what it still needs, and the value per unit is zero, so the requirement never
falls. The negative number in the warning is the same zero seen from the other side: the code
divides what it still needs by the value per unit, four over zero is infinity, and casting that to
an integer lands on the bottom of the range.

Vanilla Cooking Expanded never uses its own sugar as a counted ingredient, so nothing upstream
ever exercised this.

**If it passes anyway**, the reading above is wrong and that matters more than the scenario: say
so, and keep the log.

**Alternatives considered before the correction.** Dropping the
`ingredientValueGetterClass` line makes every count an item count, and the author's numbers then
read as sane recipes: 4 eggs, 4 chocolate, 25 fruit, 4 milk, 40 flour, 40 corn, 4 sugar. Keeping
the getter and special-casing sugar preserves the author's intent but needs a number invented for
him. The first is a smaller edit and a larger change of balance.

**The second finding, which survives either fix.** Read as nutrition, the partner ingredients are
already far outside anything vanilla cooks:

| recipe | partner | asks for | that is | sugar |
|---|---|---|---|---|
| bloodshot cake pops | unfertilized eggs | 4 nutrition | 16 eggs | 4 |
| coffin bars | chocolate | 4 nutrition | 40 chocolate | 4 |
| brain cakes | raw animal product | 4 nutrition | 80 milk | 4 |
| spider bites | fruit | 25 nutrition | 500 berries | 4 |
| murder buns | flour | 40 nutrition | 800 flour | 4 |
| candy corn | raw corn | 40 nutrition | 800 corn | 4 |

A vanilla simple meal costs 0.5 nutrition and returns 0.9. A batch of candy corn would cost 44 and
return ten sweets worth 0.1 each, so 1.0 — eighty-eight simple meals of food for one tenth of one
meal back. Whatever is decided about the sugar line, these numbers deserve a sentence in the
changelog, because nothing else in the repository relates them to a vanilla recipe.

## 6. The sweets themselves

Spawn the six with dev mode, which sidesteps scenario 5 entirely, and have a pawn eat each.

**Expect:** chocolate with a different sprite. Same 60 hit points, market value 3, mass 0.075,
deterioration 8, nutrition 0.1, `DesperateOnly` preferability, `Gluttonous` joy, four eaten at a
time. Only the recreation differs, and it is the only reason to eat one.

| sweet | joy | against chocolate's 0.10 |
|---|---|---|
| coffin bars | 0.25 | two and a half times |
| cake pops, spider bites, brain cakes, murder buns | 0.15 | half again |
| candy corn | 0.05 | half |

**Fails if:** the item draws as a pink box. These use `Graphic_StackCount`, which reads a whole
folder rather than a file, so a mislaid folder gives `Collection cannot init: No textures found at
path` in the log and a bad graphic on screen. Three sprites each, at one, at a middling stack and
at a full stack of 75.

**Not a fault:** no trader will ever carry one. The sweets have no `tradeTags`, which is the
author's choice. The masks do trade — `ApparelMakeableBase` gives them the `Clothing` tag.

## 7. The four missing decorations, as styles

Enable Props as Style as well. It gates its Halloween folder on this mod's `packageId`, and its
four styles read textures out of this mod's `Textures` folder.

| style | dresses | texture, shipped here |
|---|---|---|
| `PAS_Halloween_SculptureSmall` | small sculpture | `Decorations/Gargoyle/Gargoyle` |
| `PAS_Halloween_TorchLamp` | torch lamp | `Decorations/JackolanternL/JackolanternL` |
| `PAS_Halloween_Campfire` | campfire | `Decorations/Cauldron/Cauldron` |
| `PAS_Halloween_Brazier` | brazier | `Decorations/Candle/Candle` |

**Expect:** the halloween style group offered, and each of the four vanilla buildings drawn in the
Halloween artwork while keeping its own behaviour — the torch lamp still refuels and lights, the
brazier still pushes heat.

**Fails if:** a pink box on any of the four. That is the coupling to check: the textures live here
and nowhere else, so deleting one of the four "unused" texture folders would break another mod
silently.

**Also check** that the lit jack-o-lantern and the unlit one are not confused. `HMM_Jackolantern`
is the dark building in scenario 4; the lit pumpkin has no `ThingDef` at all and exists only as
this style.

## 8. French

Switch the language to French and look at the same objects.

**Expect:** every label and description translated — eleven masks, seven decorations, six sweets,
six recipes. Sixty-six keys, all of them checked against the defs.

**Fails if:** a raw key appears in place of a label.

## 9. Not with the original

Do not enable `[KD] Halloween Monster Mash` at the same time. Every defName is unchanged, which is
what lets an old save keep its things, and is also what makes the two mods collide.

**Expect**, if both are on: the usual duplicate-defName behaviour, the last loaded winning in
silence. There is nothing to verify here; it is a thing not to do.

---

## What to send back

`Player.log` from the session, plus one line per scenario. Scenario 5 is the one whose answer is
not already known: whether the bill is refused, and whether the warning above is in the log.
