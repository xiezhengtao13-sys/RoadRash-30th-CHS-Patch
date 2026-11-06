<#
Road Rash 30th Anniversary Edition - Simplified Chinese patch installer / 暴力摩托30周年纪念版 简体中文补丁安装器
Usage:  install.ps1 [-GameDir "D:\...\steamapps\common\RoadRash"] [-Restore] [-Force]
Only the translation table (translations.json) is distributed. The patch is built locally from YOUR own ENU.DLL.
本补丁只发布译文表,在你本机用你自己的 ENU.DLL 生成中文版,不包含任何 EA 的文件。
#>
param([string]$GameDir = "", [switch]$Restore, [switch]$Force)
$ErrorActionPreference = "Stop"
$KnownHash = "2309D5B30560103C7A8B3B97E626877FB89FD85164F82186082DC1C665466E70"

function Find-GameDir {
    $libs = @()
    foreach ($k in @("HKCU:\Software\Valve\Steam", "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam")) {
        try {
            $v = (Get-ItemProperty $k -ErrorAction Stop)
            foreach ($n in @("SteamPath", "InstallPath")) { if ($v.$n) { $libs += ($v.$n -replace '/', '\') } }
        } catch {}
    }
    foreach ($l in @($libs)) {
        $vdf = Join-Path $l "steamapps\libraryfolders.vdf"
        if (Test-Path $vdf) {
            foreach ($m in [regex]::Matches((Get-Content $vdf -Raw), '"path"\s+"([^"]+)"')) { $libs += ($m.Groups[1].Value -replace '\\\\', '\') }
        }
    }
    foreach ($l in ($libs | Select-Object -Unique)) {
        $c = Join-Path $l "steamapps\common\RoadRash"
        if (Test-Path (Join-Path $c "TEXT\ENU.DLL")) { return $c }
    }
    return $null
}

if (-not $GameDir) { $GameDir = Find-GameDir }
if (-not $GameDir) { $GameDir = Read-Host "Game folder not found. Paste the RoadRash folder path / 没找到游戏目录,请粘贴 RoadRash 文件夹路径" }
$dll = Join-Path $GameDir "TEXT\ENU.DLL"
$bak = "$dll.orig"
if (-not (Test-Path $dll)) { throw "ENU.DLL not found: $dll" }
Write-Host "Game: $GameDir"
if (Get-Process -Name RoadRash95 -ErrorAction SilentlyContinue) { throw "Road Rash is running. Please close the game first. / 游戏正在运行,请先关闭游戏再安装。" }

if ($Restore) {
    if (-not (Test-Path $bak)) { throw "No backup (ENU.DLL.orig) found. Use Steam > Verify integrity of game files. / 没有备份,请用 Steam 验证游戏文件完整性。" }
    Copy-Item $bak $dll -Force
    Write-Host "Restored English. / 已恢复英文原版。" -ForegroundColor Green
    return
}

if (-not (Test-Path $bak)) {
    $h = (Get-FileHash $dll -Algorithm SHA256).Hash
    if ($h -ne $KnownHash -and -not $Force) {
        throw "ENU.DLL is not the expected original (hash mismatch). Game version may differ. Use -Force to continue. / ENU.DLL 与预期原版不一致,可能是游戏版本不同或已被改过,加 -Force 强制继续。"
    }
    Copy-Item $dll $bak
    Write-Host "Backup created: $bak"
}

$tr = New-Object "System.Collections.Generic.Dictionary[int,string]"
$json = Get-Content (Join-Path $PSScriptRoot "translations.json") -Raw -Encoding UTF8 | ConvertFrom-Json
foreach ($pr in $json.PSObject.Properties) { $tr[[int]$pr.Name] = [string]$pr.Value }

Add-Type -TypeDefinition @"
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
public static class RRPatch {
  [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)] static extern IntPtr LoadLibraryExW(string f, IntPtr h, uint fl);
  [DllImport("kernel32.dll")] static extern bool FreeLibrary(IntPtr h);
  [DllImport("user32.dll", CharSet=CharSet.Unicode)] static extern int LoadStringW(IntPtr h, uint id, out IntPtr buf, int max);
  [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)] static extern IntPtr BeginUpdateResourceW(string f, bool del);
  [DllImport("kernel32.dll", SetLastError=true)] static extern bool UpdateResourceW(IntPtr h, IntPtr type, IntPtr name, ushort lang, byte[] data, uint cb);
  [DllImport("kernel32.dll", SetLastError=true)] static extern bool EndUpdateResourceW(IntPtr h, bool discard);
  public static int Apply(string src, string dst, Dictionary<int,string> tr) {
    File.Copy(src, dst, true);
    IntPtr lib = LoadLibraryExW(src, IntPtr.Zero, 0x2);
    if (lib == IntPtr.Zero) throw new Exception("LoadLibraryEx failed " + Marshal.GetLastWin32Error());
    var blocks = new SortedDictionary<int, byte[]>();
    var ids = new HashSet<int>();
    foreach (var k in tr.Keys) ids.Add(k / 16);
    foreach (int b in ids) {
      var ms = new MemoryStream();
      for (int i = 0; i < 16; i++) {
        int id = b * 16 + i; string s;
        if (tr.ContainsKey(id)) s = tr[id];
        else { IntPtr p; int n = LoadStringW(lib, (uint)id, out p, 0); s = n > 0 ? Marshal.PtrToStringUni(p, n) : ""; }
        byte[] u = Encoding.Unicode.GetBytes(s);
        ms.WriteByte((byte)(s.Length & 255)); ms.WriteByte((byte)(s.Length >> 8));
        ms.Write(u, 0, u.Length);
      }
      blocks[b + 1] = ms.ToArray();
    }
    FreeLibrary(lib);
    IntPtr h = BeginUpdateResourceW(dst, false);
    if (h == IntPtr.Zero) throw new Exception("BeginUpdateResource failed " + Marshal.GetLastWin32Error());
    foreach (var kv in blocks)
      if (!UpdateResourceW(h, (IntPtr)6, (IntPtr)kv.Key, 1033, kv.Value, (uint)kv.Value.Length)) throw new Exception("UpdateResource failed " + Marshal.GetLastWin32Error());
    if (!EndUpdateResourceW(h, false)) throw new Exception("EndUpdateResource failed " + Marshal.GetLastWin32Error());
    return blocks.Count;
  }
}
"@

$tmp = Join-Path $env:TEMP "RoadRash_CHS_ENU.DLL"
$n = [RRPatch]::Apply($bak, $tmp, $tr)
Copy-Item $tmp $dll -Force
Remove-Item $tmp -Force
Write-Host "Done. Patched $n string blocks, $($tr.Count) strings. / 完成:已汉化 $($tr.Count) 条文本。" -ForegroundColor Green
Write-Host "Note: Steam 'Verify integrity' or a game update will revert it; just run this again. / Steam 验证或更新会还原,重新运行本脚本即可。"
