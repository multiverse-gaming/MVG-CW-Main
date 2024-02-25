
AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_elementals.lua" )
include( "base/scifi_elementals.lua" )

local cmd_debug_dmgranges			= GetConVarNumber( "sfw_debug_showdmgranges" )
local cmd_fx_bloomstyle	 			= GetConVarNumber( "sfw_fx_bloomstyle" )
local cmd_fx_particles				= GetConVarNumber( "sfw_fx_particles" )
local cmd_fx_sprites				= GetConVarNumber( "sfw_fx_sprites" )
local cmd_fx_lights					= GetConVarNumber( "sfw_fx_lightemission" )
local cmd_fx_lights_forcelegacy 	= GetConVarNumber( "sfw_fx_lightemission_force_legacy" )
local cmd_meteor_ignoreallies		= GetConVarNumber( "sfw_meteor_ignoreallies" )

PROJECTILE_RULE_IGNORE		= 0
PROJECTILE_RULE_KILLME		= 1
PROJECTILE_RULE_XPLODE		= 2
PROJECTILE_RULE_PHXCOLLIDE	= 3

local NotiColor	= Color( 255, 80, 175 )

local bloomstyle_0 = Material( "bloom/halo_static" )
local bloomstyle_1 = Material( "sprites/light_ignorez" )
local bloomstyle_2 = Material( "bloom/halo_static_2" )
--local bloomstyle_3 = ...

local function GetBloomStyle()

	if ( cmd_fx_bloomstyle <= 0 || cmd_fx_bloomstyle > 2 || !cmd_fx_bloomstyle ) then
		return bloomstyle_0
	end
	
	if ( cmd_fx_bloomstyle == 1 ) then
		return bloomstyle_1
	end
	
	if ( cmd_fx_bloomstyle == 2 ) then
		return bloomstyle_2
	end

end

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName 		= "SciFi Projectile"
ENT.Author 			= "Darken217"
ENT.Spawnable 		= false											-- Don't show this entity in the spawn menu. IHL also checks for this when labelling SENTs. 
ENT.AdminSpawnable 	= false											-- No, not even for admins.
ENT.DisableDuplicator =	true										-- Thou shallt not dupeth my entities.

ENT.NewHitMechanic 	= false											-- Use a touch-trace based XPlode() trigger instead of a physics collide trigger.
ENT.SvThinkDelay	= 0.12											-- The entity's SERVER SIDED think delay. Lower delay = higher think rate = more accuracy, Higher delay = less networking = better performance
ENT.ClThinkDelay 	= 0												-- The same as above, but CLIENT SIDED.
ENT.LagCompensated 	= false 										-- Lag compensation. Allows the entity to be lag compensated during Player:LagCompensation().

ENT.RenderGroup		= RENDERGROUP_BOTH
ENT.RShadow 		= false 										-- Render shadows?
ENT.RMdl 			= "models/dav0r/hoverball.mdl"					-- Placeholder model
ENT.RMat 			= "nil" 										-- Placeholder material

ENT.Phx 			= SOLID_BBOX									-- Solidity.
ENT.PhxStatic		= false											-- Set this to true, if the entity should NEVER move.
ENT.PhxMaxVelocity  = 5120											-- Global rule for physical maximum velocity.
ENT.PhxFlag			= FSOLID_NOT_STANDABLE							-- You can't walk or stand on this thingy.
ENT.PhxMType 		= bit.bor( MOVETYPE_FLY, MOVETYPE_CUSTOM )
ENT.PhxMColl		= MOVECOLLIDE_FLY_BOUNCE						-- Just ... just accept this, ok?
ENT.PhxCGroup 		= COLLISION_GROUP_PROJECTILE					-- Collision group. This determines, what can collide with the entity.
ENT.PhxSSize		= 5 											-- Set this to nil, if you want to use the model's collision mesh.
ENT.PhxSProp 		= "default_silent"								-- The entity's surface prop. This also effects collision sounds and underwater behaviour (only, if gravity is enabled!) 
ENT.PhxMass 		= 1												-- Physical mass.
ENT.PhxGrav			= false											-- Gravity?
ENT.PhxDrag			= false											-- Drag?
ENT.PhxDragAmount	= 1												-- Drag???
ENT.PhxElastic		= 4294967296									-- dem bounces...
ENT.PhxBuoyancy 	= 0 											-- The entities buoyancy, reaching from 0 to 1.
ENT.PhxUseFlags		= false											-- Use flags to give this entity an optimized place in the game's physics. Disable this, if you're planning to create an item or something, the player should be able to grab.

