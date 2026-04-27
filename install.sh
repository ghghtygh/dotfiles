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

# Source aliases.sh in shell rc files (idempotent)
add_source_line() {
  local rc_file="$1"
  local source_line="source $DOTFILES_DIR/shell/aliases.sh"
  [ -f "$rc_file" ] || return 0
  if grep -Fxq "$source_line" "$rc_file"; then
    echo "ok: aliases sourced in $rc_file"
  else
    {
      echo ""
      echo "# dotfiles aliases"
      echo "$source_line"
    } >> "$rc_file"
    echo "added: aliases source line to $rc_file"
  fi
}

add_source_line "$HOME/.zshrc"
add_source_line "$HOME/.bashrc"

echo
echo "Done."
echo "- tmux: start tmux and press 'prefix + I' to install plugins"
echo "- aliases: open a new shell or run 'source ~/.zshrc' (or ~/.bashrc)"
