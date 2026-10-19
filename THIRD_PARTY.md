# 第三方素材与代码

## 校徽与校名

`src/assets/` 中的 SVG 来自 [modern-nju-thesis](https://github.com/nju-lug/modern-nju-thesis)，作者 OrangeX4，采用 MIT 许可证。

- `nju-emblem-purple.svg` 与 `nju-name-purple.svg` 为南大紫配色版本。
- `nju-emblem-watermark.svg` 为淡色水印版本。
- 上游版权声明及完整许可证见 [licenses/modern-nju-thesis-MIT.txt](licenses/modern-nju-thesis-MIT.txt)。

本项目是非官方课程实验报告模板。软件许可不表示南京大学对本项目的认可，也不授予额外的校徽、校名或商标使用权。

## 仓库辅助脚本

`scripts/setup`、`scripts/package` 和 `scripts/uninstall` 由仓库初始骨架提供，其中包含改编自 [CeTZ 打包脚本](https://github.com/johannes-wolf/cetz/blob/35c0868378cea5ad323cc0d9c2f76de8ed9ba5bd/scripts/package) 的代码，采用 Apache-2.0 许可证。原始来源注释保留在各文件中，完整许可证见 [licenses/Apache-2.0.txt](licenses/Apache-2.0.txt)。本次整理修正了脚本的工作目录处理和临时目录清理。
