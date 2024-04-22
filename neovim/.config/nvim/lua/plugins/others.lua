return {
    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        "norcalli/nvim-colorizer.lua",
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        enabled = true,
    },
    {
        "iryukizo/tiger-syntax",
        lazy = false,
        enabled = true
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        -- config = function()
        --     local telescope = require('telescope')
        --     telescope.setup {
        --         extensions = {
        --             ['todo-comments'] = {},
        --         },
        --         telescope.load_extension('todo-comments')
        --     }
        -- end,
        -- keys = {
        --     { "<leader>td", function()
        --         require('telescope').extensions['todo-comments'].todo()
        --     end }
        -- }
    }
}
