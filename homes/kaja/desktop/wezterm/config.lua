local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Helper to give first value if we're on a light theme, second if dark
function light_dark(if_light, if_dark)
	local appearance_mode = 'Light'
	if wezterm.gui then
		appearance_mode = wezterm.gui.get_appearance()
	end

	if appearance_mode:find 'Dark' then
		return if_dark
	else
		return if_light
	end
end

config.use_fancy_tab_bar = false
config.enable_scroll_bar = true

config.font = wezterm.font_with_fallback {'Fira Code Nerd Font', 'Fira Code'}
config.font_size = 11.0
config.color_scheme = light_dark('One Light (base16)', 'OneDark (base16)')

config.mouse_bindings = {
	-- Left click shouldn't open hyperlinks
	{event={Up={streak=1, button="Left"}}, mods="NONE", action=act.CompleteSelection 'PrimarySelection'},
	-- Ctrl+left click should open hyperlinks
	{event={Up={streak=1, button="Left"}}, mods="CTRL", action=act.OpenLinkAtMouseCursor},
}
config.keys = {
	{mods='ALT', key='d', action=wezterm.action.SplitHorizontal{domain='CurrentPaneDomain'}},
	{mods='ALT|SHIFT', key='d', action=wezterm.action.SplitVertical{domain='CurrentPaneDomain'}},
}

config.default_prog = { '/home/kaja/.nix-profile/bin/bash','--login','-c', 'exec /usr/bin/env --argv0=- --unset=SHELL TERM=xterm-256color /home/kaja/.nix-profile/bin/fish' }

-- Workaround for https://github.com/wez/wezterm/issues/4962
config.enable_wayland = false

wezterm.log_info(config)
return config
