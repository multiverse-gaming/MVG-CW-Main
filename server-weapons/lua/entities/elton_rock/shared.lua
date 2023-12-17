

AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_fx_particles = GetConVarNumber( "sfw_fx_particles" )

ENT.PrintName 		= "Eltons Rock"
ENT.RMdl 			= "models/crystal/yeah.mdl"
ENT.RMat 			= "models/elemental/frozen_alpha"
ENT.RShadows 		= true
ENT.Phx				= SOLID_CUSTOM
ENT.PhxMaxVelocity 	= 12000
ENT.PhxSSize		= nil
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxDragAmount 	= 4096
ENT.PhxMass 		= 2
ENT.FxTracer 		= nil --"" --"jotunn_trail"
ENT.SndImpact 		= "" --"scifi.hornet.dart.explode"
ENT.LifeTime		= 12
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.LightEmit 		= false
ENT.SoundEmit		= false

if ( IsMounted( "ep2" ) ) then
	ENT.SoundFile		= "NPC_Hunter.FlechetteNearmiss"
	ENT.SoundHitEntity 	= "NPC_Hunter.FlechetteHitBody"
	ENT.SoundHitWorld 	= "NPC_Hunter.FlechetteHitWorld"
else
	ENT.SoundFile		= "cat.dart.flyby"
	ENT.SoundHitEntity 	= ""
	ENT.SoundHitWorld 	= ""
end

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "IsAttached" )
	self:NetworkVar( "Bool", 1, "XPloding" )
	self:NetworkVar( "Bool", 2, "MTarLocked" )
	self:NetworkVar( "Int", 0, "charge" )
	
end

function ENT:SubInit( ent, phys )

	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 						-- parent
				0, 									-- attachment ID
				Color( 225, 220, 255, 200 ), 		-- Color
				1, 									-- force additive rendering
				4, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				32,									-- texture resulution
				"rock_splinter_stalactite" 			-- texture
			)
		end

		ent:SetNoDraw( false )
	--	ent:SetNWInt( "charge", 0 )
		ent.Ricochet = false
	end

end

function ENT:SubThink()

--	if ( SERVER ) && ( !self:GetIsAttached() ) then
--		self.Entity:EmitSound( self.SoundFile )
--	end

--	debugoverlay.Line( self.Entity:GetPos(), self.Entity:GetPos() + self.Entity:GetAngles():Forward() * 16, 1, Color( 255, 255, 255, 255 ), true ) 

end

function ENT:Touch( EntOther )
	
	if ( CLIENT ) then return end

	local tr = self:GetTouchTrace()
	local hitPos = tr.HitPos
	local phys_own = self.Entity:GetPhysicsObject()
	
	if ( tr.HitSky ) then
		self.Entity:Remove() 
	end
	
	if ( tr.HitWorld ) then return end
	
	if ( tr.HitNonWorld ) && ( IsValid( self.Owner ) ) then
		if ( !IsValid( tr.Entity ) ) then return end
		if ( !IsValid( tr.Entity:GetPhysicsObject() ) ) then return end
		if ( string.StartWith( tr.Entity:GetClass(), "func_" ) || string.StartWith( tr.Entity:GetClass(), "phys_" ) ) then self.Entity:Remove() end -- this is sooo cheesy...
		if ( tr.Entity:IsPlayer() || tr.Entity:IsNPC() ) then self.Entity:Remove() end
		
		if ( !self:GetIsAttached() ) && ( tr.Entity ~= self.Entity && tr.Entity:GetClass() ~= self.Entity:GetClass() ) then
			
			if ( GetRelChance( 5 ) ) then
				DoElementalEffect( { Element = EML_ICE, Target = tr.Entity, Duration = 1, Attacker = self.Owner } )
			end

			ParticleEffectAttach( "rock_impact_stalactite", 1, self.Entity, 1 )
			
			self.Entity:EmitSound( self.SoundHitEntity )
			if ( tr.Entity:GetClass() == "prop_ragdoll" || tr.Entity:GetClass() == "prop_physics" ) then
				tr.Entity:SetAbsVelocity( self.Entity:GetAngles():Forward() * 12800 )
				tr.Entity:SetPhysicsAttacker( self.Owner, 10 )
--[[
				local phys = tr.Entity:GetPhysicsObject()
				if ( phys:GetMass() <= 50 ) then
					phys_own:EnableGravity( true )
					phys_own:SetDragCoefficient( 2048 )
					tr.Entity:SetPos( self.Entity:GetPos() )
					tr.Entity:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
					tr.Entity:SetParent( self.Entity )
					phys:EnableDrag( false )
					phys:SetMass( 0 )
				end
]]--		
			end	
			
			self:SetIsAttached( true )
			self.PhysGrav = true
		end
	end

end

function ENT:PhysicsCollide( data, phy )

	self.Entity:XPlode()

	local charge = self.Entity:GetNWInt( "charge" )

	if ( !self:GetIsAttached() && charge >= 90 && data.HitNormal:Length() >= 0.8 ) then
		data.PhysObject:ApplyForceCenter( data.OurOldVelocity - data.HitNormal * ( 256 * charge ) )
		--self.Entity:SetAbsVelocity( self.Entity:GetAngles():Forward() * ( 256 * charge ) )
	end
	
	local surf = data.HitEntity
	
	ParticleEffectAttach( "rock_impact_stalactite", 1, self.Entity, 1 )
	self.Entity:EmitSound( self.SoundHitWorld )

	if ( surf:IsWorld() ) && ( self.Ricochet ) then
		self.Entity:GetPhysicsObject():EnableMotion( false )
		self.Entity:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		self.Entity:SetIsAttached( true )
	else
		self.Ricochet = true
		data.PhysObject:EnableGravity( true )
		data.PhysObject:EnableDrag( true )
	end
			
end

function ENT:OnTakeDamage( dmginfo )

	return false
	
end

function ENT:OnRemove()

	self.Entity:EmitSound( "common/Null.wav", SNDLVL_GUNFIRE, PTICH_NORM, 1, CHAN_ITEM )

end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 1.4
	end
	
	if ( hgroup == HITGROUP_CHEST || hgroup	== HITGROUP_STOMACH ) then
		mul = 1.2
	end
	
	return mul

end

function ENT:XPlode()

	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( SERVER ) && ( !self:GetXPloding() ) then
	
		local pos = self.Entity:GetPos()
		local ang = self.Entity:GetAngles()

		local charge = self:GetNWInt( "charge" )
		local dmg = 100
		local dmgtype = bit.bor( DMG_SLASH, DMG_BUCKSHOT, DMG_NEVERGIB )
		
		self:SetXPloding( true )
		
		ParticleEffect( "rock_impact_stalactite", pos, ang, self.Entity )
		self.Entity:EmitSound( "Glass.Strain" )

		self.Entity:DealPointDamage( dmgtype, dmg, pos, 256, 100, 8 )	
		self.Entity:DealPointDamage( dmgtype, dmg, pos + ang:Forward() * 4, 256, 200, 8 )	

	end

end