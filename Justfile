root := justfile_directory()
export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# Compile the manual and render the initialized template's first page.
doc:
  mkdir -p build
  typst compile --root . docs/manual.typ build/manual.pdf
  ./scripts/package build/packages/local
  typst compile --root . --package-path build/packages --pages 1 --ppi 150 template/main.typ thumbnail.png

# Compile source imports, package imports, and an initialized project in isolation.
test:
  python3 -m unittest discover -s tests -v

# Package into TARGET/nju-exp-report/0.1.0.
package target:
  ./scripts/package "{{target}}"

install: (package "@local")

uninstall:
  ./scripts/uninstall @local

ci: test doc
