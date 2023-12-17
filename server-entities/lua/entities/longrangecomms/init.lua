AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

util.AddNetworkString("advert_fix")

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("longrangecomms")
		ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

    SetGlobalBool("commsDown", false)
	self.Entity:SetModel("models/props/starwars/tech/imperial_deflector.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Entity:SetNWInt( "enginehealth", 500 )
	self.Entity:SetNWInt( "maxhealth", 500 )
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
	local Health = self.Entity:GetNWInt( "enginehealth", 500 )
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
				v:SendLua("chat.AddText(Color(255, 0, 0), '[AI] WARNING!', Color(255, 255, 255), ' > The Long Range Communication was destroyed! >> No communication over long range comms possible!')")
			end
		end
	end
	self.Entity:TakePhysicsDamage(dmginfo)


end

function ENT:Use(activator, caller)


	local HealthonE = self.Entity:GetNWInt( "enginehealth", 500 )
	self.Entity:EmitSound("ambient/energy/spark1.wav")
	if HealthonE < 1 then
		HealthonE = 0
	end

	if (activator:IsPlayer()) then
		if HealthonE == 0 then
			activator:SendLua("chat.AddText(Color(255, 0, 0), '[Long Range Comms Array] WARNING', Color(255, 255, 255), ' > Relay Destroyed. No Long Range Communication possible!')")
		else
			activator:SendLua("local health = "..HealthonE.." chat.AddText(Color(255, 0, 0), '[Long Range Comms Array]', Color(255, 255, 255), ' All frequencys ready > Status: '..health..'%')")
		end
	end
end