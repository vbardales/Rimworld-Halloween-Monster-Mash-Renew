# The one integration this mod has: Props as Style dresses four vanilla buildings in artwork that only this
# mod ships (the gargoyle, the lit jack-o-lantern, the cauldron and the candle are textures here and
# styles there). Its Halloween folder is gated on this mod's packageId and its four styles read these paths.
# The scenario asserts the contract from this mod's side: the running mod that answers for each path is
# this one, so deleting a texture folder that looks unused here would be seen. It needs a pass that mounts
# Props as Style (wsl-deps.avec-props-as-style.map); elsewhere it is skipped by requirement, and a skip is
# not a pass. Props as Style has no Pickle suite of its own, so nothing else plays its styles in a game.
@requires:nelim.propsasstyle @requires:nelim.pickletools.textureowner
Feature: Props as Style finds the textures it reads in this mod

  Scenario Outline: <path> is answered by this mod
    Then Nelim's Pickle Tools: the texture "<path>" is answered by the mod "nelim.halloweenmonstermash"

    Examples:
      | path                                    |
      | Decorations/Gargoyle/Gargoyle           |
      | Decorations/JackolanternL/JackolanternL |
      | Decorations/Cauldron/Cauldron           |
      | Decorations/Candle/Candle               |
