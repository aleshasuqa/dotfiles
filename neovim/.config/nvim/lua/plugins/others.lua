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
    },
    {
        'glacambre/firenvim',
        build = ":call firenvim#install(0)"
    }
}
