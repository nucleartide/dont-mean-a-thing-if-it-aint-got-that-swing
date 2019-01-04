start:
	@$(shell which pico8) \
		-home $(shell pwd) \
		-run $(shell pwd)/carts/prototype.p8
.PHONY: start
