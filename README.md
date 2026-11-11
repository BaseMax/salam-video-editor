# salam-video-editor

A Salam port of a Python FFmpeg video trimmer/editor.

Trim a video, optionally add intro/outro stills, and compress with FFmpeg.

## Requirements

- `ffmpeg` and `ffprobe` on PATH.

## Build & Run

```bash
salam run main.salam -- input.mp4 -o output.mp4
```

Options: `--remove-start`, `--remove-end`, `--intro-image`, `--intro-duration`,
`--outro-image`, `--outro-duration`, `--codec h264|h265`, `--crf`, `--preset`,
`--audio-bitrate`, `--max-dimension`, `--overwrite`, etc.
