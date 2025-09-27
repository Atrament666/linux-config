local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
    "asm_lsp",
    "bashls",
    "clangd",
    "cssls",
    "css_variables",
    "cssmodules_ls",
    "emmet_language_server",
    "html",
    "lua_ls",
    "mesonlsp",
    "omnisharp",
    "tailwindcss",
    "vimls",
    "pylsp",
    "quick_lint_js",
}

require('mason-lspconfig').setup {ensure_installed = servers}
for _, value in ipairs(servers) do
    lspconfig[value].setup {capabilities = capabilities}
end

lspconfig.lua_ls.setup {settings = {Lua = {diagnostics = {globals = {'vim'}}}}}
lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            configurationSources = {'flake8'},
            plugins = {
                flake8 = {
                    enabled = true,
                    maxLineLength = 120,
                    ignore = {'E501', 'W503'}
                },
                pylint = {enabled = false},
                pycodestyle = {enabled = false},
                autopep8 = {enabled = false}
            }
        }
    }
}

lspconfig.asm_lsp.setup {
	settings = {
		["nasm.formatting"] = {enable=true},
		["nasm.syntax"] = "intel",
	}
}

lspconfig.qmlls.setup {
    cmd = {"qmlls6"},
    filetypes = {"qml"},
    root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end
}

lspconfig.omnisharp.setup {
  cmd = { "/usr/bin/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  root_dir = lspconfig.util.root_pattern('*.sln', '*.csproj', '.git'),
  settings = {
    omnisharp = {
      useModernNet = true,
      enableRoslynAnalyzers = true,
      organizeImportsOnFormat = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Klíčové zkratky a další funkce LSP
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}




local map = vim.keymap.set
map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<cr>',  {silent=true})

