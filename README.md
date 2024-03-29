# dotfiles

This is my dotfile repository. This file documents steps that need to be
manually executed to finish setup.

## Common

These are apps that consume the managed configs:

* [sioyek](http://sioyek.info)

## Neovim

All Neovim plugins should now automatically install during first-time Neovim setup.

LSP language servers can be managed through `:Mason`. After installation, they
need to be added to `lsp.lua` list of configured servers.

Neovim Typst support (obviously) requires Typst.

* I made a manual tweak to `typst.vim` to circumvent the SQL filetype problem.

VimTeX and Typst are configured to use sioyek as the PDF viewer.

Telescope works better with these:

* [fd](https://github.com/sharkdp/fd)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

## macOS

These are macOS apps that consume the managed configs:

* [Karabiner-Elements](https://karabiner-elements.pqrs.org)
