require('conform').setup({
    formatters_by_ft = {
        html = {'prettier_html'},
        javascript = {'prettier_js'},
        css = {'prettier_css'},
        c = {'cformatter'},
        cpp = {'cformatter'},
        lua = {'luaformat'},
        python = {'black'},
        qml = {'qmlformat'}
    },
    formatters = {
        cformatter = {
            command = 'clang-format',
            args = '--style="{BasedOnStyle: llvm, IndentWidth: 4}"'
        },
        prettier_html = {
            command = '/usr/bin/prettier',
            args = {
                '--parser',
                'html',
                '--tab-width',
                '4',
                '--use-tabs',
                'false',
                '--bracket-same-line',
                'true',
                '--print-width',
                '160'
            }
        },
        prettier_js = {
            command = '/usr/bin/prettier',
            args = {
                '--parser',
                'babel',
                '--tab-width',
                '4',
                '--use-tabs',
                'false',
                '--bracket-same-line',
                'true',
                '--print-width',
                '160'
            }
        },
        prettier_css = {
            command = '/usr/bin/prettier',
            args = {
                '--parser',
                'css',
                '--tab-width',
                '4',
                '--use-tabs',
                'false',
                '--bracket-same-line',
                'true',
                '--print-width',
                '160'
            }
        },
        luaformat = {
            command = '/home/atrament/.local/share/nvim/mason/bin/lua-format',
            args = {'--chop-down-table'}
        },
        qmlformat = {
            command = 'qmlformat',
            args = {vim.api.nvim_buf_get_name(0)}
        }

    }
})

local map = vim.keymap.set
map('n', '<M-F>', ':lua require("conform").format() <CR>', {buffer=0, silent=true, desc="Format source code"})
