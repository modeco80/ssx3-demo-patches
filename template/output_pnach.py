#!/bin/python3

# Writes a pnach formatted patch from ARMIPS output.

import binascii
import sys

sys.path.insert(0, '../')
import pnach_utils

# base addresses. If you change these in the .asm
# UPDATE THESE.
TRAMPOLINE_BASE = [TRAMPOLINE_ADDRESS]
TRAMPOLINE_ENTRY_BASE = [TRAMPLINE_ENTRY_ADDRESS]

with open('7656425F.pnach', 'w') as pnach_file:
    # init the cheat
    pnach = pnach_utils.PnachWriter(pnach_file)
    pnach.write_cheat_header('Template', 'Author', 'What this cheat does')

    # Write the trampoline
    pnach.write_comment(' Trampoline\n');
    pnach.set_base_address(TRAMPOLINE_BASE)
    with open('trampoline.bin', 'rb') as tramp_file:
        for inst in pnach_utils.read_in_inst_sized_chunks(tramp_file):
            pnach.write_word(inst)

    # Write the trampoline entry point
    pnach.write_comment(' Trampoline Entry Point\n');
    pnach.set_base_address(TRAMPOLINE_ENTRY_BASE)
    with open('trampoline_entry.bin', 'rb') as tramp_file:
        for inst in pnach_utils.read_in_inst_sized_chunks(tramp_file):
            pnach.write_word(inst)



        

