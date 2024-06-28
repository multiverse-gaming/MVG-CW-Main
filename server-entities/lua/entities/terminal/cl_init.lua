include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("TerminalTask", function()
    local terminal = net.ReadEntity()
    local task = net.ReadString()

    if IsValid(terminal) then
        chat.AddText(Color(255, 0, 0), "[TerminalTask] ", Color(255, 255, 255), "Terminal " .. terminal:EntIndex() .. " requires: " .. task)
    end
end)
