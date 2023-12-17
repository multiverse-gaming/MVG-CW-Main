AddCSLuaFile()

ENT.Base = "drone_entity"
ENT.PrintName		= "Spy Drone"
ENT.Category        = "Drones"
ENT.Spawnable		= true

ENT.armor = 50
ENT.forward = 50
ENT.up = 0
ENT.cam_up = 5
ENT.Target = NULL
ENT.PropellersPitch = 170
ENT.SoundVolume = 0.1

function ENT:Initialize()
	if CLIENT then
		self:SetElements({
			["m+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(3, 3, 0), angle = Angle(-90, 135, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(-3, 3, 0), angle = Angle(-90, 45, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(-3, -3, 0), angle = Angle(-90, -45, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["m+++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "", pos = Vector(3, -3, 0), angle = Angle(-90, -135, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["m6"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(10, -10, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m7"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(10, 10, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m8"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-10, -10, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} },
			["m9"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "", rel = "", pos = Vector(-10, 10, 0), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/airboat/airboat_blur02", skin = 0, bodygroup = {} }
		})
	
		return
	end

	self:_Initialize("models/props_junk/sawblade001a.mdl", 30)
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
			local tr = util.TraceLine {
				start = self:GetPos(),
				endpos = self:GetPos() + self:GetForward() * 300,
				filter = { self, user }
			}

			local ent = tr.Entity
			if not ent:IsValid() then return end

			--ht == drone entity that we put by drone_remote wep
			if ent:GetClass() == "hacktool_drone" and ent.ht and ent.ht:IsValid() and ent.ht.AllowControl and CurTime() > ent.nextkick then
				ent.ht:SetDriver(NULL)
				ent:AddText("Owner kicked")
				ent.nextkick = CurTime() + 8
			end

			if string.sub(ent:GetClass(), 1, 6) != "drone_" then return end

			if ent.AllowControl then user:ChatPrint("This drone is already hacked. You may drive it") return end

			user:ChatPrint("Hacking... it takes some time")

			self.Target = ent
			timer.Create("hack_ent" .. self:EntIndex(), 10, 1, function()
				if self:IsValid() and self.Target:IsValid() then
					self.Target.AllowControl = true
					if user:IsValid() then user:ChatPrint("Hacked successfully!") end
					self.Target = NULL
				end
			end)

			self.nextshoot = CurTime() + 1
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
		if self.Target:IsValid() then
			if user:KeyDown(IN_MOVELEFT) or
				user:KeyDown(IN_MOVERIGHT) or
				user:KeyDown(IN_JUMP) or
				user:KeyDown(IN_DUCK) or
				user:KeyDown(IN_FORWARD) then

				self.Target = NULL
				timer.Destroy("hack_ent" .. self:EntIndex())
				user:ChatPrint("Hacking was stoped!")
			end
		end

		local speed = user:KeyDown(IN_SPEED) and 5 or 1
		if user:KeyDown(IN_SPEED) then 
			speedx = speed - 3
			speedx2 = speed * 4.8
		else 
			speedx = 1 
			speedx2 = 1
		end

		if user:KeyDown(IN_MOVELEFT) then angf = angf + Vector(-100, 0, 150) * speedx end
		if user:KeyDown(IN_MOVERIGHT) then angf = angf + Vector(100, 0, -150) * speedx end

		if user:KeyDown(IN_JUMP) then vecf = vecf + vector_up * 400 * speed end
		if user:KeyDown(IN_DUCK) then vecf = vecf - vector_up * 400 * speed end

		if user:KeyDown(IN_FORWARD) then
			vecf = vecf + self:GetForward() * 1000 * speed + self:GetUp() * 26 * speedx2
			angf = angf + Vector(0, 10 * speed, 0)
		end

		if user:KeyDown(IN_BACK) then
			vecf = vecf - self:GetForward() * 1000 * speed + self:GetUp() * 26 * speedx2
			angf = angf - Vector(0, 10 * speed, 0)
		end
	end

	angf = angf - Vector(angr, angp, 0) * 7

	angf = angf - avel * delta * 100
	vecf = vecf - vel * delta * 200

	return angf, vecf, SIM_GLOBAL_ACCELERATION
end