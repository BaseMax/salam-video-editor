# salam-video-editor

A Salam port of a Python FFmpeg video trimmer/editor.

Trim a video, optionally add intro/outro stills, automatically crop black bars/time-varying padding, and compress with FFmpeg.

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

### Auto-crop (remove black bars and padding)

Automatically detect and crop black borders and apply time-varying padding removal (default: 1 cm from every edge in the first 10 minutes, 2 cm in the last 5 minutes), then scale to fill the frame.

The crop area is **detected dynamically across the whole video** by sampling segments (not just the first frames), so changes in frame size/content/padding at different times (for example 10m–15m having different width/height or borders) are detected and cropped correctly. Adjacent segments with the same crop are merged for efficiency, and all segments are scaled to a common output size.

```bash
salam run main.salam -- input.mp4 --auto-crop -o output.mp4
```

With intro/outro and custom padding:

```bash
salam run main.salam -- input.mp4 \
  --auto-crop --crop-padding-first-cm 1 --crop-padding-last-cm 2 \
  --crop-first-minutes 10 --crop-last-minutes 5 \
  --intro-image images/start.png --intro-duration 3 \
  --outro-image images/end.png --outro-duration 3 \
  -o output.mp4
```

## Options

- `--remove-start SECONDS` — seconds to remove from the beginning
- `--remove-end SECONDS` — seconds to remove from the end
- `--intro-image PATH` — image shown before the video
- `--intro-duration SECONDS` — how long to show the intro (default 3)
- `--outro-image PATH` — image shown after the video
- `--outro-duration SECONDS` — how long to show the outro (default 3)
- `--auto-crop` — automatically remove black bars and time-varying padding to make the video full screen
- `--crop-padding-first-cm CM` — extra padding (cm) to remove from every edge during the first segment (default 1.0, used with `--auto-crop`)
- `--crop-padding-last-cm CM` — extra padding (cm) to remove from every edge during the last segment (default 2.0, used with `--auto-crop`)
- `--crop-first-minutes MIN` — how many minutes at the start use the first padding value (default 10, used with `--auto-crop`)
- `--crop-last-minutes MIN` — how many minutes at the end use the last padding value (default 5, used with `--auto-crop`)
- `--crop-dpi DPI` — DPI used to convert padding cm to pixels (default 96, used with `--auto-crop`)
- `--codec h264|h265` — video codec (default h264)
- `--crf N` — quality level (default 23 for h264, 28 for h265)
- `--preset NAME` — encoder preset (default slow)
- `--audio-bitrate RATE` — AAC audio bitrate (default 128k)
- `--max-dimension N` — cap width/height (default 1920; 0 keeps source resolution)
- `--ffmpeg NAME_OR_PATH` — ffmpeg executable (default ffmpeg)
- `--ffprobe NAME_OR_PATH` — ffprobe executable (default ffprobe)
- `--overwrite` — overwrite the output file if it already exists

## Notes

- `~` in paths is expanded using `HOME` (or `USERPROFILE` on Windows).
- Output defaults to `INPUT_edited.mp4` next to the input.
- Image and video outputs are gitignored; only `images/start.png` and `images/end.png` are tracked.