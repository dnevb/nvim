return {
  {

    "wthollingsworth/pomodoro.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("pomodoro").setup({
        time_work = 30,
        time_break_short = 5,
        time_break_long = 20,
        timers_to_long_break = 4,
      })
    end,
    keys = {
      {
        "<leader>pr",
        function()
          require("pomodoro").start()
        end,
        desc = "Start pomodoro",
      },
      {
        "<leader>pi",
        function()
          require("pomodoro").status()
        end,
        desc = "Show pomodoro status",
      },
      {
        "<leader>ps",
        function()
          require("pomodoro").stop()
        end,
        desc = "Stop pomodoro",
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
        ["<leader>p"] = { name = "+pomodoro" },
      },
    },
  },
}
