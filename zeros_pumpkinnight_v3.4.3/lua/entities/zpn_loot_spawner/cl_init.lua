/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zclib.EntityTracker.Add(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Draw()
	self:DrawModel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

	self.LastDraw = CurTime()
end

function ENT:Think()

	if not self.LastDraw or CurTime() > (self.LastDraw + 1) and LocalPlayer():GetPos():Distance(self:GetPos()) > 200 then
		local lookDir = (self:GetPos() - LocalPlayer():GetPos()):Angle()
		lookDir:RotateAroundAxis(lookDir:Up(),90)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

		self.LookAngle = Angle(0,lookDir.y,0)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	if self.LookAngle then self:SetRenderAngles(self.LookAngle) end
end
