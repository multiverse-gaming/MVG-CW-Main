local SAVED = {}

util.AddNetworkString("RDV.LIBRARY.SendConfig")
util.AddNetworkString("RDV.LIBRARY.UpdaConfig")
util.AddNetworkString("RDV.LIBRARY.ResetConfigOption")
util.AddNetworkString("RDV_LIB_CFG_BTN")

net.Receive("RDV_LIB_CFG_BTN", function(len, ply)
    local UID = net.ReadUInt(8)

    local T = RDV.LIBRARY.CONFIG.SBUTTONS[UID]

    if T then
        if !T.CA then
            if !RDV.LIBRARY.CanChangeConfig(ply) then 
                return
            end
        elseif ( T.CA(ply) == false ) then
            return
        end

        RDV.LIBRARY.CONFIG.SBUTTONS[UID].CB(ply)
    end
end )

hook.Add("PlayerReadyForNetworking", "RDV.LIBRARY.CONFIG", function(ply)
    local CHANGED = {}
    
    for k, v in pairs(RDV.LIBRARY.CONFIG.OPTIONS) do
        if v.VALUE and ( ( v.DEFAULT and v.VALUE ~= v.DEFAULT) or !v.DEFAULT ) then
            table.insert(CHANGED, {
                TYPE = v.TYPE,
                VALUE = v.VALUE,
                UID = k,
            })
        end
    end

    local COUNT = #CHANGED

    net.Start("RDV.LIBRARY.SendConfig")
        net.WriteBool(true)
        net.WriteUInt(COUNT, 16)

        for i = 1, COUNT do
            local TAB = CHANGED[i]

            net.WriteString(TAB.UID)
            net.WriteType(TAB.VALUE)
        end
    net.Send(ply)

    hook.Run("RDV_LIB_ConfigSyncComplete", ply)
end )

hook.Add("ShutDown", "RDV.CONFIG.SHUTDOWN", function()
    RDV.LIBRARY.SaveConfigOptions()
end)

timer.Create("RDV_CONFIG_SAVE", 300, 0, function()
    RDV.LIBRARY.SaveConfigOptions()
end)

net.Receive("RDV.LIBRARY.UpdaConfig", function(len, ply)
    if !RDV.LIBRARY.CanChangeConfig(ply) then return end

    local UID = net.ReadString()
    local VAL = net.ReadType()

    RDV.LIBRARY.SetConfigOption(UID, VAL)
end )

net.Receive("RDV.LIBRARY.ResetConfigOption", function(len, ply)
    if !RDV.LIBRARY.CanChangeConfig(ply) then return end

    local UID = net.ReadString()

    local TAB = RDV.LIBRARY.CONFIG.OPTIONS[UID]

    if !TAB or !TAB.DEFAULT then return end
    
    RDV.LIBRARY.SetConfigOption(UID, TAB.DEFAULT)
end )