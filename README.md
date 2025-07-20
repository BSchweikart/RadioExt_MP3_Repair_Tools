### ❗  IN THE PROCESS OF A FULL UPDATE FULL BAT FILES ARE BEING UPDATED A FULL REWORK. SO FAR THIS IS WORKING ON MY END THIS README WILL BE UPDATED WITH WORKING LINKS  ❗

# 🎧 RadioExt Fixer Utilities

A simple utility toolkit for preparing MP3 files and generating the required JSON metadata.
A songInfos json can also be created.

Happy modding, chooms. 💿🎙️📡

### Author's github

[RadioExt mod](https://github.com/justarandomguyintheinternet/CP77_radioExt) 

### 🎵 What is RadioExt?

[RadioExt on Nexus Mods](https://www.nexusmods.com/cyberpunk2077/mods/8977)

A Cyberpunk 2077 mod that allows custom radio stations using MP3 files. This tool ensures your tracks play correctly and avoid fallback issues.

---

### ❗ Disclamer

This toolset is not a guaranteed 100% fix.

- ✅ Some users may see fully working custom stations
- ⚠️ Others may need to troubleshoot deeper mod or system issues
- 🔁 Still useful for prepping your station in a clean, standard format

---

## 🛡️ Antivirus Notice

Some antivirus software may flag `.bat` files or bundled `.exe` tools like `ffmpeg.exe` or `lame.exe` as suspicious. This is a common false positive for:

- 🟨 Batch scripts (`.bat`) that automate file changes
- 🟦 Open-source command-line tools such as FFmpeg or LAME

### ✅ Safety and Verification

These tools are open-source and widely used. You can verify their integrity at the following sources:

- [FFmpeg Official Site](https://ffmpeg.org/)
- [Gyan.dev FFmpeg Builds](https://www.gyan.dev/ffmpeg/builds/)
- [LAME MP3 Encoder](https://lame.sourceforge.io/)

If you’d like extra peace of mind, we recommend:

- Running a scan on the `.zip` or individual tools with your antivirus
- Uploading `.bat` files or executables to [VirusTotal](https://www.virustotal.com/) for manual scanning

> ✅ All `.bat` files in this toolkit have been tested and passed local scans using **Bitdefender** with no detections.

If your antivirus flags a false positive:
- Create an exception for this folder/toolkit
- Or clone/download the `.bat` files directly from the official GitHub repository

---

## 📦 What’s Included?

| Script                    | Purpose |
|---------------------------|---------|
| `fix_radioEXTmp3s.bat`    | Cleans your MP3s for the mod (bitrate, metadata, headers)  
| `build_metadata.bat`      | Prompts you for station details and builds `metadata.json`  
| `generate_songInfos.bat`  | Scans cleaned MP3s and builds `songInfos.json`  
| `create_station.bat`      | Guides you through the full setup and generates a Vortex-ready `.zip` mod package  

---

## 🗂 Folder Structure (Auto-created by scripts)

```
radioEXT_fixer_utilities/
├── completed_files/          # Cleaned MP3s + final JSONs (output folder)
├── mp3s_to_fix/              # Drop your original MP3s here
├── logs/                     # All log files from batch scripts
├── metadata_template/        # Contains default metadata.json
├── *.bat                     # All scripts listed above
├── ffmpeg.exe                # Must be present here
├── ffprobe.exe               # Required for songInfos
├── lame.exe                  # Required for LAME re-encoding
```

---

## 🔽 Download the Latest Release

👉 [**Click here to download the latest tools (.zip)**](https://github.com/BSchweikart/RadioExt_MP3_Repair_Tools/releases/latest)

### 🔧 Included Tools
- Batch tools
   - [`create_station.bat`]()
   - [`fix_radioEXTmp3s.bat`]()
   - [`build_metadata.bat`]()
   - [`generate_songInfos.bat`]()

- These exe's are bundled inside the ZIP, but you may also download them yourself: You may replace the included exe's with ones you trust if preferred.
- [FFmpeg Official Site](https://ffmpeg.org/download.html)
- [Gyan.dev FFmpeg Builds](https://www.gyan.dev/ffmpeg/builds/)
- [LAME MP3 Encoder (SourceForge)](https://lame.sourceforge.io/download.php)

- Template folders (`mp3s_to_fix`, `completed_files`)
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

## 🚀 Getting Started (Recommended Path) for Beginners

### 🎮 Use `create_station.bat` — One script to do it all

If you're new to RadioExt, this script handles **everything for you**:

Just run:
```
create_station.bat
```

It will guide you through:

1. 🗃️ Creating all needed folders
2. 🎵 Cleaning your MP3s (`fix_radioEXTmp3s.bat`)
3. 🧾 Generating `metadata.json` from a template (`build_metadata.bat`)
4. 📄 Creating `songInfos.json` from your cleaned MP3s
5. 🎙️ Naming your station
6. 📦 Packaging everything into:
   - A Vortex-compatible `.zip`
   - A standard folder you can install manually

When complete,
You can immediately:
- Drop the `.zip` into Vortex  
- Or install the folder manually
The final mod structure will look like this and inside the `completed_files` folder:

```
completed_files\
├── YourStationName\            ← 📁 Manual install folder
│   └── bin\
│       └── x64\
│           └── plugins\
│               └── cyber_engine_tweaks\
│                   └── mods\
│                       └── radioExt\
│                           └── YourStationName\
│                               ├── metadata.json
│                               ├── songInfos.json
│                               └── *.mp3
└── YourStationName.zip         ← 📦 Vortex-compatible ZIP

---
Manual install

```
   - Copy all files starting with bin into radios section of radioEXT mod folder:
     ```
     YourStationName/
     └── bin/
         └── x64/
             └── plugins/
                 └── cyber_engine_tweaks/
                     └── mods/
                         └── radioExt/
                             └── radios/
                                 └── YourStationName/
                                     ├── songInfos.json
                                     ├── metadata.json
                                     ├── YourSong1.mp3
                                     ├── YourSong2.mp3

file path:

Cyberpunk 2077/bin/x64/plugins/cyber_engine_tweaks/mods/radioExt/radios/YourStationName/
---

📝 All steps log to `logs\create_station_bat_log.txt` for easy debugging.

---

## ⚙️ Advanced Usage (Manual Steps)

For experienced users who want more control, you can run each batch script individually:

### 🧪 Step 1: Clean MP3s
```
fix_radioEXTmp3s.bat
```
- Input: `mp3s_to_fix\`
- Output: Cleaned MP3s → `completed_files\`
- Logs: `logs\fix_radioEXTmp3s_bat_log.txt`

### 📝 Step 2: Create `metadata.json`
```
build_metadata.bat
```
- Prompts for station name, stream toggle, icon, and optional order
- Output: `completed_files\metadata.json`
- Logs: `logs\build_metadata_bat_log.txt`

### 📄 Step 3: Create `songInfos.json`
```
generate_songInfos.bat
```
- Reads MP3s in `completed_files\`
- Calculates song durations in ticks
- Output: `completed_files\songInfos.json`
- Logs: `logs\generate_songInfos_bat_log.txt`

---

## ✅ Advanced Notes

- If you're using a **streaming radio URL** instead of MP3s, `build_metadata.bat` will prompt you for it and update `streamInfo` accordingly
- `order` inside `metadata.json` is optional, but not all songs should be listed — only highlight tracks you want in a fixed order
- If you’re using a custom icon atlas, the script lets you enable `customIcon.useCustom: true`

---

## 🧰 Troubleshooting

If `songInfos.json` doesn’t fix RadioExt fallback issues, make sure:

- Your MP3s were cleaned using `fix_radioEXTmp3s.bat`
- The files use 320kbps CBR, 44.1kHz, Joint Stereo, with stripped tags
- `ffmpeg.exe`, `ffprobe.exe`, and `lame.exe` are in the root folder

Still stuck? Try exporting the MP3 manually in **Audacity** with:
- Bitrate: 320kbps
- Sample rate: 44100 Hz
- Joint Stereo
- No ReplayGain or metadata

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
