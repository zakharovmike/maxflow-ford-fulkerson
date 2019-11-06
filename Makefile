
main:
	ocamlbuild ftest.native

clean:
	rm -rf _build/
	rm ftest.native
