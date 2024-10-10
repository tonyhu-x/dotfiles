return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = function(_, opts)
    opts.suggestion = {
      auto_trigger = true,
      keymap = {
        accept = false,
      },
    }
  end,
}