ENT.LifeTime		= 2.5											-- The entities life time. Once expired, the entity will be removed automatically.
ENT.OnWater			= PROJECTILE_RULE_XPLODE						-- Simplified behaviour rules on a certain event. Those can be either ignored or overridden, of cause. There are things like call Xplode on event or pretend, it's a physical collision and stuff.
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE

ENT.FxTracerNew	 	= false											-- Use the new method to attach particles to a projectile. This is forced client-side and more adjustable, but may cause issues in multiplayer.
ENT.FxTracer 		= "ngen_core_small"								-- Particle effect attached on spawn.
ENT.FxAttachType 	= PATTACH_ABSORIGIN_FOLLOW
ENT.FXAttachId		= 0
ENT.FxOffset		= Vector( 0, 0, 0 )

ENT.LightEmit		= true											-- Emit dynamic light. This works pretty much the same as the standard gmod_light entity.
ENT.LightColor		= "220 200 255 255"
ENT.LightSpotRadius	= 240
ENT.LightDistance	= 280
ENT.LightBrightness	= 1
ENT.LightStyle 		= 0
ENT.LightDecay		= 2048
ENT.LightDieTime	= 1
ENT.LightRealistic  = false											-- Enables the use of env_projectedtexture based lighting, which is by far more realistic then default lighting but burns performance. You should avoid using this.
ENT.LightFlare		= true											-- Draw a fake bloom effect around a glowing entity?
ENT.LightFlareMat 	= GetBloomStyle()								-- Effect texture. This will be derived from the internal system, unless overridden. ToDo: Not-additive FX texture?
ENT.LightFlareColor = nil											-- Effect color can be overridden manually and is otherwise derived from the set or default self.LightColor, excluding the alpha value. -- Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 4												-- Transparency. The effect itself will be rendered additively, so you should be careful with higher alpha values.
ENT.LightFlareAdd 	= false 										-- Fake self-additive rendering. The LightFlare should be always be additive regardless. This enables to render it twice with different sizes simultaniously to create a glowing effect outside a particle.
ENT.LightFlareSize 	= 0.52											-- Effect size scaling. The glow's size is computed of self.LightDistance * self.LightFlareSize.
ENT.LightFlarePos 	= nil 											-- Offset along the entity's z-axis, given the y-axis is the top direction. This offset is relative to the entity's position in the world.
ENT.LensFlare 		= false											-- Draw a lense-flare effect. This will be the size of the light flare +60%. It also follows the same rules for positioning and computation. Note, that this effect can't be colored.
ENT.LensFlareMat 	= Material( "bloom/lflare_default" )			-- The lens-flare material to be used.

ENT.SndImpact 		= "cat.ca3.hit"									-- Sound played by the XPlode() function.
ENT.SoundEmit		= false											-- Emit a sound on Think(). This can be used for faked fly-by sounds.
ENT.SoundFile		= ""

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "MTarLocked" ) 	-- Meteor targeting. Is a target locked?
	self:NetworkVar( "Bool", 1, "XPloding" ) 	-- Is the XPlode() function running or was it triggered?
--	self:NetworkVar( "Int", 0, "LifeTime" )
--	self:NetworkVar( "Vector", 0, "Pos" )

