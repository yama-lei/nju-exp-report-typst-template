#import "@local/nju-exp-report:0.1.0": *

#show: nju-lab.with()

= 默认配置

不填写课程、副标题、作者和信息卡时，也应能编译。

#pagebreak()

= 后续页

左侧页眉没有课程名称，右侧仍显示默认标题。

#context assert.eq(counter(page).final().first(), 2)
