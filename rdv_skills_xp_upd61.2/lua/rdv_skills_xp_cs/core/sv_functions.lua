function RDV.SAL.SetLevel(client, level)
    if not IsValid(client) then return end

    local PRE = hook.Run("RDV_SAL_PreSetLevel", client, tonumber(level))

    if PRE == false then
        return
    elseif isnumber(PRE) then
        level = PRE
    end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    TAB.LEVEL = TAB.LEVEL or 0
    TAB.LEVEL = tonumber(level)

    client:SetNWInt("RDV.LEVELS.INFO.LEVEL", level)

    hook.Run("RDV_SAL_PostSetLevel", client, tonumber(level))
end

function RDV.SAL.AddExperience(client, exp)
    if not IsValid(client) then return end

    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(client:Team())
    --PrintTable(teams)
    --print(clientTeam)

    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]
    if !TAB then return end

    TAB.LEVEL = tonumber(TAB.LEVEL) or 0
    TAB.EXPERIENCE = tonumber(TAB.EXPERIENCE) or 0

    if !RDV.SAL.GetRequiredXP(TAB.LEVEL + 1) then
        return
    end
    
    local PRE = hook.Run("RDV_SAL_PreAddExperience", client, tonumber(exp))

    if PRE == false then
        return
    elseif isnumber(PRE) then
        exp = PRE
    end

    exp = math.Round(exp)

    TAB.EXPERIENCE = TAB.EXPERIENCE + exp

    local REQUR = RDV.SAL.GetRequiredXP(TAB.LEVEL + 1)

    local REST = ( (TAB.EXPERIENCE - REQUR) )

    if TAB.EXPERIENCE >= REQUR then
        RDV.SAL.SetLevel(client, TAB.LEVEL + 1)

        TAB.EXPERIENCE = 0
    end

    if REST > 0 then
        RDV.SAL.AddExperience(client, REST)
    else
        net.Start("RDV.LEVELS.UpdateClient")
            net.WriteUInt(1, 2)
            net.WriteString(TAB.EXPERIENCE)
        net.Send(client)
    end

    hook.Run("RDV_SAL_PostAddExperience", client, tonumber(exp))
end

function RDV.SAL.Save(client)
    if not IsValid(client) then return end

    local PCHAR =  ( RDV.LIBRARY.GetCharacterEnabled() and RDV.LIBRARY.GetCharacterID(client, nil) or 1 )

    if not PCHAR or not isnumber(PCHAR) then
        return
    end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    if !TAB or !TAB.INITIALIZED then return end

    TAB.LEVEL = tonumber(TAB.LEVEL) or 0
    TAB.EXPERIENCE = tonumber(TAB.EXPERIENCE) or 0
    TAB.POINTS = tonumber(TAB.POINTS) or 0

    if not isnumber(TAB.LEVEL) or not isnumber(TAB.EXPERIENCE) then
        return
    end

    local CLEARED = util.TableToJSON(TAB.SKILLS)

    local q = RDV_Mysql:Select("RDV_LEVELS_DB_V1")
        q:Where("CLIENT", SID64)
        q:Where("PCHARACTER", PCHAR)
        q:Callback(function(data)
            if !data or data[1] == nil then
                local q = RDV_Mysql:InsertIgnore("RDV_LEVELS_DB_V1")
                    q:Insert("CLIENT", SID64)
                    q:Insert("SKILLS", CLEARED)
                    q:Insert("POINTS", TAB.POINTS)
                    q:Insert("EXPERIENCE", TAB.EXPERIENCE)
                    q:Insert("LEVEL", TAB.LEVEL)
                    q:Insert("PCHARACTER", PCHAR)
                q:Execute()
            else
                local q = RDV_Mysql:Update("RDV_LEVELS_DB_V1")
                    q:Update("LEVEL", TAB.LEVEL)
                    q:Update("EXPERIENCE", TAB.EXPERIENCE)
                    q:Update("SKILLS", CLEARED)
                    q:Update("POINTS", TAB.POINTS)
                    q:Where("PCHARACTER", PCHAR)
                    q:Where("CLIENT", SID64)
                q:Execute()
            end

            hook.Run("RDV_SAL_PostPlayerSave", client, TAB, PCHAR)
        end)
    q:Execute()
end



function RDV.SAL.GetSkills(client)
    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    if !TAB then return end

    return (TAB.SKILLS or {})
end

function RDV.SAL.GetClientCanUseSkill(client, skill)
    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    if !TAB or !TAB.SKILLS then return end
    local skill = TAB.SKILLS[skill]
    return skill.Catagories && skill.Catagories[client:getJobTable().category]
end

function RDV.SAL.GetSkillTier(client, skill)
    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    if !TAB or !TAB.SKILLS then return end

    return (TAB.SKILLS[skill] or 0)
end

function RDV.SAL.HasSkill(client, skill)
    local SKILLS = RDV.SAL.GetSkills(client)
    
    if (!RDV.SAL.GetClientCanUseSkill(client, skill)) then return end

    if SKILLS[skill] then
        return true
    else
        return false
    end
end

function RDV.SAL.GiveSkill(client, skill, level)
    local PRE = hook.Run("RDV_SAL_CanGiveSkill", client, skill, tonumber(level))

    if PRE == false then
        return
    end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]
    if !TAB then return end
    
    TAB.SKILLS[skill] = level

    hook.Run("RDV_SAL_PostGiveSkill", client, skill, tonumber(level))
end

function RDV.SAL.GivePoints(client, points)
    if not IsValid(client) or not points then
        return
    end

    local PRE = hook.Run("RDV_SAL_PreGivePoints", client, points)

    if PRE == false then
        return
    elseif isnumber(PRE) then
        points = PRE
    end

    local SID64 = client:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    TAB.POINTS = (TAB.POINTS or 0)
    TAB.POINTS = TAB.POINTS + points

    net.Start("RDV.LEVELS.UpdateClient")
        net.WriteUInt(2, 2)
        net.WriteUInt(TAB.POINTS, 32)
    net.Send(client)

    hook.Run("RDV_SAL_PostGivePoints", client, points)
end


function RDV.SAL.ResetSkills(ply)
    local POINTS = 0

    local SID64 = ply:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    local SKILLS = TAB.SKILLS

    if SKILLS then
        for k, v in pairs(SKILLS) do
            local CFG = RDV.SAL.SKILLS.LIST[k]
    
            if CFG then
                POINTS = POINTS + v
            end
        end
    else
        return false, 0
    end

    if POINTS >= 1 then
        RDV.SAL.GivePoints(ply, POINTS)

        TAB.SKILLS = {}

        return true, POINTS
    else
        return false, 0
    end
end