end

function ENT:Initialize()

	local size = self.PhxSSize
	
	if ( self.Phx ~= SOLID_NONE ) then self.Entity:PhysicsInit( self.Phx ) end
	if ( self.PhxFlag ~= "" ) then self.Entity:SetSolidFlags( self.PhxFlag ) end
	
	if ( self.PhxStatic == true ) then
		self.Entity:PhysicsInitShadow( false, false )
	end
	
	if ( SERVER ) then

		if ( self.LagCompensated ) then
			self:SetLagCompensated( true ) 
		end
		
		self.Entity:SetNoDraw( false )
		self.Entity:DrawShadow( self.RShadow )
		
		if ( self.RMdl ~= "" ) && ( util.IsValidModel( self.RMdl ) ) then
			self.Entity:SetModel( self.RMdl )
		else
			self.Entity:SetModel( "models/dav0r/hoverball.mdl" )
		end
		
		if ( self.RMat ~= "" ) then
			self.Entity:SetMaterial( self.RMat )
		else
			self.Entity:SetMaterial( "nil" )
		end
		
		if ( self.Phx == SOLID_VPHYSICS ) then
			self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		else
			self.Entity:SetMoveType( self.PhxMType )
			self.Entity:SetMoveCollide( self.PhxMColl )
		end
	
		if ( size ~= nil ) then
			self.Entity:PhysicsInitSphere( size, self.PhxSProp )
			self.Entity:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
		else
			self.Entity:PhysicsInit( SOLID_VPHYSICS )
			self.Entity:SetSolid( SOLID_VPHYSICS )
			self.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )
			self.Entity:SetCollisionBounds( self.Entity:GetModelBounds() )
		end
		
		self.Entity:SetCollisionGroup( self.PhxCGroup )
		self.Entity:SetElasticity( self.PhxElastic )
		
		local phys = self.Entity:GetPhysicsObject()
		if ( !IsValid( phys ) ) then DevMsg( "@"..self:GetClass().." : !Error; Invalid physics object. Removing! " ) self.Entity:Remove() return end
		phys:SetMass( self.PhxMass )
		phys:EnableGravity( self.PhxGrav )
		phys:EnableDrag( self.PhxDrag )
		phys:SetBuoyancyRatio( self.PhxBuoyancy )
		if ( self.PhxDrag ) then
			phys:SetDragCoefficient( self.PhxDragAmount )
		end
		phys:Wake()
		
		if ( self.PhxUseFlags ) then
			self.Entity:AddFlags( FL_FLY )
			self.Entity:AddFlags( FL_OBJECT )
			self.Entity:AddFlags( FL_BASEVELOCITY )
			self.Entity:AddEFlags( EFL_NO_WATER_VELOCITY_CHANGE )
			phys:AddGameFlag( FVPHYSICS_WAS_THROWN )
		end

		if ( self.LifeTime > 0 ) then
		--	self.Entity:SetLifeTime( self.LifeTime )
			self.Entity:SetPhysicsAttacker( self.Owner, self.LifeTime )

			self.DieTime = CurTime() + self.LifeTime
		end
		
		local velo_global = physenv.GetPerformanceSettings() -- One does not simple adjust global settings...
		velo_global.MaxVelocity = self.PhxMaxVelocity 
		physenv.SetPerformanceSettings( velo_global )
		
		if ( self.LightEmit ) && ( cmd_fx_lights == 1 ) && ( cmd_fx_lights_forcelegacy == 1 ) then
			local fx2 = ents.Create( "light_dynamic" )
			if ( !IsValid( fx2 ) ) then return end
			fx2:SetKeyValue( "_light", self.LightColor )
			fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius )
			fx2:SetKeyValue( "distance", self.LightDistance )
			fx2:SetKeyValue( "brightness", self.LightBrightness )
			fx2:SetPos( self.Entity:GetPos() )
			fx2:SetParent( self.Entity )
			fx2:Spawn()
			--fx2:Fire( "kill", "", self.LifeTime )
		end
		
		local cmd_projexturelighting = GetConVarNumber( "sfw_fx_projexturelighting" )
		
		if ( cmd_projexturelighting == 1 && self.LightRealistic ) || ( cmd_projexturelighting == 2 ) then
			local pos = self.Entity:GetPos()
			local ang = self.Entity:GetAngles()
			local clr = self.LightColor

			local sides = {
				["up"] = { dir = ang:Up() },
				["dn"] = { dir = ang:Up() * -1 },
				["rt"] = { dir = ang:Right() },
				["lf"] = { dir = ang:Right() * -1 },
				["fw"] = { dir = ang:Forward() },
				["bk"] = { dir = ang:Forward() * -1 }
			}

			for k,v in pairs ( sides ) do
				local realtime = ents.Create( "env_projectedtexture" )
				realtime:SetPos( pos )
				realtime:SetAngles( v.dir:Angle() )	
				realtime:SetParent( self.Entity )		
				realtime:SetKeyValue( "lightfov", 90 )
				realtime:SetKeyValue( "lightworld", 1 )	
				realtime:SetKeyValue( "lightcolor", clr )
				realtime:SetKeyValue( "enableshadows", 1 )
				realtime:SetKeyValue( "farz", self.LightDistance * 1 )
				realtime:SetKeyValue( "nearz", 8 )
				realtime:Fire( "SpotlightTexture", "vgui/white", 0 )
			end
		end
			
	end
	
	if ( !self.FxTracerNew ) && ( self.FxTracer ~= nil ) && ( ( !game.SinglePlayer() && CLIENT ) || SERVER ) then
		ParticleEffectAttach( self.FxTracer, self.FxAttachType, self.Entity, self.FXAttachId )
	end

	if ( self.FxTracerNew ) && ( self.FxTracer ~= nil ) && ( CLIENT ) then
		CreateParticleSystem( self.Entity, self.FxTracer, self.FxAttachType, self.FXAttachId, self.FxOffset ) 
	end
	
	if ( CLIENT ) && ( cmd_fx_particles >= 1 ) then
		self.PixVis = util.GetPixelVisibleHandle()
	end
	
	if ( IsValid( self.Entity ) ) then
		self.Entity:SubInit( self.Entity, self.Entity:GetPhysicsObject() )
	end

