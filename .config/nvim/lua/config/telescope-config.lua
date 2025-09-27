require('telescope').setup {pickers = {buffers = {sort_lastused = true}}}

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local function insert_line_from_file(file_path)
    local lines = {}
    for line in io.lines(file_path) do table.insert(lines, line) end

    pickers.new({}, {
        prompt_title = "Select Line to Insert",
        finder = finders.new_table {results = lines},
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
            actions.select_default:replace(
                function(prompt_bufnr)
                    local selected_line =
                        action_state.get_selected_entry().value
                    actions.close(prompt_bufnr)
                    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                    local text_to_insert = "'" .. selected_line .. "'"
                    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, -1,
                                              {text_to_insert})
                    vim.cmd('write')
                end)
            return true
        end
    }):find()
end

local function get_buffer_keymaps(mode)
    local maps = vim.api.nvim_buf_get_keymap(0, mode) -- Použije aktuální buffer (0)
    local results = {}

    for _, map in ipairs(maps) do
        table.insert(results, {
            lhs = map.lhs,   -- Stisknutá klávesa
            rhs = map.rhs or "(builtin)",  -- Výsledek mapování
            mode = mode
        })
    end

    return results
end

local function buffer_keymap_picker(mode)
    local mappings = get_buffer_keymaps(mode)

    pickers.new({}, {
        prompt_title = "Buffer Keymaps (" .. mode .. ")",
        finder = finders.new_table {
            results = mappings,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = string.format("%-10s→%s",entry.lhs,  entry.rhs),
                    ordinal = entry.lhs
                }
            end
        },
        sorter = conf.generic_sorter({})
    }):find()
end


vim.api.nvim_create_user_command('InsertLineFromFile', function(opts)
    insert_line_from_file(opts.args)
end, {nargs = 1})


local builtin = require('telescope.builtin')
local map = vim.keymap.set

map('n', '<leader>ff', builtin.find_files, {desc = "Find files"})
map('n', '<leader>fg', builtin.live_grep, {desc = "Grep files"})
map('n', '<M-Tab>', builtin.buffers, {desc = "Switch buffers"})
map('n', '<leader>fh', builtin.help_tags, {desc = "Search help"})
map('n', '<M-x>', builtin.commands, {desc = "Search commands"})
map('n', '<M-k>', function() buffer_keymap_picker("n") end , {desc = "Show buffer keympas in Telescope" })


return buffer_keymap_picker
