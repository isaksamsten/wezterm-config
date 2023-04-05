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
-- wezterm.on("update-right-status", function(window, pane)
-- 	local meta = pane:get_metadata() or {}
-- 	if meta.is_tardy then
-- 		local secs = meta.since_last_response_ms / 1000.0
-- 		window:set_right_status(string.format("⏳%5.1fs", secs))
-- 	end
-- end)

return {
	term = "wezterm",
	window_decorations = "RESIZE | INTEGRATED_BUTTONS",
	-- ->
	font = wezterm.font_with_fallback({
		-- { family = "SF Mono", stretch = "Condensed" },
		{ family = "Jetbrains Mono NL", stretch = "Condensed" },
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
	ssh_domains = {
		{
			name = "samsten",
			remote_address = "samsten.se",
			-- local_echo_threshold_ms = 50,
			username = "isak",
		},
	},
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
		{ key = "x", mods = "SUPER", action = act.ActivateCopyMode },

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

		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
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

		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},

		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	},
}
