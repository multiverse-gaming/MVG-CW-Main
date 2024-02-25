function player.FindInSphere(pos, dist)
    dist = dist * dist
    local t = {}
    for index, ply in ipairs(player.GetAll()) do
        if ply:GetPos():DistToSqr(pos) < dist then
            t[#t + 1] = ply
        end
    end
    return t
end

if not SummeLibrary.CacheSteamNames then return end

SummeLibrary.Players = {}

local Player = FindMetaTable("Player")

function Player:SteamName()
    local steamID64 = self:SteamID64()
    if SummeLibrary.Players[steamID64] then
        return SummeLibrary.Players[steamID64]
    else
        self:CacheSteamName()
        return "Loading..."
    end
end

function Player:CacheSteamName()

    if not IsValid(self) then return end

    local steamID64 = self:SteamID64()

    if not steamID64 or steamID64 == nil then return end

    local url = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=94A0B83E4750AC1EEFF0530D847E1151&steamids="..steamID64

    http.Fetch(url, function(body)

        if not body then return end

        body = util.JSONToTable(body)

        if not body.response.players[1].personaname then return end

        local steamName = body.response.players[1].personaname

        SummeLibrary.Players[steamID64] = steamName
    end)
end

hook.Add("PlayerInitialSpawn", "SummeLibrary.SaveSteamName", function(ply)
    ply:CacheSteamName()
end)