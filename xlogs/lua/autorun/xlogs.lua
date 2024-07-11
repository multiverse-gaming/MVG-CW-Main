--[[
	xLogs
	Author: TheXnator
	
	Icons made by SmashIcons from www.flaticon.com (https://www.flaticon.com/authors/smashicons)
]] --

-- Create xLogs global tables
xLogs = xLogs or {}
xLogs.LoggingCats = xLogs.LoggingCats or {}
xLogs.LoggingTypes = xLogs.LoggingTypes or {}
xLogs.Logs = xLogs.Logs or {}
xLogs.Settings = xLogs.Settings or {}

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
   local files, folders = file.Find(f .. "/*", "LUA")
    for k, v in pairs(files) do inc(f .. "/" .. v) end
    for k, v in pairs(folders) do incFolder(f .. "/" .. v) end
end

-- Include xLogs files
inc("xlogs/sh_config.lua") -- These need to load first
inc("xlogs/sh_xlogs.lua")
incFolder("xlogs")

if SERVER then
    local function addContentFolder(path)
        local files, folders = file.Find(path .. "/*", "GAME")
        for k, v in pairs(files) do resource.AddFile(path .. "/" .. v) end
        for k, v in pairs(folders) do addContentFolder(path .. "/" .. v) end
    end

    -- I like having load times which aren't ridiculous
    if xLogs.Config.UsingFastDL then
        addContentFolder("materials/xlogs")
        addContentFolder("resource/fonts")
    else
        resource.AddWorkshop("1895935906")
    end
end

xLogs.log(string.format("Loaded %s v%s.%s.%s by %s", xLogs.Config.Name,
                        xLogs.Config.MajorVersion, xLogs.Config.MinorVersion,
                        xLogs.Config.Patch, xLogs.Config.Author))
