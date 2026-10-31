# First observation of what happens when the original mod is loaded beside this port (TESTING.md, pass 5).
# The original ships every def in a `1.2/` folder with no LoadFolders.xml, so in 1.6 none of its defs loads
# and only its textures do: it may be harmless. This scenario asserts a clean load and is expected to say
# which one it is. Green: the README and the Steam description overstate the warning. Red: read the line
# the log gives, assert that line under @allow-errors, and keep the warning. Played only with
# -DepMap wsl-deps.incompat-original.map, skipped everywhere else by the requirement.
@requires:KD.HalloweenMonsterMash
Feature: the original mod loaded beside this port

  Scenario: the original and this port load together
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the load of the mod "nelim.halloweenmonstermash" is clean
