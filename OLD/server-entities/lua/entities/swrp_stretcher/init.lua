AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

CreateConVar("sv_med_stretcher_heal", "0", FCVAR_NOTIFY + FCVAR_DONTRECORD, "Should medical stretcher heal players?")


function ENT:Initialize()
	self:SetModel("models/props/starwars/medical/medical_bed.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	phys:EnableGravity(false)

	timer.Simple(0.1,function()
		if IsValid(self) then
			self:SetPos(self:GetPos()+Vector(0,0,30))
		end
	end)

	self:SetCollisionGroup(2)

	self.master = nil

	self.pod = ents.Create("prop_vehicle_prisoner_pod")
	self.pod:SetParent(self)
	self.pod:SetPos(self:GetPos() + (self:GetUp() * 23) + (self:GetForward() * 30))
	local podAng = self:GetAngles()
	podAng:RotateAroundAxis(self:GetRight(), 90)
	self.pod:SetAngles(podAng)
	self.pod:SetModel("models/vehicles/prisoner_pod_inner.mdl")
	self.pod:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
	self.pod:Spawn()
	self.pod:Activate()
	self.pod:SetVehicleClass("Pod")

	self.pod:SetCollisionGroup(10)

	self.pod:SetColor(Color(0, 0, 0, 0))
	self.pod:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.pod:SetVehicleClass("Pod")

	self.activator = ents.Create("base_anim")
	self.activator:SetModel("models/hunter/blocks/cube05x1x05.mdl")
	self.activator:SetParent(self)
	self.activator:SetPos(self:GetPos() + (self:GetUp() * 7) + (self:GetForward() * 50))
	self.activator:SetAngles(podAng)
	self.activator:PhysicsInit(SOLID_VPHYSICS)
	self.activator:SetSolid(SOLID_BBOX)
	self.activator:SetUseType(SIMPLE_USE)
	self.activator:Spawn()
	self.activator:Activate()

	self.activator:SetColor(Color(0, 0, 0, 0))
	self.activator:SetRenderMode(RENDERMODE_TRANSALPHA)

	self.activator:GetPhysicsObject():Sleep()
	self.activator:GetPhysicsObject():EnableGravity(false)
	self.activator:GetPhysicsObject():EnableMotion(false)
	self.activator:SetNoDraw(true)

	self.activator.Use = function(s,ply)
		if not IsValid(self.master) then
			self.master = ply
			ply:EmitSound("buttons/button1.wav")
		else
			self.master = nil 
			ply:EmitSound("buttons/button8.wav")
			return
		end
	end

	
	self.activator.Draw=function() end
	self.activator.DrawTranslucent=function() end


	self.activator:SetCollisionGroup(2)


	self.col = ents.Create("prop_physics")
	self.col:SetModel("models/hunter/blocks/cube1x2x025.mdl")
	self.col:SetParent(self)
	self.col:SetPos(self:GetPos() + (self:GetUp() * 11) - (self:GetForward() * 10) )
	self.col:SetAngles(podAng-Angle(90,90,0))
	self.col:Spawn()
	self.col:Activate()

	self.col:SetColor(Color(0, 0, 0, 0))
	self.col:SetRenderMode(RENDERMODE_TRANSALPHA)

	self.col:GetPhysicsObject():Sleep()
	self.col:GetPhysicsObject():EnableGravity(false)
	self.col:GetPhysicsObject():EnableMotion(false)




end


local bufferVec = Vector(0, 0, -28)
function ENT:Think()

	self:NextThink(CurTime())

	if IsValid(self.pod) and IsValid(self.pod:GetDriver()) and GetConVar("sv_med_stretcher_heal"):GetInt() == 1 then
		if self.pod:GetDriver():Health() < self.pod:GetDriver():GetMaxHealth() then
			self.pod:GetDriver():SetHealth(self.pod:GetDriver():Health()+1)
		end
	end

	local phys = self:GetPhysicsObject()

	phys:SetVelocityInstantaneous(vector_origin)
	phys:AddAngleVelocity(-phys:GetAngleVelocity())

	local traceFloor = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + (-self:GetUp()*1000),
		filter = function(ent)
			if self == ent then return false end

			return true
		end
	})

	local distToWorld = traceFloor.HitPos:DistToSqr(self:GetPos())


	if distToWorld > 1000 then -- Too high
		phys:AddVelocity(-self:GetUp()*12)
	elseif distToWorld < 800 then -- Too low
		phys:AddVelocity(self:GetUp()*12)
	else -- The bob
		phys:AddVelocity((self:GetUp()*0.5) * math.sin(CurTime()))
	end

	if not (self:GetAngles().pitch == 0) or not (self:GetAngles().roll == 0) then
		local ang = self:GetAngles()
		ang.pitch = 0
		ang.roll = 0
		ang = LerpAngle(FrameTime()*30, self:GetAngles(), ang)
		phys:SetAngles(ang)
	end

	if not IsValid(self.master) then return end
	local distToPly = self:GetPos():DistToSqr(self.master:GetPos())
	if distToPly > 1000000 then
		self.master = nil
		return true
	end

	local traceFront = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + (self:GetForward()*1000),
		filter = function(ent)
			if self == ent then return false end
			if self.activator == ent then return false end

			return true
		end
	})


	local distToFront = traceFront.HitPos:DistToSqr(self:GetPos())

	if ((distToPly > 15000) and not (distToPly < 10000)) then

		local ang = (self.master:GetPos() - (self:GetPos() + bufferVec)):GetNormalized():Angle()
		ang = LerpAngle(FrameTime()*15, self:GetAngles(), ang)
	
		ang[3] = 0
		if (ang[1] < -80) or (ang[1] > 80) then
			return true
		end
	
		phys:SetAngles(ang)

		if not (distToFront < 5000) then 
			phys:AddVelocity(self:GetForward()*175)
		end
	end

	return true
end

function ENT:Use(ply)
	if IsValid(self.pod:GetDriver()) then return end
	ply:EnterVehicle(self.pod)
	if ply == self.master then
		self.master = nil
	end
	return
end

function ENT:OnRemove()
end
