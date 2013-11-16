bin        = $(shell npm bin)
lsc        = $(bin)/lsc
browserify = $(bin)/browserify
groc       = $(bin)/groc

lib: src/*.ls
	$(lsc) -o lib -c src/*.ls

lib/monads: lib src/monads/*.ls
	$(lsc) -o lib/monads -c src/monads/*.ls

dist:
	mkdir -p dist

dist/once-upon-a-time.umd.js: compile dist
	$(browserify) lib/index.js --standalone onceUponATime > $@	

# ----------------------------------------------------------------------
bundle: dist/once-upon-a-time.umd.js

compile: lib lib/monads

documentation:
	$(groc) --repository-url "https://github.com/killdream/once-upon-a-time" \
          --index "README.md"                                              \
          --out "docs/literate"                                            \
          src/*.ls src/**/*.ls README.md

clean:
	rm -rf dist build lib

test:
	$(lsc) test/node.ls

.PHONY: test
