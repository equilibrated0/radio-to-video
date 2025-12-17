# Radio to Video Converter

Video killed the radio star.

This repository contains shell scripts to convert audio files to MP4 video format with cover art.

## Scripts

### mp3_to_mp4.sh

Converts MP3 audio files to MP4 video format.

**Usage:**
```bash
./mp3_to_mp4.sh "input.mp3" ["output.mp4"]
```

- `input.mp3`: Required. The MP3 file to convert.
- `output.mp4`: Optional. Output file name (defaults to input filename with .mp4 extension).

**Features:**
- Extracts embedded cover art from MP3 metadata
- Falls back to cover.jpg or cover.png in current directory
- Generates black background if no cover art found
- Preserves audio metadata
- Outputs 320kbps AAC audio with H.264 video

### flac_to_mp4.sh

Converts FLAC audio files to MP4 video format.

**Usage:**
```bash
./flac_to_mp4.sh "input.flac" ["output.mp4"]
```

- `input.flac`: Required. The FLAC file to convert.
- `output.mp4`: Optional. Output file name (defaults to input filename with .mp4 extension).

**Features:**
- Extracts embedded cover art using metaflac (if available)
- Falls back to cover.jpg or cover.png in current directory
- Generates black background if no cover art found
- Preserves audio metadata
- Outputs 320kbps AAC audio with H.264 video

## Requirements

- `ffmpeg` and `ffprobe` (required for both scripts)
- `metaflac` (optional, for FLAC cover art extraction)

## Examples

```bash
# Convert MP3 with default output name
./mp3_to_mp4.sh "podcast_episode.mp3"

# Convert MP3 with custom output name
./mp3_to_mp4.sh "podcast_episode.mp3" "my_video.mp4"

# Convert FLAC with default output name
./flac_to_mp4.sh "album_track.flac"

# Convert FLAC with custom output name
./flac_to_mp4.sh "album_track.flac" "music_video.mp4"
```
