param([Parameter(Mandatory)][string]$ModRoot, [string]$SharedDir)

# Own values and facts of this port's content: the six candy recipes (base, work, stoves, ingredients, fixed filters, products,
# the Plants Expanded guard on the spider bites) and the dependency contract of About.xml (Cooking Expanded hard, Plants Expanded
# optional and in loadAfter). One consumer, nothing shareable; Tests/Test-Mod.ps1 (generated) runs it after the shared checks.
# Prints findings, exit 1 on any. Replaces the former scripts/Test-CandyRecipes.ps1 (same assertions, deleted b055b32).
# The generic checks live in the shared scripts: Check-ModBasics, Check-XmlFields, Check-DefRefs, Check-ConfigErrors,
# Check-Translations, Check-DefInjected.
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ModRoot).Path
$mod = Join-Path $root 'Mod'
$script:findings = @()

# One rule: the block returns its problems; each is printed under the rule name.
function It([string]$name, [scriptblock]$body) {
    try { $problems = @(& $body | Where-Object { $_ }) } catch { $problems = @("threw: $($_.Exception.GetBaseException().Message)") }
    foreach ($p in $problems) { $script:findings += "[$name] $p" }
}
function Read-Xml([string]$p) { [xml](Get-Content -LiteralPath $p -Raw -Encoding UTF8) }

$recipes = Read-Xml (Join-Path $mod 'Defs/RecipeDefs/Recipes_Candy.xml')
$about = Read-Xml (Join-Path $mod 'About/About.xml')

It 'Candy base is one abstract recipe, item counting, 450 work, both stoves' {
    $bases = $recipes.SelectNodes('/Defs/RecipeDef[@Name="HMM_MakeCandyBase"]')
    if ($bases.Count -ne 1) { 'Expected one candy base.'; return }
    $base = $bases[0]
    if ($base.GetAttribute('Abstract') -ne 'True' -or $base.HasAttribute('ParentName')) { 'Expected an abstract base without another parent.' }
    if ($recipes.SelectNodes('//ingredientValueGetterClass').Count -ne 0) { 'Item counting must use the default getter; nutrition counting blocks zero-nutrition sugar.' }
    if ($base.workAmount -ne '450') { 'Expected 450 work.' }
    if ((@($base.recipeUsers.li | Sort-Object) -join ',') -ne 'ElectricStove,FueledStove') { 'Both stoves must be supported.' }
}

It 'Six concrete recipes, each two ingredients, ten sweets, guard only on the spider bites' {
    $expected = @(
        @('BloodshotCakePops', 'categories', 'EggsUnfertilized', 4),
        @('CoffinBars', 'thingDefs', 'Chocolate', 4),
        @('SpiderBites', 'categories', 'VCE_Fruit', 25),
        @('BrainCakes', 'categories', 'AnimalProductRaw', 4),
        @('MurderBuns', 'thingDefs', 'VCE_Flour', 40),
        @('CandyCorn', 'thingDefs', 'RawCorn', 40)
    )
    if ($recipes.SelectNodes('/Defs/RecipeDef[defName]').Count -ne 6) { 'Expected six concrete recipes.' }
    foreach ($case in $expected) {
        $name, $kind, $partner, $count = $case
        $defs = $recipes.SelectNodes("/Defs/RecipeDef[defName='HMM_Make_$name']")
        if ($defs.Count -ne 1) { "Missing or duplicate recipe: $name"; continue }
        $recipe = $defs[0]
        if ($recipe.GetAttribute('ParentName') -ne 'HMM_MakeCandyBase') { "$name must inherit the candy base." }
        # VCE_Fruit is defined by Vanilla Plants Expanded, which the mod does not require: only that recipe is guarded.
        $guard = if ($name -eq 'SpiderBites') { 'VanillaExpanded.VPlantsE' } else { '' }
        if ($recipe.GetAttribute('MayRequire') -ne $guard) { "$name MayRequire must be '$guard'." }
        if ($recipe.SelectNodes('workAmount|recipeUsers').Count -ne 0) { "$name overrides work or stoves." }
        if ($recipe.SelectNodes('ingredients/li').Count -ne 2) { "$name must require two ingredients." }
        foreach ($ingredient in @(@('thingDefs', 'VCE_RawSugar', 4), @($kind, $partner, $count))) {
            $group, $def, $amount = $ingredient
            $nodes = $recipe.SelectNodes("ingredients/li[filter/$group/li='$def']")
            if ($nodes.Count -ne 1) { "$name missing or duplicate ingredient: $def"; continue }
            if ($nodes[0].count -ne [string]$amount) { "$name requires $amount items of $def." }
            if ($nodes[0].SelectNodes('filter/*/li').Count -ne 1) { "$name has unexpected alternatives for $def." }
            if ($recipe.SelectNodes("fixedIngredientFilter/$group/li[text()='$def']").Count -ne 1) { "$name fixed filter excludes $def." }
        }
        if ($recipe.SelectNodes('fixedIngredientFilter/*/li').Count -ne 2) { "$name has unexpected fixed ingredients." }
        $products = $recipe.SelectNodes('products/*')
        if (-not ($products.Count -eq 1 -and $products[0].Name -eq "HMM_$name" -and $products[0].InnerText -eq '10')) { "$name must produce ten matching sweets." }
    }
}

It 'Dependencies: Cooking Expanded hard, Plants Expanded optional and loaded after' {
    $deps = @($about.ModMetaData.modDependencies.li.packageId)
    if ($deps -notcontains 'VanillaExpanded.VCookE') { 'Vanilla Cooking Expanded must stay a declared dependency.' }
    if ($deps -contains 'VanillaExpanded.VPlantsE') { 'Vanilla Plants Expanded must stay optional (MayRequire), not a dependency.' }
    if (@($about.ModMetaData.loadAfter.li) -notcontains 'VanillaExpanded.VPlantsE') { 'Vanilla Plants Expanded must be in loadAfter.' }
}

if ($script:findings.Count) { $script:findings | ForEach-Object { Write-Output $_ }; exit 1 }
Write-Output 'PASS: six candy recipes (item counting, ingredients, fixed filters, products, work, stoves, Plants Expanded guard) and the dependency contract.'
