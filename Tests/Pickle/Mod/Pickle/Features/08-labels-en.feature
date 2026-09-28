# The game applies the language chosen at launch to what the mod defines. Three defs, one of each kind the
# mod translates (an apparel, a sweet, a recipe): what the game resolved, read from the running def database,
# not from the language file. The 66 keys are checked offline by Check-DefInjected; this shows the game
# took them. A pass is one language, so the English and French files are split by tag and each pass
# excludes the other's: '<suite>,!@lang-fr' for English and '<suite>,!@lang-en' for French.
@lang-en
Feature: English labels

  Scenario Outline: the game shows the English label of <def>
    Then def "<def>" field "label" is "<label>"

    Examples:
      | def                 | label            |
      | HMM_Mask_Devil      | devil mask       |
      | HMM_CoffinBars      | coffin bars      |
      | HMM_Make_CoffinBars | make coffin bars |
