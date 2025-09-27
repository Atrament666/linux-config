local map = vim.keymap.set
local wk = require('which-key')

map ('n', '<F3>', ':NvimTreeToggle<CR>', {buffer=0, silent=true, desc="Toggle NvimTree"})
map('c', 'w!!', 'w !sudo -A tee > /dev/null %',{})
