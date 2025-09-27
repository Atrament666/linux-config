local langs = {
    "asm",
    "bash",
    "bibtex",
    "c",
    "cpp",
    "cmake",
    "csv",
    "gitcommit",
    "lua",
    "latex",
    "make",
    "meson",
    "nasm",
    "ninja",
    "html",
    "css",
    "javascript",
    "java",
    "json",
    "python",
    "qmldir",
    "qmljs",
    "scss",
    "ssh_config",
    "xml"
}

require('nvim-treesitter.configs').setup {
    ensure_installed = langs,
    highlight = {enabled = true},
    auto_install = true,
    modules = {},
    sync_install = false,
    ignore_install = {}

}
