return {
  "folke/flash.nvim",
  keys = {
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").jump({
          search = { forward = false },
        })
      end,
      desc = "Flash Backwards",
    },
    {
      "R",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
