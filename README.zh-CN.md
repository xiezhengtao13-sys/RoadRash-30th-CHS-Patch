[English](README.md) | **简体中文**

# 《暴力摩托:30周年纪念版》简体中文补丁

非官方、爱好者制作的简体中文汉化,适用于 Steam 版 **Road Rash™: 30th Anniversary Edition**(AppID 2448570)。

## 汉化内容
- 菜单、功能说明、车行、车型介绍、比赛结果与提示、按键设置、联机/拨号提示、系统报错、制作名单,共 **1022 条**文本。
- 约 480 句车手对白按角色性格重新润色(艾克索粗野、博斯街头腔、西德大小姐、乔恩前科犯、珀尔朋克、朗达疯批、斯利姆和迈克各有风味)。
- 车型名、乐队/曲名、人名等专有名词保留英文,尽量保持原版风味。

**未汉化:** 烙在图片里的文字、`RoadRash95.exe` 内的联机对话框、视频字幕。

## 安装(一键)
1. 下载本仓库(**Code → Download ZIP**),解压。
2. **先关闭游戏**,再双击 **`install.bat`**。
   - 脚本会自动查找游戏目录(读取 Steam 注册表和所有 Steam 库文件夹)。找不到时,按提示粘贴 `...\steamapps\common\RoadRash` 的路径。
   - 它会把原文件备份为 `TEXT\ENU.DLL.orig`,然后在本机生成中文版。
3. 启动游戏即可。

## 还原英文
双击 **`restore_english.bat`**(或在 Steam 里"验证游戏文件完整性")。

## 注意
- Steam 的"验证游戏文件完整性"或游戏更新会把中文还原成英文,重新运行 `install.bat` 即可。
- 本仓库**不含任何游戏文件**,只有译文表 `translations.json`;中文版是在你本机用你自己的 `TEXT\ENU.DLL` 生成的。
- 没有 exe,只调用 Windows 自带 PowerShell,源码可直接查看。
- 如果脚本提示哈希不一致,说明你的游戏版本与测试版本不同,欢迎提 Issue。
- 想改进译文?编辑 `translations.json`(键是字符串 ID,值是译文;`%s` `%d` `\n` 必须保留),运行 `install.bat` 即可看到效果,欢迎提 PR。

## 许可
脚本 MIT,译文 CC BY-NC-SA 4.0。Road Rash 是 Electronic Arts 的商标,本项目与 EA 无关。
