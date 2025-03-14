# SSX 3 - Patches

Patches for the demo builds of SSX 3. This is "source code" form of these, and the "pnach" files are the output product.

The patches are provided in the patches subdirectory/, and a template is provided to make it easy for other patches to be made.

# Building

If you don't trust me for some reason, you can build the patches from this repository yourself.

You need armips, python, and GNU make.

Simply running `make ARMIPS=/path/to/armips` should build the patches.

# Patch Documentation

## Debug Menu (OPM2)

Enables the Debug Menu. Press Circle in the pause menu to open the debug menu. Make sure the first menu item is focused; others currently cause issues.

## Debug Menu (KR)

Enables the Debug Menu. Press Circle in the pause menu to open the debug menu. Make sure the first menu item is focused; others currently cause issues.

## No Autoreset (KR)

Disables the game's "auto reset" functionality, allowing you to explore out of bounds. 

Unfortunately, certain auto resets like wipeout recovery use the same auto reset type as "bad" ones we don't want to enable. This sucks.

