AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Double Minigun Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 100
ENT.forward = 100
ENT.up = 25

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			
			["m2"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(10, -10, 7), angle = Angle(50, 45, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m3"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(10, 10, 7), angle = Angle(50, -45, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m4"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(-10, -10, 7), angle = Angle(50, 140, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m5"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(-10, 10, 7), angle = Angle(50, 225, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(30, -30, 9), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(30, 30, 9), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-30, -30, 9), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-30, 30, 9), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },

			["m10"] = { type = "Model", model = "models/props_combine/headcrabcannister01a_skybox.mdl", bone = "", rel = "", pos = Vector(0, 10, 12), angle = Angle(0, 180, 0), size = Vector(3, 3, 3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m11"] = { type = "Model", model = "models/props_combine/headcrabcannister01a_skybox.mdl", bone = "", rel = "", pos = Vector(0, -10, 12), angle = Angle(0, 180, 0), size = Vector(3, 3, 3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		})
	
		return
	end
	
	self:_Initialize("models/props_phx/construct/metal_plate1.mdl", 100)

	--Spawning gun
	
	self.gun = {}
	for i = 1, 2 do
		self.gun[i] = ents.Create("minigun_dent")
		self.gun[i]:SetPos(self:GetPos() + self:GetUp() * -3 + self:GetRight() * (i == 2 and -1 or i) * 8)
		self.gun[i]:SetAngles(self:GetAngles())
		self.gun[i]:SetModelScale(0.9, 0)
		self.gun[i]:Spawn()
		self.gun[i]:SetParent(self)
	end
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
	for i = 1, 2 do if self.gun[i]:IsValid() then self.gun[i]:Switch(user:IsValid() and user:KeyDown(IN_ATTACK)) end end

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
			for i = 1, 2 do
				if self.gun[i]:IsValid() then 
					local bullet = {}

					bullet.Num = 3
					bullet.Src = self.gun[i]:GetPos() + self.gun[i]:GetForward() * 20 - self:GetUp() * 20
					bullet.Dir = self.gun[i]:GetForward()
					bullet.Spread = Vector(0.03, 0.03, 0.03)
					bullet.Tracer = 2	
					bullet.Force = 30
					bullet.Damage = 2
					bullet.Attacker = self.Owner
						
					user:EmitSound("weapons/pistol/pistol_fire2.wav", 50, math.random(200, 250))
						
					self.gun[i]:FireBullets(bullet)
				end
			end

			self.nextshoot = CurTime() + 0.04
		end

		for i = 1, 2 do if self.gun[i]:IsValid() then self.gun[i]:SetAngles(self:GetAngles() + Angle(user:EyeAngles().p < 0 and 0 or user:EyeAngles().p, user:EyeAngles().y, 0)) end end
	end

	self:NextThink(CurTime())
	return true
end
