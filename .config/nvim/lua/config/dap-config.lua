local dap = require('dap')
local dapui = require("dapui")
local wk = require("which-key")

dap.adapters.codelldb = {
    type = 'executable',
    --    port = "${port}",
    --    executable = {command = '/usr/bin/codelldb', args = {"--port", "${port}"}}
    command = '/usr/bin/codelldb',
    name = 'codelldb'
}

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" }
}


local lldb = {
    name = "Launch lldb",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
                            'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    runInTerminal = false
}

dap.configurations.cpp = {lldb}
dap.configurations.c = {lldb}


dap.configurations.asm = {
	{
		name = "Debug Assembly",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/' .. vim.fn.expand("%:t:r"),
			'file')
		end,
		cwd = '${workspaceFolder}',
		stopAtEntry = true,
		runInTerminal = false
	}
}

require("dapui").setup()
require("lazydev").setup({library = {plugins = {"nvim-dap-ui"}, types = "true"}})
require("dap-python").setup("python3")

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config =
    function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end



wk.add({
	{"<F4>", function() require("dap").run_to_cursor() end,  desc = "Run to Cursor" },
	{"<F5>", function() require("dap").continue() end,  desc = "Continue" },
	{"<F29>", function() require("dap").run_last() end,  desc = "Run Last" },
	{"<F7>", function() require("dap").step_into() end,  desc = "Step Into" },
	{"<F8>", function() require("dap").step_over() end,  desc = "Step Over" },
	{"<F12>", function() require("dap").toggle_breakpoint() end,  desc = "Toggle Breakpoint" },
}, { mode = "n" , group= "Debug"})


