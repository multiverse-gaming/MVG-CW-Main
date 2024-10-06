net.Receive("RDV.LEVELS.UpdateClient", function()
    if not IsValid(LocalPlayer()) then
        return
    end

    local SID64 = LocalPlayer():SteamID64()
    RDV.SAL.PLAYERS[SID64] = RDV.SAL.PLAYERS[SID64] or {}

    local TAB = RDV.SAL.PLAYERS[SID64]
    
    local TRANS = net.ReadUInt(2)

    if ( TRANS == 1 ) then
        local OLD = (TAB.EXPERIENCE or 0)
        local EXPER = net.ReadString()

        if RDV.LIBRARY.GetConfigOption("SAL_notifEnabled") then
            local LANG = RDV.LIBRARY.GetLang(nil, "SAL_earnedExp", {
                (EXPER - OLD),
            })

            notification.AddLegacy(LANG, NOTIFY_GENERIC, 2)
        end
        
        TAB.EXPERIENCE = tonumber(EXPER)
    elseif ( TRANS == 2 ) then
        local POINT = net.ReadUInt(32)

        TAB.POINTS = POINT
    elseif ( TRANS == 3 ) then
        local EXPER = net.ReadString()
        local POINT = net.ReadUInt(32)

        TAB.POINTS = POINT
        TAB.EXPERIENCE = tonumber(EXPER)
    end

    hook.Run("RDV_SAL_ReceivedUpdatedStats", LocalPlayer())
end)

local PVS = {}

hook.Add("NotifyShouldTransmit", "RDV.LEVELS.NotifyShouldTransmit", function(ent, should)
    if !RDV.LIBRARY.GetConfigOption("SAL_expPVS") then return end

    if !IsValid(ent) or !ent:IsPlayer() or !should then return end
    if PVS[ent] and PVS[ent] > CurTime() then return end

    if !should then
        return 
    end

    net.Start("RDV.LEVELS.PVS_Experience")
        net.WriteUInt(ent:EntIndex(), 8)
    net.SendToServer()

    PVS[ent] = CurTime() + 10
end)

net.Receive("RDV.LEVELS.PVS_Experience", function()
    if !RDV.LIBRARY.GetConfigOption("SAL_expPVS") then return end

    local INDEX = net.ReadUInt(8)
    local EXP = net.ReadString()

    local ent = Entity(INDEX)

    if !IsValid(ent) or !ent:IsPlayer() then
        return
    end

    local SID64 = ent:SteamID64()

    RDV.SAL.PLAYERS[SID64] = {
        EXPERIENCE = EXP
    }
end)
