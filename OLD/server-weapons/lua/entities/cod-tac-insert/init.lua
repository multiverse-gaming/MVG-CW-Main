
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.RespawnCounter = 0

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then 
		return 
	end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "cod-tac-insert" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent:GetOwner(self.TacOwner)
	return ent
	
end

function ENT:Initialize()
	
	self:SetModel( "models/hoff/weapons/tac_insert/w_tac_insert.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:DrawShadow(false)
	self:SetMaxHealth(5)
	self:SetHealth(5)
	local phys = self:GetPhysicsObject()
	
		  if (phys:IsValid()) then
			phys:Wake()
		  end
		self.Hit = false
		
	self:SetDTFloat( 0, math.Rand( 0.5, 1.3 ) )
	self:SetDTFloat( 1, math.Rand( 0.3, 1.2 ) )
	
end

function ENT:SetupDataTables()

	self:DTVar( "Float", 0, "RotationSeed1" )
	self:DTVar( "Float", 1, "RotationSeed2" )

end

ENT.HealthAmnt = 75

 function ENT:OnTakeDamage(dmg)
 
	self:TakePhysicsDamage(dmg)
 
	if(self.HealthAmnt <= 0) then 
		return 
	end
 
	self.HealthAmnt = self.HealthAmnt - dmg:GetDamage()
 
	if(self.HealthAmnt <= 0) then
		local effect = EffectData()
		effect:SetStart(self:GetPos())
		effect:SetOrigin(self:GetPos())
		util.Effect("cball_explode", effect, true, true)
		sound.Play(Sound("npc/assassin/ball_zap1.wav"), self:GetPos(), 100, 100)
		hook.Remove("PlayerSpawn","TacSpawner"..self:GetNWString("OwnerID"))
		self:Remove()
	end
	
 end

ENT.CanUse = true
function ENT:Use( activator, caller )
	if activator == self.Owner and self.CanUse then
		self.CanUse = false
		if self.Owner:Alive() and self.Owner:IsValid() and SERVER then
			for k, v in pairs( self.Owner.Tacs ) do
				timer.Simple( 0 * k, function()
					if IsValid( v ) then
						if not self.Owner:HasWeapon("seal6-tac-insert") then
							self.Owner:Give("seal6-tac-insert")
							self.Owner:EmitSound("hoff/mpl/seal_tac_insert/ammo.wav")
						else
							local effect = EffectData()
							effect:SetStart(v:GetPos())
							effect:SetOrigin(v:GetPos())
							util.Effect("cball_explode", effect, true, true)
							sound.Play(Sound("npc/assassin/ball_zap1.wav"), v:GetPos(), 100, 100)
						end
						v:Remove()
					end				
					hook.Remove("PlayerSpawn","TacSpawner"..v:GetNWString("OwnerID"))
					table.remove( self.Owner.Tacs, k )
				end )
			end	
		end
	end
end

function ENT:Think()

end

function ENT:PhysgunPickup(ply, ent)
	if IsValid(ent) and ent:GetClass() == self:GetClass() then
		return false
	end
end
hook.Add("PhysgunPickup", "stop_tac_physgun", function(ply, ent)
	if IsValid(ent) and ent.PhysgunPickup then
		return ent:PhysgunPickup(ply, ent)
	end
end)