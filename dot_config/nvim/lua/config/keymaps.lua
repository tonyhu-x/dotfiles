-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("", "`", "'", opts)
keymap("", "'", "`", opts)

keymap("i", "<C-c>", "<Esc>", opts)

keymap("t", "<C-c>", "<C-\\><C-n>", opts)
keymap("t", "<C-\\><C-c>", "<C-c>", opts)

keymap("n", "<S-l>", "gt", opts)
keymap("n", "<S-h>", "gT", opts)

if vim.g.vscode then
  keymap("", "<leader>e", "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>", opts)
  keymap("", "<leader>E", "<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>", opts)
  keymap("", "<leader>p", "<Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>", opts)
  keymap("", "<leader>f", "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>", opts)

  keymap({ "n", "v" }, "go", "<Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>", opts)
  keymap("n", "<leader>cr", "<Cmd>call VSCodeNotify('editor.action.rename')<CR>", opts)
  keymap({ "n", "v" }, "gD", "<Cmd>call VSCodeNotify('editor.action.revealDeclaration')<CR>", opts)
  keymap({ "n", "v" }, "gr", "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>", opts)
  keymap({ "n", "v" }, "ga", "<Cmd>call VSCodeNotify('breadcrumbs.focusAndSelect')<CR>", opts)
end
