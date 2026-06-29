local cmp = require("cmp")
require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

cmp.setup({
	-- Sources for autocompletion
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- Luasnip (Snippet engine)
		{ name = "nvim_lsp" }, -- cmp-nvim-lsp
	}, {
		{ name = "buffer" }, -- Attached to the current buffer
		{
			name = "spell", -- cmp-spell
			option = {
				keep_all_entries = false,
				preselect_correct_word = true,
				enable_in_context = function()
					local buf = vim.api.nvim_get_current_buf()
					local ok, parser = pcall(vim.treesitter.get_parser, buf)
					if not ok or not parser then
						return true
					end
					return require("cmp.config.context").in_treesitter_capture("spell")
				end,
			},
		},
	}),

	-- Sources for snippets
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- Luasnip
		end,
	},

	-- Window mode
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		},
	},

	-- Keymaps
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
	}),

	-- Formatting
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			return vim_item
		end,
	},
})
