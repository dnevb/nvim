return {
  {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      -- technically these are "diagnostic signs"
      -- neovim enables them by default.
      -- here we are just changing them to fancy icons.
      lsp_zero.set_sign_icons({
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
      })
    end
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'VonHeikemen/lsp-zero.nvim',
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'BufEnter',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function(_, opts)
      local lsp_zero = require('lsp-zero')
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      -- this is the function that loads the extra snippets
      -- from rafamadriz/friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        auto_brackets = {},
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- confirm completion item
          ['<Enter>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),

          -- trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- scroll up and down the documentation window
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          -- navigate between snippet placeholders
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        }),
        -- note: if you are going to use lsp-kind (another plugin)
        -- replace the line below with the function from lsp-kind
        formatting = lsp_zero.cmp_format({ details = true }),
      })
    end
  },
}
