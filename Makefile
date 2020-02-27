BIN=teensy
OUTDIR=target/thumbv7em-none-eabi/release
HEX=$(OUTDIR)/$(BIN).hex
ELF=$(OUTDIR)/$(BIN)

all:: $(ELF)

.PHONY: $(ELF)
$(ELF):
	cargo build --release

$(HEX): $(ELF)
	arm-none-eabi-objcopy -O ihex $(ELF) $(HEX)

hex: $(HEX)

.PHONY: flash
flash: hex
	teensy_loader_cli -w -s -mmcu=mk66fx1m0 $(HEX) -v

bloat:
	cargo bloat $(BLOAT_ARGS) -n 50 --target thumbv7em-none-eabi
