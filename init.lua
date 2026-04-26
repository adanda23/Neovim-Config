-- Setup lazy
require("config.lazy")

-- Setup colorscheme, options, and keymaps
vim.cmd.colorscheme("kanagawa-dragon")

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files", { desc = "Telescope find files" })
vim.opt.clipboard = "unnamedplus"
vim.keymap.set('n', '<leader>r', '<cmd>checktime<cr>', { desc = 'Refresh buffers' })


-- Enable inline error messages
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = true,
	},
})

-- ToggleTerm Setup
require("toggleterm").setup({
  size = 40,
  direction = "vertical",
  open_mapping = [[<leader>t]],
  insert_mappings = false, -- only trigger in normal mode
  terminal_mappings = false,
})

vim.keymap.set('n', '<leader>ot', '<cmd>ToggleTerm<cr>', { desc = 'Open terminal' })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })


-- Scroll down half a page and recenter
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Scroll up half a page and recenter
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Center while searching (optional but helpful)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		vim.cmd("Neotree close")
	end,
})

-- Setup LSP servers
vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	filetypes = { "c", "cpp" },
	root_markers = { "compile_commands.json", "CMakeLists.txt", ".git" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.config("basedpyright", {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("clangd")
vim.lsp.enable("basedpyright")
