# Ford-Fulkerson algorithm in OCaml

by Mikhail Zakharov \
with the [base project][1] provided by Arthur Bit-Monnot

This repository contains the acceptable version of the project. Further extensions were not tackled.

Some preconfigured tests for the max flow are provided. These can be ran with `make test` (though the output is not very exciting — says OK).

To manually run a test first build the project with `make build`.
Then run the program with:

```
./ftest.native <input-graph-file> <source> <sink> <output-graph-file>

f.ex: ./ftest.native graphs/graph1 0 5 outfile
```

Then `make gviz` to create SVGs of the initial graph and its final state.
The two SVGs `initial-graph.svg` and `final-graph.svg` can be visualized with any web browser.
`graphs/graph_` and `outfile` are the text versions, respectively.

---

## Use in VS Code

Install the _OCaml_ and/or _OCaml and Reason IDE_ extension in VS Code. See which one works best, maybe both.

Features :

- full compilation as VS Code build task (Ctrl+Shift+B)
- highlights of compilation errors as you type
- code completion
- automatic indentation on file save

## Requires

- Opam
- OCaml
- Graphviz
- OUnit2

## Build and run

A makefile provides some useful commands:

- `make build` to compile. This creates an ftest.native executable
- `make demo` to run the `ftest` program with some arguments
- `make gviz` to create SVGs of the initial and final graphs
- `make test` to run some tests
- `make format` to indent the entire project
- `make edit` to open the project in VSCode
- `make clean` to remove build artifacts

In case of trouble with the VS Code extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

[1]: https://github.com/arthur-bit-monnot/ocaml-maxflow-project
