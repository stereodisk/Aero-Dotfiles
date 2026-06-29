require("oil").setup({
	default_file_explorer = false, -- fallback to :Explore
	use_default_keymaps = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			-- .class or .pyc
			return name:match("%.class$") or name:match("%.pyc$")
		end,
	},
	float = {
		padding = 2,
		max_width = 80,
		max_height = 30,
		border = "rounded",

		override = function(conf)
			local screen_w = vim.o.columns
			local screen_h = vim.o.lines - vim.o.cmdheight
			local window_w = conf.width
			local window_h = conf.height

			conf.col = math.floor((screen_w - window_w) / 2)
			conf.row = math.floor((screen_h - window_h) / 2)

			return conf
		end,
	},
})
