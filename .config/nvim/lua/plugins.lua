return {
    {"nvim-lua/plenary.nvim"},
    {"nvim-telescope/telescope.nvim", lazy = false},
    {"nvim-treesitter/nvim-treesitter", cmd = "TSUpdate"},
    {"joshdick/onedark.vim"},
    {"nvim-lualine/lualine.nvim", options = {theme = "onedark"}},
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    {"neovim/nvim-lspconfig"},
    {"VonHeikemen/lsp-zero.nvim"},
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"olrtg/nvim-emmet"},
    {'hrsh7th/cmp-cmdline'},
    {'SirVer/ultisnips'},
    {'honza/vim-snippets'},
    {'quangnguyen30192/cmp-nvim-ultisnips'},
    {"nvim-tree/nvim-tree.lua"},
    {"mfussenegger/nvim-dap"},
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
    },
    {'mfussenegger/nvim-lint'},
    {'stevearc/conform.nvim'},
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {}
    },
    {"preservim/tagbar"},
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {path = "luvit-meta/library", words = {"vim%.uv"}}

    },
    {"Bilal2453/luvit-meta", lazy = true},
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {name = "lazydev", group_index = 0})
        end
    },
    {"peterhoeg/vim-qml", ft = {"qml"}},
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
	preset= "helix",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({global = false})
                end,
                desc = "Buffer local Keymaps (which-key)"
            }
        }
    },
    {"mfussenegger/nvim-dap-python"},
    {'echasnovski/mini.nvim', version = '*'},
    {'nvim-tree/nvim-web-devicons'}

}
