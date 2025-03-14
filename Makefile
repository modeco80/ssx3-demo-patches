# Makefile

TOP=$(shell pwd)
ARMIPS=$(TOP)/armips.exe

# todo: NOT this. please god not this.
define makeone
	cd $1; $(ARMIPS) -sym trampoline.sym trampoline.asm; 
	cd $1; ./output_pnach.py; cp -v *.pnach $(TOP)/patches;
endef

define cleanone
	cd $1; rm *.pnach *.sym *.bin;
endef

define doallpatches
	$(call $1,debug_menu_opm2)
	$(call $1,debug_menu_kr)
	$(call $1,no_autoreset_kr)
endef

all:
	$(call doallpatches,makeone)

clean:
	$(call doallpatches,cleanone)

# copy to emulator
copy:
	cp -v patches/*.pnach $(PCSX2_DIR)/cheats/