end

function ENT:CanEmitLight()

	local cmd_fx_lights = GetConVarNumber( "sfw_fx_lightemission" )
	local cmd_fx_lights_forcelegacy = GetConVarNumber( "sfw_fx_lightemission_force_legacy" )
	local cmd_fx_lights_projextures = GetConVarNumber( "sfw_fx_projexturelighting" )

	if ( cmd_fx_lights <= 0 ) then 
		return false
	end
	
	if ( cmd_fx_lights_forcelegcy == 1 ) then
		return false
	end
	
	if ( cmd_fx_lights_projextures == 2 ) then
		return false
	end

	if ( self.LightEmit && self.LightRealistic && cmd_fx_lights_projextures == 0 ) then 
		return true
	end
	
	if ( self.LightEmit ) then
		return true
	else
		return false
	end
	
end

function ENT:Think()

 	if ( self.OnWater ~= PROJECTILE_RULE_IGNORE ) or ( self.OnWater == nil ) then
		if ( self.Entity:WaterLevel() > 0 ) then
			if ( self.OnWater == PROJECTILE_RULE_KILLME ) then
				if ( SERVER ) then
					if ( cmd_fx_particles == 1 ) && ( math.random( 0, 100 ) < 20 ) then
					ParticleEffect( "event_onwater_remove", self.Entity:GetPos(), self.Entity:GetAngles(), fx )
					end
					self.Entity:Remove()
				end
			elseif ( self.OnWater == PROJECTILE_RULE_PHXCOLLIDE ) then
				self.Entity:PhysicsCollide()
			elseif ( self.OnWater == PROJECTILE_RULE_XPLODE ) then
				self.Entity:XPlode()
			end
		end
	end
	
	if ( SERVER ) && ( self.SoundEmit == true ) && ( self.Entity:GetCollisionGroup() ~= COLLISION_GROUP_DISSOLVING ) then
		self.Entity:EmitSound( self.SoundFile )
	end
	
	if ( CLIENT ) then
		if ( self.Entity:CanEmitLight() ) then
			local dlight = DynamicLight( self.Entity:EntIndex() )
			local clr = string.ToColor( self.LightColor )
			
			if ( dlight ) then
				dlight.pos = self.Entity:GetPos()
				dlight.r = clr.r
				dlight.g = clr.g
				dlight.b = clr.b
				dlight.brightness = self.LightBrightness
				dlight.Decay = self.LightDecay
				dlight.Size = self.LightDistance
				dlight.Style = self.LightStlye
				dlight.DieTime = CurTime() + self.LightDieTime
				dlight.noworld = false
				dlight.nomodel = false
			end
		end
		
		self:SetNextClientThink( self.ClThinkDelay )
	end
	
	self:SubThink( self.Entity )
	
	if ( SERVER ) then
		self:NextThink( CurTime() + self.SvThinkDelay )
		
		if ( IsValid( self.Entity ) ) && ( self.LifeTime > 0 ) && ( self.DieTime <= CurTime() ) then
			self.Entity:Remove()
		end
	end
	
	return true 

