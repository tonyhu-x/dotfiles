return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      rust_analyzer = {},
      tinymist = {
        --- todo: these configuration from lspconfig maybe broken
        single_file_support = true,
        root_dir = function()
          return vim.fn.getcwd()
        end,
        --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
        settings = {},
      },
    },
  },
}
