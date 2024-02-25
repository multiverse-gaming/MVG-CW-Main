AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize()
	self:SetModel("models/cs574/objects/ammo_container.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if(IsValid(phys)) then
		phys:Wake()
	end

	self:SetHealth(self.BaseHealth)
	self:SetSkin(self.CurSkin)
end

function ENT:SpawnFunction(ply, tr, ClassName)
	if(!tr.Hit) then return end

	local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80

	local ent = ents.Create(ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end




function ENT:Use(activator, caller)
	local dispenser_timer = GetConVar("rw_sw_dispenser_timer"):GetInt()
	local ammoType1 = activator:GetActiveWeapon():GetPrimaryAmmoType()
	local ammoType2 = activator:GetActiveWeapon():GetSecondaryAmmoType()
	local clip1 = activator:GetActiveWeapon():GetMaxClip1()
	--local clip2 = activator:GetActiveWeapon():GetMaxClip2()
	local mul = GetConVar("rw_sw_dispenser_allammo_multiplier"):GetInt()

	if self.UseTimer <= CurTime() and activator:IsPlayer() then
		
		self:SetSkin(self.LoadingSkin)
		self:EmitSound("buttons/button6.wav")
		activator:GiveAmmo(60, "rpg_round", false)
		activator:GiveAmmo(90, "grenade" ,false)

		activator:GiveAmmo(clip1*mul, ammoType1, false)
		activator:GiveAmmo(3 --[[clip2*mul]] , ammoType2, false)

		if clip1 <= 0 then
			activator:GiveAmmo(750, ammoType1, false)
		end
		self.UseTimer = CurTime() + dispenser_timer
		self.Status = 0
	else
		self:EmitSound("npc/roller/code2.wav")
		return false
	end
end

function ENT:Think()
	if self.UseTimer <= CurTime() && self.Status == 0 then
		self:EmitSound("buttons/button7.wav")
		self:SetSkin(self.CurSkin)
		self.Status = 1
	end 
end

function ENT:OnTakeDamage(damage)
	self:SetHealth(self:Health() - damage:GetDamage())
	if (self:Health() <= 0) then
		self:EmitSound("ambient/explosions/explode_3.wav")
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		util.Effect("Explosion", effectdata)
		self:Remove()
	end
end