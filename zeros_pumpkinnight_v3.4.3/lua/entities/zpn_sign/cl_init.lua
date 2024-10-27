/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:DrawTranslucent()
	self:Draw()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function ENT:Draw()

	self:DrawModel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

	if zclib.Convar.Get("zpn_cl_draw_antighost") == 1 and zclib.util.InDistance(LocalPlayer():GetPos(), self:GetPos(), 3000) then
		render.SetColorMaterial()
		render.DrawSphere( self:GetPos(), zpn.config.AntiGhostSign.Distance, 30, 30, zpn.default_colors["violett01"] )
		render.DrawWireframeSphere( self:GetPos(), zpn.config.AntiGhostSign.Distance, 30, 30, zpn.default_colors["violett03"],true)
	end

end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
