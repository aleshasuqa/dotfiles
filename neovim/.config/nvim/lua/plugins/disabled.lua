local plugins = {
    -- "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    "vim-pack/nvim-spectre",
    "dstein64/vim-startuptime",
    "rcarriga/nvim-notify",
}

To_disbable = {}

for _, p in ipairs(plugins) do
    table.insert(To_disbable, { p, enabled = false })
end

return {
    To_disbable,
}
