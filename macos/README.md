# macOS dotfiles

My personal macOS customizations, so a fresh MacBook can be set up quickly.
These are just config files — no apps are bundled. Install the tools below
first (via Homebrew), then run `install.sh` to symlink everything into place.

## What's here

| Path | Tool | Notes |
|------|------|-------|
| `.zshrc` | zsh | oh-my-zsh + Powerlevel10k, eza aliases, fzf keybindings, note/todo helpers |
| `.zprofile` | zsh | Homebrew shellenv + nvm bootstrap |
| `.p10k.zsh` | Powerlevel10k | prompt theme |
| `.gitconfig` | git | user name/email |
| `.tmux.conf` | tmux | Ctrl-a prefix, vim-style panes, mouse, true color |
| `.yabairc` | yabai | float layout, focus-follows-mouse |
| `.skhdrc` | skhd | hotkeys that drive yabai (see below) |
| `.config/ghostty/` | Ghostty | Ayu Dark theme, padding, transparency + blur |
| `.config/kitty/` | kitty | font, padding, opacity, option-as-alt |
| `.config/nvim/` | Neovim | LazyVim-based config |
| `.config/yabai/focus-direction.sh` | yabai | focus nearest floating window by direction |
| `.config/git/ignore` | git | global gitignore |

## Prerequisites (install with Homebrew)

These configs assume the following are installed. Install what you use:

```sh
# shell + prompt
brew install zsh fzf eza
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# terminals / editor / multiplexer
brew install --cask ghostty kitty
brew install neovim tmux

# window manager + hotkey daemon
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# node version manager (used by .zprofile)
brew install nvm && mkdir -p ~/.nvm
```

Optional: eza theme referenced by `.zshrc` (`EZA_CONFIG_DIR=~/.config/eza`):

```sh
git clone https://github.com/eza-community/eza-themes.git ~/.config/eza/eza-themes
ln -s ~/.config/eza/eza-themes/themes/default.yml ~/.config/eza/theme.yml
```

## Install

```sh
git clone https://github.com/sotheasong/dotfiles.git ~/dotfiles
cd ~/dotfiles/macos
DRY_RUN=1 ./install.sh   # preview
./install.sh             # symlink into place (existing files are backed up)
```

`install.sh` symlinks each config into `$HOME`, backing up any existing real
files to `~/.dotfiles-backup-<timestamp>` first.

## Start the window manager

yabai and skhd run as background services:

```sh
yabai --start-service
skhd --start-service
```

yabai needs Accessibility permission (System Settings → Privacy & Security →
Accessibility). Some features also require disabling SIP — this config uses only
basic features that work with SIP enabled.

### skhd keybindings

| Keys | Action |
|------|--------|
| `shift + alt + h/j/k/l` | focus floating window west/south/north/east |
| `alt + f` | toggle fullscreen zoom for focused window |
