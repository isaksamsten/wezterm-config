local wezterm = require("wezterm")
local act = wezterm.action
local icons_map = {
	tardy = " ",
	resize_pane = "  ",
}
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	local icon = icons_map[name]
	window:set_right_status(icon or name or "")
end)

local copy_mode = wezterm.gui.default_key_tables().copy_mode
local search_mode = wezterm.gui.default_key_tables().search_mode
local config = {
	term = "wezterm",
	window_decorations = "RESIZE | INTEGRATED_BUTTONS",
	-- ->
	font = wezterm.font_with_fallback({
		-- { family = "SF Mono", stretch = "Condensed" },
		{ family = "Jetbrains Mono NL", stretch = "Condensed", weight = "Regular" },
		{ family = "Menlo", stretch = "Condensed" },
		-- { family = "Iosevka", stretch = "Normal", weight = "Regular", harfbuzz_features = { "ss04", "calt=0" } },
		{ family = "Symbols Nerd Font", scale = 1.0, italic = false },
	}),
	front_end = "WebGpu",
	font_size = 13,
	freetype_load_target = "Normal",
	freetype_render_target = "HorizontalLcd",
	allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
	color_scheme = "OneDark (base16)",
	bold_brightens_ansi_colors = true,
	adjust_window_size_when_changing_font_size = false,
	show_tab_index_in_tab_bar = false,
	command_palette_font_size = 13,
	window_frame = {
		font = wezterm.font_with_fallback({
			{ family = "SF Pro" },
			{ family = "Symbols Nerd Font", scale = 1.4, italic = false },
		}),
		font_size = 13,

		inactive_titlebar_bg = "#232328",
		active_titlebar_bg = "#232328",
		inactive_titlebar_fg = "#cccccc",
		active_titlebar_fg = "#ffffff",
		inactive_titlebar_border_bottom = "#2b2042",
		active_titlebar_border_bottom = "#2b2042",
		button_fg = "#cccccc",
		button_bg = "#2b2042",
		button_hover_fg = "#ffffff",
		button_hover_bg = "#3b3052",
	},
	colors = {
		tab_bar = {
			inactive_tab_edge = "#232328",
			active_tab = {
				bg_color = "#282c34",
				fg_color = "#c8cdd5",
			},
			inactive_tab = {
				bg_color = "#232328",
				fg_color = "#abb2bf",
			},
			inactive_tab_hover = {
				bg_color = "#232328",
				fg_color = "#cdd6f4",
			},
			new_tab = {
				bg_color = "#232328",
				fg_color = "#abb2bf",
			},
			new_tab_hover = {
				bg_color = "#232328",
				fg_color = "#c8cdd5",
			},
		},
	},
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 4,
	},
	unix_domains = {
		{
			name = "unix",
		},
	},
	-- ssh_domains = {
	-- 	{
	-- 		name = "samsten",
	-- 		remote_address = "samsten.se",
	-- 		-- local_echo_threshold_ms = 50,
	-- 		username = "isak",
	-- 	},
	-- },

	disable_default_key_bindings = true,
	keys = {
		{ key = "L", mods = "SUPER", action = wezterm.action.ShowDebugOverlay },
		{ key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "D", mods = "SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "W", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
		{
			key = "r",
			mods = "SUPER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		},

		{
			key = "P",
			mods = "SUPER",
			action = wezterm.action.ActivateCommandPalette,
		},
		{ key = "}", mods = "SUPER", action = act.ActivateTabRelative(1) },
		{ key = "{", mods = "SUPER", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "SUPER", action = act.ActivatePaneDirection("Next") },
		{ key = "[", mods = "SUPER", action = act.ActivatePaneDirection("Prev") },
		{
			key = "f",
			mods = "SUPER",
			action = wezterm.action.TogglePaneZoomState,
		},
		{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = act.ResetFontSize },
		{ key = "=", mods = "SUPER", action = act.IncreaseFontSize },

		{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
		{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
		{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
		{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
		{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
		{ key = "6", mods = "SUPER", action = act.ActivateTab(5) },
		{ key = "7", mods = "SUPER", action = act.ActivateTab(6) },
		{ key = "8", mods = "SUPER", action = act.ActivateTab(7) },
		{ key = "9", mods = "SUPER", action = act.ActivateTab(-1) },

		{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
		{ key = "C", mods = "SUPER", action = act.ActivateCopyMode },

		{ key = "/", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },

		{ key = "m", mods = "SUPER", action = act.Hide },
		{ key = "n", mods = "SUPER", action = act.SpawnWindow },
		{ key = "q", mods = "SUPER", action = act.QuitApplication },

		{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },

		{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "UpArrow", mods = "SHIFT|SUPER", action = act.ScrollByPage(-1) },
		{ key = "DownArrow", mods = "SHIFT|SUPER", action = act.ScrollByPage(1) },

		{ key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
		{ key = "h", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
		{ key = "l", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
		{ key = "k", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
		{ key = "j", mods = "SUPER", action = act.ActivatePaneDirection("Down") },

		{ key = "LeftArrow", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "RightArrow", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "DownArrow", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", mods = "ALT|SUPER", action = act.AdjustPaneSize({ "Down", 1 }) },
		{
			key = "s",
			mods = "SUPER",
			action = act.PaneSelect,
		},
		{
			key = "S",
			mods = "SUPER",
			action = act.PaneSelect({
				mode = "SwapWithActive",
			}),
		},

		{
			key = "X",
			mods = "SUPER|SHIFT",
			action = act.DetachDomain("CurrentPaneDomain"),
		},

		{
			key = "F",
			mods = "SHIFT|CTRL",
			action = wezterm.action.Search("CurrentSelectionOrEmptyString"),
		},

		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },

		{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(1) },
	},

	key_tables = {

		resize_pane = {
			{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "LeftArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "H", action = act.AdjustPaneSize({ "Left", 5 }) },

			{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "RightArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "L", action = act.AdjustPaneSize({ "Right", 5 }) },

			{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "UpArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "K", action = act.AdjustPaneSize({ "Up", 5 }) },

			{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "DownArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "J", action = act.AdjustPaneSize({ "Down", 5 }) },

			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},

		copy_mode = copy_mode,
		search_mode = search_mode,
	},
}
config.ssh_domains = wezterm.default_ssh_domains()
for _, dom in ipairs(config.ssh_domains) do
	dom.assume_shell = "Posix"
	dom.name = string.gsub(dom.name, "SSHMUX:", "mux:")
	dom.name = string.gsub(dom.name, "SSH:", "ssh:")
end
return config
