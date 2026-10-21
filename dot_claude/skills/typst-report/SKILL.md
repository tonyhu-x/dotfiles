---
name: typst-report
description: Write reports, notes, handouts and other documents as Typst (.typ) files using Tony's @local/claude-report template, which marks Claude's TODOs and Tony's own comments. Use when Tony asks for a document, report or write-up in Typst / .typ format, or asks to revise such a document (resolve its #todo items, act on its #me comments). Do not use for Markdown, PDF-only, Word or Claude Docs output.
---

# Typst reports

Tony wants the deliverable as a `.typ` file built on the `claude-report` template. The template lives in [package/lib.typ](package/lib.typ) and is installed as the local Typst package `@local/claude-report:0.1.0` (a symlink into Typst's package directory), so any `.typ` file anywhere can import it.

For general Typst syntax, styling and debugging, also load the `typst` skill.

## Workflow

1. **Location and name.** Put the report where Tony says. If Tony doesn't name the file, give it a short descriptive name in sentence case (`Pilot vowel analysis.typ`).
2. **Start from [starter.typ](starter.typ).** Copy it, then fill in `title` and any other `report` arguments that apply.
3. **Write the content** (see the conventions below). Use `#todo` wherever something is missing, uncertain, or needs Tony's input.
4. **Compile and keep the PDF** next to the `.typ` file:
   ```bash
   typst compile "Pilot vowel analysis.typ"
   ```
   Fix every error and warning. Then check the layout visually by rendering PNGs into your scratchpad directory (never the report folder) and reading them:
   ```bash
   typst compile "Pilot vowel analysis.typ" "<scratchpad>/page-{p}.png" --ppi 110
   ```
5. **Report back** briefly: where the file is, and the open TODOs that need Tony's input.

If `@local/claude-report` can't be found, run `~/.claude/skills/typst-report/install.sh` (it recreates the symlink) and compile again.

## Template API

```typst
#import "@local/claude-report:0.1.0": *

#show: report.with(
  title: [Title],                       // required in practice
  subtitle: none,                       // content
  authors: ("Claude",),                 // strings; PDF metadata only, not shown
  date: datetime.today(),               // datetime, content, or none
  meta: ("Course": [LING 330]),         // extra "Key: value" fields in the header line
  abstract: none,                       // content
  toc: false,                           // table of contents after the header
  heading-numbering: "1.1",             // none to switch off numbering
)
```

The header shows the title, a status line (date, `meta` fields, and the count of open TODOs) and a fixed provenance line explaining that Claude wrote the document except for Tony's marked parts, and how those parts and TODOs look. Don't write a separate disclaimer.

| Function | Use |
| --- | --- |
| `#todo[...]` | Claude's open item or note to Tony: orange panel, dashed bar, labelled TODO. |
| `#ti[...]` | Inline TODO inside a sentence (alias of `#todo(inline: true)[...]`). |
| `#me[...]` | Tony's own comment or addition: purple panel labelled "Tony". |
| `#mi[...]` | Tony's inline comment inside a sentence (alias of `#me(inline: true)[...]`). |
| `#callout(kind: "note" \| "tip" \| "warning", title: auto)[...]` | Admonitions, like GitHub `> [!NOTE]`. |
| `#hr()` | Horizontal rule (Markdown `---`). |
| `#task(done: false)[...]` | Checkbox for task-list items: `- #task(done: true)[Collect data]`. |

## Conventions for Claude and Tony's parts

- **Claude's own text is never wrapped in `#me`.** `#me` is only for Tony's words. When Tony gives text in chat and asks for it to be added *as their own comment or addition*, wrap it in `#me`; otherwise anything Claude writes, even from Tony's notes, is plain text.
- **Never edit or delete the content of a `#me` block** unless Tony asks. If Tony's comment is a request ("add a section on X"), do it in Claude's text and leave the `#me` block in place for Tony to remove, unless Tony says to remove addressed comments.
- **TODOs are for iteration.** Use them for gaps, unverified claims, placeholders, and questions or notes for Tony. Keep each one specific and actionable. When revising, look for them with `grep -n '#todo' file.typ`, resolve what you can, delete the resolved ones, and update the rest. Don't leave silent placeholders; every gap gets a TODO.

## Attachments

- Put every attachment (images, data files, audio, generated figures) **in the same folder as the `.typ` file**. No subfolders.
- Name attachments in **sentence case** with spaces, as Tony would title them: `Vowel chart.png`, `Survey responses.csv`, `Speaker 3 recording.wav`.
- Reference them by bare relative path: `#image("Vowel chart.png")`, `#csv("Survey responses.csv")`.
- A script written only to generate an attachment goes in the scratchpad, not the report folder, unless Tony asks to keep it.

## Markdown → Typst cheat sheet

| Markdown | Typst |
| --- | --- |
| `# H1`, `## H2` | `= H1`, `== H2` |
| `**bold**`, `*italic*` | `*bold*`, `_italic_` |
| `~~strike~~`, `==mark==` | `#strike[...]`, `#highlight[...]` |
| `` `code` ``, fenced code | same (`` ```python ... ``` ``) |
| `- item`, `1. item` | `- item`, `+ item` |
| `- [ ] task` | `- #task[task]` |
| `[text](url)` | `#link("url")[text]` |
| `![alt](Image.png)` | `#figure(image("Image.png", alt: "alt"), caption: [...])` |
| `> quote` | `#quote(block: true, attribution: [Who])[...]` |
| `> [!NOTE]` | `#callout[...]` |
| tables | `#table(columns: 3, table.header[A][B][C], [..], ...)`, inside `#figure(..., caption: [...])` for a numbered caption |
| `[^1]` | `#footnote[...]` |
| `$x$`, `$$x$$` | `$x$`, `$ x $` (spaces make it display math) |
| `---` | `#hr()` |

The template already styles links, code, quotes and tables (bold header, horizontal rules only), so don't add per-element styling.

## Gotchas

- `@word` is a cross-reference and fails if no `<word>` label exists. Escape literal at-signs (`\@`), and likewise `\#`, `\$`, `\*`, `\_`, `\<` in prose.
- Strings with spaces in file names are fine: `image("Vowel chart.png")`.
- Put show/set rules for one-off tweaks after the `#show: report.with(...)` line.

## Maintaining the template

The package source is `package/` in this skill folder; Typst's local package directory links to it, so edits take effect immediately for every report that imports `0.1.0`. Keep changes backward compatible so existing reports still compile. If you bump `version` in [package/typst.toml](package/typst.toml), run [install.sh](install.sh) and update the import in [starter.typ](starter.typ) and in this file.
