#!/bin/sh
set -eu

repo_root=$(cd "$(dirname "$0")/.." && pwd)
work_dir="$repo_root/.cache/merge-ut-dictionaries"
output="$repo_root/src/data/dictionary_oss/dictionary_ut.txt"

python=""
for candidate in python3.14 python3.13 python3.12 python3; do
  if command -v "$candidate" >/dev/null 2>&1 &&
    "$candidate" -c 'import sys; sys.exit(sys.version_info < (3, 12))' 2>/dev/null; then
    python=$(command -v "$candidate")
    break
  fi
done
if [ -z "$python" ]; then
  echo "Python 3.12 or later is required." >&2
  exit 1
fi

if [ -d "$work_dir/.git" ]; then
  git -C "$work_dir" fetch --depth 1 origin
  git -C "$work_dir" reset --hard FETCH_HEAD
else
  mkdir -p "$(dirname "$work_dir")"
  git clone --depth 1 https://github.com/utuhiro78/merge-ut-dictionaries.git "$work_dir"
fi

# make.sh は python コマンドを呼ぶが、macOS には python3 しかないことが多い
shim_dir=$(mktemp -d)
trap 'rm -rf "$shim_dir"' EXIT
ln -s "$python" "$shim_dir/python"

(cd "$work_dir/src/merge" && PATH="$shim_dir:$PATH" sh make.sh)

cp "$work_dir/src/merge/mozcdic-ut.txt" "$output"
echo "Wrote $output ($(wc -l <"$output" | tr -d ' ') entries)"
