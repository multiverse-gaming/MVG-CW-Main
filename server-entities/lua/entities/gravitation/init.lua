AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction(ply, tr)
	if self:Count() <= 0 then
		if (!tr.Hit) then return end
		
		local SpawnPos = tr.HitPos + tr.HitNormal * 16
		
		local ent = ents.Create("gravitation")
			ent:SetPos(SpawnPos)
		ent:Spawn()
		ent:Activate()
		
		return ent
	else
		ply:ChatPrint("A gravity generator already exists.")
	end
end

function ENT:Count()
	local count = 0
	for k, v in ipairs(ents.FindByClass("gravitation")) do
		count = count + 1
	end
	return count
end


function ENT:Initialize()
		getLastGravity = nil
		self.Entity:SetModel("models/props/starwars/furniture/imp_console.mdl")
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

if SERVER then
	WaitTillAllowedToPlayAgain = false
end

function ENT:OnTakeDamage(dmginfo)
	local Health = self.Entity:GetNWInt( "enginehealth", 500 )
	local TakeDamageInfo = dmginfo
	local damage = TakeDamageInfo:GetDamage()
	local Loss = Health - damage
	if Health > 1 then
		print(Health)
		self.Entity:SetNWInt( "enginehealth", Loss )
		self.Entity:EmitSound("ambient/energy/spark1.wav")
	else
		if not self.Entity:IsOnFire() then
			self.Entity:Ignite( 500, 100 )
			if WaitTillAllowedToPlayAgain == false then
				for k, v in pairs( player.GetAll() ) do
					v:PrintMessage( HUD_PRINTTALK, "[AI] The gravity generator was destroyed!" )
				end
			end
			if SERVER and not WaitTillAllowedToPlayAgain then
				WaitTillAllowedToPlayAgain = true
				timer.Simple(5, function() WaitTillAllowedToPlayAgain = false end)
			end
			RunConsoleCommand( "sv_gravity", 100 )
		end
	end




	self.Entity:TakePhysicsDamage(dmginfo)
end

hook.Add("PostGamemodeLoaded", "grav.gm.graviation.savegrav", function()
	getLastGravity = GetConVar("sv_gravity"):GetInt()

end)

hook.Add("PostCleanupMap", "ResetGravity", function()
	if getLastGravity != nil then
		RunConsoleCommand( "sv_gravity", getLastGravity )
	end
end)

function ENT:Use(activator, caller)


	local HealthonE = self.Entity:GetNWInt( "enginehealth", 500 )
	self.Entity:EmitSound("ambient/energy/spark1.wav")
	if HealthonE < 1 then
		HealthonE = 0
	end

	if (activator:IsPlayer()) then
		if HealthonE == 0 then
			activator:PrintMessage( HUD_PRINTTALK, "[Gravity Generator] Broken, needs repairing!" )
		else
			activator:PrintMessage( HUD_PRINTTALK, "[Gravity Generator] Energylevel: "..HealthonE.."%" )
		end
	end
end

function ENT:OnRemove()
	if getLastGravity != nil then
		RunConsoleCommand( "sv_gravity", getLastGravity )
	end
end