# RadioExt MP3 Tools

A collection of tools to clean up MP3 files and generate metadata for use with the

### ❗ Disclamer

This is not a 100% fix. This could fully fix some people's issues fully.

Some might see no change in play back meaning issue still exists.

Some might see some files playing correctly and other files still have play back issues.

### Author's github

[RadioExt mod](https://github.com/justarandomguyintheinternet/CP77_radioExt) 

### 🎵 What is RadioExt?

[RadioExt on Nexus Mods](https://www.nexusmods.com/cyberpunk2077/mods/8977)

A Cyberpunk 2077 mod that allows custom radio stations using MP3 files. This tool ensures your tracks play correctly and avoid fallback issues.

---

## 📂 Folder Structure

```
mp3-fixer-tools/
├── rebuild_all_mp3s.bat            # Main MP3 fixer (converts MP3 > WAV > MP3 clean)
├── generate_songInfos.bat          # Generates songInfos.json from cleaned MP3s
├── ffmpeg.exe                      # Required for WAV conversion
├── ffprobe.exe                     # Required for generating songInfos.json
├── lame.exe                        # Required for final MP3 encoding
├── mp3s_to_fix/                    # Place original/broken MP3s here also used for json file creation.
├── mp3s_cleaned/                   # Cleaned MP3s will appear here
├── json_file_complete/             # songInfos.json will be placed here
```

## 🔽 Download the Latest Release

👉 [**Click here to download the latest tools (.zip)**](https://github.com/BSchweikart/RadioExt_MP3_Repair_Tools/releases/latest)

### 🔧 Included Tools
- Batch tools
   - [`generate_songInfos.bat`](https://github.com/BSchweikart/RadioExt_MP3_Repair_Tools/blob/v1.0.0/radioEXT-mp3-fixer-json-create/generate_songInfos.bat)
   - [`rebuild_all_mp3s.bat`](https://github.com/BSchweikart/RadioExt_MP3_Repair_Tools/blob/v1.0.0/radioEXT-mp3-fixer-json-create/rebuild_all_mp3s.bat)

- These exe's are bundled inside the ZIP, but you may also download them yourself: You may replace the included exe's with ones you trust if preferred.
- [FFmpeg Official Site](https://ffmpeg.org/download.html)
- [Gyan.dev FFmpeg Builds](https://www.gyan.dev/ffmpeg/builds/)
- [LAME MP3 Encoder (SourceForge)](https://lame.sourceforge.io/download.php)

- Template folders (`mp3s_to_fix`, `json_file_complete`)
- Everything you need in one package.

---

## 🛠 Requirements

(A non exe folder might be uploaded later but can read more through the links)
Download and place the following executables **in the same folder as the `.bat` files**:

### 🔹 `ffmpeg.exe` + `ffprobe.exe`
- 🔗 Download (ZIP): [FFmpeg Essentials Build](https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip)
- Open the downloaded ZIP and go into the `bin/` folder
- Copy both `ffmpeg.exe` **and** `ffprobe.exe` into the same folder as your `.bat` files
- `ffprobe.exe` is used for the json file creation, reads each file’s duration.

### 🔹 `lame.exe`
- Download: [https://www.rarewares.org/mp3-lame-bundle.php](https://www.rarewares.org/mp3-lame-bundle.php)
- Look for: **LAME 3.100.1 64-bit bundle**
- Extract `lame.exe` only into this folder

---

## 🧾 Generate `songInfos.json` (Recommended First Step)

### 🔹 This might be all you need!

If your songs play correctly in-game but RadioExt logs:
```
[RadioExt] Invalid length for song: ...
```
...you can skip re-encoding and just create a `songInfos.json` to override the fallback behavior.

This is the **quickest and cleanest solution** for most users with working MP3s but minor metadata issues.


If you're worried about fallback behavior in RadioExt or want to guarantee song lengths:

1. After fixing MP3s, run:
   You can place your MP3s right into cleaned to just get the json file.
   ```
   generate_songInfos.bat
   ```
2. The file `songInfos.json` will appear in `json_file_complete/`
3. Copy that file into your custom station folder:

**Full path example:**
```
Cyberpunk 2077/
└── bin/
    └── x64/
        └── plugins/
            └── cyber_engine_tweaks/
                └── mods/
                    └── radioExt/
                        └── radios/
                            └── YourStationName/
                                ├── songInfos.json ✅
                                ├── YourSong1.mp3
                                ├── YourSong2.mp3
```
   ```
   Cyberpunk 2077/bin/x64/plugins/cyber_engine_tweaks/mods/radioExt/radios/YourStationName/
   
   ```

---

## 🔧 Optional: Re-encode MP3s with LAME (If songInfos.json doesn't solve it)

1. Place your original MP3s into the `mp3s_to_fix/` folder
2. Run:
   ```
   rebuild_all_mp3s.bat
   ```
3. Clean files will appear in `mp3s_cleaned/`  
   → These are ready for use with RadioExt

---

## ✅ Notes

- Cleaned MP3s will include:
  - `encoder: LAME3.100`
  - `probe_score: 100`
- RadioExt will no longer fallback to 180s if the metadata is clean or songInfos.json is present

---

## 🎵 Fallback Option: Use Audacity if LAME Fails

If your file is still giving fallback errors, and `lame.exe` doesn't seem to help, you can try fixing it with [**Audacity**](https://www.audacityteam.org/):

1. Open your MP3 in Audacity
2. Go to `File → Export → Export as MP3`
3. Use:
   - Constant Bitrate: 320 kbps
   - Sample Rate: 44100 Hz
   - Channel Mode: Joint Stereo
4. In the metadata window:
   - Add a **Title** and **Artist** (or just "Unknown")
5. Save the file and test it in-game

Audacity re-exports using LAME internally and will reset the broken metadata headers without needing advanced tools.

---

Happy broadcasting! 🎧

---

## 📜 License Notice

## 🛡️ License

This tool is licensed under the **GNU General Public License v3.0**.

This file is provided to comply with the **LGPL 2.1 license requirements** of the LAME encoder.

You are free to use, modify, and distribute it under the terms of the GPL.

See [`LICENSE`](LICENSE) for full details.

This tool includes open-source binaries from the following projects:

### 🔹 [FFmpeg Project](https://ffmpeg.org) — `ffmpeg.exe`, `ffprobe.exe`
- These are compiled from the **GPL v3 build** of FFmpeg.
- Distributed under the **GNU General Public License v3 (GPL v3)**
- Downloaded from:  
  [https://www.gyan.dev/ffmpeg/builds/ffmpeg-n7.1-latest-win64-gpl-7.1.zip](https://www.gyan.dev/ffmpeg/builds/ffmpeg-n7.1-latest-win64-gpl-7.1.zip)
- See [`LICENSE`](LICENSE) or (https://www.gnu.org/licenses/gpl-3.0.txt) for the full license text.

### 🔹 [LAME MP3 Encoder](https://lame.sourceforge.io/) — `lame.exe`
- Distributed under the **LGPL v2.1** license
- Source and license details:  
  [https://www.rarewares.org/mp3-lame-bundle.php](https://www.rarewares.org/mp3-lame-bundle.php)
- See [`LICENSE LAMEE`](LICENSE_lame) or (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) for full license text.

### 🔹 Batch Script (`generate_songInfos.bat`)
- Provided under the **GNU General Public License v3**
- You are free to use, modify, and distribute this tool under the same license terms

---

By distributing this tool, you acknowledge the licensing terms of these components.  
If you modify or distribute the batch script alongside FFmpeg GPL binaries, your modifications must also follow the GPL license.

---

## ✅ Distributing This Tool

You may freely bundle and redistribute this tool as long as you:
- Include the **GPL license text** for FFmpeg [`LICENSE`](LICENSE)
- Include the **LGPL license text** for LAME [`LICENSE LAME`](LICENSE_lame)
- Do not remove attribution or alter licensing terms

---
