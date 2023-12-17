

AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

hook.Add( "GetFallDamage", "rmt_nofall_trump", function( ply, speed )
	if ( IsValid( ply ) && IsValid( ply:GetActiveWeapon() ) && ply:GetActiveWeapon():GetClass() == "sfw_melee" ) then
		local wep = ply:GetActiveWeapon()

		if ( ply:KeyDown( IN_DUCK ) ) then
			ply:SetNWFloat( "SWL_FeatherFall", CurTime() ) 
			wep:SetNextAttack( 0.5 )
			ply:ViewPunch( Angle( speed / 32, 0, math.random( -speed, speed ) / 128 ) )
			return 0
		end
	end
end )

SWEP.PrintName				= "Melee Trooper blade"
SWEP.Author					= "Drugz"

SWEP.Purpose				= "An standard flux-stream blade."
SWEP.Instructions			= "Mouse1 to strike, Mouse2 to stab/dash. Hitting a target will decrease the blade's charge."

SWEP.Slot					= 0
SWEP.SlotPos				= 4

SWEP.HoldType = "wos-energy-staff"
SWEP.ViewModelFOV = 61.909547738693
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/v_knife_t.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false



SWEP.DeploySpeed 			= 2.8
SWEP.Weight					= 1

SWEP.SciFiSkin				= "nil"
SWEP.SciFiWorld 			= "nil"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Automatic	= true

SWEP.ViewModelSprintAng 	= Angle( -10, -10, 0 )

SWEP.SciFiFamily			= { "vtec", "melee_simple", "useshook", "infammo", "autoregen" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 15 - 50, +5", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				 --", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Impact, Energy", color = Color( 110, 180, 255 ) },
	["4"] = { text = "Attack speed: 	(max.) 2.5", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Range: 						 82 units", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Damage is positively effected by the wielder's movement speed.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Damage decreases with lower blade charge.", color = Color( 180, 180, 180 ) },
--	["9"] = { text = "... They ask for your allegiance, and you shall give it ...", color = Color( 255, 20, 20 ) }
}

SWEP.ViewModelMeleePos		= Vector( 2, 4, -2 )
SWEP.ViewModelMeleeAng		= Angle( 10, 20, -20 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 4
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.HitDistance			= 82

SWEP.SciFiRegenDelay		= 0.6


	


SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/doom/weapons/templar_sword.mdl", bone = "v_weapon.knife_Parent", rel = "", pos = Vector(-0.519, -2.597, 2.596), angle = Angle(3.506, 87.662, -19.871), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/doom/weapons/templar_sword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 0.518, -3.636), angle = Angle(-78.312, -17.532, -12.858), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


--resource.AddSingleFile( "weapons/eblade/eblade_idle.wav" )

local SwingElectric = { "Scifi.Blade.Swing01", "Scifi.Blade.Swing02", "Scifi.Blade.Swing03" }
local HitElectric = { "Scifi.Blade.Hit.Electric01", "Scifi.Blade.Hit.Electric02" }
local HitDefault = Sound( "Scifi.Blade.Hit" )
local comfort = 0

function SWEP:SubInit()

	self.NextRegenTime = 0
	comfort = 52

end




function SWEP:SetupDataTables()

	self:NetworkVar( "Int", 0, "SciFiMelee" )
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )

end

if ( CLIENT ) then

	function SWEP:CustomAmmoDisplay()

		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = true
		
		if ( self.Primary.ClipSize > -1 ) then
			self.AmmoDisplay.PrimaryClip = self:Clip1()
		end
		
		return self.AmmoDisplay
		
	end

end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )

end

function SWEP:Think()

	if ( self.Owner:GetActiveWeapon() ~= self.Weapon ) then return end

	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()
	
	if ( IsExistent( self ) ) and ( IsExistent( self:GetNWEntity( "blade" ) ) ) then
	
		local blade = self:GetNWEntity( "blade" )
		local vm_blade = self.Owner:GetVelocity()
		local velo = math.Clamp( ( math.Round( ( math.abs( vm_blade.y ) + math.abs( vm_blade.x ) + math.abs( vm_blade.z ) ) ) / 300 ), 0.01, 0.25 )

               if ( CLIENT ) then
			EmitSound( "", blade:GetPos(), blade:EntIndex(), CHAN_STATIC, velo, 50, SND_CHANGE_PITCH, 60 + velo * 10 )

		end
		
		if ( self:GetNWBool( "eblade_active" ) == true ) then
		--	CreateParticleSystem( blade, "blade_glow", PATTACH_POINT_FOLLOW, 1, Vector( 0, 0, 0 ) ) 
		--	ParticleEffectAttach( "blade_glow", PATTACH_POINT_FOLLOW, blade, 0 ) -- wtf, garry? why you rekt this function?
			self:SetNWBool( "eblade_active", false )
		end
	
	end
	
	if ( idletime > 0 && CurTime() > idletime ) and ( SERVER ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle_cycle" ) )

		self:UpdateNextIdle()

	end

	local meleetime = self:GetNextMeleeAttack()

	if ( meleetime > 0 && CurTime() > meleetime ) then

		self:DealDamage()

		self:SetNextMeleeAttack( 0 )

	end
	
	if ( SERVER ) then
		
		if( self.NextRegenTime <= CurTime() ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) then 
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 ) 
			end
		end
		
		if ( self.Weapon:Clip1() >= 101 ) then
			self.Weapon:SetClip1( 100 )
		end
	
	end
	
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy()

	if ( self.Owner:IsNPC() ) then self:Remove() end --Those NPC-peasants aren't mighty enough to use this weapon.

	local vm = self.Owner:GetViewModel()

