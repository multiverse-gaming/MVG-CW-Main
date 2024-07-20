local trackedPlayers = {}

local function isPlayerTracked(ply)
    return trackedPlayers[ply:SteamID()] == true
end

concommand.Add("watchfox_track_player", function(ply, cmd, args)
    local steamID = args[1]
    if steamID then
        trackedPlayers[steamID] = true
        print("Added player with SteamID " .. steamID .. " to watch list.")
    else
        print("Invalid SteamID.")
    end
end)

-- Adjusting the shouldWrapNet hook
hook.Add("watchfox.security.shouldWrapNet", "watch.shouldWrapNet", function(name, ply, len)

    if isPlayerTracked(ply) then
        print(ply:SteamID() .. " tracked player used message: " .. name)

        return true
    end

end)

-- Implementing the readString hook
hook.Add("watchfox.security.readString", "watch.readString", function(stringContent)

    --print(WatchFox.Core.WrapperContext:GetNameOfPlayerSender():SteamID() .. ", content of string:" .. stringContent)

end)
