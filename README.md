# hx

The **hx Hash Expression Language Specification** — the troff source of the
document published as <https://www.mdxfind.com/hx.pdf>.

`hx` is a domain-specific language for describing, computing and verifying
cryptographic hash compositions. It gives a precise, human-readable notation
for the exact sequence of operations that produces a hash value from a
password, a salt, and any further parameters — so that a construction can be
stated once and then compiled, executed and checked rather than described in
prose and reimplemented from the description.

The language is implemented in
[mdxfind](https://github.com/Cynosureprime/mdxfind) and
[hashpipe](https://github.com/Cynosureprime/hashpipe), whose `hx.l`, `hx.y`,
`hx_ast.c`, `hx_compile.c` and `hx_vm.c` are the grammar, the compiler and the
virtual machine this document specifies. `hashpipe -X 'expr'` evaluates an
expression, and `hashpipe -X 'expr' -D` disassembles it.

## What is here

| File | |
|---|---|
| `hx.1` | The specification proper — language, grammar, primitives, opcodes, the virtual machine. Carries the `$Revision$` that identifies the document. |
| `hx.8` | **Appendix A**, the mdxfind type to hx expression reference: one row per registered type, giving its index, its name and the expression it computes. |
| `hx.9` | Title page and table of contents. |
| `Makefile` | How the PDF is built. |

Appendix A is the part most often read on its own. It is the authoritative
statement of what each mdxfind type computes, and it is what other projects
transcribe when they need to say what a type *is* rather than merely what it
is called.

## Building

Needs `groff` with the `pic` and `tbl` preprocessors, and `ps2pdf` from
Ghostscript.

```sh
make            # hx.pdf
make hx.ps      # stop at PostScript
make clean
```

One thing to expect, documented at length in the `Makefile`: groff emits the
title page and the table of contents **after** the body, because `.TC` cannot
run until every heading has been collected. The published PDF has them at the
front. Moving them is a manual step and the `Makefile` deliberately does not
do it, so `make` produces the document's content and stops there.

## Reading it another way

The `.ps` and `.pdf` are not committed. If you only want the document, take a
published PDF rather than building one:

* **[Releases](https://github.com/Cynosureprime/hx/releases)** -- each release is
  tagged with the document revision, so the PDF there is pinned to the exact
  source it was made from, including the Appendix A revision stated in the
  release notes.
* <https://www.mdxfind.com/hx.pdf> -- always the current one.

Neither is byte-reproducible by `make`, for the front-matter reason above.

For a plain-text Appendix A — which is what a tool wants — `pdftotext` on the
built PDF works, and so does reading `hx.8` directly: its table rows are
tab-separated `index`, `name`, `expression`, wrapped in `tbl` markup.

## License

MIT. See [LICENSE](LICENSE).