end

function ENT:SubInit( ent, phys )
 -- will be ran on Initialize().
end

function ENT:SubThink( ent )
 -- can be overridden by the child-entity, to do things per Think() without actually overriding the Think() function.
end

function ENT:Draw()

	self.Entity:DrawModel()

	if ( cmd_fx_sprites == 1 ) && ( self.LightEmit && self.LightFlare ) && ( self.LightFlareMat ~= nil ) then

		local ply = GetViewEntity() --LocalPlayer()
		local origin = self.Entity:GetPos()

		if ( self.LightFlarePos ) && ( IsValid( self.Owner ) && !self.Owner:IsNPC() ) then
			origin = self.Entity:GetPos() + self.Entity:GetAngles():Forward() * self.LightFlarePos
		end
		
		if ( !self.PixVis || self.PixVis == nil ) then DevMsg( "@"..self:GetClass().." : !Error;  Failed to create PixVis handle! Check your init!" ) return end
		local isvisible	= util.PixelVisible( origin, 4, self.PixVis )	
	
		if ( !isvisible || isvisible < 0.1 ) then return end
		local color_1
		local alpha = self.LightFlareAlpha * ( isvisible )
		local bscale = GetConVarNumber( "sfw_fx_bloomscale" )
		
		local plyview = ply:EyeAngles():Forward()
		local entview = origin - ply:EyePos() + Vector( self.LightFlareSize )
		local iscale = math.Clamp( math.tan( plyview:Dot( ( entview ):GetNormalized() ) ) - 0.4, 0, 1 )

		if ( self.LightFlareColor ) then
			color_1 = self.LightFlareColor
		else
			color_1 = string.ToColor( self.LightColor )
		end

		if ( self.Entity:GetOwner() ~= LocalPlayer() ) then
			alpha = self.LightFlareAlpha * 1.4 -- magic number?
		end
		
		render.SetMaterial( self.LightFlareMat )
		local size = ( self.LightDistance * self.LightFlareSize ) * ( isvisible ) * ( ( bscale / 10 + 1 ) * ( iscale ) )
		local color = Color( color_1.r, color_1.g, color_1.b, alpha * bscale * iscale )
		
		if ( self.LightFlareAdd ) then
			local color2 = Color( color_1.r, color_1.g, color_1.b, ( alpha * bscale * iscale ) / 2 )

			render.DrawSprite( origin, size * 0.6, size * 0.6, color )
			render.DrawSprite( origin, size * 1.4, size * 1.4, color2 )
		else
			render.DrawSprite( origin, size, size, color )
		end
		
		if ( self.LensFlare ) then
			local color3 = Color( 255, 255, 255, ( alpha * bscale * iscale ) / 3 )
			render.SetMaterial( self.LensFlareMat )
			render.DrawSprite( origin, ( self.LightDistance * self.LightFlareSize ) * 1.6, ( self.LightDistance * self.LightFlareSize ) * 1.6, color3 )
		end

	end

