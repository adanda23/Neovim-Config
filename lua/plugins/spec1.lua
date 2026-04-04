return {
    {
       'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },
    { 
        'rebelot/kanagawa.nvim',   
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        config = function()
        require("neo-tree").setup({
            window = {
                close_if_last_window = true,
            },
        })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
        },
        config = function()
          local cmp = require("cmp")
          local luasnip = require("luasnip")

          cmp.setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<CR>"]      = cmp.mapping.confirm({ select = true }),
              ["<C-e>"]     = cmp.mapping.abort(),
              ["<Tab>"]     = cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                else fallback() end
              end, { "i", "s" }),
              ["<S-Tab>"]   = cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then luasnip.jump(-1)
                else fallback() end
              end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "luasnip" },
              { name = "buffer" },
              { name = "path" },
            }),
          })
        end,
    },
    { "github/copilot.vim" }
}
