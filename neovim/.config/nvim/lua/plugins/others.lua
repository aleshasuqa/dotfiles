return {
    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        "kkoomen/vim-doge",
        lazy = false,
        config = function()
            vim.cmd(":call doge#install()")
        end,
    },
}
