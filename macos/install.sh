#!/usr/bin/env bash
# Symlink the macOS dotfiles in this folder into place.
#
# Every managed file/dir under this directory (except this script) is linked to
# the matching location under $HOME. Existing real files are backed up to
# ~/.dotfiles-backup-<timestamp> before being replaced with a symlink.
#
# Usage:
#   ./install.sh          # create the symlinks
#   DRY_RUN=1 ./install.sh # print what would happen, change nothing

set -euo pipefail

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
DRY_RUN="${DRY_RUN:-0}"

# Files/dirs to link, relative to both this folder and $HOME.
# .config subtrees are linked at the leaf so unrelated configs aren't disturbed.
LINKS=(
  .zshrc
  .zprofile
  .gitconfig
  .p10k.zsh
  .tmux.conf
  .skhdrc
  .yabairc
  .config/ghostty
  .config/kitty
  .config/nvim
  .config/yabai
  .config/git/ignore
)

link() {
  local rel="$1"
  local src="$DOTS_DIR/$rel"
  local dst="$HOME/$rel"

  [ -e "$src" ] || { echo "skip (missing in repo): $rel"; return; }

  # Already the correct symlink?
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok:   $rel"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    local backup="$BACKUP_DIR/$rel"
    echo "back: $rel -> ${backup/#$HOME/~}"
    if [ "$DRY_RUN" != 1 ]; then
      mkdir -p "$(dirname "$backup")"
      mv "$dst" "$backup"
    fi
  fi

  echo "link: $rel"
  if [ "$DRY_RUN" != 1 ]; then
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
  fi
}

echo "Linking macOS dotfiles from $DOTS_DIR"
[ "$DRY_RUN" = 1 ] && echo "(dry run — no changes will be made)"
for rel in "${LINKS[@]}"; do
  link "$rel"
done
echo "Done."
