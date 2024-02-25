AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Repair Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 70
ENT.forward = 50
ENT.up = 0
ENT.cam_up = 4.5

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m+"] = { type = "Model", model = "models/mechanics/robotics/claw.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-8, 8, 2.5), angle = Angle(90, -45, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface003", skin = 0, bodygroup = {} },
			["m"] = { type = "Model", model = "models/props_phx/gears/bevel90_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.36, 0.36, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} },
			["s1"] = { type = "Model", model = "models/props_phx/gears/bevel24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 1.5), angle = Angle(0, 0, 0), size = Vector(0.354, 0.354, 0.774), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper001", skin = 0, bodygroup = {} },
			["m++++"] = { type = "Model", model = "models/mechanics/robotics/claw.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-8, -8, 2.5), angle = Angle(90, -135, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface003", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/mechanics/robotics/claw.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 8, 2.5), angle = Angle(90, 45, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface003", skin = 0, bodygroup = {} },
			["s2"] = { type = "Model", model = "models/props_phx/gears/bevel24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0.7), angle = Angle(180, 0, 0), size = Vector(0.354, 0.354, 0.454), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper001", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/mechanics/robotics/claw.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, -8, 2.5), angle = Angle(90, 135, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface003", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(13, -13, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(13, 13, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-13, -13, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-13, 13, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} }
		})
	
		return
	end

	self:_Initialize("models/props_junk/sawblade001a.mdl", 80)

	--Repair laser
	self.gun = ents.Create("prop_physics")
	self.gun:SetModel("models/props_combine/breenlight.mdl")	
	self.gun:SetPos(self:GetPos() + self:GetForward() * 3 + self:GetUp() * -3 + self:GetRight() * 4)
	self.gun:SetAngles(self:GetAngles())
	self.gun:SetModelScale(0.4, 0)
	self.gun:SetMaterial("models/props_combine/combinethumper001")
	self.gun:Spawn()
	self.gun:SetParent(self)
		
	self:SetNWEntity("gun", self.gun) --For beam drawing
end

function ENT:Think()
	self:_Think()

	if CLIENT then
		self.WElements["m6"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m7"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m8"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m9"].angle = Angle(0, CurTime() * 1500, 0)
		
		self.WElements["s1"].angle = Angle(0, CurTime() * 15, 0)
		self.WElements["s2"].angle = Angle(180, CurTime() * -25, 0)

		return 
	end
	
	--LAZ0R and savers
	local user = self:GetDriver()

	self:SetNWBool("do_beam", user:IsValid() and user:KeyDown(IN_ATTACK))
	if user:IsValid() then
		user:DrawWorldModel(false)
		user:DrawViewModel(false)
		user:SetNoDraw(true)
		
		local weapon = user:GetActiveWeapon()
		
		if weapon:IsValid() then
			weapon:SetNextPrimaryFire(CurTime() + 2)
			weapon:SetNextSecondaryFire(CurTime() + 2)
		end

		if user:KeyDown(IN_ATTACK) and self.gun:IsValid() then
			local tr = util.TraceHull {
				start = self.gun:GetPos(),
				endpos = self.gun:GetPos() - self.gun:GetUp() * 600,
				filter = { user, self, self.gun },
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5)
			}

			if tr.Hit then
				local ef = EffectData()
				ef:SetNormal(tr.HitNormal)
				ef:SetOrigin(tr.HitPos)
				util.Effect("ManhackSparks", ef)
			end

			--I use this vars to draw a beam | also this way sux
			--self:SetNWVector("beam_start", self.gun:GetPos())
			--self:SetNWVector("beam_end", tr.HitPos)

			local drone = tr.Entity
			
			if drone:IsValid() and string.sub(drone:GetClass(), 1, 6) == "drone_" and drone.Enabled then
				if drone.armor < drone.defArmor then
					drone:SetArm(drone.armor + 1)
				end
			end
		end

		if self.gun:IsValid() then 
			local angp = user:EyeAngles().p - 90
			self.gun:SetAngles(self:GetAngles() + Angle(angp < -90 and -90 or angp, user:EyeAngles().y, 0)) 
		end
	end

	self:NextThink(CurTime())
	return true
end

local laser = Material("sprites/physgbeamb")
function ENT:Draw()
	if SERVER then return end

	local user = self:GetDriver()
	if self:GetNWBool("do_beam") then
		local gun = self:GetNWEntity("gun")

		if gun:IsValid() then
			local start = gun:GetPos()
			local endpos = util.TraceHull {
				start = gun:GetPos(),
				endpos = gun:GetPos() - gun:GetUp() * 600,
				filter = { user, self, gun },
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5)
			}.HitPos

			if start and endpos then
				render.SetMaterial(laser)
				render.DrawBeam(start, endpos, math.Rand(1, 2), math.Rand(0, 50), math.Rand(0, 50), Color(0, 255, 140, 255))
			end
		end
	end	

	--SWEP Construction Kit changed draw code
	if !self.WElements then return end
		
	if !self.wRenderOrder then
		self.wRenderOrder = {}

		for k, v in pairs(self.WElements) do
			table.insert(self.wRenderOrder, 1, k)
		end
	end
		
	for k, name in pairs(self.wRenderOrder) do
		if self:GetDriver():IsValid() and self:GetDriver():SteamID() == LocalPlayer():SteamID() and name == "mine" then continue end

		local v = self.WElements[name]
		if !v then self.wRenderOrder = nil break end
			
		local pos, ang

		pos = self:GetPos()
		ang = self:GetAngles()
			
		local model = v.modelEnt
		local sprite = v.spriteMaterial
			
		model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
		model:SetAngles(ang)

		local matrix = Matrix()
		matrix:Scale(v.size)
		model:EnableMatrix( "RenderMultiply", matrix )
		model:SetMaterial(v.material)
				
		render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
		render.SetBlend(v.color.a/255)
		model:DrawModel()
		render.SetBlend(1)
		render.SetColorModulation(1, 1, 1)
	end
end