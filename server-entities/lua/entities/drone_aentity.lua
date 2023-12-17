AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Armored Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 800
ENT.nextshoot2 = 0

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m4"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, -10, -5), angle = Angle(180, -45, 180), size = Vector(1.5, 1.5, 1.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m3"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, 10, -5), angle = Angle(180, 45, 180), size = Vector(1.5, 1.5, 1.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m2"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 10, -5), angle = Angle(180, 135, 180), size = Vector(1.5, 1.5, 1.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m1"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, -10, -5), angle = Angle(180, -135, 180), size = Vector(1.5, 1.5, 1.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			
			["m++++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, -10, 0), angle = Angle(90, -45, 180), size = Vector(1, 1, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, 10, 0), angle = Angle(90, 45, 180), size = Vector(1, 1, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 10, 0), angle = Angle(90, 135, 180), size = Vector(1, 1, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, -10, 0), angle = Angle(90, -135, 180), size = Vector(1, 1, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(47, -47, 2), angle = Angle(0, 0, 0), size = Vector(1.5, 1.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(47, 47, 2), angle = Angle(0, 0, 0), size = Vector(1.5, 1.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-47, -47, 2), angle = Angle(0, 0, 0), size = Vector(1.5, 1.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-47, 47, 2), angle = Angle(0, 0, 0), size = Vector(1.5, 1.5, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },

			["m10"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(47, -47, 2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_tpplatform_sheet", skin = 0, bodygroup = {} },
			["m11"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(47, 47, 2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_tpplatform_sheet", skin = 0, bodygroup = {} },
			["m12"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(-47, -47, 2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_tpplatform_sheet", skin = 0, bodygroup = {} },
			["m13"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(-47, 47, 2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_tpplatform_sheet", skin = 0, bodygroup = {} }
		
		})
	
		return
	end

	self:_Initialize("models/props_phx/construct/metal_plate4x4.mdl", 2000)

	--Spawning gun
	self.gun = ents.Create("minigun_dent")
	self.gun:SetPos(self:GetPos() + self:GetUp() * -7 + self:GetRight() * -10)
	self.gun:SetAngles(self:GetAngles())
	self.gun:SetModelScale(1, 0)
	self.gun:Spawn()
	self.gun:SetParent(self)
	
	self.gun2 = ents.Create("prop_physics")
	self.gun2:SetPos(self:GetPos() + self:GetUp() * -7 + self:GetRight() * 10)
	self.gun2:SetAngles(self:GetAngles())
	self.gun2:SetModelScale(1.2, 0)
	self.gun2:SetModel("models/weapons/w_rocket_launcher.mdl")
	self.gun2:Spawn()
	self.gun2:SetParent(self)
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
	
	--Minigun, rockets and savers
	local user = self:GetDriver()
	if self.gun:IsValid() then self.gun:Switch(user:IsValid() and user:KeyDown(IN_ATTACK)) end

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
			local bullet = {}
			bullet.Num = 2
			if self.gun:IsValid() then 
				self.gun:Switch(true)

				bullet.Src = self.gun:GetPos() + self.gun:GetForward() * 16 - self:GetUp() * 20
				bullet.Dir = self.gun:GetForward()
				bullet.Spread = Vector(0.02, 0.02, 0.02)
				bullet.Tracer = 1
				bullet.Force = 50
				bullet.Damage = 6
				bullet.Attacker = self.Owner
				
				user:EmitSound("weapons/pistol/pistol_fire2.wav", 50, math.random(200, 250))

				self.gun:FireBullets(bullet)
				
				self.nextshoot = CurTime() + 0.04
			end
		end
		
		if user:KeyDown(IN_ATTACK2) and CurTime() > self.nextshoot2 then	
			if self.gun2:IsValid() then
				local ammo = ents.Create("rocket_dent")
				ammo:SetPos(self.gun2:GetPos() + self.gun2:GetUp() * 8)
				ammo:SetOwner(self.Owner)
				ammo:SetAngles(self.gun2:GetAngles())
				ammo:Spawn()
			
				self.gun2:EmitSound("weapons/rpg/rocketfire1.wav")
			
				local physamm = ammo:GetPhysicsObject()
				if IsValid(physamm) then physamm:EnableGravity(false) end 
			
				physamm:AddVelocity(self.gun2:GetForward() * 5000)

				self.nextshoot2 = CurTime() + 2
			end
		end

		if self.gun:IsValid() then self.gun:SetAngles(self:GetAngles() + Angle(user:EyeAngles().p < 0 and 0 or user:EyeAngles().p, user:EyeAngles().y, 0)) end
		if self.gun2:IsValid() then self.gun2:SetAngles(self:GetAngles() + Angle(user:EyeAngles().p < 0 and 0 or user:EyeAngles().p, user:EyeAngles().y, 0)) end
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
		local speed = user:KeyDown(IN_SPEED) and 2 or 1

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-50, 0, 100) * speed end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(50, 0, -100) * speed end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 200 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 200 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 450 * speed + self:GetUp() * 35 * speed
			angf = angf + Vector(0, 10 * speed, 0)
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 450 * speed + self:GetUp() * 35 * speed
			angf = angf - Vector(0, 10 * speed, 0)
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 90
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end
