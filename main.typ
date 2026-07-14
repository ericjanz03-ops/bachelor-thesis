// ════════════════════════════════════════════════════════════════════════════
// Main entry point
// Compile: typst compile main.typ
// ════════════════════════════════════════════════════════════════════════════

#import "lib/style.typ":        apply-styles, apply-footnote-styles, frontmatter-numbering, mainmatter-numbering
#import "lib/cite.typ":         cf, quot, cf-multi, fig-source, fig-based-on
#import "lib/abbr.typ":         abbr, abbrev-list, _abbrevs
#import "lib/pages/titlepage.typ":       titlepage
#import "lib/pages/confidentiality.typ": confidentiality-notice
#import "lib/pages/declaration.typ":     declaration
#import "lib/pages/appendix.typ":        appendix

// ─── Metadata ────────────────────────────────────────────────────────────────
#let meta = toml("doc.toml")

#set document(
  title:  meta.document.title,
  author: meta.authors.map(a => a.name),
  date:   auto,
)

// ─── Global styles ────────────────────────────────────────────────────────────
#show: apply-styles

// Footnotes are suppressed everywhere by default.
// They are re-enabled only for the mainmatter via apply-footnote-styles below.
#show footnote:       _ => []
#show footnote.entry: _ => []
#set  footnote.entry(separator: none)

// ════════════════════════════════════════════════════════════════════════════
// FRONTMATTER (Roman numerals)
// ════════════════════════════════════════════════════════════════════════════
#show: frontmatter-numbering

#titlepage(meta)

// Confidentiality notice (optional)
#if meta.options.confidential {
  confidentiality-notice(meta)
  pagebreak()
}

// Table of contents
#context if query(heading.where(outlined: true)).len() > 0 {
  outline(title: [Inhaltsverzeichnis], depth: 3, indent: 1em)
  pagebreak()
}

// List of figures
#context if query(figure.where(kind: image)).len() > 0 {
  heading(outlined: true, numbering: none)[Abbildungsverzeichnis]
  outline(title: none, target: figure.where(kind: image))
  pagebreak()
}

// List of tables
#context if query(figure.where(kind: table)).len() > 0 {
  heading(outlined: true, numbering: none)[Tabellenverzeichnis]
  outline(title: none, target: figure.where(kind: table))
  pagebreak()
}

// List of listings
#context if query(figure.where(kind: raw)).len() > 0 {
  heading(outlined: true, numbering: none)[Quellcodeverzeichnis]
  outline(title: none, target: figure.where(kind: raw))
  pagebreak()
}

// List of abbreviations
#context if _abbrevs.final().len() > 0 {
  heading(outlined: true, numbering: none)[Abkürzungsverzeichnis]
  abbrev-list()
  pagebreak()
}

// AI disclaimer (optional)

// ════════════════════════════════════════════════════════════════════════════
// MAINMATTER (Arabic numerals starting at 1)
// ════════════════════════════════════════════════════════════════════════════

// Re-enable footnotes for the main chapters only.
// The inner show rules override the global suppression above.
#show: apply-footnote-styles
#show: mainmatter-numbering

#include "chapters/index.typ"

// ════════════════════════════════════════════════════════════════════════════
// BACKMATTER
// ════════════════════════════════════════════════════════════════════════════

// AI tools register
#if meta.options.ai_register {
  pagebreak(weak: true)
  heading(outlined: true, numbering: none)[KI-Hilfsmittelverzeichnis]
  include "chapters/ai-tools.typ"
}

// Bibliography
// split_bibliography = true appends internet sources (refs-online.bib) under
// an "Internetquellen" sub-heading within the same Literaturverzeichnis
// section. Only "Literaturverzeichnis" appears in the Inhaltsverzeichnis —
// the "Internetquellen" sub-heading is unnumbered and not outlined.
// Requires Typst ≥ 0.15 (multi-bibliography support). Citations are routed
// automatically: each .bib file only contains the keys it "owns", so Typst
// assigns each citation to the bibliography whose source file defines it.
#pagebreak(weak: true)
#bibliography(
  "refs.bib",
  title: [Literaturverzeichnis],
  style: "lib/fom.csl",
  full: false,
)
#if meta.options.at("split_bibliography", default: false) {
  heading(outlined: false, numbering: none)[Internetquellen]
  bibliography(
    "refs-online.bib",
    title: none,
    style: "lib/fom.csl",
    full: false,
  )
}

// Appendix (enable in doc.toml: options.appendix = true)
#if meta.options.at("appendix", default: false) {
  show: appendix
  include "chapters/appendix.typ"
}

// Declaration of independent work
#if meta.options.declaration {
  declaration(meta)
}
