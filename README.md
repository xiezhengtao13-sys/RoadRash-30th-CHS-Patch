# 《暴力摩托:30周年纪念版》简体中文补丁
# Road Rash: 30th Anniversary Edition - Simplified Chinese Patch

非官方、爱好者制作的简体中文汉化,适用于 Steam 版 **Road Rash™: 30th Anniversary Edition**(AppID 2448570)。

## 汉化内容
- 菜单、功能说明、车行、车型介绍、比赛结果与提示、按键设置、联机/拨号提示、系统报错、制作名单,共 1022 条文本。
- 约 480 句车手对白按角色性格重新润色(艾克索粗野、博斯街头腔、西德大小姐、乔恩前科犯、珀尔朋克、朗达疯批、斯利姆和迈克各有风味)。
- 车型名、乐队/曲名、人名等专有名词保留英文,尽量保持原版风味。

**未汉化:** 烙在图片里的文字、`RoadRash95.exe` 内的联机对话框、视频字幕。

## 安装
1. 下载本仓库(Code → Download ZIP),解压。
2. 双击 **`install.bat`**。脚本会自动查找 Steam 里的游戏目录,备份原文件为 `TEXT\ENU.DLL.orig`,然后生成中文版。
   - 找不到目录时,按提示粘贴 `...\steamapps\common\RoadRash` 的路径。
3. 启动游戏即可。

## 还原英文
双击 **`restore_english.bat`**(或在 Steam 里验证游戏文件完整性)。

## 注意
- Steam 的"验证游戏文件完整性"或游戏更新会把中文还原成英文,重新运行 `install.bat` 即可。
- 本补丁**不含任何游戏文件**,只包含译文表 `translations.json`;中文版是在你本机用你自己的 `TEXT\ENU.DLL` 生成的。
- 脚本只调用 Windows 自带 PowerShell,没有 exe,源码都能直接看。
- 如果脚本提示 `ENU.DLL` 哈希不一致,说明你的游戏版本与我测试的不同,欢迎提 Issue。
- 译文有问题或想改?直接编辑 `translations.json`(键是字符串 ID,值是译文;`%s` `%d` `\n` 必须保留),再运行 `install.bat` 就能看到效果。欢迎 PR。

## 许可
脚本 MIT,译文 CC BY-NC-SA 4.0。Road Rash 是 Electronic Arts 的商标,本项目与 EA 无关。

---

## English
Unofficial Simplified Chinese fan translation for the Steam release of Road Rash: 30th Anniversary Edition.
It ships only a translation table; `install.bat` rebuilds `TEXT\ENU.DLL` locally from your own copy (backup saved as `ENU.DLL.orig`). Run `restore_english.bat` to revert. Not affiliated with EA.