self.Weapon:SetHoldType( "wos-energy-sword" )	
	
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self:UpdateNextIdle()
	
	self:SetClip1( 60 )
end
	
	
function SWEP:PrimaryAttack()

	self:SetNWBool( "eblade_active", true )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	local anim = ""
	
	if ( GetRelChance( comfort ) ) then
		self.Owner:ViewPunch( Angle( 0, 2, 0 ) )
		anim = "midslash1"
		comfort = comfort - 10
	else
		self.Owner:ViewPunch( Angle( 0, -2, 0 ) )
		anim = "midslash2"
		comfort = comfort + 10
	end
	
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingElectric[ math.random( 1, #SwingElectric ) ] )

	local weaken = 0.4 + ( self.SciFiACC / 30 )
	
	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )
	
	self:SetNextPrimaryFire( CurTime() + weaken )
	--self:SetNextSecondaryFire( CurTime() + weaken + 0.1 )

	self.NextRegenTime = CurTime() + self.SciFiRegenDelay
	
	self:AddSciFiACC( 12 )

end
    
function SWEP:SecondaryAttack(tr)
	local ply = self.Owner
	local t = {} 
	t.start = ply:GetPos() + Vector( 0, 0, 52 ) 
	t.endpos = ply:GetPos() + ply:EyeAngles():Forward() * 700
	t.filter = ply 
	local tr = util.TraceEntity( t, ply ) 
	ply:SetPos( tr.HitPos )
	self:SetNextSecondaryFire( CurTime() + 1)
	if self.Transparency == 0 then
		self:ResetVis()
	end
end

function SWEP:DealDamage()

	local anim = self:GetSequenceName( self.Owner:GetViewModel():GetSequence() )
	local amp = GetConVarNumber( "sfw_damageamp" )
	local playervelo = self.Owner:GetVelocity()
	local velo = math.Clamp( ( math.Round( ( math.abs( playervelo.y ) + math.abs( playervelo.x ) + math.abs( playervelo.z ) ) ) / 64 ), 1, 10 )

	self.Owner:LagCompensation( true )
	
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -16, -16, -8 ),
			maxs = Vector( 16, 16, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
	
		self:EmitSound( HitElectric[ math.random( 1, #HitElectric ) ] )
		
		util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
		
		if ( anim == "stab" ) then
			ParticleEffect( "blade_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		else
			ParticleEffect( "saphyre_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		end
	
		if ( self:Clip1() > 0 ) then
				if ( !game.SinglePlayer() && SERVER ) then
				local fx2 = ents.Create( "light_dynamic" )
				if ( !IsValid( fx2 ) ) then return end
				fx2:SetKeyValue( "_light", "70 110 255 255" )
				fx2:SetKeyValue( "spotlight_radius", 256 )
				fx2:SetKeyValue( "distance", 512 )
				fx2:SetKeyValue( "brightness", 1 )
				fx2:SetPos( tr.HitPos )
				fx2:Spawn()
				fx2:Fire( "kill", "", 0.12 )
				end
			self:EmitSound( HitDefault )
		end
	
	end

	local hit = false
	
	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then

		local dmginfo = DamageInfo()
		local dmgforce = self.Owner:GetRight() * 100 + self.Owner:GetForward() * 100 + playervelo * 2
	
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )

		if ( self:Clip1() > 0 ) then
		--	self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_NEVERGIB ), 25 * amp, self.Owner:GetShootPos() + self.Owner:GetAimVector() * 16, 64 )
			for k,v in pairs ( ents.FindInSphere( tr.HitPos, 56 ) ) do
				if ( v ~= self.Owner ) && ( v:GetOwner() ~= self.Owner ) then
					self:DealDirectDamage( bit.bor( DMG_AIRBOAT, DMG_NEVERGIB ), 25 * amp, v, self.Owner, dmgforce )
				end
			end
			dmginfo:SetDamage( ( math.random( 100, 160 ) + ( self:Clip1() / 4 ) ) * amp + velo )
			dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_NEVERGIB ) )
			self:TakePrimaryAmmo( math.Clamp( 25, 0, self:Clip1() ) )
		else
			dmginfo:SetDamage( math.random( 100, 160 ) * amp + velo )
		end
		
		dmginfo:SetDamageForce( dmgforce )

		tr.Entity:TakeDamageInfo( dmginfo )
		
		hit = true
		
	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 8 * phys:GetMass(), tr.HitPos )
		end
	end
	
	
	self:SetNWBool( "eblade_active", false )

	self.Owner:LagCompensation( false )

end