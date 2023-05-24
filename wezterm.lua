local wezterm = require("wezterm")
local act = wezterm.action
local icons_map = {
	copy_mode = "  ",
	search_mode = "  ",
}

local gui_colors = {
	DarkBackground = "#24273A",
	DarkForeground = "#C6D0F5",
	LightBackground = "#24273A",
	LightForeground = "#EFF1F5",
}

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

local function get_window_colors_for_scheme(appearance)
	if appearance:find("Dark") then
		return {
			DarkBackground = "#24273A",
			DarkForeground = "#8087a2",
			LightBackground = "#24273A",
			LightForeground = "#C6D0F5",
		}
	else
		return {
			DarkBackground = "#EFF1F5",
			DarkForeground = "#8c8fa1",
			LightBackground = "#EFF1F5",
			LightForeground = "#4C4F69",
		}
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		local colors = get_window_colors_for_scheme(appearance)

		overrides.window_frame = {
			inactive_titlebar_bg = colors.DarkBackground,
			inactive_titlebar_fg = colors.DarkForeground,
			active_titlebar_bg = colors.DarkBackground,
			active_titlebar_fg = colors.DarkForeground,
		}
		overrides.colors = {
			tab_bar = {
				inactive_tab_edge = colors.DarkBackground,
				active_tab = {
					bg_color = colors.LightBackground,
					fg_color = colors.LightForeground,
				},
				inactive_tab = {
					bg_color = colors.DarkBackground,
					fg_color = colors.DarkForeground,
				},
				inactive_tab_hover = {
					bg_color = colors.DarkBackground,
					fg_color = colors.LightForeground,
				},
				new_tab = {
					bg_color = colors.DarkBackground,
					fg_color = colors.DarkForeground,
				},
				new_tab_hover = {
					bg_color = colors.DarkBackground,
					fg_color = colors.LightForeground,
				},
			},
		}

		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	local message = icons_map[name] or name
	local bg = gui_colors.DarkBackground
	local fg = gui_colors.DarkForeground
	if message then
		window:set_right_status(wezterm.format({
			{ Background = { Color = bg } },
			{ Foreground = { Color = fg } },
			{ Text = message },
		}))
	else
		window:set_right_status("")
	end
end)

local copy_mode = wezterm.gui.default_key_tables().copy_mode
local search_mode = wezterm.gui.default_key_tables().search_mode
local config = {
	term = "wezterm",
	window_decorations = "RESIZE | INTEGRATED_BUTTONS",
	-- ->
	font = wezterm.font_with_fallback({
		-- { family = "SF Mono", stretch = "Condensed", weight = "Medium" },
		{ family = "Jetbrains Mono NL", stretch = "Condensed", weight = "Regular" },
		-- { family = "Menlo" },
		-- { family = "Iosevka", stretch = "Normal", weight = "Regular", harfbuzz_features = { "ss04", "calt=0" } },
		{ family = "Symbols Nerd Font Mono", scale = 1.0 },
	}),
	front_end = "WebGpu",
	font_size = 13,
	freetype_load_target = "Normal",
	freetype_render_target = "HorizontalLcd",
	allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
	color_scheme = "Catppuccin Macchiato",
	bold_brightens_ansi_colors = true,
	adjust_window_size_when_changing_font_size = true,
	show_tab_index_in_tab_bar = false,
	command_palette_font_size = 13,
	window_frame = {
		font = wezterm.font_with_fallback({
			{ family = "SF Pro" },
		}),
		font_size = 13,

		inactive_titlebar_bg = gui_colors.DarkBackground,
		inactive_titlebar_fg = gui_colors.DarkForeground,
		active_titlebar_bg = gui_colors.DarkBackground,
		active_titlebar_fg = gui_colors.DarkForeground,
		-- inactive_titlebar_border_bottom = "purple",
		-- active_titlebar_border_bottom = "purple",
	},
	colors = {
		tab_bar = {
			inactive_tab_edge = gui_colors.DarkBackground,
			active_tab = {
				bg_color = gui_colors.LightBackground,
				fg_color = gui_colors.LightForeground,
			},
			inactive_tab = {
				bg_color = gui_colors.DarkBackground,
				fg_color = gui_colors.DarkForeground,
			},
			inactive_tab_hover = {
				bg_color = gui_colors.DarkBackground,
				fg_color = gui_colors.LightForeground,
			},
			new_tab = {
				bg_color = gui_colors.DarkBackground,
				fg_color = gui_colors.DarkForeground,
			},
			new_tab_hover = {
				bg_color = gui_colors.DarkBackground,
				fg_color = gui_colors.LightForeground,
			},
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
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
			key = "P",
			mods = "SUPER",
			action = wezterm.action.ActivateCommandPalette,
		},

		{ key = "}", mods = "SUPER", action = act.ActivateTabRelative(1) },
		{ key = "{", mods = "SUPER", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "SUPER", action = act.ActivatePaneDirection("Next") },
		{ key = "[", mods = "SUPER", action = act.ActivatePaneDirection("Prev") },
		{
			key = "Enter",
			mods = "SUPER|SHIFT",
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
