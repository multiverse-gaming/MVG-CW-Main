local OBJ = NCS_DATAPAD.GetPlugin()

util.AddNetworkString("NCS_DATAPAD.Hypex.Intercom")
local ActiveSpeakers = {}
net.Receive("NCS_DATAPAD.Hypex.Intercom", function(len, ply)
    local val = net.ReadBool()

    if OBJ.JobPermissions[team.GetName(ply:Team())] or OBJ.GroupPermissions[ply:GetUserGroup()] then
        ActiveSpeakers[ply] = val
    end
end)

hook.Add("PlayerCanHearPlayersVoice", "HYPEX_PLUGIN_INTERCOM", function(lis,tal)
    if lis == tal then return end
    if ActiveSpeakers[tal] then
        return true
    end
end)