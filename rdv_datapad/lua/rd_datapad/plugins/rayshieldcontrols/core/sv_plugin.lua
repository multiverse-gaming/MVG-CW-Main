local hackableConsoles = {}

hook.Add("Think", "UpdateHackableConsoleStatus", function()
    for _, ent in pairs(ents.FindByClass("dev_hackable_console_door")) do
        local consoleData = {
            entity = ent,
            hacked = ent:GetIsHacking() and ent:GetHackTimeRemaining() <= 0,
            hackingInProgress = ent:GetIsHacking() and ent:GetHackTimeRemaining() > 0,
        }
        hackableConsoles[ent:EntIndex()] = consoleData
    end
end)

util.AddNetworkString("RequestHackableConsoleStatus")
util.AddNetworkString("SendHackableConsoleStatus")

net.Receive("RequestHackableConsoleStatus", function(len, ply)
    local consoleStatus = {}
    for _, data in pairs(hackableConsoles) do
        table.insert(consoleStatus, data)
    end

    net.Start("SendHackableConsoleStatus")
    net.WriteTable(consoleStatus)
    net.Send(ply)
end)
