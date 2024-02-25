AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("meddroid")
		ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel("models/props/starwars/medical/health_droid.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Entity:SetNWInt( "enginehealth", 500 )

	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end

function ENT:PhysicsCollide(data, physobj)
	if (data.Speed > 80 and data.DeltaTime > 0.2) then
		self.Entity:EmitSound("Default.ImpactSoft")
	end
end


function ENT:OnTakeDamage(dmginfo)
	return
end

function ENT:Use(activator, caller)


	local HealthonE = self.Entity:GetNWInt( "enginehealth", 500 )
	self.Entity:EmitSound("ambient/energy/spark1.wav")
	if HealthonE < 1 then
		HealthonE = 0
	end

	if (activator:IsPlayer()) then
		if HealthonE == 0 then
		activator:PrintMessage( HUD_PRINTTALK, "[Medical Droid] Sorry, my bacta tanks are empty!" )
		self.Entity:Remove()
		else
		if activator:Health() < 199 then
		activator:PrintMessage( HUD_PRINTTALK, "[Medical Droid] You have been gained +10 HP! Remaining Energy: "..HealthonE.."%" )
		activator:SetHealth(activator:Health()+10)
		local Loss = HealthonE - 10
		self.Entity:SetNWInt( "enginehealth", Loss )
		else
		activator:PrintMessage( HUD_PRINTTALK, "[Medical Droid] Sorry, i cannot provide you medical assistance." )
		end
		end
	end
end