local function require_dir(dir)
    local scandir = vim.loop.fs_scandir(dir)

    if scandir then
        while true do
            local name, type = vim.loop.fs_scandir_next(scandir)
            if not name then break end
            if type == "file" and name:match("%.lua$") then
                local module = dir:match("([^/]+)$") .. "." ..
                                   name:gsub("%.lua$", "")
                require(module)
            end
        end
    end
end

-- this loads all files in config folder
require_dir('/home/atrament/.config/nvim/lua/config')
require('general-mappings')

vim.api.nvim_create_autocmd({"VimLeave"}, {
	callback = function()
		vim.cmd("!reset")
	end
})
