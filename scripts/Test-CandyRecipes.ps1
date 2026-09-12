<#
.SYNOPSIS
Checks the candy recipe contract without launching RimWorld.
.EXAMPLE
pwsh -NoProfile -File ./scripts/Test-CandyRecipes.ps1
#>
param(
    [string]$ModPath = (Join-Path $PSScriptRoot '../Mod')
)
$ErrorActionPreference = 'Stop'
function Assert-Recipe($Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}
[xml]$xml = Get-Content (Join-Path $ModPath 'Defs/RecipeDefs/Recipes_Candy.xml') -Raw
$bases = $xml.SelectNodes('/Defs/RecipeDef[@Name="HMM_MakeCandyBase"]')
Assert-Recipe ($bases.Count -eq 1) 'Expected one candy base.'
$base = $bases[0]
Assert-Recipe ($base.GetAttribute('Abstract') -eq 'True' -and -not $base.HasAttribute('ParentName')) 'Expected an abstract base without another parent.'
Assert-Recipe ($xml.SelectNodes('//ingredientValueGetterClass').Count -eq 0) 'Item counting must use the default getter; nutrition counting blocks zero-nutrition sugar.'
Assert-Recipe ($base.workAmount -eq '450') 'Expected 450 work.'
Assert-Recipe ((@($base.recipeUsers.li | Sort-Object) -join ',') -eq 'ElectricStove,FueledStove') 'Both stoves must be supported.'
$expected = @(
    @('BloodshotCakePops', 'categories', 'EggsUnfertilized', 4),
    @('CoffinBars', 'thingDefs', 'Chocolate', 4),
    @('SpiderBites', 'categories', 'VCE_Fruit', 25),
    @('BrainCakes', 'categories', 'AnimalProductRaw', 4),
    @('MurderBuns', 'thingDefs', 'VCE_Flour', 40),
    @('CandyCorn', 'thingDefs', 'RawCorn', 40)
)
Assert-Recipe ($xml.SelectNodes('/Defs/RecipeDef[defName]').Count -eq 6) 'Expected six concrete recipes.'
foreach ($case in $expected) {
    $name, $kind, $partner, $count = $case
    $defs = $xml.SelectNodes("/Defs/RecipeDef[defName='HMM_Make_$name']")
    Assert-Recipe ($defs.Count -eq 1) "Missing or duplicate recipe: $name"
    $recipe = $defs[0]
    Assert-Recipe ($recipe.GetAttribute('ParentName') -eq 'HMM_MakeCandyBase') "$name must inherit the candy base."
    Assert-Recipe ($recipe.SelectNodes('workAmount|recipeUsers').Count -eq 0) "$name overrides work or stoves."
    Assert-Recipe ($recipe.SelectNodes('ingredients/li').Count -eq 2) "$name must require two ingredients."
    foreach ($ingredient in @(@('thingDefs', 'VCE_RawSugar', 4), @($kind, $partner, $count))) {
        $group, $def, $amount = $ingredient
        $nodes = $recipe.SelectNodes("ingredients/li[filter/$group/li='$def']")
        Assert-Recipe ($nodes.Count -eq 1) "$name missing or duplicate ingredient: $def"
        Assert-Recipe ($nodes[0].count -eq [string]$amount) "$name requires $amount items of $def."
        Assert-Recipe ($nodes[0].SelectNodes('filter/*/li').Count -eq 1) "$name has unexpected alternatives for $def."
        Assert-Recipe ($recipe.SelectNodes("fixedIngredientFilter/$group/li[text()='$def']").Count -eq 1) "$name fixed filter excludes $def."
    }
    Assert-Recipe ($recipe.SelectNodes('fixedIngredientFilter/*/li').Count -eq 2) "$name has unexpected fixed ingredients."
    $products = $recipe.SelectNodes('products/*')
    Assert-Recipe ($products.Count -eq 1 -and $products[0].Name -eq "HMM_$name" -and $products[0].InnerText -eq '10') "$name must produce ten matching sweets."
}
Write-Output 'PASS: six candy recipes; item counting, ingredients, fixed filters, products, work and stoves.'
