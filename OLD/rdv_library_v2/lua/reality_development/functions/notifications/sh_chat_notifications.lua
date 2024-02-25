function RDV.LIBRARY.AddText(receivers, ...)
    if SERVER then
        net.Start("RDV.LIBRARY.AddText")
            net.WriteTable({...})
        net.Send(receivers)
    else
        chat.AddText(...)

        surface.PlaySound("common/talk.wav")
    end
end

function RDV.LIBRARY.PlaySound(client, snd)
    if !IsValid(client) or !snd then
        return
    end
    
    if SERVER then
        net.Start("RDV.LIBRARY.PlaySound")
            net.WriteString(snd)
        net.Send(client)
    else
        surface.PlaySound(snd)
    end
end

if CLIENT then
    net.Receive("RDV.LIBRARY.PlaySound", function()
        local SND = net.ReadString()

        surface.PlaySound(SND)
    end)

    net.Receive("RDV.LIBRARY.AddText", function()
        chat.AddText(unpack(net.ReadTable()))

        surface.PlaySound("common/talk.wav")
    end)
else
    util.AddNetworkString("RDV.LIBRARY.PlaySound")
    util.AddNetworkString("RDV.LIBRARY.AddText")
end