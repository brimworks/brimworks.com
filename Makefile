
.PHONY: cuttlebelle
.DEFAULT: build

build: cuttlebelle
	cuttlebelle

cuttlebelle:
	@command -v cuttlebelle > /dev/null || npm install -g cuttlebelle

watch: cuttlebelle
	cuttlebelle watch