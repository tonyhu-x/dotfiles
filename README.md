# dotfiles

This is my dotfile repository. This file documents steps that need to be
manually executed to finish setup.

## Neovim

LSP language servers can be managed through `:Mason`. After installation, they
need to be added to `lsp.lua` list of configured servers.

Telescope works better with these:

* [fd](https://github.com/sharkdp/fd)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

## macOS

These are macOS apps that consume the managed configs:

* [Karabiner-Elements](https://karabiner-elements.pqrs.org)
