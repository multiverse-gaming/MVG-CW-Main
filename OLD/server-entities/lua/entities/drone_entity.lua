AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= "Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.nextshoot = 0
ENT.armor = 200 -- Current armor
ENT.defArmor = nil -- Default armor
ENT.Enabled = true -- Is drone driveable
ENT.wait = 0
ENT.AllowControl = false -- For hacking
ENT.PropellersPitch = 95
ENT.SoundVolume = 5

if CLIENT then
	function ENT:SetElements(tab)
		tab = tab or {
			["m"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["mine"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "", rel = "", pos = Vector(0, 0, 1), angle = Angle(180, 10, 0), size = Vector(1, 1, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m2"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(10, -10, -3), angle = Angle(40, 45, 0), size = Vector(1.5, 1.5, 1.5), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m3"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(10, 10, -3), angle = Angle(40, -45, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m4"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(-10, -10, -3), angle = Angle(40, 140, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m5"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "", rel = "", pos = Vector(-10, 10, -3), angle = Angle(40, 225, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(30, -30, 6), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(30, 30, 6), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-30, -30, 6), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-30, 30, 6), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },

			["m10"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(30, -30, 6), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(155, 155, 155, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
			["m11"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(30, 30, 6), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(155, 155, 155, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
			["m12"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(-30, -30, 6), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(155, 155, 155, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
			["m13"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "", pos = Vector(-30, 30, 6), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(155, 155, 155, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} }
		}

		self.WElements = table.FullCopy(tab)
		self:CreateModels(self.WElements)
	end
else
	-- If true drone goes disabled
	function ENT:Switch(n)
		self.Enabled = n
		self:SetNWBool("disabled", not n)
	end

	-- Changes armor of our drone
	function ENT:SetArm(n)
		self.armor = n

		umsg.Start("upd_health_drone")
			umsg.Entity(self)
			umsg.String(tostring(self.armor))
		umsg.End()
	end
end

-- Gets drone's individual ID
-- IDs are based on first char after '_' symbol in ent class
-- And drone's EntIndex
function ENT:GetUnit()
	return "UNIT " .. string.upper(string.sub(self:GetClass(), 7, 7)) .. "-" .. self:EntIndex()
end

-- Gets drone's driver
function ENT:GetDriver()
	return self:GetNWEntity("user")
end

function ENT:OnRemove()
	self:SetDriver(NULL)

	if self.Sound then self.Sound:Stop() self.Sound = nil end

	return true
end

function ENT:SpawnFunction(ply, tr, ClassName)
	if not tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 32

	local ent = ents.Create(ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply

	return ent
end

-- Main function
-- As you can see this function changes drone's driver
function ENT:SetDriver(ply)
	if CLIENT then return end

	local user = self:GetDriver()

	-- Waiting before new exit or enter | Does not work with NULL ply!
	if ply:IsValid() and CurTime() < self.wait then return end
	self.wait = CurTime() + 0.3

	-- If someone tries to get drone while its in use
	if ply:IsValid() and user:IsValid() then return end

	if ply:IsValid() then
		local weapon = ply:GetActiveWeapon()
		if weapon:IsValid() then self.plyWep = weapon:GetClass() end -- Saving guy's weapon

		-- If ply doesnt has crowbar we will give it
		--[[if not ply:HasWeapon("weapon_crowbar") then
			ply:Give("weapon_crowbar")
			ply.PlyGotCrowbar = true -- We will use this variable after ply's exit
		end]]
		--ply:SelectWeapon("weapon_crowbar")

		-- Saving ply's position
		-- We will use it when player is getting out
		local pos = ply:GetPos()
		ply.drones_oldpos = pos
		ply.drones_oldsolid = ply:GetSolid()

		ply:SetNWEntity("drone_", self)
		ply:DrawWorldModel(false)
		ply:DrawViewModel(false)
		ply:SetNoDraw(true)
		ply:SetSolid(SOLID_NONE)
		ply:SetMoveType(MOVETYPE_NOCLIP)
		ply:Flashlight(false)
		ply:AllowFlashlight(false)

		-- We have to do it because driver follows drone
		self.ghost = ents.Create("entity_ghost_drone")
		self.ghost:SetPos(pos)
		self.ghost:SetModel(ply:GetModel())
		self.ghost:SetAngles(Angle(0, ply:GetAngles().y, 0))
		self.ghost:SetNWEntity("user", ply)
		self.ghost:SetSequence(107)
		self.ghost:Spawn()

		self.ghost.dmg = ents.Create("entity_damager_drone")
		self.ghost.dmg:SetPos(pos + Vector(0, 0, 35))
		self.ghost.dmg:SetNWEntity("user", ply)
		self.ghost.dmg:Spawn()

		self.ghost:SetParent(self.ghost.dmg)
	elseif user:IsValid() then
		user.drones_stopMoving = true -- Changes position in Move hook (Fixes a little bug with SetPos)
		user:SetPos(self.ghost:IsValid() and self.ghost:GetPos() or user.drones_oldpos)
		user:SetNWEntity("drone_", NULL)

		-- Getting weapon from buffer
		if ply.PlyGotCrowbar then
			if user:HasWeapon("weapon_crowbar") then user:StripWeapon("weapon_crowbar") end
			ply.PlyGotCrowbar = false
		end

		-- If we gave a crowbar to driver we should remove it from player's inventory
		-- But if he has not lost it
		if self.plyWep and user:HasWeapon(self.plyWep) then
			user:SelectWeapon(self.plyWep)
			self.plyWep = nil
		end

		user:SetVelocity(Vector(0, 0, 0))
		user:DrawWorldModel(true)
		user:DrawViewModel(true)
		user:SetNoDraw(false)
		user:SetSolid(user.drones_oldsolid)
		user.drones_oldsolid = nil
		user:SetMoveType(MOVETYPE_WALK)
		user:AllowFlashlight(true)

		SafeRemoveEntity(self.ghost.dmg)
		SafeRemoveEntity(self.ghost)

	end

	self:SetNWEntity("user", ply)
end

function ENT:_Initialize(mdl, mass)
	mdl = mdl or "models/props_phx/construct/metal_plate2x2.mdl"
	mass = mass or 200

	self:DrawShadow(false)
	self:SetModel(mdl)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:SetMass(mass) end

	if not self.Sound then
		self.Sound = CreateSound(self, "npc/manhack/mh_engine_loop1.wav")
		self.Sound:Play()
		self.Sound:ChangeVolume(self.SoundVolume)
	end

	self:StartMotionController()

	if not self.defArmor then self.defArmor = self.armor end
end

function ENT:Initialize()
	if CLIENT then
		self:SetElements()

		return
	end

	self:_Initialize()

	--Spawning gun
	self.gun = ents.Create("minigun_dent")
	self.gun:SetPos(self:GetPos() + self:GetForward() * 10 + self:GetUp() * -10 + self:GetRight() * 10)
	self.gun:SetAngles(self:GetAngles())
	self.gun:SetModelScale(0.9, 0)
	self.gun:Spawn()
	self.gun:SetParent(self)
end

function ENT:OnTakeDamage(dmg)
	if CLIENT then return end

	self:TakePhysicsDamage(dmg)

	-- Maximum armor (Im too lazy to make another variable with a constant value)
	if not self.defArmor then self.defArmor = self.armor end
	if self.armor <= 0 then return end

	self:EmitSound("npc/manhack/grind" .. math.random(1, 5) .. ".wav", 25, 100)
	self:EmitSound("ambient/energy/spark" .. math.random(1, 6) .. ".wav", 25, 110)

	self:SetArm(self.armor - dmg:GetDamage())

	if self.armor <= self.defArmor / 2 and not self.DANGER then
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		util.Effect("drone_fexplosion", ef)

		self.DANGER = true
	end

	if self.armor <= self.defArmor / 3 and not self.PLAYED_siren then
		self:EmitSound("npc/scanner/scanner_siren2.wav", 50, 140)
		self:EmitSound("ambient/fire/gascan_ignite1.wav", 200, 100)

		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:AddAngleVelocity(VectorRand() * 100)
		end

		self.PLAYED_siren = true
	end

	--Destroying drone if no health
	if self.armor <= 0 then
		if self:GetDriver():IsValid() then self:SetDriver(NULL) end

		if self.Sound then self.Sound:Stop() self.Sound = nil end

		for i = 1, 5 do
			timer.Simple(math.Rand(0.1, 3), function()
				if not self or not IsValid(self) then return end

				local ef = EffectData()
				ef:SetOrigin(self:GetPos())
				util.Effect("Explosion", ef)

				self:Ignite(15)
			end)

			local phys = self:GetPhysicsObject()
			if phys:IsValid() then
				phys:AddAngleVelocity(VectorRand() * 200)

				local vec = VectorRand()
				vec.z = 0

				phys:AddVelocity(vec * 150 + vector_up * 150)

				timer.Simple(5, function()

					if !self:IsValid() then return end

					self:Remove()

				end)
			end
		end

		self:EmitSound("npc/manhack/bat_away.wav", 100, 85)
		self:EmitSound("npc/manhack/grind_flesh2.wav", 100, 100)

		self:Switch(false)
	end
end

function ENT:Draw()
	if SERVER then return end

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

function ENT:PhysicsCollide(data, phys)
	if CLIENT then return end

	if not self.Enabled then return end
	if data.DeltaTime < 0.3 then return end

	--Sure drone has to get damage when it collides
	if data.Speed > 420 then
		local driver = self:GetDriver()

		self:TakeDamage(math.Round(math.Clamp(data.Speed / 70, 5, 15)))

		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:SetVelocity(VectorRand() * 200)
			phys:AddAngleVelocity(VectorRand() * 200)
		end
	end
end

function ENT:Use(activator, caller)
	if CLIENT then return end
	if not self.Enabled then return end

	if not activator:IsPlayer() then return end

	self:SetDriver(activator)
end

function ENT:_Think()
	if CLIENT then
		if self:GetNWBool("nightvision") then
			local dlight = DynamicLight(self:EntIndex())
			if dlight then
				dlight.pos = self:GetPos()
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.brightness = 1
				dlight.Decay = 1000
				dlight.Size = 1500
				dlight.DieTime = CurTime() + 0.2
			end
		end
	end

	local user = self:GetDriver()
	if user:IsValid() and not user:Alive() then self:SetDriver(NULL) end

	if not self.Enabled then
		-- Totally not sparks D:
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAngles(self:GetAngles())
		util.Effect("drone_sparks", ef)
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end

	local vel = math.Round(self:GetVelocity():Length())
	if self.Sound then
		self.Sound:ChangePitch(math.Clamp(vel * 0.255, self.PropellersPitch, 255))
	end
end

function ENT:Think()
	self:_Think()

	if CLIENT then
		--Rotate propellers
		self.WElements["m6"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m7"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m8"].angle = Angle(0, CurTime() * 1500, 0)
		self.WElements["m9"].angle = Angle(0, CurTime() * 1500, 0)

		return
	end

	--Minigun and savers
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
			if self.gun:IsValid() then
				local bullet = {}
				bullet.Num = 1
				bullet.Src = self.gun:GetPos() + self.gun:GetForward() * 20
				bullet.Dir = self.gun:GetForward()
				bullet.Spread = Vector(0.02, 0.02, 0.02)
				bullet.Tracer = 2
				bullet.Force = 50
				bullet.Damage = 10
				bullet.Attacker = self.Owner

				user:EmitSound("weapons/pistol/pistol_fire2.wav", 50, math.random(200, 250))

				self.gun:FireBullets(bullet)

				self.nextshoot = CurTime() + 0.03
			end
		end

		if self.gun:IsValid() then self.gun:SetAngles(self:GetAngles() + Angle(user:EyeAngles().p < 0 and 0 or user:EyeAngles().p, user:EyeAngles().y, 0)) end
	end

	self:NextThink(CurTime())
	return true
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
		local speed = user:KeyDown(IN_SPEED) and 2.5 or 1

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-100, 0, 150) * speed end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(100, 0, -150) * speed end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 500 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 500 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 1000 * speed + self:GetUp() * 75 * speed
			angf = angf + Vector(0, 10 * speed, 0)
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 1000 * speed + self:GetUp() * 75 * speed
			angf = angf - Vector(0, 10 * speed, 0)
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 90
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end

function ENT:EMPaffect()
	if self:GetDriver():IsValid() then self:SetDriver(NULL) end

	self:EmitSound("npc/manhack/bat_away.wav", 50, 85)
	self:EmitSound("npc/manhack/grind_flesh2.wav", 50, 100)

	if self.Sound then self.Sound:Stop() self.Sound = nil end

	self:Switch(false)
end


--Changed SWEP Construction Kit base code

if CLIENT then
	ENT.wRenderOrder = nil

	function ENT:CreateModels(tab)
		if !tab then return end

		for k, v in pairs(tab) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME")) then

				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
			end
		end
	end

	function table.FullCopy(tab)
		if !tab then return nil end

		local res = {}
		for k, v in pairs(tab) do
			if type(v) == "table" then
				res[k] = table.FullCopy(v)
			elseif type(v) == "Vector" then
				res[k] = Vector(v.x, v.y, v.z)
			elseif type(v) == "Angle" then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end

		return res
	end
end
