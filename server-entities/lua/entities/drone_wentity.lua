AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Drone w/o Gun"
ENT.Category        = "Drones"
ENT.Spawnable		= true

function ENT:Initialize()
	if CLIENT then
		self:SetElements()
	
		return
	end

	self:_Initialize("models/props_phx/construct/metal_plate1.mdl", 200)
end

function ENT:Think()
	self:_Think()

	if CLIENT then
		self.WElements["m6"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m7"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m8"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m9"].angle = Angle(0, CurTime() * 1500, 0)

		return 
	end
	
	--Minigun and savers
	local user = self:GetDriver()
	if user:IsValid() then
		user:DrawWorldModel(false)
		user:DrawViewModel(false)
		user:SetNoDraw(true)
		
		local weapon = user:GetActiveWeapon()
		
		if weapon:IsValid() then
			weapon:SetNextPrimaryFire(CurTime() + 2)
			weapon:SetNextSecondaryFire(CurTime() + 2)
		end
	end

	self:NextThink(CurTime())
	return true
end