// report: a simple report template with TODO marks and Tony's own comments.
//
// Usage:
//   #import "@local/report:0.1.0": *
//   #show: report.with(title: [My report])

#let me-name = "Tony"
#let me-full-name = "Tony Juntao Hu"

// Colours. Marked content uses a light `tint` of its colour as background;
// inline marks also darken the text by `shade`.
#let me-colour = rgb("#7c3aed")
#let todo-colour = rgb("#c2410c")
#let link-colour = rgb("#1d4ed8")
#let muted = luma(90)
#let rule-colour = luma(200)
#let tint = 90%
#let shade = 25%

// Sizes. `gap` is the base vertical rhythm; `pad` is the inner spacing of panels.
#let gap = 1em
#let pad = 0.75em
#let rule = 0.5pt + rule-colour
#let bar = 2.5pt
#let radius = 3pt

// Labels are set in true small caps from the font.
#let _label(colour, body) = text(fill: colour, tracking: 0.05em, smallcaps(all: true, body))

// Shared look for callouts, Tony's blocks and TODO blocks: tinted panel with
// a coloured left bar and a small-caps label.
#let _panel(colour, label, body, dashed: false) = block(
  width: 100%,
  fill: colour.lighten(tint),
  stroke: (left: (paint: colour, thickness: bar, dash: if dashed { "dashed" } else { none })),
  inset: pad,
  radius: (right: radius),
  {
    block(below: pad, _label(colour, label))
    body
  },
)

// No `extent`: highlight draws one rectangle per text run, and a horizontal
// extent makes each run's rectangle cover the edge of the previous run's glyphs.
#let _inline-mark(colour, body) = highlight(
  fill: colour.lighten(tint),
  text(fill: colour.darken(shade), body),
)

/// Tony's own comment or addition, kept visually apart from Claude's text.
/// Use `inline: true` inside a sentence.
#let me(body, inline: false) = {
  if inline { _inline-mark(me-colour, body) } else { _panel(me-colour, me-name, body) }
}

/// An open item for Claude to improve, or a note from Claude to Tony.
/// Use `inline: true` inside a sentence.
#let todo(body, inline: false) = {
  [#metadata(body)<report-todo>]
  if inline {
    _inline-mark(todo-colour, [#smallcaps(all: true)[Todo]: #body])
  } else {
    _panel(todo-colour, "Todo", body, dashed: true)
  }
}

// Short aliases for the inline forms.
#let mi = me.with(inline: true)
#let ti = todo.with(inline: true)

/// Markdown/GitHub-style admonition. `kind` is "note", "tip" or "warning".
#let callout(kind: "note", title: auto, body) = {
  let styles = (
    note: (rgb("#2563eb"), "Note"),
    tip: (rgb("#15803d"), "Tip"),
    warning: (rgb("#b91c1c"), "Warning"),
  )
  let (colour, default-title) = styles.at(kind)
  _panel(colour, if title == auto { default-title } else { title }, body)
}

/// Horizontal rule (Markdown `---`).
#let hr() = block(above: gap, below: gap, line(length: 100%, stroke: rule))

/// Task-list checkbox for list items (Markdown `- [ ]` / `- [x]`).
#let task(done: false, body) = {
  box(
    width: 0.75em,
    height: 0.75em,
    baseline: 0.05em,
    stroke: 0.6pt + muted,
    radius: 0.5 * radius,
    if done { align(center + horizon, text(size: 0.7em, sym.checkmark)) },
  )
  [~#body]
}

#let report(
  title: none,
  subtitle: none,
  authors: auto,
  date: datetime.today(),
  meta: (:),
  abstract: none,
  toc: false,
  heading-numbering: "1.1",
  produced-by-claude: true,
  body,
) = {
  // Claude's documents credit Claude but only show authors when they are given
  // explicitly; Tony's own documents always show them.
  let show-authors = not produced-by-claude or authors != auto
  let authors = if authors == auto {
    if produced-by-claude { ("Claude",) } else { (me-full-name,) }
  } else if authors == none { () } else if type(authors) == array { authors } else { (authors,) }
  set document(
    title: title,
    author: authors.filter(a => type(a) == str),
    date: if type(date) == datetime { date } else { auto },
  )
  set page(paper: "us-letter", numbering: "1")
  set text(lang: "en")
  set heading(numbering: heading-numbering)
  show heading: set block(above: 2 * gap, below: gap)

  show link: set text(fill: link-colour)

  // Code: subtle background inline, shaded panel for blocks.
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 2pt), outset: (y: 2pt), radius: 0.5 * radius)
  show raw.where(block: true): block.with(width: 100%, fill: luma(245), inset: pad, radius: radius)

  // Block quotes: grey bar, as in Markdown.
  show quote.where(block: true): it => block(
    width: 100%,
    stroke: (left: bar + rule-colour),
    inset: (left: pad, y: pad / 2),
    {
      set text(fill: muted)
      it.body
      if it.attribution != none { align(end)[— #it.attribution] }
    },
  )

  // Tables: bold header row and horizontal rules only.
  set table(align: left, stroke: (_, y) => if y == 0 { (top: 0.8pt, bottom: 0.5pt) } else { (bottom: rule) })
  show table.cell.where(y: 0): set text(weight: "bold")
  show figure.where(kind: table): set figure.caption(position: top)

  // Title block.
  if title != none {
    block(below: gap, text(size: 2em, weight: "bold", title))
  }
  if subtitle != none {
    block(above: 0pt, below: gap, text(size: 1.3em, fill: muted, subtitle))
  }
  // Status line.
  let fields = ()
  if show-authors and authors.len() > 0 { fields.push(authors.join(", ")) }
  if date != none {
    fields.push(if type(date) == datetime { date.display("[month repr:long] [day], [year]") } else { date })
  }
  for (key, value) in meta { fields.push([#key: #value]) }
  let sep = h(0.5em) + sym.dot.c + h(0.5em)

  // The TODO count needs context, so the rest of the header is built inside it.
  // Each part is only added when there is something to show, so a document
  // without header content starts at the top of the page like plain Typst.
  context {
    let status = fields
    let n = query(<report-todo>).len()
    if n > 0 { status.push(text(fill: todo-colour)[#n #smallcaps(all: true)[Todo]#if n > 1 [s]]) }
    if status.len() > 0 { block(text(fill: muted, status.join(sep))) }
    let has-header = title != none or subtitle != none or status.len() > 0

    // Provenance line, only for documents Claude produced.
    if produced-by-claude {
      block(
        above: 1.5 * gap,
        below: 2 * gap,
        width: 100%,
        inset: (y: pad),
        stroke: (y: rule),
        text(size: 0.9em, fill: muted)[
          This document was produced by Claude, except for parts marked as written by #me-name.
          #me-name's additions appear in a purple block labelled “#_label(me-colour, me-name)” or,
          within a sentence, as #_inline-mark(me-colour)[purple highlighted text]. Orange blocks
          with a dashed bar labelled “#_label(todo-colour)[Todo]”, and inline
          #_inline-mark(todo-colour)[#smallcaps(all: true)[Todo]: …] marks, are open items or notes
          from Claude.
        ],
      )
    } else if has-header {
      v(gap)
    }
  }

  if abstract != none {
    block(inset: (x: 1.5em), below: 2 * gap)[*Abstract.* #abstract]
  }
  if toc {
    outline()
  }

  body
}
