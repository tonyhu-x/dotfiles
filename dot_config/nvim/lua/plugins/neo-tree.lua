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
        require("neo-tree.command").execute({ reveal = true })
      end,
      desc = "Reveal in NeoTree",
    },
  },
}
