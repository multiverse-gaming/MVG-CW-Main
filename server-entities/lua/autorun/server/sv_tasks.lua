util.AddNetworkString("CompleteTask")

net.Receive("CompleteTask", function(len, ply)
    local terminal = net.ReadEntity()
    if IsValid(terminal) and terminal.Broken then
        terminal:Repair()
        ply:ChatPrint("You have fixed the terminal!")
    end
end)
