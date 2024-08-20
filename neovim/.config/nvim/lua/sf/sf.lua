local vim = vim
local map = vim.keymap.set
local util = require('sf.util')

local commands = {
    {
        name = 'run',
        action = function() vim.cmd('SFRun') end
    },
    {
        name = 'soql query',
        action = function() vim.cmd('SFQuery') end
    },
    {
        name = 'open org',
        action = function() vim.cmd('SFOpenOrg') end
    },
    {
        name = 'login',
        action = function() vim.cmd('SFLogin') end
    },
    {
        name = 'deploy to org',
        action = function() vim.cmd('SFDeploy') end
    },
    {
        name = 'retrieve from org',
        action = function() vim.cmd('SFDeploy') end
    },
    {
        name = 'test class',
        action = function() vim.cmd('SFTestClass') end
    },
    {
        name = 'test method',
        action = function() vim.cmd('SFTestMethod') end
    },
    {
        name = 'create class',
        action = function()
            local class = vim.fn.input('Class name: ')
            vim.cmd('SFCreateClass ' .. class)
        end
    },
    {
        name = 'create trigger',
        action = function()
            local trigger = vim.fn.input('Trigger name: ')
            local sobject = vim.fn.input('SObjct: ')
            vim.cmd('SFCreateTrigger ' .. trigger .. ' ' .. sobject)
        end
    },
    {
        name = 'create lwc',
        action = function()
            local lwc = vim.fn.input('LWC name: ')
            vim.cmd('SFCreateLWC ' .. lwc)
        end
    },
    {
        name = 'SObjct fields',
        action = function() vim.cmd('SFSObjectFields') end
    },
}

map("n", "<leader>ss", function ()
    util.tele_cmd({
        name = 'SF',
        picks = commands,
        width = 25,
        telescope_opts = require("telescope.themes").get_dropdown{layout_config = {width = 25}},
        mappings = function(prompt_bufnr, nmap)
            nmap('i', '<CR>', function()
                require('telescope.actions').close(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
                selection.value.action()
            end)
            return true
        end
    })
end)

require('sf.commands')
require('sf.sfkeys')
