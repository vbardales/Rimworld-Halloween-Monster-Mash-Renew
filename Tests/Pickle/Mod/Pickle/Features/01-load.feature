# What only a running game can say about the load: that nothing in the log comes from the mod. The offline
# checkers read the XML; none of them can see a category that no loaded mod defines, and the game reports
# that as `Could not resolve cross-reference` at startup, before any scenario begins. LoadAudit reads the
# log from the start of the game, so this is the scenario that sees it.
#
# `HMM_Make_SpiderBites` names the category `VCE_Fruit`, which Vanilla Plants Expanded defines and Vanilla
# Cooking Expanded does not. The recipe carries MayRequire="VanillaExpanded.VPlantsE" (2026-09-28, option B),
# so this must be GREEN in the sans-facultatifs pass, where the category does not exist, and in the avec-vpe
# pass, where it does. Red in the first means the guard does not work. Not yet observed in a game. One thing
# to read on the first run: the French keys of the recipe, absent without Plants Expanded, may log a warning.
@requires:nelim.pickletools.loadaudit
Feature: the mod loads without a message that belongs to it

  Scenario: nothing in the log comes from the mod once a colony is loaded
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the load of the mod "nelim.halloweenmonstermashrenew" is clean
