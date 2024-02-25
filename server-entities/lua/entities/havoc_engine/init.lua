AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("havoc_engine")
		ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel("models/props/starwars/vehicles/bd_dispenser.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Entity:SetNWInt( "enginehealth", 1000 )

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
	local Health = self.Entity:GetNWInt( "enginehealth", 1000 )
	local TakeDamageInfo = dmginfo
	local damage = TakeDamageInfo:GetDamage()
	local Loss = Health - damage
	if Health > 1 then
		
		self.Entity:SetNWInt( "enginehealth", Loss )
		self.Entity:EmitSound("ambient/energy/spark1.wav")
	else
		if not self.Entity:IsOnFire() then
			self.Entity:Ignite( 500, 100 )
			for k, v in pairs( player.GetAll() ) do
				v:PrintMessage( HUD_PRINTTALK, "[AI] An Energy Generator has been destroyed!" )
			end
		end
	end




	self.Entity:TakePhysicsDamage(dmginfo)
end

function ENT:Use(activator, caller)


	local HealthonE = self.Entity:GetNWInt( "enginehealth", 1000 )
	self.Entity:EmitSound("ambient/energy/spark1.wav")
	if HealthonE < 1 then
		HealthonE = 0
	end

	if (activator:IsPlayer()) then
		if HealthonE == 0 then
		activator:PrintMessage( HUD_PRINTTALK, "[Energy Generator] Error" )
		else
		activator:PrintMessage( HUD_PRINTTALK, "[Energy Generator] Running > Status: "..HealthonE.."%" )
		end
	end
end