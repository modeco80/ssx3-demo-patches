#!/bin/python3

# Writes a pnach formatted patch from ARMIPS output.

import binascii
import sys

sys.path.insert(0, '../')
import pnach_utils

# base addresses. If you change these in the .asm
# UPDATE THESE.
TRAMPOLINE_BASE = 0x3796d0
TRAMPOLINE_ENTRY_BASE = 0x1874e8

with open('7656425F.debug_menu.pnach', 'w') as pnach_file:
    # init the cheat
    pnach = pnach_utils.PnachWriter(pnach_file)
    cheat = pnach.begin_cheat('Lily\\DebugMenu', 'modeco80', 'Enables the SSX Debug Menu. Use Circle in the pause menu to enter the debug menu.')

    # Write the trampoline
    pnach.write_comment(' Trampoline\n');
    pnach.set_base_address(TRAMPOLINE_BASE)
    with open('trampoline.bin', 'rb') as tramp_file:
        for inst in pnach_utils.read_in_inst_sized_chunks(tramp_file):
            cheat.write_word(inst)

    # Write the trampoline entry point
    pnach.write_comment(' Trampoline Entry Point\n');
    pnach.set_base_address(TRAMPOLINE_ENTRY_BASE)
    with open('trampoline_entry.bin', 'rb') as tramp_file:
        for inst in pnach_utils.read_in_inst_sized_chunks(tramp_file):
            cheat.write_word(inst)


        

