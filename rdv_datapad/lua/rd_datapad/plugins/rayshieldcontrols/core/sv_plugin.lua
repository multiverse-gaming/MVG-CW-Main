-- Create a table to store the status of each hackable console
local hackableConsoles = {}

-- Update the status of each hackable console every second
hook.Add("Think", "UpdateHackableConsoleStatus", function()
    for _, ent in pairs(ents.FindByClass("dev_hackable_console_door")) do
        local consoleData = {
            entity = ent,
            hacked = ent:GetIsHacking() and ent:GetHackTimeRemaining() <= 0, -- Check if hacking is complete
            hackingInProgress = ent:GetIsHacking() and ent:GetHackTimeRemaining() > 0, -- Check if hacking is in progress
        }
        hackableConsoles[ent:EntIndex()] = consoleData
    end
end)

-- Networking for sending the console data to the client
util.AddNetworkString("RequestHackableConsoleStatus")
util.AddNetworkString("SendHackableConsoleStatus")

net.Receive("RequestHackableConsoleStatus", function(len, ply)
    local consoleStatus = {}
    for _, data in pairs(hackableConsoles) do
        table.insert(consoleStatus, data)
    end

    -- Send the status to the client
    net.Start("SendHackableConsoleStatus")
    net.WriteTable(consoleStatus)
    net.Send(ply)
end)
