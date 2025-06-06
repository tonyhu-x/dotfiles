-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = "<S-Space>"
vim.o.showtabline = 2
-- do NOT sync with system clipboard, thanks
vim.o.clipboard = ""

-- disable animations
vim.g.snacks_animate = false