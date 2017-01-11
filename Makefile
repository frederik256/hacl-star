#
# Main HACL* Makefile
#

.PHONY: setup library

all: library

setup:
	@echo $(CYAN)"\n# Installing OCaml packages required by F*"$(NORMAL)
	opam install ocamlfind batteries sqlite3 fileutils stdint zarith yojson pprint menhir
	@echo $(CYAN)"\n# Installing OCaml packages required by KreMLin"$(NORMAL)
	opam install ppx_deriving_yojson zarith pprint menhir ulex process fix wasm
	@echo $(CYAN)"\n# Compiling F*"$(NORMAL)
	make -C dependencies/FStar/src/ocaml-output
	@echo $(CYAN)"\n# Compiling KreMLin"$(NORMAL)
	make -C dependencies/kremlin
	@echo $(CYAN)"\nAll done ! Enjoy ;) "$(NORMAL)

library:
	@echo $(CYAN)"# Compiling the HaCl* library"$(NORMAL)
	mkdir -p build && cd build; \
	cmake -DCMAKE_C_COMPILER=gcc-6 ../extracted/c && make
	@echo $(CYAN)"\nDone ! Generated libraries can be found in 'build'."$(NORMAL)

clean:
	@echo $(CYAN)"# Clean HaCl*"$(NORMAL)
	rm -rf *~
	rm -rf build


NORMAL="\\033[0;39m"
CYAN="\\033[1;36m"
