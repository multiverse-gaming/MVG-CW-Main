local COL_1 = Color(255,255,255)

local q = [[
    CREATE TABLE IF NOT EXISTS RDV_LEVELS_DB_V1(
        CLIENT VARCHAR(80),
        PCHARACTER INT DEFAULT 1,
        LEVEL INT,
        EXPERIENCE INT,
        POINTS INT,
        SKILLS TEXT,
        PRIMARY KEY(CLIENT, PCHARACTER)
    );
]]

RDV_Mysql:RawQuery(q)

local function CheckSkills(ply)
    local SID64 = ply:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    for k, v in pairs(TAB.SKILLS) do
        local CFG = RDV.SAL.SKILLS.LIST[k]

        if CFG then
            if v > CFG.MAX then
                local OVERDRAW = v - CFG.MAX

                TAB.SKILLS[k] = CFG.MAX

                RDV.SAL.GivePoints(client, OVERDRAW)
            end 
        else
            local POINTS = TAB.SKILLS[k]

            RDV.SAL.GivePoints(client, POINTS)

            TAB.SKILLS[k] = nil
        end
    end
end

local function Initialize(ply, char)
    if !char then char = 1 end

    local SID64 = ply:SteamID64()
    RDV.SAL.PLAYERS[SID64] = {}

    local q = RDV_Mysql:Select("RDV_LEVELS_DB_V1")
    q:Select("PCHARACTER")
    q:Select("LEVEL")
    q:Select("EXPERIENCE")
    q:Select("POINTS")
    q:Select("SKILLS")
    q:Where("CLIENT", SID64)
    q:Where("PCHARACTER", char)
        q:Callback(function(data)
            data = data or {}

            local T = data[1] or {LEVEL = 0, EXPERIENCE = 0, POINTS = 0, SKILLS = {}}

            if isstring(T.SKILLS) then
                T.SKILLS = util.JSONToTable(T.SKILLS)
            end

            RDV.SAL.PLAYERS[SID64] = {
                LEVEL = T.LEVEL,
                EXPERIENCE = T.EXPERIENCE,
                POINTS = T.POINTS,
                SKILLS = T.SKILLS,
                INITIALIZED = true,
            }

            ply:SetNWInt("RDV.LEVELS.INFO.LEVEL", T.LEVEL)

            net.Start("RDV.LEVELS.UpdateClient")
                net.WriteUInt(3, 2)
                net.WriteString(T.EXPERIENCE)
                net.WriteUInt(T.POINTS, 32)
            net.Send(ply)
        end)
    q:Execute()

    CheckSkills(ply, char)
end

    RDV.LIBRARY.OnCharacterLoaded(nil, function(ply, char)
        if !RDV.LIBRARY.GetCharacterEnabled() then return end

        Initialize(ply, char)
    end)

    RDV.LIBRARY.OnCharacterChanged(nil, function(ply, new, old)
        if !RDV.LIBRARY.GetCharacterEnabled() then return end

        if !old or ( new == old ) then
            return
        end

        RDV.SAL.Save(ply)
    end)

    RDV.LIBRARY.OnCharacterDeleted(nil, function(ply, CHARACTER_ID)
        if !RDV.LIBRARY.GetCharacterEnabled() then return end

        local q = RDV_Mysql:Delete("RDV_LEVELS_DB_V1")
            q:Where("PCHARACTER", CHARACTER_ID)
        q:Execute()
    
        local SID64 = ply:SteamID64()
        RDV.SAL.PLAYERS[SID64] = {}
    end)


hook.Add("PlayerReadyForNetworking", "RDV.LEVELS.PlayerReadyForNetworking", function(client)
    local SID64 = client:SteamID64()
    RDV.SAL.PLAYERS[SID64] = {}
    
    if RDV.LIBRARY.GetCharacterEnabled() then return end

    Initialize(client)
end)