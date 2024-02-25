include('shared.lua')

local mat = Material("color")

local num =  100 ^ 2 
function ENT:Draw()
	local ply = LocalPlayer()
	local ent = ply:GetEyeTrace().Entity
	if ent == self and ply:GetPos():DistToSqr(self:GetPos()) < num then
		render.SetColorMaterial()
		render.SetColorModulation(1, 0, 0)
		self:DrawModel()
	else
		self:DrawModel()
	end
end