AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Mine-Dropping Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 120

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, 10, 0), angle = Angle(-90, 45, 0), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m"] = { type = "Model", model = "models/props_combine/headcrabcannister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.1, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++++"] = { type = "Model", model = "models/props_combine/combine_interface001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, -6.753, -3.636), angle = Angle(0, 90, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, 20, -1.5), angle = Angle(0, 0, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_emitter01", skin = 0, bodygroup = {} },
			["m++++++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, -20, -1.5), angle = Angle(0, 0, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_emitter01", skin = 0, bodygroup = {} },
			["m+++++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, -20, -1.5), angle = Angle(0, 0, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_emitter01", skin = 0, bodygroup = {} },
			["m++++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, 20, -1.5), angle = Angle(0, 0, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_emitter01", skin = 0, bodygroup = {} },
			["m++++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, -10, 0), angle = Angle(-90, -45, 0), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++++++"] = { type = "Model", model = "models/props_combine/combine_mortar01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, -9.87), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 10, 0), angle = Angle(-90, 135, 0), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, -10, 0), angle = Angle(-90, -135, 0), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(20, -20, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(20, 20, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-20, -20, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-20, 20, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} }
		})
	
		return
	end

	self:_Initialize("models/props_phx/construct/metal_plate1.mdl", 100)
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

		if user:KeyDown(IN_ATTACK) and CurTime() > self.nextshoot then
			local ent = ents.Create("mine_ent_drone")
			ent:SetPos(self:GetPos() - Vector(0, 0, 10))
			ent.Owner = user
			ent:Spawn()

			undo.Create("Mine")
				undo.AddEntity(ent)
				undo.SetPlayer(user)
			undo.Finish()

			self.nextshoot = CurTime() + 2
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
	local vec = VectorRand()
	vec.z = 0
	vecf = vecf + vec * math.sin(CurTime()) * 20
	angf = angf + vec * math.sin(CurTime()) * 20
 
	local angp = math.NormalizeAngle(ang.p)
	local angr = math.NormalizeAngle(ang.r)

	local user = self:GetDriver()
	if user:IsValid() then
		local speed = user:KeyDown(IN_SPEED) and 2.5 or 1

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-100, 0, 150) * speed end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(100, 0, -150) * speed end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 700 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 700 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 1500 * speed + self:GetUp() * 85 * speed
			angf = angf + Vector(0, 10 * speed, 0)
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 1500 * speed + self:GetUp() * 85 * speed
			angf = angf - Vector(0, 10 * speed, 0)
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 90
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end