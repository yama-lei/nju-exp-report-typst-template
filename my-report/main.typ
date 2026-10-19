#import "@local/nju-exp-report:0.1.0": *

#let student-name = sys.inputs.at("student-name", default: "张三")
#let student-id = sys.inputs.at("student-id", default: "填写学号")
#let report-date = sys.inputs.at("report-date", default: "填写日期")

#show: nju-lab.with(
  title: "实验报告",
  subtitle: "实验名称",
  course: "课程名称 · 实验一",
  author: student-name,
  info: (
    "学号": student-id,
    "姓名": student-name,
    "班级": "填写班级",
    "日期": report-date,
  ),
)

= 实验目的

在这里说明本次实验需要验证的问题与预期结果。正文支持 *加粗*、_强调_、`行内代码` 和数学公式 $E = m c^2$。

= 实验环境与方法

== 实验环境

#nju-table(
  columns: (1fr, 2fr),
  table.header(hcell[项目], hcell[配置]),
  [操作系统], [填写系统名称与版本],
  [工具], [填写工具名称与版本],
  [实验数据], [说明来源、规模与单位],
)

== 实验步骤

+ 准备实验环境与数据，记录初始条件。
+ 按照实验要求执行操作，保留中间结果。
+ 对照预期结果检查输出，分析偏差原因。

#nju-note(title: "记录要求")[保留复现实验所需的命令、参数和原始数据。]

= 实验结果与分析

记录测量结果，并解释结果是否符合预期。表格可以配上编号和引用，见 @tab:results。

#figure(
  nju-table(
    columns: (1fr, 1fr, 1fr),
    table.header(hcell[实验组], hcell[测量值], hcell[单位]),
    [A], [填写结果], [填写单位],
    [B], [填写结果], [填写单位],
  ),
  caption: [实验测量结果],
) <tab:results>

= 实验总结

总结实验结论、遇到的问题和仍未验证的假设。
