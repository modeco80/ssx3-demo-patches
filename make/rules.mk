# rules.mk

PNACH_FILENAME = $(PNACH_CRC).$(PNACH_NAME).pnach

all: $(PNACH_FILENAME)

clean:
	rm *.bin *.pnach symbols.sym

$(MAIN_BINARY): $(SOURCE_FILE)
	$(ARMIPS) -sym symbols.sym $<

$(PNACH_FILENAME): $(MAIN_BINARY)
	$(TOP)/pnach_utils/output_pnach.py $@
	cp $@ $(TOP)/patches

