#!/bin/sh
# Link the bundled template into Typst's local package directory so that
# `#import "@local/claude-report:<version>"` works from any folder.
set -eu

skill_dir="$(cd "$(dirname "$0")" && pwd)"
version="$(sed -n 's/^version = "\(.*\)"/\1/p' "$skill_dir/package/typst.toml")"

case "$(uname)" in
  Darwin) data_dir="$HOME/Library/Application Support" ;;
  *) data_dir="${XDG_DATA_HOME:-$HOME/.local/share}" ;;
esac
target="${TYPST_PACKAGE_PATH:-$data_dir/typst/packages}/local/claude-report/$version"

mkdir -p "$(dirname "$target")"
ln -sfn "$skill_dir/package" "$target"
echo "Linked $target -> $skill_dir/package"
