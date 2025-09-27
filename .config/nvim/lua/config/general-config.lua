vim.cmd("colorscheme onedark")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.cursorline = true
vim.o.scrolloff = 999
vim.o.splitbelow = true

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd('silent! normal! g`"zv', false)
    end,
})
