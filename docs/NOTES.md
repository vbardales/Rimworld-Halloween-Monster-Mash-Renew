# Hallowen Monster Mash — relevé, et reprise intégrale

Note de travail à la racine du dépôt : elle concerne plusieurs mods à la fois, donc elle ne peut
vivre dans aucun.

**Source :** « Hallowen Monster Mash » (le titre porte bien la coquille), par [KD] Killer_Diller,
Workshop [2257175849](https://steamcommunity.com/sharedfiles/filedetails/?id=2257175849).
`packageId` : `KD.HalloweenMonsterMash`.

---

## Le fait technique qui commande tout le reste

**Ce mod est mort, et de la façon la plus complète qui soit.** Il ne déclare que la 1.2, n'a
aucun `LoadFolders.xml`, et toutes ses defs vivent dans un dossier `1.2/`. RimWorld 1.6 ne lit
que la racine : **aucune de ses defs ne se charge**. C'est le cas Epona à l'identique.

**Mais ses textures sont à la racine** — `Textures/Candy/`, `Textures/Decorations/`,
`Textures/Masks/` — donc le jeu les charge normalement. Les 73 fichiers sont disponibles en jeu
alors que rien d'autre du mod ne fonctionne.

Conséquence pratique pour qui reprend une partie de ce mod : **on peut pointer les chemins des
textures sans rien copier**, à condition d'être abonné. C'est ce que fait Props as Style pour les
décorations.

**Arbitré le 2026-09-04, contre la première rédaction de cette note :** pointer les chemins
convient à un mod de styles, qui est de toute façon un complément, mais **pas à un mod de contenu
destiné à la publication**. Ça transforme l'abonnement à un mod mort en dépendance dure — sans
lui, textures manquantes et aucun message qui l'explique — et ça fait reposer le mod sur un item
1.2 dont l'auteur est absent depuis cinq ans et demi et qui peut être délisté à tout moment.
C'est aussi le contraire de ce que font NeckAccessory et SlippersMats, qui recopient l'art amont.
Les 44 fichiers des masques pèsent 400 Ko : le poids n'entre pas dans la balance. **Les masques et
les bonbons copient leurs textures ; les props gardent leurs renvois.**

**Réserve levée le 2026-09-04.** La page Workshop est lisible — Steam coupe par intermittence,
il suffit de réessayer. Relevé : page en ligne, 4 491 visites, 121 abonnés, **aucune licence
déclarée**, et l'auteur n'a pas touché à ses trois items RimWorld depuis le **13 mai 2021**.
C'est le profil de NeckAccessory : abandonné, pas retiré. La pratique documentée dans
`PUBLISHING.md` s'applique — crédit explicite, lien vers l'original, retrait sur demande.

Le bandeau « This item has been removed from the community » que renvoient certains extracteurs
de texte est une **chaîne cachée du gabarit Steam**, présente sur toutes les pages. Elle est
absente de la page rendue : vérifié dans un navigateur. Ne pas conclure au retrait sur cette base.

---
## Décorations — 11 defs, partagées 7 / 4

Quatre ont un jumeau vanilla et sont devenues des **styles** dans Props as Style : gargouille →
`SculptureSmall`, citrouille allumée → `TorchLamp`, chaudron → `Campfire`, bougie → `Brazier`.
Elles y restent : le travail est fait, et il ne se défait pas.

Les sept autres — araignée, fantômes, chauves-souris, squelette, faucheuse, arbre hanté,
citrouille éteinte — n'avaient rien à styliser : aucun jumeau vanilla, et ce sont les props les
plus purs du corpus, `Beauty 1`, aucun coût, aucun matériau, aucun composant. Elles deviennent des
defs dans Halloween Monster Mash.

À signaler : chez l'auteur, la **citrouille allumée** et la **bougie** étaient de vrais bâtiments
— `Refuelable`, `Glower` de rayon 10, `HeatPusher`, et un `CompProperties_MeditationFocus` avec
`FocusStrengthOffset_Lit`. En style, ce comportement est perdu ; ce sont la torche et le brasero
vanilla qui le fournissent. Si quelqu'un veut ces deux-là **en tant que bâtiments**, il faudra
les extraire, pas les styliser.

## Bonbons — 6 defs + 6 recettes → **Halloween Monster Mash** (et non Food Court)

| defName | Libellé | Texture | Nutrition |
|---|---|---|---|
| `HMM_BloodshotCakePops` | Bloodshot Cake Pops | `Candy/BloodshotCakePops` | 0.1 |
| `HMM_CoffinBars` | Coffin Bars | `Candy/CoffinBars` | 0.1 |
| `HMM_SpiderBites` | Spider Bites | `Candy/SpiderBites` | 0.1 |
| `HMM_BrainCakes` | Brain Cakes | `Candy/BrainCakes` | 0.1 |
| `HMM_MurderBuns` | Murder Buns | `Candy/MurderBuns` | 0.1 |
| `HMM_CandyCorn` | Candy Corn | `Candy/CandyCorn` | 0.1 |

Tous héritent de `ResourceBase`. Les six `RecipeDef` correspondantes (`HMM_Make_*`) se posent sur
`ElectricStove` et `FueledStove`. Deux `StatDef` accompagnent le lot.

Ici le mécanisme du style ne s'applique pas : ce sont des objets, pas des bâtiments. Il faudra
**recréer les defs**, et copier les textures : voir l’arbitrage plus haut, un mod de contenu ne
doit pas dépendre de l’abonnement à un mod mort.

## Masques — 11 defs → **Halloween Monster Mash** (et non Hand-Me-Downs)

`HMM_Mask_Devil`, `Clown`, `Witch`, `Frankenstein`, `Mummy`, `Wolfman`, `Hockey`, `Skull`,
`Zombie`, `Cat`, et `HMM_Mask_Pirate` qui est en réalité un chapeau. Tous sur `HatMakeableBase`,
textures sous `Masks/<Nom>/<Nom>`.

**Le travail est déjà fait**, dans `HalloweenMonsterMash/` : les 11 defs portées en 1.6 et repliées sur
un `HMM_MaskBase` local, les 44 textures copiées, la traduction française, l'ATTRIBUTION, la
LICENSE à portée limitée, le README et le CHANGELOG. Non commité, à absorber plutôt qu'à refaire.
Une jonction `RimWorld/Mods/HalloweenMonsterMash` pointe sur `HalloweenMonsterMash/Mod` ; la retirer avec
`[System.IO.Directory]::Delete(chemin, $false)` et jamais avec un `rm -rf`, qui la suivrait.

**Le défaut de fond, corrigé là-bas :** chaque masque déclarait `costStuffCount` et les trois
`StuffEffectMultiplier*` du chapeau vanilla **sans aucun `stuffCategories`** — ni dans le def, ni
dans l'ascendance `HatMakeableBase → ApparelMakeableBase → ApparelBase → ApparelNoQualityBase`.
`MadeFromStuff` était donc faux, les quatre lignes inertes, et aucun `ArmorRating_*` ni
`Insulation_*` ne les remplaçait : la « mediocre protection » promise par onze descriptions valait
zéro. Remplacées par les valeurs plates qu'elles auraient données sur du tissu. **Ne pas
« corriger » en ajoutant `stuffCategories`** : un vêtement stuffé est teinté par son matériau, et
ces textures sont peintes — le diable rouge et le clown sortiraient couleur laine.

**Avertissement `renderNodeProperties` retiré.** La première rédaction annonçait que le système de
rendu des couvre-chefs avait changé et qu'il faudrait reprendre l'apparence portée. Vérifié :
**zéro occurrence dans tous les defs d'apparel vanilla**, Core et les cinq DLC. `wornGraphicPath`
reste le mécanisme, et les masques se dessinent sur les quatre orientations sans rien ajouter.

---

*Note transmise aux sessions concernées le 2026-09-04, puis révisée le même jour après arbitrage
de l'utilisatrice. Elle reste la référence : elle est datée, versionnée, et survit à la fin des
sessions.*

**Correction, 2026-09-04.** Une version antérieure de ce paragraphe affirmait qu'aucune session
« Old School Dressing » n'existait, ni comme session ni comme dossier. **C'est faux, et l'erreur
était la mienne** : la session Old School Dressing est celle qui a porté les masques, et qui écrit
ces lignes. La répartition d'origine avait donc bien atteint son destinataire ; le lot a seulement
changé de main ensuite, sur décision de l'utilisatrice.

Le piège mérite d'être connu, parce qu'il se rejouera : **`list_sessions` exclut la session
courante** — c'est écrit dans sa description. Se chercher dans cette liste, c'est interroger un
ensemble qui vous retire par construction, et n'y pas figurer ne prouve rien. L'absence d'un
dossier `OldSchoolDressing/` dans le dépôt a paru confirmer la conclusion : deux indices
concordants, tous deux sans valeur. Pour savoir qui l'on est, `get_session("self")`.

Le dossier a été créé le 2026-09-04, sous le nom `OldSchoolDressing/`. **Il s'appelle
`HandMeDowns/` depuis le 2026-09-05** — les noms d'époque sont conservés ci-dessus parce que le
paragraphe raconte un incident, et qu'un récit renommé après coup cesse d'expliquer ce qui s'est
passé. C'est le recueil privé des vêtements et coiffures repris de mods morts, sur le modèle
d'Animal Ark et de Food Court. Il était vide quand ces lignes ont été écrites, ce qui explique
qu'on ait pu le croire inexistant.

---

# Épilogue — 2026-09-04 : la répartition en trois n'a pas eu lieu

**Tout ce qui précède décrit un plan qui a été abandonné en cours de route.** Le relevé technique
reste juste et vaut d'être lu ; les trois destinations, non. Décision de l'utilisateur, le même
jour : le mod source est porté **en entier**, dans un seul dossier.

## Où tout se trouve désormais

`HalloweenMonsterMash/` — c'est `HalloweenMasks/` renommé, pas un dossier neuf. Le travail de la
session Hand-Me-Downs sur les masques est intact, il est devenu un tiers du mod.

| Partie | Destination finale |
|---|---|
| 11 masques | `HalloweenMonsterMash/Mod/Defs/ThingDefs_Misc/Masks.xml` |
| 7 décorations | idem, `Decorations.xml` — araignée, fantômes, chauves-souris, squelette, faucheuse, arbre hanté, citrouille **éteinte** |
| 6 bonbons | idem, `Candy.xml` |
| 6 recettes | `HalloweenMonsterMash/Mod/VCE/`, conditionné à Vanilla Cooking Expanded |
| 4 décorations | **textures seules** — gargouille, citrouille allumée, chaudron, bougie restent des styles chez Props as Style |

`packageId` : `nelim.halloweenmonstermash`. Renommage sans risque, le mod n'avait jamais été
publié — pas de `About/PublishedFileId.txt`, donc la règle « UN SEUL COUP » de `PUBLISHING.md` ne
s'appliquait pas encore. Jonction refaite vers `RimWorld/Mods/HalloweenMonsterMash`.

**Food Court ne reçoit pas les bonbons.** La session a été prévenue.

## Ce que ça change au paragraphe « copier ou renvoyer »

La position ci-dessus — masques et bonbons copient, props gardent leurs renvois — est **dépassée,
et par le haut**. Le portage embarque les **73 textures**, y compris les quatre que Props as Style
utilise. Props as Style a été repointé sur `nelim.halloweenmonstermash` au lieu de
`kd.halloweenmonstermash` : ses `texPath` sont inchangés, mais il ne dépend plus d'un abonnement à
un item 1.2 délistable. Le renvoi vers un mod mort a disparu du dépôt entier — c'était le vrai
risque identifié dans ce paragraphe, et il est levé plutôt que contenu.

## Les trois dépendances Vanilla Expanded

Vérification faite sur les quatre fichiers de defs de l'auteur : **seul Vanilla Cooking Expanded
est réellement utilisé** (`VCE_RawSugar` dans les six recettes, `VCE_Flour` et `VCE_Fruit` dans
trois). Vanilla Plants Expanded et le Vanilla Expanded Framework ne sont référencés nulle part —
déclarés à tort. Le portage n'en déclare aucune : VCE est isolé par `LoadFolders.xml`, les deux
autres sont simplement tombées.

## Deux corrections au relevé lui-même

- Le relevé annonçait « deux `StatDef` accompagnent le lot » des bonbons. **Il n'y en a aucune** :
  les quatre fichiers de l'auteur ne contiennent que des `ThingDef` et des `RecipeDef`.
- Les `texPath` des bonbons (`Candy/CoffinBars` pour des fichiers `Candy/CoffinBars/CoffinBars_a.png`)
  **ne sont pas cassés**. Un `texPath` de `Graphic_StackCount` désigne un dossier :
  `Graphic_Collection.Init` appelle `ContentFinder<Texture2D>.GetAllInFolder(req.path)`. Vanilla
  `Chocolate` et `Silver` sont rangés de la même façon. Ne pas « réparer ».

*Cette note reste à la racine : elle concerne toujours trois mods, dont deux qu'elle ne peut pas
loger. Elle est écrite en français, comme le relevé qu'elle prolonge ; la règle « tout en anglais »
du 2026-09-04 vaut pour les fichiers publiés, et son application à cette note-ci n'a pas été
tranchée.*

## PropsInUse vient après, pas maintenant

Ajouté le 2026-09-04, mot de l'utilisatrice : « les 7 décos restent chez HalloweenMonsterMash, de
même que tout le mod en fait. Ensuite, PropsInUse ira y piocher ce qu'il peut en faire, mais
après. »

L'ordre est la consigne. **Rien ne se pioche tant que la reprise n'est pas finie** : PropsInUse
travaillerait sinon sur des defs encore en train de bouger, et deux sessions écriraient le même
lot. Une fois `HalloweenMonsterMash/` stabilisé, il devient la source où PropsInUse choisit — et
il choisira dans des defs propres et versionnées, pas dans le dossier Workshop d'un mod mort.

Ce que ça ne change pas : les 4 styles de Props as Style restent des styles, et les 7 décorations
restent des defs de Halloween Monster Mash. « Tout le mod » désigne la reprise, pas une remise à
plat de ce qui est déjà fait.

### Ce que PropsInUse trouvera, le moment venu

Relevé et vérifié le 2026-09-04 dans `HalloweenMonsterMash/Mod/Defs/ThingDefs_Misc/Decorations.xml`.
Les sept props sont sur un `HMM_PropBase` local héritant de `BuildingBase` : `Beauty` 1, cinq bois,
catégorie `Misc`, **aucun comp**. Il n'y a donc rien à désactiver — seulement à référencer.

| defName | Objet |
|---|---|
| `HMM_Spider` | araignée |
| `HMM_Ghosts` | fantômes |
| `HMM_Bats` | chauves-souris |
| `HMM_Skeleton` | squelette |
| `HMM_Reaper` | faucheuse |
| `HMM_Tree` | arbre hanté |
| `HMM_Jackolantern` | citrouille **éteinte** |

Piège de nommage : `HMM_Jackolantern` est la citrouille **éteinte**. L'allumée n'existe pas comme
def ici — c'est le style `TorchLamp` de Props as Style, et l'auteur la rangeait sous un dossier de
textures distinct (`Decorations/JackolanternL`). Ne pas prendre l'une pour l'autre.

**Ces `defName` sont figés.** Ce sont ceux de l'auteur, et ils le restent : les changer casserait
la compatibilité de sauvegarde avec le mod d'origine en plus de la surface sur laquelle PropsInUse
s'appuiera. C'est la contrainte que « PropsInUse viendra piocher après » fait peser sur Halloween
Monster Mash, et elle est déjà satisfaite.
