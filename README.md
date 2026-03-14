# Dotfiles

Personal dotfiles for macOS. Includes zsh (Prezto + Pure prompt), Neovim (LazyVim), and tmux.

## What's Included

- **zsh** — [Prezto](https://github.com/sorin-ionescu/prezto) framework with [Pure](https://github.com/sindresorhus/pure) prompt, syntax highlighting, autosuggestions, and history substring search
- **Neovim** — [LazyVim](https://www.lazyvim.org/) configuration
- **tmux** — Custom config with vim-style pane navigation and [TPM](https://github.com/tmux-plugins/tpm) plugins

## Prerequisites

Install the following before running the install script:

- **git**
- **zsh**
- **[Neovim](https://neovim.io/) >= 0.11.2** (required by LazyVim)
- **[tmux](https://github.com/tmux/tmux)**
- **curl**

On macOS with [Homebrew](https://brew.sh/):

```bash
brew install zsh neovim tmux curl
```

On Ubuntu/Debian:

```bash
sudo apt-get update && sudo apt-get install -y git zsh tmux curl
```

> **Note:** Ubuntu's packaged Neovim is typically outdated. Install v0.11.2+ from the [Neovim releases page](https://github.com/neovim/neovim/releases).

## Install

```bash
git clone https://github.com/dsaravanan/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

After installing, restart your shell (`exec zsh -l`) and open tmux and press `prefix + I` to install tmux plugins.

### Options

- **`--append-zshrc`** — Instead of replacing `~/.zshrc` with a symlink, append the custom config (aliases, keybindings, colors) to your existing `~/.zshrc`. Useful if you already have a zshrc you want to keep.

```bash
./install.sh --append-zshrc
```

## What `install.sh` Does

1. Clones Prezto into `~/.zprezto`
2. Symlinks Prezto's default runcoms (`zshenv`, `zprofile`, `zlogin`, `zlogout`)
3. Symlinks custom `zshrc` and `zpreztorc` from this repo
4. Symlinks `nvim/` to `~/.config/nvim`
5. Symlinks `tmux.conf` to `~/.tmux.conf`
6. Clones TPM into `~/.tmux/plugins/tpm`

The script is idempotent — existing symlinks are replaced and existing files are backed up to `.bak`.
