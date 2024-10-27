/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zclib.EntityTracker.Add(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function ENT:Draw()
	self:DrawModel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	if zclib.Convar.Get("zclib_cl_drawui") == 1 and zclib.util.InDistance(LocalPlayer():GetPos(), self:GetPos(), 500) then
		self:DrawInfo()
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ENT:DrawInfo()
	cam.Start3D2D(self:LocalToWorld(Vector(0,0,90 + (3 * math.abs(math.sin(CurTime()) * 1)))), zclib.HUD.GetLookAngles(), 0.1)
		draw.SimpleText(zpn.Theme.NPC.name, zclib.GetFont("zpn_npc_title"), 2, -78, zpn.Theme.Design.color02, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(zpn.Theme.NPC.name, zclib.GetFont("zpn_npc_title"), 0, -80, zpn.Theme.Design.color01, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
