function NCS_SHARED.AddText(receivers, ...)
    if SERVER then
        net.Start("NCS_SHARED.AddText")
            net.WriteTable({...})
        net.Send(receivers)
    else
        chat.AddText(...)

        surface.PlaySound("common/talk.wav")
    end
end

function NCS_SHARED.PlaySound(client, snd)
    if !IsValid(client) or !snd then
        return
    end
    
    if SERVER then
        net.Start("NCS_SHARED.PlaySound")
            net.WriteString(snd)
        net.Send(client)
    else
        surface.PlaySound(snd)
    end
end

if CLIENT then
    net.Receive("NCS_SHARED.PlaySound", function()
        local SND = net.ReadString()

        surface.PlaySound(SND)
    end)

    net.Receive("NCS_SHARED.AddText", function()
        chat.AddText(unpack(net.ReadTable()))

        surface.PlaySound("common/talk.wav")
    end)
else
    util.AddNetworkString("NCS_SHARED.PlaySound")
    util.AddNetworkString("NCS_SHARED.AddText")
end

