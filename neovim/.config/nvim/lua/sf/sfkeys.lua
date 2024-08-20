local vim = vim
local map = vim.keymap.set
local util = require('sf.util')

map('n', ';;',
    function()
        local cont = util.retrieve({'sf', 'sobject', 'list', '--sobject', 'all'}, 'AllObjects')
        local p = {}
        for s in string.gmatch(cont, '(.-)\n') do
            table.insert(p, {
                name = s,
                action = function () end
            })
        end
        util.tele_cmd({
            picks = p,
            width = 40,
            telescope_opts = require('telescope.themes').get_cursor{layout_config = {width = 40}},
            mappings = function(prompt_bufnr, nmap)
                nmap('i', '<CR>', function()
                    local actions = require 'telescope.actions'
                    local action_state = require 'telescope.actions.state'
                    local selection = action_state.get_selected_entry(prompt_bufnr)
                    actions.close(prompt_bufnr)
                    vim.cmd('SFSObjectFields ' .. selection.value.name)
                end)
                return true
            end
        })
    end
)

map('n', '..', function ()
    vim.cmd('SFLogThis')
end)

map('n', '<leader>nn', function ()
    util.openFloat(50, 10)
end)
