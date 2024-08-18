-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"*.slint"},
    callback = function()
        vim.cmd(":setlocal filetype=slint")
    end,
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"*.apxc", "*.cls", "*.trigger"},
    callback = function()
      vim.cmd("set filetype=apex")
    end,
})
