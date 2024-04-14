function NCS_DEFCON.GetDefcon()
	return (NCS_DEFCON.CURRENT or 0)
end

function NCS_DEFCON.IsAdmin(P, CB)
    if NCS_DEFCON.CONFIG.camienabled then
        CAMI.PlayerHasAccess(P, "[NCS] Defcon", function(ACCESS)
            CB(ACCESS)
        end )
    else
        if NCS_DEFCON.CONFIG.admins[P:GetUserGroup()] then
            CB(true)
        else
            CB(false)
        end
    end
end

function NCS_DEFCON.AddText(receivers, ...)
    if SERVER then
        net.Start("NCS_DEFCON.AddText")
            net.WriteTable({...})
        net.Send(receivers)
    else
        chat.AddText(...)

        surface.PlaySound("common/talk.wav")
    end
end

function NCS_DEFCON.PlaySound(client, snd)
    if !IsValid(client) or !snd then
        return
    end
    
    if SERVER then
        net.Start("NCS_DEFCON.PlaySound")
            net.WriteString(snd)
        net.Send(client)
    else
        surface.PlaySound(snd)
    end
end

if CLIENT then
    net.Receive("NCS_DEFCON.PlaySound", function()
        local SND = net.ReadString()

        surface.PlaySound(SND)
    end)

    net.Receive("NCS_DEFCON.AddText", function()
        chat.AddText(unpack(net.ReadTable()))

        surface.PlaySound("common/talk.wav")
    end)
else
    util.AddNetworkString("NCS_DEFCON.PlaySound")
    util.AddNetworkString("NCS_DEFCON.AddText")
end

