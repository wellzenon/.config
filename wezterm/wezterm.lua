local wezterm = require("wezterm")
local config = {

	enable_tab_bar = false,
	font = wezterm.font({
		family = "Google Sans Code",
		harfbuzz_features = { "calt", "clig", "liga" },
	}),
}

config.colors = {

	foreground = "silver",
	background = "191c23",

	ansi = {
		"black",
		"maroon",
		"green",
		"olive",
		"navy",
		"purple",
		"teal",
		"silver",
	},

	brights = {
		"grey",
		"red",
		"lime",
		"yellow",
		"blue",
		"fuchsia",
		"aqua",
		"white",
	},
}

return config
