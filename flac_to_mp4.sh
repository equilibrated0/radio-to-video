# Usage: ./flac_to_mp4.sh "input.flac" ["output.mp4"]

in="$1"; out="${2:-${in%.flac}.mp4}"
tmpcover="$(mktemp -t coverXXXX).jpg"

# Try to extract embedded cover art
if command -v metaflac >/dev/null 2>&1; then
  metaflac --export-picture-to="$tmpcover" "$in" 2>/dev/null || true
fi

# Pick a cover image
if [ -s "$tmpcover" ]; then
  cover="$tmpcover"
elif [ -f cover.jpg ]; then
  cover="cover.jpg"
elif [ -f cover.png ]; then
  cover="cover.png"
else
  ffmpeg -v error -y -f lavfi -i color=c=black:s=1280x720:d=1 "$tmpcover"
  cover="$tmpcover"
fi

# Get precise audio duration (fallback to container duration if stream one is missing)
dur="$(ffprobe -v error -select_streams a:0 -show_entries stream=duration \
      -of default=noprint_wrappers=1:nokey=1 "$in")"
if [ -z "$dur" ]; then
  dur="$(ffprobe -v error -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 "$in")"
fi

# Build MP4, cutting exactly to the audio duration
ffmpeg -y \
  -loop 1 -i "$cover" -i "$in" \
  -map 1:a:0 -map 0:v:0 \
  -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
  -c:v libx264 -tune stillimage -pix_fmt yuv420p -preset veryfast -crf 18 \
  -c:a aac -b:a 320k \
  -movflags +faststart \
  -to "$dur" \
  -map_metadata 1 \
  "$out"

rm -f "$tmpcover"
echo "Done -> $out (duration forced to $dur s)"
