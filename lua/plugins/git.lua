local map = vim.keymap.set

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function opts(desc)
          return { buffer = bufnr, desc = desc }
        end

        local map = vim.keymap.set

        map("n", "<leader>gr", gs.reset_hunk, opts "Reset Hunk")
        map("n", "<leader>gp", gs.preview_hunk, opts "Preview Hunk")
        map("n", "<leader>gb", gs.blame_line, opts "Blame Line")
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']h', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, opts "Next hunk")

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, opts "Previous hunk")
      end
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
  },
}
