AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Melon Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true
ENT.AdminOnly = true
ENT.armor = 9999

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m"] = { type = "Model", model = "models/props_junk/watermelon01.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m6"] = { type = "Model", model = "models/props_c17/TrapPropeller_Blade.mdl", bone = "", rel = "", pos = Vector(0, 0, 20), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },		
		})
	
		return
	end

	--Spawning gun
	self.gun = ents.Create("prop_physics")
	self.gun:SetModel("models/weapons/w_rocket_launcher.mdl")
	self.gun:SetParent(self)
	self.gun:SetPos(self:GetPos() + self:GetForward() * 10 + self:GetUp() * -10 + self:GetRight() * 10)
	self.gun:SetAngles(self:GetAngles())
	self.gun:SetModelScale(0.9, 0)
	self.gun:Spawn()

	self:_Initialize("models/weapons/w_rocket_launcher.mdl", 50000)
end

function ENT:Think()
	self:_Think()

	if CLIENT then
		self.WElements["m6"].angle = Angle(0, CurTime() * 5000, 0)

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

		if self.gun:IsValid() and user:KeyDown(IN_ATTACK) and CurTime() > self.nextshoot then
			local ent = ents.Create("prop_physics")
			ent:SetModel("models/props_junk/watermelon01.mdl")
			ent:SetPos(self.gun:GetPos() + self.gun:GetForward() * 50)
			ent:Spawn()
			ent:EmitSound("weapons/ar2/ar2_altfire.wav", 25)

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then phys:EnableGravity(false) phys:SetMass(50000) phys:SetVelocity(self.gun:GetForward() * 99999999) end

			self.nextshoot = CurTime() + 0.1
		end

		if self.gun:IsValid() then self.gun:SetAngles(self:GetAngles() + Angle(user:EyeAngles().p < 0 and 0 or user:EyeAngles().p, user:EyeAngles().y, 0)) end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:PhysicsSimulate(phys, delta)
	--Fly physics
	if CLIENT then return end
	if not self.Enabled then return end

	local ang = phys:GetAngles()
	local avel = phys:GetAngleVelocity()
	local vel = phys:GetVelocity()

	local vecf = Vector(0, 0, 0)
	local angf = Vector(0, 0, 0)

	vecf = vecf + self:GetUp() * (573 + math.sin(CurTime() * 2) * 3)
	local vec = VectorRand()
	vec.z = 0
	vecf = vecf + vec * math.sin(CurTime()) * 20
	angf = angf + vec * math.sin(CurTime()) * 20
 
	local angp = math.NormalizeAngle(ang.p)
	local angr = math.NormalizeAngle(ang.r)

	local user = self:GetDriver()
	if user:IsValid() then
		local speed = user:KeyDown(IN_SPEED) and 5 or 1

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-100, 0, 150) * speed end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(100, 0, -150) * speed end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 500 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 500 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 1500 * speed + self:GetUp() * 175 * speed
			angf = angf + Vector(0, 10 * speed, 0)
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 1500 * speed + self:GetUp() * 175 * speed
			angf = angf - Vector(0, 10 * speed, 0)
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 90
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end