#import "../src/lib.typ": *

#show: nju-lab.with(
  title: "NJU 实验报告模板使用说明",
  subtitle: "nju-exp-report · 0.1.0",
  course: "非官方课程实验报告模板",
  author: "yama-lei",
  kind: "模板使用说明",
  info: ("编译器": "Typst ≥ 0.14.2", "包命名空间": "@local"),
)

= 新建报告

本包尚未发布到 Typst Universe。克隆仓库后，在仓库根目录运行：

```bash
bash scripts/package @local
typst init @local/nju-exp-report:0.1.0 my-report
typst compile my-report/main.typ my-report/main.pdf
```

安装脚本需要 Bash 4 及以上版本和 Perl。手动安装方式见仓库 README。编辑生成的 `main.typ` 即可修改报告，不需要复制包内的校徽和样式文件。

= 应用模板

```typ
#import "@local/nju-exp-report:0.1.0": *
#show: nju-lab.with(
  title: "实验报告",
  subtitle: "实验名称",
  course: "课程名称 · 实验一",
  author: "张三",
  info: ("姓名": "张三", "学号": "填写学号"),
)

= 实验目的

在这里开始正文。
```

模板设置 A4 页面、南大紫配色、中文正文和三级标题样式。首页不显示页眉，后续页在页眉显示校徽、课程和报告标题。每页显示当前页码与总页数。模板不单设封面，不自动生成目录。

== 参数

#nju-table(
  columns: (1.25fr, 1.6fr, 2.8fr),
  table.header(hcell[参数], hcell[默认值], hcell[作用]),
  [`title`], [`"实验报告"`], [主标题及 PDF 标题],
  [`subtitle`], [`none`], [首页副标题],
  [`course`], [`none`], [课程名称及默认左页眉],
  [`author`], [`none`], [PDF 作者元数据，不自动写入信息卡],
  [`kind`], [`"本科生课程实验报告"`], [首页右上方报告类型],
  [`header-left`], [`none`], [覆盖后续页的左页眉],
  [`info`], [`(:)`], [按顺序排列的信息字典，空字典隐藏],
  [`first-line-indent`], [`0pt`], [正文首行缩进，例如 `2em`],
)

#pagebreak()

= 组件示例

== 表格与图表引用

`nju-table` 接受 `table` 的参数，第一行为紫色背景。表头使用 `hcell` 设置白色文字，使用 `table.header` 标明需跨页重复的表头。带编号的表格应放在 `figure` 中，例如 @tab:demo。

#figure(
  nju-table(
    columns: (1fr, 2fr),
    table.header(hcell[组件], hcell[作用]),
    [`nju-table`], [紫色表头与隔行底色],
    [`hcell`], [白色粗体表头文字],
    [`nju-note`], [带标题的提示框],
    [`nju-section`], [不编号的装饰标题],
  ),
  caption: [通用组件],
) <tab:demo>

```typ
#figure(
  nju-table(
    columns: (1fr, 2fr),
    table.header(hcell[项目], hcell[结果]),
    [实验 A], [通过],
  ),
  caption: [实验结果],
) <tab:results>
```

== 提示框

#nju-note(title: "复现要求")[请记录实验环境、输入数据和完整命令。]

```typ
#nju-note(title: "复现要求")[请记录实验环境、输入数据和完整命令。]
```

== 装饰标题

#nju-section[附录示例]

`nju-section` 不改变标题计数，也不进入目录。如需可引用的非编号标题，可使用原生的 `heading(numbering: none)`。

== 仅使用标题区

`nju-title-block` 接受 `title`、`subtitle`、`course`、`kind`、`info`，默认均为空，`kind` 默认是“本科生课程实验报告”。它不设置页边距、正文样式和页码，适用于已有页面布局的文档。

= 字体与素材

字体字典 `nju-fonts` 包含 `song`、`hei`、`kai` 和 `title` 四组候选字体。建议安装 Noto Serif CJK SC、Noto Sans CJK SC 和 FandolKai。Times New Roman 和小标宋等候选字体不是使用模板的必要条件。字体变化可能影响字形和分页，提交前应检查 PDF。

导出的颜色包括 `nju-purple`、`nju-purple-dark`、`nju-purple-light`、`nju-purple-mid` 与 `nju-gold`。仅导入模块不会全局应用样式。

模板代码采用 MIT 许可证，校徽和校名来自 OrangeX4 的 modern-nju-thesis，保留了上游 MIT 版权声明。完整许可见仓库 `LICENSE`、`THIRD_PARTY.md` 与 `licenses/`。本模板未经南京大学官方认证，课程的提交要求以任课教师规定为准。
