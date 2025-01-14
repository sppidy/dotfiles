-- I prefer having all the config in one file
-- But NvChad

----------
-- Vars --
----------
vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
-- Fucking neovim overriding shit in unimaginable ways
if vim.bo.filetype == "python" then
    vim.opt.expandtab = true
end

-- Auto-reload file
vim.opt.autoread = true
vim.cmd[[
au CursorHold * checktime
]]

-- Auto open nvim-tree if nvim launched with a directory
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end })

------------
-- NvChad --
------------
local M = {
	plugins = "custom.plugins",
	ui = {
		theme = "wal",
		hl_override = {
			Comment = {
				italic = true
			}
		}
	}
}

--------------
-- Keybinds --
--------------
M.mappings = {
	general = {
		n = {
			["<leader>w"] = { "<cmd> w <CR>", "Save file" },
			["<leader>q"] = { "<cmd> q <CR>", "Quit" },
			["<leader>wq"] = { "<cmd> wq <CR>", "Save file and quit" },
			["<C-left>"] = { "<cmd>vertical resize -2<cr>", "Decrease width" },
			["<C-right>"] = { "<cmd>vertical resize +2<cr>", "Increase width" },
			["<C-up>"] = { "<cmd>horizontal resize +2<cr>", "Increase height" },
			["<C-down>"] = { "<cmd>horizontal resize -2<cr>", "Decrease height" },
			-- ["<C-h>"] = { "<cmd>NvimTreeToggle<CR>", "Open NvimTree" },
			-- ["<C-l>"] = { "<cmd>NvimTreeToggle<CR>", "Open NvimTree" },

			["L"] = {
				function()
					require("nvchad.tabufline").tabuflineNext()
				end,
				"Goto next buffer",
			},
			["H"] = {
				function()
					require("nvchad.tabufline").tabuflinePrev()
				end,
				"Goto prev buffer",
			},
		},
		i = {
			["<C-s>"] = { "<cmd>w<cr>", "Save in insert mode" },
		},
	},
	nvimtree = {
		n = {
			-- change root
			["="] = {
				function()
					require("nvim-tree.api").tree.change_root_to_node()
				end,
				"Change root to node",
			},
		},
	},
	nvterm = {
		n = {

			["<C-j>"] = {
				function()
					require("nvterm.terminal").toggle "horizontal"
				end,
				"Toggle horizontal term",
			},
		},
		t = {
			["<C-k>"] = {
				function()
					require("nvterm.terminal").toggle "horizontal"
				end,
				"Toggle horizontal term",
			},
		},
	}
}

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

vim.cmd [[
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'        " start selecting up
]]
--------------

return M
