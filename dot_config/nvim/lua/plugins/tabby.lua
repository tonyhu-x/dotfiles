return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "nanozuki/tabby.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local theme = {
        text = "TabLine",
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        bg = "TabLineFill",
        current = "TabLineSel",
      }

      local count_unsaved_buffers = function()
        local count = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_get_option_value("modified", { buf = buf }) then
            count = count + 1
          end
        end
        return count
      end

      require("tabby").setup({
        line = function(line)
          return {
            {
              { "  ", hl = theme.text },
            },
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current or theme.text

              return {
                {
                  line.sep("", hl, theme.bg),
                  tab.number(),
                  tab.close_btn(""),
                  line.sep("", hl, theme.bg),
                  hl = hl,
                  margin = " ",
                },
                line.wins_in_tab(tab.id).foreach(function(win)
                  return {
                    line.sep("", hl, theme.bg),
                    win.is_current() and "" or "",
                    win.buf_name(),
                    win.buf().is_changed() and "+",
                    line.sep("", hl, theme.bg),
                    hl = hl,
                    margin = " ",
                  }
                end),
              }
            end),
            {
              line.sep("", theme.text, theme.bg),
              { "[+] = " .. tostring(count_unsaved_buffers()) },
              line.sep("", theme.text, theme.bg),
              hl = theme.text,
              margin = " ",
            },
            line.spacer(),
            hl = theme.bg,
          }
        end,
      })
    end,
  },
}
