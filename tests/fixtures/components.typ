#import "@local/nju-exp-report:0.1.0": *

#assert.eq(nju-purple, rgb("#630460"))
#assert.eq(nju-purple-dark, rgb("#4a0347"))
#assert.eq(nju-fonts.keys(), ("song", "hei", "kai", "title"))
#assert.eq(type(nju-table(columns: 1, [内容])), content)
#assert.eq(type(nju-note[内容]), content)
#assert.eq(type(nju-section[附录]), content)
#assert.eq(type(nju-title-block()), content)

#show: nju-lab.with(
  title: "组件回归测试",
  subtitle: "独立包导入",
  course: "测试课程",
  author: ("甲", "乙"),
  kind: "测试报告",
  header-left: "自定义页眉",
  first-line-indent: 2em,
  info: ("姓名": "张三", "学号": "000000", "日期": [测试日期]),
)

= 一级标题

== 二级标题

=== 三级标题

正文含 *强调*、_斜体_、`code`、“中文引号”、#link("https://www.nju.edu.cn")[超链接] 和 $a^2 + b^2 = c^2$。

- 无序列表
+ 有序列表

#nju-note[默认标题的提示框。]
#nju-note(title: "自定义标题")[自定义提示内容。]

#figure(
  nju-table(
    columns: (1fr, 2fr),
    table.header(hcell[字段], hcell[结果]),
    [第一行], [通过],
    [第二行], [通过],
  ),
  caption: [有编号的表格],
) <tab:test>

引用 @tab:test。

#figure(rect(width: 2cm, height: 1cm), caption: [有编号的图]) <fig:test>
引用 @fig:test。

#pagebreak()

= 第二页

这一页应显示校徽、自定义页眉及页码。

#figure(
  rect(width: 2cm, height: 1cm),
  caption: [无编号图题],
  numbering: none,
)

#heading(numbering: none)[不编号的原生标题]
#nju-section[附录]

```python
print("hello, NJU")
```

#context {
  assert.eq(counter(page).final().first(), 2)
  assert.eq(counter(heading).get().first(), 2)
}

#metadata("components-ok") <result>
