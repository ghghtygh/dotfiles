#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1"
  local dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok: $dest"
    return
  fi
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "backup: $dest -> $dest.backup"
    mv "$dest" "$dest.backup"
  fi
  ln -snf "$src" "$dest"
  echo "linked: $dest -> $src"
}

link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "installed: TPM"
else
  echo "ok: TPM"
fi

echo
echo "Done. Start tmux and press 'prefix + I' to install plugins."
