
return {
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       -- snippet plugin
  --       "L3MON4D3/LuaSnip",
  --       dependencies = "rafamadriz/friendly-snippets",
  --       opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  --       config = function(_, opts)
  --         require("luasnip").config.set_config(opts)
  --         require "nvchad.configs.luasnip"
  --       end,
  --     },
  --
  --     -- autopairing of (){}[] etc
  --     {
  --       "windwp/nvim-autopairs",
  --       opts = {
  --         fast_wrap = {},
  --         disable_filetype = { "TelescopePrompt", "vim" },
  --       },
  --       config = function(_, opts)
  --         require("nvim-autopairs").setup(opts)
  --
  --         -- setup cmp for autopairs
  --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  --         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --       end,
  --     },
  --
  --     -- cmp sources plugins
  --     {
  --       "saadparwaiz1/cmp_luasnip",
  --       "hrsh7th/cmp-nvim-lua",
  --       "hrsh7th/cmp-nvim-lsp",
  --       "hrsh7th/cmp-buffer",
  --       "hrsh7th/cmp-path",
  --     },
  --   },
  --   opts = function()
  --     return require "nvchad.configs.cmp"
  --   end,
  --   config = function(_, opts)
  --     require("cmp").setup(opts)
  --   end,
  -- },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { "string" },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
  },
}
}
