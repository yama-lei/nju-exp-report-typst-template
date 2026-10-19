#import "theme.typ": *

// ---------- 通用组件 ----------
// 表头文字
#let hcell(c) = text(fill: white, weight: "bold", font: nju-fonts.hei)[#c]

// 紫色表头、隔行浅底的表格
#let nju-table(..args) = table(
  inset: 4.5pt,
  stroke: (x, y) => (
    top: if y == 0 { none } else { 0.4pt + luma(205) },
    bottom: 0.6pt + if y == 0 { nju-purple } else { luma(205) },
    left: none, right: none,
  ),
  fill: (x, y) => if y == 0 { nju-purple } else if calc.rem(y, 2) == 0 { nju-purple-light },
  ..args,
)

// 不编号的一级标题样式（附录、致谢等）
#let nju-section(body) = block(above: 1.4em, below: 0.8em, sticky: true, width: 100%)[
  #set text(font: nju-fonts.hei, size: 15pt, weight: "bold", fill: nju-purple-dark)
  #grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    body, line(length: 100%, stroke: 0.6pt + nju-purple-mid),
  )
]

// 提示框
#let nju-note(title: "说明", body) = block(
  width: 100%,
  inset: (x: 10pt, y: 8pt),
  fill: nju-purple-light,
  stroke: (left: 2.5pt + nju-purple),
  radius: (right: 3pt),
)[
  #text(font: nju-fonts.hei, weight: "bold", fill: nju-purple)[#title]#h(0.6em)#body
]

