AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Self-Destructing Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m+"] = { type = "Model", model = "models/combine_turrets/floor_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, 20, 0), angle = Angle(-90, 45, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m"] = { type = "Model", model = "models/combine_turrets/ground_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, 20, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper002", skin = 0, bodygroup = {} },
			["m+++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, -20, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper002", skin = 0, bodygroup = {} },
			["m++++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, -20, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper002", skin = 0, bodygroup = {} },
			["m++++"] = { type = "Model", model = "models/combine_turrets/floor_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, 20, 0), angle = Angle(-90, 135, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, 20, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper002", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/combine_turrets/floor_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, -20, 0), angle = Angle(-90, -45, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/combine_turrets/floor_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, -20, 0), angle = Angle(-90, -135, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(20, -20, 0), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(20, 20, 0), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-20, -20, 0), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-20, 20, 0), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} }
		})
	
		return
	end

	self:_Initialize("models/props_phx/construct/metal_plate1.mdl", 250)
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

	--explos and savers
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
			util.BlastDamage(self.Owner, self.Owner, self:GetPos(), 500, 800)
			local ef = EffectData()
			ef:SetOrigin(self:GetPos())
			util.Effect("effect_rockboom", ef)

			self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 500, 100)
			
			SafeRemoveEntity(self)

			self.nextshoot = CurTime() + 1
		end
	end

	self:NextThink(CurTime())
	return true
end