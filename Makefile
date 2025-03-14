# Top-level Makefile. Builds all patches

TOP=$(shell pwd)
ARMIPS=$(TOP)/armips.exe

define makeone
	$(MAKE) -C $(1) TOP=$(TOP) ARMIPS=$(ARMIPS)
endef

define cleanone
	$(MAKE) -C $(1) TOP=$(TOP) ARMIPS=$(ARMIPS) clean
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
