local pomodoro_state = false

return {
  {
    "wthollingsworth/pomodoro.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("pomodoro").setup({
        time_work = 25,
        time_break_short = 5,
        time_break_long = 20,
        timers_to_long_break = 4,
      })
    end,
    keys = {
      {
        "<leader>tp",
        function()
          if pomodoro_state then
            require("pomodoro").stop()
            pomodoro_state = false
          else
            require("pomodoro").start()
            pomodoro_state = true
          end
        end,
        desc = "Toggle pomodoro",
      },
      {
        "<leader>ts",
        function()
          require("pomodoro").status()
        end,
        desc = "Show pomodoro status",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_z, 1, function()
        local status = require("pomodoro").statusline()
        if status == "ﮫ (inactive)" then
          return ""
        end

        return status:sub(4)
      end)

      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+tracking" },
      },
    },
  },
}
