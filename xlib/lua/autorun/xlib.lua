--[[
	xLib
	Author: TheXnator
]] --

-- Create xLib global tables
xLib = xLib or {}

local includeFunctions = {
    sv = SERVER and include or function() end,
    cl = SERVER and AddCSLuaFile or include,
    sh = function(f)
        include(f)
        if SERVER then AddCSLuaFile(f) end
    end
}

local function inc(f)
    return (includeFunctions[string.GetFileFromFilename(f):sub(1, 2)] or includeFunctions["sh"])(f)
end

local function incFolder(f)
   	local files, folders = file.Find(string.format("%s/*", f), "LUA")
  	for k, v in pairs(files) do inc(string.format("%s/%s", f, v)) end
	for k, v in pairs(folders) do incFolder(string.format("%s/%s", f, v)) end
end

incFolder("xlib/config")
incFolder("xlib/required")
inc("xlib/core/sh_xlib.lua")
incFolder("xlib/core")
incFolder("xlib/panels")
incFolder("xlib/modules")

xLib.logAddonLoaded(xLib)

hook.Run("xLibAddonLoaded")