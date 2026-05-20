# FOM Thesis — Typst Template

A Typst template for academic papers at **FOM Hochschule für Oekonomie & Management**, built to comply with the official FOM style guidelines (margins, fonts, heading hierarchy, citation format, and all required front/back matter).

---

## Requirements

- [Typst](https://typst.app/) ≥ 0.13
- A BibTeX file (`refs.bib`) — managed with [Zotero](https://www.zotero.org/) + [Better BibTeX](https://retorque.re/zotero-better-bibtex/) recommended

---

## VS Code Setup

Install the **[Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)** extension (`myriad-dreamin.tinymist`). It provides everything you need in one package:

- Syntax highlighting and error diagnostics
- Autocompletion for functions, variables, and labels
- Live PDF preview inside the editor

**Opening the live preview:**

- Press `Ctrl+Shift+P` (macOS: `Cmd+Shift+P`), then run **Tinymist: Show Document Preview** — or click the preview icon in the top-right corner of the editor when a `.typ` file is open.
- The preview updates automatically on every save.

---

## Compiling

```bash
# One-shot PDF output
typst compile main.typ

# Live preview with hot reload
typst watch main.typ
```

The output file is `main.pdf`.

---

## Project Structure

```text
.
├── main.typ                      # Entry point — compile this file
├── doc.toml                      # Document metadata and feature flags
├── refs.bib                      # BibTeX bibliography
│
├── assets/                       # Images and other media referenced from chapters
│
├── guides/                       # Official FOM style guides (PDF, for reference only)
│
├── chapters/
│   ├── index.typ                 # Chapter order — only file to edit when adding chapters
│   ├── 01-introduction.typ
│   ├── 02-fundamentals.typ
│   ├── 03-implementation.typ
│   ├── 04-discussion.typ
│   ├── 05-conclusion.typ
│   ├── ai-tools.typ              # AI tools register entries
│   └── appendix.typ              # Appendix content (only if options.appendix = true)
│
└── lib/
    ├── style.typ                 # Page layout, fonts, spacing, heading styles
    ├── cite.typ                  # Citation helper functions (cf, quot, fig-source, …)
    ├── abbr.typ                  # Abbreviation tracking and list rendering
    ├── ai-entry.typ              # AI tools register entry component
    ├── fom.csl                   # CSL citation style (standard)
    ├── fom-split.csl             # CSL citation style (grouped by source type)
    └── pages/
        ├── titlepage.typ         # Title page
        ├── confidentiality.typ   # Confidentiality notice (Sperrvermerk)
        ├── declaration.typ       # Declaration of independent work
        └── appendix.typ          # Appendix numbering and heading setup
```

---

## Configuration (`doc.toml`)

All document metadata and optional sections are controlled in `doc.toml`. Nothing in `main.typ` needs to be changed for a new paper.

```toml
[document]
type       = "Projektarbeit"          # Document type (displayed on title page)
title      = "Your Title Here"
subtitle   = ""                       # Optional — leave empty to omit
program    = "Wirtschaftsinformatik"
date       = "DD.MM.YYYY"
degree     = ""                       # Optional — e.g. "Bachelor of Science (B.Sc.)"
module     = "ERP-Systeme"            # Shown when degree is empty
supervisor = "Prof. Dr. ..."          # Optional — leave empty to omit

[university]
name     = "FOM Hochschule für Oekonomie & Management"
location = "Düsseldorf"

[[authors]]                           # Repeat block for each author
name = "Firstname Lastname"
id   = "000000"                       # Student ID (Matrikelnummer)

[[authors]]
name = "Firstname Lastname"
id   = "000001"

[options]
confidential       = false   # true  → include confidentiality notice (Sperrvermerk)
print_mode         = false   # true  → duplex-print layout
declaration        = true    # false → omit declaration of independent work
ai_register        = true    # false → omit AI tools register
appendix           = false   # true  → include chapters/appendix.typ
split_bibliography = false   # true  → split bibliography by source type
                             #         see "Split Bibliography" section below
```

---

## Helper Functions

### Citations — `lib/cite.typ`

Footnote citations follow the FOM style (Author Year, S. X). Import is handled automatically via `main.typ`.

| Function | Footnote output |
| --- | --- |
| `#cf(<key>)` | *Vgl. Author (Year).* |
| `#cf(<key>, page: "12")` | *Vgl. Author (Year), S. 12.* |
| `#quot(<key>, page: "12")` | *Author (Year), S. 12.* (verbatim quote, no *Vgl.*) |
| `#cf-multi((<a>, "3"), (<b>, "7"))` | *Vgl. A (Year), S. 3; B (Year), S. 7.* |

**Figure sources** — embed the source as a footnote inside the caption. This keeps the caption text clean in the list of figures while the source number appears only on the figure page itself:

| Function | Output |
| --- | --- |
| `#fig-source(<key>)` | *Quelle: Author (Year).* |
| `#fig-based-on(<key>)` | *In Anlehnung an Author (Year).* |

**Example:**

```typst
#figure(
  image("assets/diagram.png"),
  caption: [System architecture#footnote[#fig-based-on(<doe2023>, page: "47")]],
) <fig-arch>
```

The footnote number is suppressed in the Abbildungsverzeichnis and only appears on the figure page in the main text.

**Alternative — source line below the figure** (does not appear in the list of figures):

```typst
#figure(image("assets/diagram.png"), caption: [System architecture]) <fig-arch>
#fig-based-on-note(<doe2023>, page: "47")
```

| Function | Rendered output |
| --- | --- |
| `#fig-source-note(<key>, page: "5")` | Centered italic block: *Quelle: Author (Year), S. 5.* |
| `#fig-based-on-note(<key>, page: "5")` | Centered italic block: *In Anlehnung an Author (Year), S. 5.* |
| `#fig-note[custom text]` | Centered italic block with arbitrary text |

---

### Abbreviations — `lib/abbr.typ`

Abbreviations are automatically expanded on first use and listed alphabetically in the abbreviation index.

```typst
// In running text:
#abbr("ERP", "Enterprise Resource Planning")
// → First occurrence:  "Enterprise Resource Planning (ERP)"
// → All subsequent:    "ERP"

// With a German-language equivalent:
#abbr("ERP", "Enterprise Resource Planning", german: "Unternehmensressourcenplanung")
// → First occurrence:  "Enterprise Resource Planning (ERP, dt.: Unternehmensressourcenplanung)"

// In main.typ — renders the complete list alphabetically (called automatically):
#abbrev-list()
```

The abbreviation list is only included in the document if at least one abbreviation was used.

---

### AI Tools Register — `lib/ai-entry.typ`

Documents AI tool usage as required by FOM. Add entries to `chapters/ai-tools.typ`:

```typst
#import "../lib/ai-entry.typ": ai-entry

#ai-entry(
  tool:     "Claude Sonnet 4.6 (Anthropic)",
  usage:    [Brief description of what the tool was used for.],
  prompt:   [The exact prompt or a representative example.],
  response: [Summary of the model's output and how it was used.],
)
```

The register is included automatically when `options.ai_register = true` in `doc.toml`.

---

### Code Figures — `lib/style.typ`

Use `#code-fig` to include source code listings that appear in the list of listings:

````typst
#code-fig(caption: [Example SQL query])[
  ```sql
  SELECT * FROM orders WHERE status = 'open';
  ```
]
````

---

## Split Bibliography (`split_bibliography`)

Some supervisors (typically for Bachelor's or Master's theses) require the bibliography to be grouped by source type. Set `options.split_bibliography = true` in `doc.toml` to enable this.

When enabled, the template switches to `lib/fom-split.csl` which sorts entries by type before sorting by author. All entries still live in the single `refs.bib` file:

| Group order | Entry types |
| --- | --- |
| 1 — Monographien | `book` |
| 2 — Aufsätze & Beiträge | `article-journal`, `article-magazine`, `chapter`, `paper-conference` |
| 3 — Internetquellen | `webpage`, `post`, `post-weblog` |
| 4 — Sonstige | everything else (reports, theses, …) |

> **Note:** Typst does not yet support multiple `#bibliography()` calls per document, so automatic sub-headings between the groups cannot be rendered. The entries are sorted and visually grouped, but the heading separation requires a future Typst release.

---

## Adding a New Chapter

1. Create `chapters/06-yourchapter.typ`
2. Add one line to `chapters/index.typ`:

   ```typst
   #include "06-yourchapter.typ"
   ```

`main.typ` does not need to be modified.

---

## Front and Back Matter Overview

| Section | Controlled by |
| --- | --- |
| Title page | always included |
| Confidentiality notice | `options.confidential = true` |
| Table of contents | auto — shown when headings exist |
| List of figures | auto — shown when images exist |
| List of tables | auto — shown when tables exist |
| List of listings | auto — shown when code blocks exist |
| List of abbreviations | auto — shown when `#abbr(...)` was used |
| Main chapters | `chapters/index.typ` |
| AI tools register | `options.ai_register = true` |
| Bibliography | always included |
| Appendix | `options.appendix = true` |
| Declaration of independent work | `options.declaration = true` |
