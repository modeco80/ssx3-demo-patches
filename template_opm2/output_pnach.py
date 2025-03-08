#!/bin/python3

# Writes a pnach formatted patch from ARMIPS output.

import binascii

# base addresses. If you change these in the .asm
# UPDATE THESE.
TRAMPOLINE_BASE = [TRAMPOLINE_ADDRESS]
TRAMPOLINE_ENTRY_BASE = [TRAMPLINE_ENTRY_ADDRESS]

# writes a pnach patch to write the given word into memory
# if it provided bytesttring is not large enough, it is padded with 0 bytes
def pnach_write(file, addr, bytestring):
    pad_length = len(bytestring) % 4
    bytes = bytestring
    if pad_length:
        bytes += bytes(4 - len(bytestring))

    byte_string = binascii.hexlify(bytes).decode('utf-8')
    file.write(f'patch=1,EE,{addr:08x},word,{byte_string}\n')

def read_in_inst_sized_chunks(file):
    while True:
        data = file.read(4)
        if not data:
            break
        yield data

with open('7656425F.pnach', 'w') as pnach_file:
    pnach_file.write('[TemplatePatch]\n')
    pnach_file.write('comment=Template patch\n')

    # Write the trampoline
    addend = 0
    pnach_file.write('// Trampoline\n');
    with open('trampoline.bin', 'rb') as tramp_file:
        for inst in read_in_inst_sized_chunks(tramp_file):
            pnach_write(pnach_file, TRAMPOLINE_BASE + addend, inst)
            addend += 4

    # Write the trampoline entry point
    pnach_file.write('// Trampoline Entry\n')
    addend = 0
    with open('trampoline_entry.bin', 'rb') as tramp_file:
        for inst in read_in_inst_sized_chunks(tramp_file):
            pnach_write(pnach_file, TRAMPOLINE_ENTRY_BASE + addend, inst)
            addend += 4



        

