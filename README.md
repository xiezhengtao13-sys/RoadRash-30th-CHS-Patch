**English** | [简体中文](README.zh-CN.md)

# Road Rash: 30th Anniversary Edition — Simplified Chinese Patch

Unofficial fan translation (Simplified Chinese) for the Steam release of **Road Rash™: 30th Anniversary Edition** (AppID 2448570).

## What is translated
- Menus, option descriptions, bike shop, bike descriptions, race results and prompts, key bindings, network/dial-up messages, system errors and credits — **1022 strings**.
- About 480 rider taunts rewritten to fit each character's personality.
- Bike model names, band/song titles and personal names stay in English to keep the original flavor.

**Not translated:** text baked into images, the network dialogs inside `RoadRash95.exe`, video subtitles.

## Install (one click)
1. Download this repo (**Code → Download ZIP**) and extract it.
2. **Close the game**, then double-click **`install.bat`**.
   - It finds your game folder automatically (Steam registry + all Steam library folders). If it can't, paste the path to `...\steamapps\common\RoadRash` when asked.
   - It backs up your original file as `TEXT\ENU.DLL.orig`, then builds the Chinese version locally.
3. Launch the game.

## Restore English
Double-click **`restore_english.bat`** (or use Steam → *Verify integrity of game files*).

## Notes
- Steam's *Verify integrity* or a game update reverts the patch — just run `install.bat` again.
- This repo contains **no game files**, only the translation table `translations.json`. The patched file is generated on your PC from your own `TEXT\ENU.DLL`.
- No exe: only Windows' built-in PowerShell, fully readable source.
- If the script reports a hash mismatch, your game version differs from the tested one — please open an Issue.
- Want to improve the translation? Edit `translations.json` (key = string ID, value = text; keep `%s`, `%d`, `\n`), run `install.bat`, and send a PR.

## License
Scripts: MIT. Translation: CC BY-NC-SA 4.0. Road Rash is a trademark of Electronic Arts; this project is not affiliated with EA.
