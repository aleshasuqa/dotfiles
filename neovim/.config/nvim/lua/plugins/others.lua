return {
    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                line = '<leader>c',
            },
            opleader = {
                line = '<leader>c',
            },
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
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        opts = {
            rocks = { "lua-cjson" }, -- specifies a list of rocks to install
            -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
        },
    }
}
