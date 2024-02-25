AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Laser Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 200
ENT.forward = 50
ENT.up = 0
ENT.cam_up = 6

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m+"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 10, 0), angle = Angle(0, -45, 90), size = Vector(0.699, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper001", skin = 0, bodygroup = {} },
			["m"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, -10, 0), angle = Angle(0, 45, 90), size = Vector(0.699, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper001", skin = 0, bodygroup = {} },
			["m+++++"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 5, -3.636), angle = Angle(0, -135, 90), size = Vector(0.237, 0.237, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++++++"] = { type = "Model", model = "models/props_phx/gears/bevel90_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0.518), angle = Angle(180, 0, 0), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface003", skin = 0, bodygroup = {} },
			["m++++"] = { type = "Model", model = "models/props_combine/breentp_rings.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, -135, 90), size = Vector(0.059, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++++++"] = { type = "Model", model = "models/props_phx/gears/bevel90_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0.518), angle = Angle(0, 0, 0), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface003", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, -10, 0), angle = Angle(0, 135, 90), size = Vector(0.699, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper001", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10, 10, 0), angle = Angle(0, -135, 90), size = Vector(0.699, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combinethumper001", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(15, -15, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(15, 15, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-15, -15, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-15, 15, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} }
		})
	
		return
	end

	self:_Initialize("models/Combine_Helicopter/helicopter_bomb01.mdl", 1000)

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
		
		self.WElements["m++++++"].angle = Angle(0, -CurTime() * 100, 0)
		self.WElements["m+++++++"].angle = Angle(180, CurTime() * 100, 0)

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
				endpos = self.gun:GetPos() - self.gun:GetUp() * 9999,
				filter = { user, self, self.gun },
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5)
			}
			
			self.gun:EmitSound("beams/beamstart5.wav", 10)

			if tr.Hit then
				local ef = EffectData()
				ef:SetNormal(tr.HitNormal)
				ef:SetOrigin(tr.HitPos)
				util.Effect("ManhackSparks", ef)
			end

			--I use this vars to draw a beam | also this way sucks
			--self:SetNWVector("beam_start", self.gun:GetPos())
			--self:SetNWVector("beam_end", tr.HitPos)

			local ent = tr.Entity
			
			if ent:IsValid() then
				local dmg = DamageInfo()
				dmg:SetInflictor(self)
				dmg:SetAttacker(user)
				dmg:SetDamage(5)
				ent:TakeDamageInfo(dmg)
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

local laser = Material("effects/laser_citadel1")
function ENT:Draw()
	if SERVER then return end

	local user = self:GetDriver()
	if self:GetNWBool("do_beam") then
		local gun = self:GetNWEntity("gun")

		if gun:IsValid() then
			local start = gun:GetPos()
			local endpos = util.TraceHull {
				start = gun:GetPos(),
				endpos = gun:GetPos() - gun:GetUp() * 50000,
				filter = { user, self, gun },
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5)
			}.HitPos

			if start and endpos then
				render.SetMaterial(laser)
				render.DrawBeam(start, endpos, math.Rand(2, 4), math.Rand(0, 250), math.Rand(0, 250), Color(255, 0, 0, 255))
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

function ENT:PhysicsSimulate(phys, delta)
	--Fly physics
	if CLIENT then return end
	if not self.Enabled then return SIM_NOTHING end

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

	--Controlling
	local user = self:GetDriver()
	if user:IsValid() then
		local speed = user:KeyDown(IN_SPEED) and 2 or 1

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-75, 0, 125) * speed end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(75, 0, -125) * speed end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 200 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 200 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 420 * speed + self:GetUp() * 20 * speed
			angf = angf + Vector(0, 10 * speed, 0)
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 420 * speed + self:GetUp() * 20 * speed
			angf = angf - Vector(0, 10 * speed, 0)
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 90
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end