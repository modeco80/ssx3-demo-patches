import binascii

def read_in_inst_sized_chunks(file):
    while True:
        data = file.read(4)
        if not data:
            break
        yield data

# A basic writer for pnach files
class PnachWriter:
    def __init__(self, file):
       self._file = file
       self._base_address = 0x0
       self._addr = 0x0
	
    # Set the base address
    def set_base_address(self, base_address):
       self._base_address = base_address
       self._addr = base_address

    # writes the header for a cheat
    def write_cheat_header(self, section_name, author, comment):
       self._file.write(f'[{section_name}]\n')
       if author:
           self._file.write(f'author={author}\n')
       if comment:
           self._file.write(f'comment={comment}\n')

    def write_comment(self, comment):
       self._file.write(f'//{comment}')

    # writes a pnach patch to write the given word into memory
    # if the provided bytestring is not large enough, it is padded with 0 bytes
    def write_word(self, bytestring):
       pad_length = len(bytestring) % 4
       put_bytes = bytes(reversed(bytestring))
       if pad_length:
            put_bytes += bytes(4 - len(bytestring))
	
       byte_string = binascii.hexlify(put_bytes).decode('utf-8')
       self._file.write(f'patch=1,EE,{self._addr:08x},word,{byte_string}\n')
       self._addr += 0x4
	