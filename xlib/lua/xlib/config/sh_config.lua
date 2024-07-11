xLib.Config = xLib.Config or {}

-- Required xLib Config
xLib.Config.Name = "xLib"
xLib.Config.MajorVersion = 1
xLib.Config.MinorVersion = 0
xLib.Config.Patch = 0
xLib.Config.Author = "TheXnator"
xLib.Config.PrefixCol = Color(200, 50, 200)

-- Addon-specific config
xLib.Config.MenuName = "xLib Addons Administration"

-- Set to true if experiencing FPS drops in menus
xLib.Config.DisableMenuShadows = false

-- Menu chat command
xLib.Config.ChatCommand = "!xlib"


--[[

    Languages Config
	Supported Languages: English

]]--


xLib.Config.LANG = "English"

xLib.Config.Languages = {}
xLib.Config.Languages["English"] = {}
xLib.Config.Languages["English"]["addonversion"] = "Installed Version"
xLib.Config.Languages["English"]["by"] = "By"
xLib.Config.Languages["English"]["updates"] = "Updates"
xLib.Config.Languages["English"]["config"] = "Config"
xLib.Config.Languages["English"]["save"] = "Save"
xLib.Config.Languages["English"]["noundo"] = "This action cannot be undone!"
xLib.Config.Languages["English"]["editconfigs"] = "Edit Configs"