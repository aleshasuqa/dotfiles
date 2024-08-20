local vim = vim
local util = require('sf.util')

local command = vim.api.nvim_create_user_command

command('SFLogThis',
    function ()
    local date = os.date("*t")
    local tmpFile = '/tmp/sf_log/' .. date.day .. '.'
    .. date.month .. '_'
    .. date.hour .. ':'
    .. date.min .. ':'
    .. date.sec .. '.txt'
    local file = assert(io.open(tmpFile, "w+"))
    local cont = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    file:write(table.concat(cont, "\n"))
end, {})

local ex = vim.fn.expand

command('SFRun', function ()
    local file = ex('%:p')
    vim.cmd('split')
    vim.cmd('term sf apex run --file ' .. file)
end, {})

command('SFQuery', function ()
    local file = ex('%:p')
    vim.cmd('split')
    vim.cmd('term sf data query --file ' .. file)
end, {})

command('SFSObjectFields', function (args)
    local class = args.fargs[1]

    local cont = util.retrieve({'sf', 'sobject', 'describe', '--sobject', class}, class)
    local desc = require('cjson').decode(cont).fields
    local fields = {}
    for _, v in ipairs(desc) do
        table.insert(fields,
            {
                name = v.name,
                -- action = function() vim.api.nvim_feedkeys('i' .. v.name .. ', ', 'n', true) end
                action = function() end
            }
        )
    end

    local selected = {}

    util.tele_cmd({
        picks = fields,
        width = 30,
        telescope_opts = require("telescope.themes").get_cursor{layout_config = {width = 30}},
        mappings = function(prompt_bufnr, map)
            map('i', '<CR>', function()
                local actions = require 'telescope.actions'
                local action_state = require 'telescope.actions.state'
                local action_utils = require "telescope.actions.utils"
                local selection = action_state.get_selected_entry(prompt_bufnr)
                action_utils.map_selections(prompt_bufnr, function(entry, _)
                    table.insert(selected, entry.value.name)
                end)
                table.insert(selected, selection.value.name)
                actions.close(prompt_bufnr)
                -- selection.value.action()
                local cmd = "a"
                for i, v in ipairs(selected) do
                    cmd = cmd .. v
                    if i ~= #selected then
                        cmd = cmd .. ', '
                    end
                end
                cmd = cmd .. ' ' .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
                vim.api.nvim_feedkeys(cmd, 'n', true)
            end)
            return true
        end})
end, { nargs = 1 })

command('SFOpenOrg', function ()
    util.open_float(80, 5)
    vim.cmd('term sf org open')
end, {})

command('SFLogin', function ()
    util.open_float(80, 5)
    vim.cmd('term sf org login web --set-default')
end, {})

command('SFTestClass', function ()
    local class = ex('%:t:r')
    print(class)
    util.open_float(150, 80)
    local cmd = 'term sf apex run test -c -r human -w 5 -n ' .. class
    vim.cmd(cmd)
end, {})

command('SFTestMethod', function ()
    local class = ex('%:t:r')
    local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys("?isTest" .. cr .. "/(" .. cr .. "h", 'n', true)
    vim.schedule(function ()
        local method = ex('<cword>')
        vim.cmd('noh')
        util.open_float(150, 80)
        local cmd = 'term sf apex run test -c -r human -w 5 -t ' .. class .. '.' .. method
        vim.cmd(cmd)
    end)
end, {})

command('SFDeploy', function ()
    local root = vim.lsp.get_active_clients()[1].config.cmd_cwd
    util.open_float(150, 80)
    local cmd = 'term sf project deploy start --source-dir ' .. root .. '/force-app'
    vim.cmd(cmd)
end, {})

command('SFRetrieve', function ()
    local root = vim.lsp.get_active_clients()[1].config.cmd_cwd
    util.open_float(150, 80)
    local cmd = 'term sf project retrieve start --source-dir ' .. root .. '/force-app'
    vim.cmd(cmd)
end, {})

command('SFCreateClass', function (args)
    local root = vim.lsp.get_active_clients()[1].config.cmd_cwd
    local class = args.fargs[1]
    print(root)
    -- open_float(150, 80)
    local cmd = '!sf apex generate class --name ' .. class .. ' --output-dir ' .. root .. '/force-app/main/default/classes'
    local cmdTest = '!sf apex generate class --name ' .. class .. 'Test --output-dir ' .. root .. '/force-app/main/default/classes'
    vim.cmd(cmd)
    vim.cmd(cmdTest)
    vim.cmd('e ' .. root .. '/force-app/main/default/classes/' .. class .. '.cls')
end, { nargs = 1 })

command('SFCreateTrigger', function (args)
    local root = vim.lsp.get_active_clients()[1].config.cmd_cwd
    local trigger = args.fargs[1]
    local sobject = args.fargs[2]
    print(root)
    -- open_float(150, 80)sf apex generate trigger --name MyTrigger --sobject Account --event "before insert,after insert"
    local cmd = '!sf apex generate trigger --name ' .. trigger
    .. ' --sobject ' .. sobject
    .. ' --event "before insert" --output-dir '  .. root .. '/force-app/main/default/triggers'
    vim.cmd(cmd)
    vim.cmd('e ' .. root .. '/force-app/main/default/triggers/' .. trigger .. '.trigger')
end, { nargs = "*" })

command('SFCreateLWC', function (args)
    local root = vim.lsp.get_active_clients()[1].config.cmd_cwd
    local lwc = args.fargs[1]
    local cmd = '!sf lightning generate component --name ' .. lwc
    .. ' --type lwc --output-dir ' .. root
    .. '/force-app/main/default/lwc'
    vim.cmd(cmd)
    vim.cmd('e ' .. root .. '/force-app/main/default/lwc/' .. lwc .. '/' .. lwc .. '.js')
end, { nargs = 1 })
