/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

local DebugPrint = false

local function NicePrint(txt)
    if DebugPrint == false then return end

    if SERVER then
        MsgC(Color(84, 150, 197), txt .. "\n")
    else
        MsgC(Color(193, 193, 98), txt .. "\n")
    end
end

// Only used for client spawn menus
local function PreLoadFile(path)
	if CLIENT then
		include(path)
	else
		AddCSLuaFile(path)
		include(path)
	end
end

local function LoadFiles(path)
	local files, _ = file.Find(path .. "/*", "LUA")

	for _, v in pairs(files) do
		if string.sub(v, 1, 3) == "sh_" then
			if CLIENT then
				include(path .. "/" .. v)
			else
				AddCSLuaFile(path .. "/" .. v)
				include(path .. "/" .. v)
			end
			NicePrint("// Loaded " .. v .. string.rep(" ", 38 - v:len()) .. " //")
		end
	end

	for _, v in pairs(files) do
		if string.sub(v, 1, 3) == "cl_" then
			if CLIENT then
				include(path .. "/" .. v)
				NicePrint("// Loaded " .. v .. string.rep(" ", 38 - v:len()) .. " //")
			else
				AddCSLuaFile(path .. "/" .. v)
			end
		elseif string.sub(v, 1, 3) == "sv_" then
			include(path .. "/" .. v)
			NicePrint("// Loaded " .. v .. string.rep(" ", 38 - v:len()) .. " //")
		end
	end
end

local function Initialize()
	NicePrint(" ")
	NicePrint("///////////////////////////////////////////////////")
	NicePrint("///////////// Zeros PumpkinNight //////////////////")
	NicePrint("///////////////////////////////////////////////////")
	NicePrint("//                                               //")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	PreLoadFile("sh_zpn_config_main.lua")

	LoadFiles("zpn_languages")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	PreLoadFile("sh_zpn_config_theme.lua")
	PreLoadFile("sh_zpn_config_mask.lua")
	PreLoadFile("sh_zpn_config_shop.lua")
	PreLoadFile("sh_zpn_config_loot.lua")
	PreLoadFile("sv_zpn_hooks.lua")

	LoadFiles("zevent/util")
	LoadFiles("zevent/player")

	LoadFiles("zevent/boss")
	LoadFiles("zevent/candy")
	LoadFiles("zevent/data")
	LoadFiles("zevent/destructibles")
	LoadFiles("zevent/ghost")
	LoadFiles("zevent/minion")
	LoadFiles("zevent/scoreboard")
	LoadFiles("zevent/shop")
	LoadFiles("zevent/swep")
	LoadFiles("zevent/slapper")
	LoadFiles("zevent/mask")
	LoadFiles("zevent/loot")
	LoadFiles("zevent/beartrap")
	NicePrint("//                                               //")
	NicePrint("///////////////////////////////////////////////////")
	NicePrint("///////////////////////////////////////////////////")

	if DebugPrint == false then
		if SERVER then
			MsgC(Color(84, 150, 197), "Zeros PumpkinNight - Loaded\n")
		else
			MsgC(Color(193, 193, 98), "Zeros PumpkinNight - Loaded\n")
		end
	end
end

// Needs to be created instantly
PreLoadFile("zevent/util/cl_settings.lua")

// Needs to wait for the gamemode to be fully loaded. Cant use a hook since to many servers have broken hooks. :I
timer.Simple(0,function()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	// If zeros libary is not installed on the server then lets tell them
	if zclib == nil then
		local function Warning(ply, msg)
			if DarkRP and DarkRP.notify then
				DarkRP.notify(ply, 1, 8, msg)
			else
				ply:ChatPrint(msg)
			end
		end

		MsgC(Color(255, 0, 0), "[Zero´s PumpkinNight] > Zeros Lua Libary not found!")
		MsgC(Color(255, 0, 0), "https://steamcommunity.com/sharedfiles/filedetails/?id=2532060111")

		if CLIENT then
			surface.PlaySound( "common/warning.wav" )
		end

		if SERVER then
			for k,v in ipairs(player.GetAll()) do
				if IsValid(v) then
					Warning(v, "[Zero´s PumpkinNight] > Zeros Lua Libary not found!")
					Warning(v, "https://steamcommunity.com/sharedfiles/filedetails/?id=2532060111")
				end
			end
		end
		return
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	Initialize()
end)
