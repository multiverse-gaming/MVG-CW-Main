include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

hook.Add("HUDPaint", "RSGen:HealthBar", function()
    local ply = LocalPlayer()
    local gen = ply:GetEyeTrace().Entity
    if (!ply:IsValid() or !gen:IsValid() or gen:GetClass() != "laser_rayshield_gen" or !gen:GetNWBool("health_bar") or ply:GetPos():Distance(gen:GetPos()) > 1800) then return nil end

    local maxhealth = gen:GetNWInt("max_health")
    local health = gen:GetNWInt("health")

    local position = gen:LocalToWorld(gen:OBBCenter()):ToScreen()
    local maxwidth = 220
    local curwidth = 220 * health / maxhealth
    local height = 20

    draw.RoundedBox(3, position.x - (maxwidth / 2), position.y - (height / 2) * 8.2, maxwidth, 40, Color(0, 0, 0, 220))
    draw.RoundedBox(3, position.x - (maxwidth / 2), position.y - (height / 2) * 8.2, curwidth, 40, Color(250, 0, 0, 200))
end)