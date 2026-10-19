#import "theme.typ": *
#import "title.typ": nju-title-block

// ---------- 主模板 ----------
#let nju-lab(
  title: "实验报告",
  subtitle: none,
  course: none,
  author: none,
  kind: "本科生课程实验报告",
  header-left: none,
  info: (:),
  first-line-indent: 0pt,
  body,
) = {
  set document(title: title, author: if author == none { () } else { author })
  set text(font: nju-fonts.song, size: 10.5pt, lang: "zh", region: "cn")
  set par(justify: true, leading: 0.72em, spacing: 0.9em, first-line-indent: first-line-indent)
  set list(indent: 1em, spacing: 0.6em, marker: text(fill: nju-purple)[•])
  set enum(indent: 1em, spacing: 0.6em)
  set heading(numbering: "1.1")
  set figure(gap: 0.9em)
  set figure.caption(separator: [　])
  show figure: set text(font: nju-fonts.hei)
  show figure.caption: set text(size: 8.8pt, font: nju-fonts.kai)
  show figure.caption: it => {
    if it.numbering != none {
      text(font: nju-fonts.hei, weight: "bold", fill: nju-purple)[#it.supplement #context it.counter.display(it.numbering)]
      it.separator
    }
    it.body
  }
  show table: set text(size: 9.5pt)
  show table: set par(justify: false, first-line-indent: 0pt)
  show strong: set text(font: nju-fonts.hei)
  // raw 内置规则会把字号缩到 0.8em，这里放大回约 0.95em，并与正文基线对齐
  show raw: set text(font: ("DejaVu Sans Mono", "Noto Sans CJK SC"), size: 1.18em)
  show raw.where(block: false): it => box(
    fill: nju-purple-light, inset: (x: 2.5pt), outset: (y: 2.5pt), radius: 2pt, it,
  )
  // 中文弯引号用 CJK 字体，避免西文字体的窄引号
  show regex("[“”‘’]"): set text(font: ("Noto Serif CJK SC",))
  show link: set text(fill: nju-purple)

  set page(
    paper: "a4",
    margin: (x: 2.3cm, top: 2.4cm, bottom: 2.2cm),
    // 首页无页眉，其余页：左校名小标 + 课程，右报告标题
    header: context if here().page() > 1 {
      set text(font: nju-fonts.hei, size: 8pt, fill: nju-purple)
      grid(
        columns: (auto, 1fr, auto),
        column-gutter: 6pt,
        align: horizon,
        image("assets/nju-emblem-purple.svg", height: 0.5cm),
        if header-left != none { header-left } else if course != none { course },
        title,
      )
      v(-0.35em)
      line(length: 100%, stroke: 0.5pt + nju-purple-mid)
    },
    footer: context {
      set text(font: nju-fonts.hei, size: 8.5pt, fill: nju-purple)
      let n = counter(page).get().first()
      let total = counter(page).final().first()
      align(center)[
        #box(line(length: 2.5em, stroke: 0.4pt + nju-purple-mid), baseline: -0.3em)
        #h(0.6em)#str(n)#text(fill: luma(140))[ \/ #str(total)]#h(0.6em)
        #box(line(length: 2.5em, stroke: 0.4pt + nju-purple-mid), baseline: -0.3em)
      ]
    },
    // 首页右下淡色校徽水印
    background: context if here().page() == 1 {
      place(bottom + right, dx: 3cm, dy: 1.5cm, image("assets/nju-emblem-watermark.svg", height: 10cm))
    },
  )

  show heading: set text(font: nju-fonts.hei)
  show heading.where(level: 1): it => block(above: 1.5em, below: 0.85em, sticky: true, width: 100%)[
    #set text(size: 15pt, weight: "bold", fill: nju-purple-dark)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      align: horizon,
      [
        #if it.numbering != none {
          text(fill: nju-purple)[#counter(heading).display("1.")]
          h(0.4em)
        }
        #it.body
      ],
      line(length: 100%, stroke: 0.6pt + nju-purple-mid),
    )
  ]
  show heading.where(level: 2): it => block(above: 1.15em, below: 0.65em, sticky: true)[
    #box(width: 3pt, height: 0.85em, fill: nju-purple, radius: 1pt, baseline: -0.1em)#h(6pt)
    #text(size: 12pt, weight: "bold", fill: nju-purple-dark)[
      #if it.numbering != none [#counter(heading).display("1.1")#h(0.5em)]#it.body
    ]
  ]
  show heading.where(level: 3): it => block(above: 1em, below: 0.55em, sticky: true)[
    #text(size: 10.5pt, weight: "bold", fill: nju-purple)[
      #if it.numbering != none [#counter(heading).display("1.1.1")#h(0.5em)]#it.body
    ]
  ]

  nju-title-block(title: title, subtitle: subtitle, course: course, kind: kind, info: info)
  body
}
