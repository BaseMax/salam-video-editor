# salam-video-editor

A Salam port of a Python FFmpeg video trimmer/editor.

Trim a video, optionally add intro/outro stills, and compress with FFmpeg.

## Requirements

- `ffmpeg` and `ffprobe` on PATH. If they are missing, the program prints install instructions for your OS.
  - Windows: `winget install Gyan.FFmpeg`
  - macOS: `brew install ffmpeg`
  - Linux (Debian/Ubuntu): `sudo apt install ffmpeg`
  - Linux (Fedora): `sudo dnf install ffmpeg`
  - Linux (Arch): `sudo pacman -S ffmpeg`
  - FreeBSD: `sudo pkg install ffmpeg`
- Salam compiler (`salam`) >= 0.5.9

## Build & Run

```bash
salam run main.salam -- input.mp4 -o output.mp4
```

### Quick start with the bundled intro/outro images

This repository ships `images/start.png` and `images/end.png`. To process `episode1.mp4` with a 3-second intro and outro:

```bash
salam run main.salam -- episode1.mp4 \
  --intro-image images/start.png --intro-duration 3 \
  --outro-image images/end.png --outro-duration 3 \
  -o output.mp4
```

Or use the helper script:

```bash
./run.sh
```

## Options

- `--remove-start SECONDS` — seconds to remove from the beginning
- `--remove-end SECONDS` — seconds to remove from the end
- `--intro-image PATH` — image shown before the video
- `--intro-duration SECONDS` — how long to show the intro (default 3)
- `--outro-image PATH` — image shown after the video
- `--outro-duration SECONDS` — how long to show the outro (default 3)
- `--codec h264|h265` — video codec (default h264)
- `--crf N` — quality level (default 23 for h264, 28 for h265)
- `--preset NAME` — encoder preset (default slow)
- `--audio-bitrate RATE` — AAC audio bitrate (default 128k)
- `--max-dimension N` — cap width/height (default 1920; 0 keeps source resolution)
- `--ffmpeg NAME_OR_PATH` — ffmpeg executable (default ffmpeg)
- `--ffprobe NAME_OR_PATH` — ffprobe executable (default ffprobe)
- `--overwrite` — overwrite the output file if it exists

## Notes

- `~` in paths is expanded using `HOME` (or `USERPROFILE` on Windows).
- Output defaults to `INPUT_edited.mp4` next to the input.
- Image and video outputs are gitignored; only `images/start.png` and `images/end.png` are tracked.