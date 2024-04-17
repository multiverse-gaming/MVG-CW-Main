util.AddNetworkString("NCS_DEFCON_CHANGE")
util.AddNetworkString("RD_DEFCON_MENU")

local COL_WHITE = Color(255,255,255)

local function SendNotification(ply, msg)
    local CFG = NCS_DEFCON.CONFIG
	local PC = CFG.prefixcolor
	local PT = CFG.prefixtext

    NCS_DEFCON.AddText(ply, PC, "["..PT.."] ", color_white, msg)
end

local DELAY = {}
net.Receive("NCS_DEFCON_CHANGE", function(len, ply)
	if DELAY[ply:SteamID64()] and DELAY[ply:SteamID64()] > CurTime() then
		local LANG = NCS_DEFCON.GetLang(nil, "DEF_rateLimited")

		SendNotification(ply, LANG)

		return
	end
	
	local defcon = net.ReadUInt(8)

	local CFG = NCS_DEFCON.CONFIG.defconList

	if !CFG or !CFG[defcon] then
		return
	end

	NCS_DEFCON.IsAdmin(ply, function(checkPassed)
		local TEAMS = CFG[defcon].teams

		if checkPassed or CFG[defcon].allteams or ( CFG[defcon].teams and TEAMS[team.GetName(ply:Team())] ) then
			NCS_DEFCON.SetDefcon(defcon, ply)
		else
			local LANG = NCS_DEFCON.GetLang(nil, "DEF_incorrectTeam")
			SendNotification(ply, LANG)
		end
	end )

	DELAY[ply:SteamID64()] = CurTime() + 1
end)