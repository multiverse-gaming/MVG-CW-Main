util.AddNetworkString("CompleteTask")

net.Receive("CompleteTask", function(len, ply)
    local terminal = net.ReadEntity()
    if terminal.Broken then
        terminal:Fix()
        ply:ChatPrint("You have fixed the terminal!")
    end
end)

local tasks = {
    "Fix Wiring",
    "Prime Shields"
}
