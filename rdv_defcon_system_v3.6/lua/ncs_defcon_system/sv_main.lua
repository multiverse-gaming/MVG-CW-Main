local COL_WHITE = Color(255,255,255)

local function SendNotification(ply, msg)
    local CFG = NCS_DEFCON.CONFIG
	local PC = CFG.prefixcolor
	local PT = CFG.prefixtext

    NCS_DEFCON.AddText(ply, PC, "["..PT.."] ", color_white, msg)
end

local COL_WHITE = Color(255,255,255)

function NCS_DEFCON.SetDefcon(number, ply)
	if not IsValid(ply) then
		return false
	end

	local CFG = NCS_DEFCON.CONFIG.defconList
	local DEFCON_LVL = tonumber(number)

	if !CFG[DEFCON_LVL] then
		local LANG = NCS_DEFCON.GetLang(nil, "DEF_invalidDefcon", {tostring(DEFCON_LVL)})

		SendNotification(ply, LANG)

		return ""
	end

	NCS_DEFCON.CURRENT = DEFCON_LVL

	cookie.Set("defconLevel", DEFCON_LVL)

	net.Start("NCS_DEFCON_CHANGE")
		net.WriteUInt(DEFCON_LVL, 8)
		net.WriteUInt(ply:EntIndex(), 8)
	net.Broadcast()

	hook.Run("NCS_DEF_PlayerChangedDefcon", DEFCON_LVL, ply)
end