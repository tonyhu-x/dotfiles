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
    -- if somehow cmp doesn't work, this should still work
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end
    end, {
      silent = true,
    })
  end,
}