end

function ENT:OnTakeDamage( CTakeDamageInfo )

	if ( self.OnDamaged ~= PROJECTILE_RULE_IGNORE ) then
		if ( self.OnDamaged == PROJECTILE_RULE_KILLME ) then
			if ( SERVER ) then
				self.Entity:Remove()
			end
		elseif ( self.OnDamaged == PROJECTILE_RULE_XPLODE ) then
			self.Entity:XPlode()
		end
	end

end

function ENT:SetTrigger()

	return true
	
end

function ENT:Touch( EntOther )

	if ( self.NewHitMechanic ) then
		local tr = self:GetTouchTrace()

		if ( ( IsValid( tr.Entity ) && tr.Entity ~= self.Entity ) || ( tr.HitWorld ) ) && ( !self:GetXPloding() ) then
			DevMsg( "@"..tostring( self.Entity ).." : !Warning; NewHitMechanic kicked in!" )
			self.Entity:XPlode()
		end
	end
	
end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	local IsXploding = self:GetXPloding()

	if ( !self.NewHitMechanic ) && ( !IsXploding ) then
		self.Entity:XPlode( pCollisionData )
	end
	
	if ( self.NewHitMechanic ) && ( pCollisionData.HitEntity:IsWorld() ) && ( !IsXploding ) then
		self.Entity:XPlode( pCollisionData )
	end
		
end

function ENT:XPlode( pCollisionData )

	--DevMsg( "@SciFiWeapons : Projectile exploded" )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
		self.Entity:DealPointDamage( DMG_GENERIC, 8 * amp, self.Entity:GetPos(), 128 )
		self.Entity:DealAoeDamage( DMG_GENERIC, 16 * amp, self.Entity:GetPos(), 64 )
		
		for k,v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 16 ) ) do
			if ( v ~= self.Entity && v:GetOwner() ~= self.Owner ) then
				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 5, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_CORROSIVE, Target = v, Attacker = self.Owner, Inflictor = self.Entity } )
				DoElementalEffect( { Element = EML_SHOCK, Target = v, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 5, Attacker = self.Owner } )
			end
		end
		
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx2 ) ) then return end
		fx2:SetKeyValue( "_light", self.LightColor )
		fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.2 )
		fx2:SetKeyValue( "distance", self.LightDistance * 1.2 )
		fx2:SetKeyValue( "brightness", 2 )
		fx2:SetPos( self.Entity:GetPos() )
		fx2:SetAngles( self.Entity:GetAngles() )
		fx2:Spawn()
		fx2:Fire( "kill", "", 0.115 )

		ParticleEffect( "ngen_hit", fx2:GetPos(), self.Entity:GetAngles(), fx )

		util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
		self.Entity:EmitSound( self.SndImpact )
	end
	
end

function ENT:GetValidOwner()

	if ( self.Owner == NULL ) then
		return self.Entity
	else
		return self.Owner
	end

end

