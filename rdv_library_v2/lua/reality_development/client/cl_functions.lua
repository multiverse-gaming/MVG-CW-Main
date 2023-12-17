local plyMeta = FindMetaTable("Player")

--[[---------------------------------]]--
--  HUD Removal
--[[---------------------------------]]--

net.Receive("RDV.LIBRARY.RemoveHUD", function()
	local time = net.ReadInt(32)

	hook.Add("HUDShouldDraw", "RDV.LIBRARY.RemoveHUD", function(name)
		if ( name == "CHudWeaponSelection" ) then return true end
		if ( name == "CHudChat" ) then return true end

		return false
	end)

	timer.Simple(time, function()
		hook.Remove("HUDShouldDraw", "RDV.LIBRARY.RemoveHUD")
	end)
end)

--[[---------------------------------]]--
--  [LEGACY] Old AddText support.
--[[---------------------------------]]--

function plyMeta:RD_SendNotification(...)
    RDV.LIBRARY.AddText(self, ...)
end

--[[

	Shorten a string and, like- add dots?

--]]

function EPS_ShortenString(text, length)
    if string.len(text) > length then
        return string.sub(text, 0, length).."..."
    end

    return text
end

hook.Add( "InitPostEntity", "RDV.LIBRARY.PlayerReadyForNetworking", function()
	if !IsValid(LocalPlayer()) then return end
	
	LocalPlayer().RDV = LocalPlayer().RDV or {}

	net.Start( "RDV.LIBRARY.PlayerReadyForNetworking" )
	net.SendToServer()
end )
