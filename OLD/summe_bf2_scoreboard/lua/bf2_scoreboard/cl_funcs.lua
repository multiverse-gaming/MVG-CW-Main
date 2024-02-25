function BF2_Scoreboard:GetUsergroup(ply)
    local usrgrp = ply:GetUserGroup()

    if BF2_Scoreboard.Config.Usergroups[usrgrp] then
        return BF2_Scoreboard.Config.Usergroups[usrgrp].name, BF2_Scoreboard.Config.Usergroups[usrgrp].color
    else
        return BF2_Scoreboard.Config.Usergroups["user"].name, BF2_Scoreboard.Config.Usergroups["user"].color
    end
end

function BF2_Scoreboard:ShortenString(string, maxChars)
    if #string > maxChars then
        local t = ""

        for _, char in pairs(string.Split(string, "")) do
            if #t < maxChars then
                t = t..char
            end
        end

        return t.."..."

    else
        return string
    end
end

function BF2_Scoreboard:GetRank(ply)
    if DarkRP then
        return team.GetName(ply:Team()), team.GetColor(ply:Team())
    else
        return "N/A"
    end
end

function BF2_Scoreboard:GetPlayers()
    local t = {}

    for k, ply in pairs(player.GetAll()) do
        t[ply] = {
            name = ply:Nick(),
            team = ply:Team(),
            group = ply:GetUserGroup(),
            kills = ply:Frags(),
            npckills = ply:GetNWInt("BF2SB_TotalKillsNPC", 0),
            deaths = ply:Deaths(),
            ping = ply:Ping(),
        }
    end

    return t
end