#import "theme.typ": *

// ---------- 首页标题区（不单设封面） ----------
#let nju-title-block(
  title: none,
  subtitle: none,
  course: none,
  kind: "本科生课程实验报告",
  info: (:),
) = {
  // 校徽 + 校名 + 报告类型
  grid(
    columns: (auto, auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    image("assets/nju-emblem-purple.svg", height: 1.45cm),
    image("assets/nju-name-purple.svg", height: 1.05cm),
    align(right, {
      set text(font: nju-fonts.hei, fill: nju-purple)
      text(size: 11pt, weight: "bold", tracking: 0.12em)[#kind]
      linebreak()
      text(size: 7.5pt, fill: nju-purple.lighten(30%), tracking: 0.08em)[NANJING UNIVERSITY · COURSE LAB REPORT]
    }),
  )
  v(0.3em)
  // 双线：粗紫 + 细金
  block(spacing: 0pt, line(length: 100%, stroke: 2.2pt + nju-purple))
  v(2pt)
  block(spacing: 0pt, line(length: 100%, stroke: 0.6pt + nju-gold))

  v(1.1em)
  align(center, {
    if course != none {
      text(font: nju-fonts.hei, size: 10pt, fill: luma(100), tracking: 0.2em)[#course]
      v(0.35em)
    }
    text(font: nju-fonts.title, size: 24pt, weight: "bold", fill: nju-purple-dark, tracking: 0.08em)[#title]
    if subtitle != none {
      v(0.25em)
      text(font: nju-fonts.kai, size: 13pt, fill: luma(70))[#subtitle]
    }
  })
  v(0.8em)

  // 信息卡：标签 / 值 两列交替
  if info.len() > 0 {
    let pairs = info.pairs()
    let cells = pairs.map(((k, v)) => (
      text(font: nju-fonts.hei, size: 9pt, weight: "bold", fill: nju-purple)[#k：],
      text(size: 9.5pt)[#v],
    )).flatten()
    block(
      width: 100%,
      inset: (x: 12pt, y: 9pt),
      fill: nju-purple-light,
      radius: 3pt,
      stroke: 0.5pt + nju-purple-mid,
      grid(
        columns: (auto, 1fr, auto, 1fr),
        column-gutter: (8pt, 16pt, 8pt),
        row-gutter: 7pt,
        align: (right + horizon, left + horizon),
        ..cells,
      ),
    )
  }
  v(0.6em)
}

