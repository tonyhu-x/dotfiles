return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      follow_current_file = { enabled = false },
    },
  },
  keys = {
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, reveal = true })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
  },
}
