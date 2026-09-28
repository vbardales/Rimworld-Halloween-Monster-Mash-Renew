# The French half of 08-labels-en.feature. Played only with -Language French, and only with the English
# scenarios excluded, so a run that forgot the language shows up as a red here and not as a silent pass.
@lang-fr
Feature: French labels

  Scenario Outline: the game shows the French label of <def>
    Then def "<def>" field "label" is "<label>"

    Examples:
      | def                 | label                      |
      | HMM_Mask_Devil      | masque de diable           |
      | HMM_CoffinBars      | barres cercueil            |
      | HMM_Make_CoffinBars | faire des barres cercueil  |
