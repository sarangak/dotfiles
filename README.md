# Dotfiles

Dotfiles in this directory are managed by [chezmoi](https://github.com/twpayne/chezmoi)

## Gotchas

Karabiner Elements stores preferences in `~/.config/karabiner`. If changes are made via the application, use `chezmoi diff` to see changes and `chezmoi add ~/.config/karabiner` to pull them in.
