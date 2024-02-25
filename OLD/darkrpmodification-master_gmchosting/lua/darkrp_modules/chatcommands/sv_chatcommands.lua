-- IF updating this make sure sh_chatcommands.lua in main darkrp is updated.

local function isCommsDown(ply, args)
    if GetGlobalBool("commsDown") then
        ply:SendLua("chat.AddText(Color(255, 0, 0), '[AI] WARNING!', Color(255, 255, 255), ' > No communication over comms possible!')")
        return ""
    end
end



local function Advert(ply, args)
    if isCommsDown(ply, args) == "" then return "" end

    if args == "" then return "" end


    local DoSay = function(text)
        if text == "" then

            return ""

        end

        for _, target in pairs(player.GetAll()) do

            DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "[Advert] " .. ply:Nick(), Color(255, 255, 0), text, ply)

        end

    end

    return args, DoSay

end

DarkRP.defineChatCommand("advert", Advert, 1.5)

DarkRP.declareChatCommand{
    command = "advert",
    description = "advert",
    delay = 1.5
}

local function Comms(ply, args)
    if isCommsDown(ply, args) == "" then return "" end

    if args == "" then return "" end

    
    local DoSay = function(text)
        if text == "" then

            return ""

        end

        for _, target in pairs(player.GetAll()) do

            DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "[Secure Comms] " .. ply:Nick(), Color(255, 255, 0), text, ply)

        end

    end

    return args, DoSay

end

DarkRP.defineChatCommand("comms", Comms, 1.5)

DarkRP.declareChatCommand{
    command = "comms",
    description = "secure comms",
    delay = 1.5
}

DarkRP.defineChatCommand("c", Comms, 1.5)

DarkRP.declareChatCommand{
    command = "c",
    description = "secure comms",
    delay = 1.5
}

local function ENComms(ply, args)

    if args == "" then return "" end

    local DoSay = function(text)
        if text == "" then

            return ""

        end

        for _, target in pairs(player.GetAll()) do

            DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "[Enemy Comms] " .. ply:Nick(), Color(255, 0, 0), text, ply)

        end

    end

    return args, DoSay

end

DarkRP.defineChatCommand("enemycomm", ENComms, 1.5)

DarkRP.declareChatCommand{
    command = "enemycomm",
    description = "enemy comms",
    delay = 1.5
}



local function EComms(ply, args)

    if args == "" then return "" end

    local DoSay = function(text)
        if text == "" then

            return ""

        end

        for _, target in pairs(player.GetAll()) do

            DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "[Enemy Comms] " .. ply:Nick(), Color(255, 0, 0), text, ply)

        end

    end

    return args, DoSay

end

DarkRP.defineChatCommand("ec", EComms, 1.5)

DarkRP.declareChatCommand{
    command = "ec",
    description = "enemy comms",
    delay = 1.5
}

local function TrainingComms(ply, args)
    if isCommsDown(ply, args) == "" then return "" end

    if args == "" then return "" end

    local DoSay = function(text)
        if text == "" then

            return ""

        end

        for _, target in pairs(player.GetAll()) do

            DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "[Training Comms] " .. ply:Nick(), Color(100, 100, 255), text, ply)

        end

    end

    return args, DoSay

end

DarkRP.defineChatCommand("tc", TrainingComms, 1.5)

DarkRP.declareChatCommand{
    command = "tc",
    description = "training comms",
    delay = 1.5
}

local function NavalComms(ply, args)
    if isCommsDown(ply, args) == "" then return "" end

    if args == "" then return "" end

    local DoSay = function(text)
        if text == "" then

            return ""

        end

        for _, target in pairs(player.GetAll()) do

            DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "[Naval Comms] " .. ply:Nick(), Color(122, 122, 122), text, ply)

        end

    end

    return args, DoSay

end

DarkRP.defineChatCommand("nc", NavalComms, 1.5)

DarkRP.declareChatCommand{
    command = "nc",
    description = "naval comms",
    delay = 1.5
}

DarkRP.defineChatCommand("n", NavalComms, 1.5)

DarkRP.declareChatCommand{
    command = "n",
    description = "naval comms",
    delay = 1.5
}