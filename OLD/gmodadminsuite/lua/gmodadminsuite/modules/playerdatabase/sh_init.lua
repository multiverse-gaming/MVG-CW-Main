if (SERVER) then
	AddCSLuaFile("gmodadminsuite/modules/playerdatabase/sh_playerdatabase.lua")
end

GAS:hook("gmodadminsuite:LoadModule:playerdatabase", "LoadModule:playerdatabase", function()
	include("gmodadminsuite/modules/playerdatabase/sh_playerdatabase.lua")
end)