#!/usr/bin/env bash
# Compile src/*.md into docs/*.html with Pandoc.
#
#   build/build.sh          rebuild docs/
#   build/build.sh --check  rebuild into a temp dir and fail if docs/ is out of date
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

out="docs"
check=0
if [[ "${1:-}" == "--check" ]]; then
  check=1
  out="$(mktemp -d)"
  trap 'rm -rf "$out"' EXIT
fi

mkdir -p "$out"
touch "$out/.nojekyll"
cp build/style.css "$out/style.css"

for md in src/*.md; do
  name="$(basename "$md" .md)"
  # Page title = the document's first "# " heading.
  title="$(sed -n 's/^# //p' "$md" | head -n 1)"
  pandoc "$md" \
    --from gfm \
    --to html5 \
    --standalone \
    --template build/template.html \
    --lua-filter build/links.lua \
    --lua-filter build/toc.lua \
    --metadata pagetitle="${title:-$name}" \
    --eol=lf \
    --output "$out/$name.html"
done

if (( check )); then
  if diff -r "$out" docs >/dev/null; then
    echo "docs/ is up to date."
  else
    echo "docs/ is OUT OF DATE. Run build/build.sh and commit." >&2
    diff -r "$out" docs >&2 || true
    exit 1
  fi
else
  echo "Built: $(ls docs/*.html | tr '\n' ' ')"
fi
