AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("touch_pickup_repairkit")
		ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel("models/props_lab/tpplug.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
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

	self.Entity:TakePhysicsDamage(dmginfo)
end

function PlayerPickupObject( ply, obj )
	if ( obj:IsPlayerHolding() ) then return end
	ply:PickupObject( obj )
end

function ENT:Use(activator, caller)

	PlayerPickupObject( activator, self )
	
end
used = false
function ENT:Touch( entity )
	if entity:GetClass() == "havoc_engine" or entity:GetClass() == "funkzentrale" or entity:GetClass() == "treibstoffpumpe" or entity:GetClass() == "schild" or entity:GetClass() == "gravitation" then
	self:Remove()
	if used == false then
	repair(entity)
	end
	end
end


function repair(entity) 
	used = true
	for k, v in pairs( player.GetAll() ) do
		v:PrintMessage( HUD_PRINTTALK, "[AI] A repair has been started. Expected repair time: 5 minutes." )
	end
	timer.Simple( 300, function()
	// entity:SetNWInt( "enginehealth", 100 )
	if entity:GetClass() == "funkzentrale" then entity:SetNWBool( "zentrale", true ) entity:SetNWInt( "enginehealth", 500 ) end
	if entity:GetClass() == "treibstoffpumpe" then entity:SetNWInt( "enginehealth", 350 ) end
	if entity:GetClass() == "schild" then entity:SetNWInt( "enginehealth", 1000 ) end
	if entity:GetClass() == "havoc_engine" then entity:SetNWInt( "enginehealth", 100 ) end
	if entity:GetClass() == "gravitation" then entity:SetNWInt( "enginehealth", 600 ) RunConsoleCommand( "sv_gravity", 600 ) end

	for k, v in pairs( player.GetAll() ) do
		v:PrintMessage( HUD_PRINTTALK, "[AI] A repair has been finished!" )
	end
	end)

end