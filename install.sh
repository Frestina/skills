#!/usr/bin/env bash
# Install the skills by symlinking them from this checkout:
#   ~/.claude/skills/<name>    -> skills/<name>   (honours $CLAUDE_CONFIG_DIR)
#
#   ./install.sh               install, or re-link after moving the checkout
#   ./install.sh --uninstall   remove the links again
set -eu
here=$(cd "$(dirname "$0")" && pwd)
skills_dir=${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills

link() {
	local src=$1 dst=$2
	if [ -e "$dst" ] && [ ! -L "$dst" ]; then
		echo "install: $dst exists and is not a symlink; move it aside first" >&2
		exit 1
	fi
	mkdir -p "$(dirname "$dst")"
	ln -sfn "$src" "$dst"
	echo "linked  $dst -> $src"
}

unlink_ours() {
	local dst=$1
	if [ -L "$dst" ] && [[ $(readlink "$dst") == "$here"/* ]]; then
		rm "$dst"
		echo "removed $dst"
	fi
}

if [ "${1-}" = --uninstall ]; then
	for skill in "$here"/skills/*/; do
		unlink_ours "$skills_dir/$(basename "$skill")"
	done
	exit 0
fi
[ $# -eq 0 ] || { echo "usage: $0 [--uninstall]" >&2; exit 2; }

for skill in "$here"/skills/*/; do
	link "${skill%/}" "$skills_dir/$(basename "$skill")"
done
