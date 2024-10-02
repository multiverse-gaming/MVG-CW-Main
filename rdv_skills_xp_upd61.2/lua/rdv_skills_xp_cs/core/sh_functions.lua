function RDV.SAL.GetActiveBonus()
    local DAY = os.date( "%A")

    local ENB = RDV.LIBRARY.GetConfigOption("SAL_xpBonusEnb_"..DAY)
    local AMT = RDV.LIBRARY.GetConfigOption("SAL_xpBonus_"..DAY)
    
    if !ENB or !tonumber(AMT) then
        return false
    end

    return math.Round(AMT, 2)
end

function RDV.SAL.GetRequiredXP(LEVEL)
    local SCALE = RDV.LIBRARY.GetConfigOption("SAL_expScale")
    local START = RDV.LIBRARY.GetConfigOption("SAL_startExp")

    if !LEVEL or !SCALE or !START then return false end

    local REQ = START * (LEVEL * SCALE)

    return math.Round(REQ)
end

function RDV.SAL.HasPermission(ply)
    if !CAMI and !ply:IsSuperAdmin() then 
        return false
    end

    if CAMI and !CAMI.PlayerHasAccess(ply, "[SAL] Admin", nil) then
        return false
    end

    return true
end

function RDV.SAL.GetExperience(client)
    if !IsValid(client) then return end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    if !TAB then return 0 end

    return ( tonumber(TAB.EXPERIENCE) or 0 )
end


function RDV.SAL.GetLevel(client)
    if !IsValid(client) then return end

    if SERVER then
        local SID64 = client:SteamID64()
        local TAB = RDV.SAL.PLAYERS[SID64]
    
        if !TAB then return end

        return ( tonumber(TAB.LEVEL) or 0 )
    else
        return tonumber(client:GetNWInt("RDV.LEVELS.INFO.LEVEL", 0))
    end
end

function RDV.SAL.GetPoints(client)
    if !IsValid(client) then return end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    if !TAB then return end

    return ( tonumber(TAB.POINTS) or 0 )
end