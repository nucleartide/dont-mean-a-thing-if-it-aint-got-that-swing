start:
	@$(shell which pico8) \
		-home $(shell pwd) \
		-run $(shell pwd)/carts/prototype2.p8 \
		-gif_scale 10
.PHONY: start
