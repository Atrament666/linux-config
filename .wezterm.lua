local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

local function dump_themes()
    local allSchemes = wezterm.color.get_builtin_schemes()
    local themeNames = {}

    -- Shromáždit názvy schémat
    for name in pairs(allSchemes) do
        table.insert(themeNames, name)
    end

    -- Otevřít soubor pro zápis
    local file = io.open(os.getenv("HOME") .. "/wezterm.themes", "w")
    if file then
        -- Zapsat názvy schémat do souboru
        for _, name in ipairs(themeNames) do
            file:write(name .. "\n")
        end
        file:close()
        print("Themes dumped to ~/wezterm.themes")
    else
        print("Failed to open file for writing.")
    end
end

local function my_theme_cycler(window, _)
    local allSchemes = wezterm.color.get_builtin_schemes()
    local currentMode = wezterm.gui.get_appearance()
    local currentScheme = window:effective_config().color_scheme
    local darkSchemes = {}
    local lightSchemes = {}

    for name, scheme in pairs(allSchemes) do
        if scheme.background then
            local bg = wezterm.color.parse(scheme.background) -- parse into a color object
            ---@diagnostic disable-next-line: unused-local
            local h, s, l, a = bg:hsla() -- and extract HSLA information
            if l < 0.4 then
                table.insert(darkSchemes, name)
            else
                table.insert(lightSchemes, name)
            end
        end
    end
    local schemesToSearch = currentMode:find("Dark") and darkSchemes or
                                lightSchemes
    local handle = io.popen("printf '%s\n' \"" ..
                                table.concat(schemesToSearch, "\" \"") ..
                                "\" | fzf")
    local result = handle:read("*a")
    handle:close()

end

config.color_scheme = 'Dark+'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font('Source Code Pro')
config.font_size = 10
config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.keys = {
    -- Theme Cycler
    {key = "t", mods = "ALT", action = wezterm.action_callback(my_theme_cycler)},

    -- Look up name of color scheme you switched to
    {key = "Escape", mods = "CTRL", action = wezterm.action.ShowDebugOverlay}
}
return config
