AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Nano Drone OD"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 800
ENT.forward = 10
ENT.up = -15
ENT.cam_up = 3.5
ENT.PropellersPitch = 200
ENT.SoundVolume = 0.1

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(1, 1, 0), angle = Angle(-90, 135, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(-1, 1, 0), angle = Angle(-90, 45, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(-1, -1, 0), angle = Angle(-90, -45, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(1, -1, 0), angle = Angle(-90, -135, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(3, -3, 0), angle = Angle(0, 0, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(3, 3, 0), angle = Angle(0, 0, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-3, -3, 0), angle = Angle(0, 0, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-3, 3, 0), angle = Angle(0, 0, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} }
		})
	
		return
	end

	self:_Initialize("models/hunter/plates/plate.mdl", 40)
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
	--local vec = VectorRand()
	--vec.z = 0
	--vecf = vecf + vec * math.sin(CurTime()) * 20
	--angf = angf + vec * math.sin(CurTime()) * 20
 
	local angp = math.NormalizeAngle(ang.p)
	local angr = math.NormalizeAngle(ang.r)

	local user = self:GetDriver()
	local speedx, speedx2
	
	if user:IsValid() then
		local speed = user:KeyDown(IN_SPEED) and 5 or 1

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-40, 0, 120) * speed end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(40, 0, -120) * speed end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 200 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 200 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 800 * speed + self:GetUp() * speed
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 800 * speed + self:GetUp() * speed
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 100
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end