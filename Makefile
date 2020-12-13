
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile

clean:
	-rm -rf _build/
	-rm ftest.native

gviz:
	dot -Tsvg initial.gv > initial-graph.svg
	dot -Tsvg final.gv > final-graph.svg

test:
	ocamlbuild -use-ocamlfind tests.byte
	./tests.byte
	-rm tests.byte