function ENT:DealAoeDamage( dmgtype, dmgamt, src, range, attacker, forcemul ) -- I've no chance but notice, that my explosion based damaging system is kinda unreliable and difficult to handle.
	
	if ( !forcemul ) then
		forcemul = 1
	end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( attacker == nil ) or ( attacker == "NULL" ) then
		dmg:SetAttacker( self.Entity:GetValidOwner() )
	else
		dmg:SetAttacker( attacker )
	end
	dmg:SetInflictor( self.Entity )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) * forcemul )
	dmg:SetDamage( dmgamt )
	
	util.BlastDamageInfo( dmg, src, range )
	
	if ( cmd_debug_dmgranges >= 1 ) then
		debugoverlay.Sphere( src, range, 0.5, Color( 255, 100, 100, 20 ), false )
		debugoverlay.Sphere( src, range / 2, 0.5, Color( 255, 50, 50, 25 ), false ) 
	end
	
	if ( cmd_debug_dmgranges >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units." )
	end
	
	if ( cmd_debug_dmgranges == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units.\n" )
	end

end

function ENT:DealAoeDamageOverTime( dmgtype, dmgamt, src, range, lifetime, tickdelay, parent )

	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( attacker == nil ) or ( attacker == "NULL" ) then
		dmg:SetAttacker( self.Entity:GetValidOwner() )
	else
		dmg:SetAttacker( attacker )
	end
	dmg:SetInflictor( self.Entity )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) )
	dmg:SetDamage( dmgamt )
	
	if ( cmd_debug_dmgranges >= 1 ) then
		debugoverlay.Sphere( src, range, lifetime, Color( 200, 175, 80, 10 ), false ) 
		debugoverlay.Sphere( src, range / 2, lifetime, Color( 255, 205, 120, 25 ), false ) 
	end
	
	if ( cmd_debug_dmgranges >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds." )
	end
	
	if ( cmd_debug_dmgranges == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds.\n" )
	end

	timer.Create( "hurt" .. parent:EntIndex(), tickdelay, 300, function()
		util.BlastDamageInfo( dmg, src, range )
	end )
	
	timer.Create( "SafeRemoveTimer".. parent:EntIndex(), lifetime, 0, function()
		timer.Destroy( "hurt" .. parent:EntIndex() )
		timer.Destroy( "SafeRemoveTimer" .. parent:EntIndex() )
	end )

end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 1
	end

	return mul

end

function ENT:DealPointDamage( dmgtype, dmgamt, src, range, dmgforce, hullsize ) -- Alternatively, you can make the projectile shoot a classic bullet on Xplode. This way, you can deal damage the old-fashioned way, while having physical projectiles.

	if ( !dmgforce ) then
		dmgforce = 1
	end
	
	if ( !hullsize ) then
		hullsize = 6
	end

	local dmg = {}
--	dmg.Attacker = self.Entity:GetValidOwner()
	dmg.Num = 1
	dmg.Src = src
	dmg.Dir = self.Entity:GetAngles():Forward()
	dmg.Distance = range
	dmg.Tracer = 0
	dmg.Force = dmgforce
	dmg.HullSize = hullsize
	dmg.Damage = dmgamt
--	dmg.AmmoType = "pistol"
	dmg.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( dmgtype )
		dmginfo:SetDamage( dmginfo:GetDamage() * self.Entity:GetCritMultiplier( tr.HitGroup ) )
	end
	
	self.Entity:GetValidOwner():FireBullets( dmg, false )
	
	if ( cmd_debug_dmgranges >= 1 ) then
		debugoverlay.Cross( src, 4, 0.5, Color( 75, 255, 50, 25 ), false ) 
	end
	
	if ( cmd_debug_dmgranges >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, at a trace result position." )
	end
	
	if ( cmd_debug_dmgranges == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, at a trace result position.\n" )
	end

end

function ENT:DealDirectDamage( dmgtype, dmgamt, target, attacker, dmgforce ) -- Or, you know, just make it boring by just applying damage.

	if ( !IsValid( target ) ) then return end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( !attacker || !IsValid( attacker ) ) then
		dmg:SetAttacker( self.Entity:GetValidOwner() )
	else
		dmg:SetAttacker( attacker )
	end
	dmg:SetInflictor( self.Entity )
	if ( !dmgforce ) then
		dmg:SetDamageForce( Vector( 0, 0, 1 ) )
	else
		dmg:SetDamageForce( dmgforce )
	end
	dmg:SetDamage( dmgamt )
	
	if ( target:IsPlayer() || target:IsNPC() ) then
		target:TakeDamageInfo( dmg ) 
	end
	
	if ( cmd_debug_dmgranges >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring( self ).." dealt "..tostring( dmgamt ).." ("..tostring( dmgtype )..") damage vs. "..tostring( target ) )
	end
	
	if ( cmd_debug_dmgranges == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring( self ).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage vs. "..tostring( target ).."\n" )
	end
	
end

function ENT:MeteorTargeting( scanrange, selfdestruct, selfdestructrange, velomul )

	if ( self.Owner:IsNPC() ) then return end
	if ( !IsValid( self.Owner ) ) then return end

	if ( SERVER ) then
		local scanr = scanrange / 2
		local phys = self.Entity:GetPhysicsObject()
		local mpos = self.Entity:GetPos()
		local tr = self.Owner:GetEyeTrace()
		
		if ( !velomul ) then velomul = 1.5 end
			
		local tr = util.TraceHull( {
			start = tr.StartPos,
			endpos = tr.HitPos,
			filter = function( ent ) if ( IsValid( ent ) && ( ent:IsNPC() || ( ent:IsPlayer() && ent ~= self.Owner ) ) ) then return true end end,
			mins = Vector( -scanr, -scanr, -scanr ),
			maxs = Vector( scanr, scanr, scanr ),
			mask = MASK_SHOT_HULL,
			ignoreworld = true
		} )

		local tars = ents.FindInSphere( tr.HitPos, scanrange )
		
		if ( tr.Entity:IsValid() && ( tr.Entity ~= NULL && !tr.Entity:IsWorld() && tr.Entity:GetClass() ~= "npc_bullseye" ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) ) then
			table.insert( tars, 1, tr.Entity )
		end

		for k, v in pairs( tars ) do
			if ( IsValid( v ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) ) then
				if ( cmd_meteor_ignoreallies == 1 && ( v:IsNPC() && v:Disposition( self.Owner ) ~= D_LI ) || cmd_meteor_ignoreallies == 0 ) || ( v:IsPlayer() ) then
					local tarpos = v:GetPos()

					if ( v:EyePos() ) then
						tarpos = v:EyePos()
					else
						tarpos = v:GetPos()
					end

					if ( IsValid( v ) ) && ( v:IsNPC() || ( v:IsPlayer() && v ~= self.Owner ) ) then
					--	phys:ApplyForceCenter( ( tarpos - mpos ) * ( velomul * ( mpos:Distance( tarpos ) ) ) )
						phys:ApplyForceOffset( ( ( tarpos - mpos ) * mpos:Distance( tarpos ) ) * velomul, mpos )
						self.Entity:SetMTarLocked( true )
					end
					
					if ( !v:IsNPC() && !v:IsPlayer() ) || ( !IsValid( v ) ) then 
						self.Entity:SetMTarLocked( false )
					end
				end
			end
		end
		
		if ( selfdestruct == true && selfdestructrange ~= nil ) && ( mpos:Distance( self.Owner:GetPos() ) > 256 ) then
			for k, v in pairs( ents.FindInSphere( mpos, selfdestructrange ) ) do
				if ( v:IsNPC() ) && ( mpos:Distance( v:GetPos() ) <= selfdestructrange ) then
					self:XPlode()
				end
			end
		end
	end

end

-------------------------------------
------------###--------------###-----
--------------##---------------##----
-----##########-------##########-----
------##----##---------##----##------
-----##--##--##-------##--##--##-----
------##----##---------##----##------
-------######-----------######-------
-------------------------------------
---------------#######---------------
-------------------------------------