#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPEND_ZSHRC=false

usage() {
  echo "Usage: ./install.sh [--append-zshrc]"
  echo "  --append-zshrc  Append custom config to existing ~/.zshrc instead of replacing it"
  exit 1
}

for arg in "$@"; do
  case "$arg" in
    --append-zshrc) APPEND_ZSHRC=true ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $arg"; usage ;;
  esac
done

link_file() {
  local src="$1" dst="$2"

  # Already a symlink pointing to the right place — nothing to do
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "OK $dst (already linked)"
    return
  fi

  # Remove existing symlink, or back up existing file/directory
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $dst to $backup"
    mv "$dst" "$backup"
  fi

  ln -s "$src" "$dst"
  echo "Linked $dst -> $src"
}

# 1. Install Prezto
ZPREZTO_DIR="${ZDOTDIR:-$HOME}/.zprezto"
if [ ! -d "$ZPREZTO_DIR" ]; then
  echo "Cloning Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$ZPREZTO_DIR"
else
  echo "Prezto already installed, updating..."
  git -C "$ZPREZTO_DIR" fetch --all --quiet
  git -C "$ZPREZTO_DIR" reset --hard origin/master --quiet
  git -C "$ZPREZTO_DIR" submodule update --init --recursive --quiet
fi

# 2. Symlink Prezto default runcoms (zshenv, zprofile, zlogin, zlogout)
for rcfile in zshenv zprofile zlogin zlogout; do
  link_file "$ZPREZTO_DIR/runcoms/$rcfile" "${ZDOTDIR:-$HOME}/.$rcfile"
done

# 3. Custom zshrc and zpreztorc
ZSHRC_DST="${ZDOTDIR:-$HOME}/.zshrc"
if [ "$APPEND_ZSHRC" = true ]; then
  MARKER="# --- dotfiles custom config ---"
  if grep -qF "$MARKER" "$ZSHRC_DST" 2>/dev/null; then
    echo "OK $ZSHRC_DST (custom config already appended)"
  else
    # Append everything after the prezto source block from our zshrc
    echo "" >> "$ZSHRC_DST"
    echo "$MARKER" >> "$ZSHRC_DST"
    sed -n '/^# Git Aliases/,$p' "$DOTFILES_DIR/zshrc" >> "$ZSHRC_DST"
    echo "Appended custom config to $ZSHRC_DST"
  fi
else
  link_file "$DOTFILES_DIR/zshrc" "$ZSHRC_DST"
fi
link_file "$DOTFILES_DIR/zpreztorc" "${ZDOTDIR:-$HOME}/.zpreztorc"

# 4. Symlink vim config
mkdir -p "$HOME/.vim/autoload"
link_file "$DOTFILES_DIR/vim/vim-plug/plug.vim" "$HOME/.vim/autoload/plug.vim"
link_file "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"

# 5. Symlink nvim config
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
link_file "$DOTFILES_DIR/nvim" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# 6. Symlink tmux.conf
link_file "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

# 7. Install TPM (Tmux Plugin Manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Cloning TPM..."
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "TPM already installed, updating..."
  git -C "$TPM_DIR" pull --quiet
fi

echo ""
echo "Done! Restart your shell or run: exec zsh -l"
echo "For tmux plugins, open tmux and press prefix + I to install."
