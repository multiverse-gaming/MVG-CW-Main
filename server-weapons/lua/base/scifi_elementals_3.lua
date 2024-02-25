
AddCSLuaFile()

--[[

	Structure: ElementalInfo (emlinfo)
	emlinfo.Element		EML_ enum
	emlinfo.Target		Entity
	emlinfo.Duration	Float
	emlinfo.Attacker	Entity
	emlinfo.Inflictor	Entity (most likely a weapon)
	emlinfo.Origin		Vector
	emlinfo.Range		Float
	emlinfo.Ticks		Int

	DoElementalEffect( table = emlinfo )

	Note: You don't need all of these vars for every elemental effect. See the examples below.
	
	Example:
	
				local MyEml = {}
				MyEml.Element = EML_FIRE
				MyEml.Target = Entity( 1 )
				MyEml.Duration = 2
				MyEml.Attacker = Entity( 0 )
				
				DoElementalEffect( MyEml )
				
		Works the same way as:

				DoElementalEffect( { Element = EML_FIRE, Target = Entity( 1 ), Duration = 2, Attacker = Entity( 0 ) } )
				
	This would ignite the player for 2 seconds.
	You can optionally define an attacker here. The attacker is obligatory for most of the other elements, 
	however when used with fire, the attacker won't be able to ignite neither himself nor owned entities, like currently equipped weapons.
	The elements fire, ice and entangling blight share the same syntax (element, target, duration, attacker). 
	Shock elemental only requires the target. It doesn't have any duration and also doesn't need an attacker.
	Note: If you know, you're going to spam the elemental info at one || more targets, consider the first solution and have the ElementalInfo table precached, if possible, so you don't drawn the garbage collector.

				DoElementalEffect( { Element = EML_CORROSIVE, Target = Entity( 1 ), Attacker = Entity( 1 ), Inflictor = Entity( 1 ):GetActiveWeapon() } )
				
	This would cause the player to corrode himself with the weapon, they're currently using.
	Duration is obsolete for this element, as the corrosive damage source has a capped life-time of 5 seconds.

				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 5, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_SHOCK, Target = v } )
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 5, Attacker = self.Owner } )
				
	These are lines used in a ents.FindInSphere() context, in the scifi_projectile's base XPlode() function, which is triggered on every hit.
	In this case "v" equals each element of the returned table and therefore an entity within a set radius.
	self.Owner is obvious.
	Note: Unless you work around owner-issue otherwise, I'd recommend using self.Entity:GetValidOwner() instead of self.Owner, to avoid NULL Entity errors, if the projectile outlives its creator.
	
	For dissolve effects, you'll need to define the initial position emlinfo.Origin, range and optionally the maximum amount of scan-ticks.
	In addition, you can force the function to use cheap particles, by setting emlinfo.ForceCheapFX to true. This is recommended, if you're planning to cover a large area with a dissolving elemental effect.
	Effects will automatically forced to cheap, if the limit from sfw_fx_maxexpensive is reached.
	
	Example: (like in sfw_seraphim)
	
				DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Attacker = self.Owner, Range = 64, Ticks = 25, Indextype = 0, ForceCheapFX = false } )
				
	Note: Everything in the line above is obligatory for dissolve elements to work. Only ticks are optional.
	Also keep in mind that the origin for indextype 1 is always the attackers shoot pos.

]]--

DMG_SF_PULSE 				= 102				-- Impulse damage. Suffers vs. armor. Hurts helicopters.
DMG_SF_HWAVE				= 132				-- Plasma/Slash combo. Ignores light/medium armor.One-hits headcrabs.
DMG_SF_PHASEBLADE 			= 8324				-- Same as the above, but more effective.
DMG_SF_ICE 					= 2621446			-- Suffers vs. armor. 
DMG_SF_ICE_SHRED 			= 536875012			-- No armor reduction except for fortified synth armor (striders).
DMG_SF_CORROSIVE_DART 		= 65538				-- Corrosive/Bullet combo.
DMG_SF_CORROSIVE 			= 393216			-- Corrosive/Toxin combo, similar to antlion worker's acid spit.
DMG_SF_CORROSIVE_ENERGY 	= 536940544			-- Just corrosive damage. Suffers from actual armor, but hurts 2.5x more when the target is corroding.
DMG_SF_BLAST 				= 33554496			-- Blast/Airboat combo. Hurts everything. No armor reduction.
DMG_SF_ENERGYBULLET 		= 4098				-- Energy projectile. Obeys default armor rules.
DMG_SF_ENERGYBLADE 			= 5120				-- Energy/Slash/Impact combo. Ignores light/medium armor. One-hits headcrabs.
DMG_SF_ENERGY 				= 33554560			-- Energy. Ignores light/medium armor.
DMG_SF_ENERGYSHOCKWAVE 		= 536875008			-- Energy damamge...
DMG_SF_VAPOR 				= 9216				-- Good effectivity. Ignores light/medium armor.
DMG_SF_VAPOR_OP 			= 263168			-- Supreme effectivity. Ignores all kinds of armor.
DMG_SF_BLIGHT 				= 33554432			-- No effectivities/resistanes. Ignores light/medium armor.
DMG_SF_RADIANTFIRE 			= 33540137 			-- ???

EML_FIRE 					= 2					-- Pretty obvious. It's fire and stuff... Don't confuse this with HL2's ignition. This fire will NOT spread naturally.
EML_CORROSIVE				= 4					-- Corrosive damage. Small DOT + increased damage from all sources and even more increased bullet damage.
EML_ICE 					= 8					-- Cryo damage. Freezes the target in place.
EML_SHOCK 					= 16				-- Heavily drains player's shields. Causes ragdolls to spazzer.
EML_BLIGHT 					= 32				-- Blight damage. Usually, ineffective vs. objects.
EML_BLIGHT_ENT 				= 64				-- Entangling blight damage. Freezes the target in place and causes panic upon breaking free.
EML_DARK 					= 128				-- ???
EML_DISSOLVE_HWAVE 			= 1024				-- Dissolves props and ragdolls with orange light effects and particles.
EML_DISSOLVE_VAPOR 			= 2048 				-- Dissolves props and ragdolls with blue light effects and particles.
EML_DISSOLVE_CORROSIVE 		= 4096 				-- Dissolves and shrinks down a ragdoll with green goo around it.
EML_DISSOLVE_HWAVE_ADVANCED = 16384 			-- Clientside ragdoll dissolve... prediction messed that one up.

local antlion 				= 99
local flesh 				= 40
local alienflesh  			= 42
local zombieflesh 			= 102
local machine 				= 70
local metal 				= 3
local synthflesh 			= 85
local syntharmor 			= 98

local Effectivities = {
	[ DMG_BULLET ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 1.1, 	[ alienflesh ] = 0.85, 	[ zombieflesh ] = 1.15, [ machine ] = 0.7, 	[ metal ] = 0.7, 	[ synthflesh ] = 0.8, 	[ syntharmor ] = 0.8 	},
	[ DMG_BUCKSHOT ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 0.85, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.7, 	[ synthflesh ] = 0.85, 	[ syntharmor ] = 0.8 	},
	[ DMG_CLUB ] 				= { [ antlion ] = 1.1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.2, 	[ zombieflesh ] = 1.25, [ machine ] = 1.5, 	[ metal ] = 1.2, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5	},
	[ DMG_PHYSGUN ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1, 		[ synthflesh ] = 1, 	[ syntharmor ] = 0.8 	},
	[ DMG_SLASH ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 1.2, 	[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 0.9, 	[ metal ] = 0.8, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.75 	},
	[ DMG_VEHICLE ] 			= { [ antlion ] = 2, 	[ flesh ] = 1.5, 	[ alienflesh ] = 1.5, 	[ zombieflesh ] = 1.25, [ machine ] = 1, 	[ metal ] = 1, 		[ synthflesh ] = 1.25, 	[ syntharmor ] = 1 		},
	[ DMG_CRUSH ] 				= { [ antlion ] = 2, 	[ flesh ] = 1, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 2, 	[ metal ] = 1, 		[ synthflesh ] = 2, 	[ syntharmor ] = 1 		},
	[ DMG_ENERGYBEAM ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 0.8, 	[ zombieflesh ] = 1, 	[ machine ] = 2, 	[ metal ] = 1.1, 	[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.1 	},
	[ DMG_AIRBOAT ] 			= { [ antlion ] = 2, 	[ flesh ] = 1.5, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1.5, 	[ machine ] = 1.25, [ metal ] = 1.15, 	[ synthflesh ] = 1, 	[ syntharmor ] = 1 		},
	[ DMG_DISSOLVE ] 			= { [ antlion ] = 2, 	[ flesh ] = 2, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 1, 	[ metal ] = 1, 		[ synthflesh ] = 2, 	[ syntharmor ] = 1 		},
	[ DMG_SHOCK ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 0.8, 	[ alienflesh ] = 0.75, 	[ zombieflesh ] = 0.75, [ machine ] = 2, 	[ metal ] = 1.5, 	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1 		},
	[ DMG_RADIATION ] 			= { [ antlion ] = 0.8, 	[ flesh ] = 1, 		[ alienflesh ] = 0.8, 	[ zombieflesh ] = 0.8, 	[ machine ] = 2, 	[ metal ] = 1.15, 	[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.1 	},
	[ DMG_ACID ] 				= { [ antlion ] = 1.25, [ flesh ] = 1.1, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1.1, 	[ machine ] = 1.15, [ metal ] = 1.2, 	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.15	},
	
	[ DMG_SF_PULSE ]			= { [ antlion ] = 0.85, [ flesh ] = 0.85, 	[ alienflesh ] = 0.8, 	[ zombieflesh ] = 1, 	[ machine ] = 1.2, 	[ metal ] = 1.2, 	[ synthflesh ] = 0.8, 	[ syntharmor ] = 1.15 	},
	[ DMG_SF_HWAVE ]			= { [ antlion ] = 1, 	[ flesh ] = 1.2, 	[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 0.9, 	[ metal ] = 0.95, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.8 	},
	[ DMG_SF_PHASEBLADE ] 		= { [ antlion ] = 1.2, 	[ flesh ] = 1.25, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1.25, [ machine ] = 1, 	[ metal ] = 0.95, 	[ synthflesh ] = 0.85, 	[ syntharmor ] = 0.95 	},
	[ DMG_SF_ENERGY ] 			= { [ antlion ] = 1, 	[ flesh ] = 1.1, 	[ alienflesh ] = 0.9, 	[ zombieflesh ] = 1, 	[ machine ] = 0.85, [ metal ] = 0.9, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_ENERGYBLADE ] 		= { [ antlion ] = 1.15, [ flesh ] = 1.15, 	[ alienflesh ] = 1.15, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.75, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_ENERGYBULLET ] 	= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1.1, 	[ machine ] = 1.15, [ metal ] = 1, 		[ synthflesh ] = 0.8, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_ENERGYSHOCKWAVE ] 	= { [ antlion ] = 1.15, [ flesh ] = 1.15, 	[ alienflesh ] = 1.15, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.75, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_CORROSIVE ] 		= { [ antlion ] = 1.5, 	[ flesh ] = 0.95, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 0.8, 	[ machine ] = 1.2, 	[ metal ] = 1.2, 	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1 	},
	[ DMG_SF_CORROSIVE_DART ] 	= { [ antlion ] = 1.5, 	[ flesh ] = 0.8, 	[ alienflesh ] = 0.75, 	[ zombieflesh ] = 0.8, 	[ machine ] = 1.2, 	[ metal ] = 1.2, 	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1 	},
	[ DMG_SF_CORROSIVE_ENERGY ] = { [ antlion ] = 1.25, [ flesh ] = 0.85, 	[ alienflesh ] = 0.85, 	[ zombieflesh ] = 0.85, [ machine ] = 1.15, [ metal ] = 1.15, 	[ synthflesh ] = 1.15, 	[ syntharmor ] = 1 		},
	[ DMG_SF_ICE ] 				= { [ antlion ] = 0.85, [ flesh ] = 0.9, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.1, 	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1 	},
	[ DMG_SF_ICE_SHRED ] 		= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.2, 	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.2 	},
	[ DMG_SF_VAPOR_OP ] 		= { [ antlion ] = 2, 	[ flesh ] = 2, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 1, 	[ metal ] = 1, 		[ synthflesh ] = 2, 	[ syntharmor ] = 1.5 	},
	[ DMG_SF_VAPOR ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 0.9, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.9 	},
	[ DMG_SF_BLIGHT ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1, 		[ synthflesh ] = 1, 	[ syntharmor ] = 1 		},
	[ DMG_SF_BLAST ] 			= { [ antlion ] = 1.15, [ flesh ] = 1.1, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 1.5, 	[ metal ] = 1.25, 	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.25 	},
	[ DMG_SF_RADIANTFIRE ] 		= { [ antlion ] = 5, 	[ flesh ] = 5, 		[ alienflesh ] = 5, 	[ zombieflesh ] = 5, 	[ machine ] = 5, 	[ metal ] = 5, 		[ synthflesh ] = 5, 	[ syntharmor ] = 5 		}
}

hook.Add( "EntityTakeDamage", "SciFiDamageEffectivity", function( tEntity, dmgInfo )
	
	local cmd_advdmg = GetConVarNumber( "sfw_allow_advanceddamage" )
	
	if ( cmd_advdmg < 1 ) then return end
	
	dmgInfo:ScaleDamage( 0.75 )

	local dmgType = dmgInfo:GetDamageType()
	local dmgAtt = dmgInfo:GetAttacker()
	local dmgInf = dmgInfo:GetInflictor()
	local dmgPos = dmgInfo:GetDamagePosition()

	local trData = { start = dmgPos, endpos = dmgPos, filter = !tEntity, ignoreworld = true }
	local tr = util.TraceEntity( trData, tEntity )

	local mul = 1
	
	if ( tr.Hit ) then
		local effect = Effectivities[ dmgType ]
		if ( !effect ) then
			return 1 
		end
		
		local tSurface = tr.SurfaceProps
		if ( !tSurface ) then return 1 end 

		local scale  = effect[ tSurface ]
		if ( !scale ) then
			return 1 
		end
		
		if ( cmd_advdmg == 2 ) then 
			DevMsg( "@SciFiDamage : " .. "Using damage type '" .. dmgType .. "' vs. target (" .. util.GetSurfacePropName( tSurface ) .. " / " .. tSurface .. ") with an effectivity of " .. ( scale * 100 ) .. "%.\n" )
		end
		
		mul = scale
	end

	if ( mul ) then
		dmgInfo:ScaleDamage( mul )
	end	
	
	local IsCorroding = tEntity:GetNWBool( "edmg_corrosive" )
	
	if ( dmgType == DMG_CORROSIVE || dmgType == DMG_CORROSIVE_DART ) && ( IsCorroding ) then
		dmgInfo:ScaleDamage( 2 )
	end

	if ( dmgType == DMG_SF_HWAVE || dmgType == DMG_SF_HWAVE_DISSOLVE ) && ( tEntity:IsPlayer() && tEntity:Armor() > 0 ) then
		dmgInfo:ScaleDamage( 0.8 )
	end

end )

hook.Add( "EntityTakeDamage", "SciFiDamageElementalEffects", function( ent, dmginfo )

	local iscorroding = ent:GetNWBool( "edmg_corrosive" )
	local dmgamt = dmginfo:GetDamage()
	local dmgtype = dmginfo:GetDamageType()
	local attacker = dmginfo:GetAttacker()

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		if ( iscorroding == true  ) && ( dmgtype ~= DMG_ENERGYBEAM ) then
			dmginfo:ScaleDamage( 2 )
			if ( dmginfo:IsBulletDamage() ) then
				dmginfo:AddDamage( 4 )
			end

			if ( ( ent:Health() - dmgamt ) <= 0 ) then
				DoElementalEffect( { Element = EML_DISSOLVE_CORROSIVE, Attacker = attacker, Origin = ent:GetPos(), Range = 64, Ticks = 8 } )
			end
		end
		
		if ( ent:GetNWBool( "bliz_frozen" ) == true ) && ( dmginfo:GetDamageType() == DMG_CLUB || dmginfo:GetDamageType() == DMG_SLASH ) then
			dmginfo:ScaleDamage( 1.15 )
		end
	end

end )

local NotiColor	= Color( 80, 255, 175 )

local mat_dslv_hwave 	= "models/elemental/burned"
local mat_dslv_vapor 	= "models/elemental/vapored"
local mat_stun_ice 		= "models/elemental/frozen"

local snd_dslv_hwave 	= Sound( "scifi.hwave.dissolve" )
local snd_dslv_vapor 	= Sound( "scifi.vapor.dissolve" )
local snd_stun_ice 		= Sound( "scifi.bliz.breakfree" )
local snd_stun_ice_2 	= Sound( "scifi.cryo.freeze" )
local snd_stun_shock 	= Sound( "scifi.Blade.Hit.Electric02" )
local snd_stun_ebl		= Sound( "scifi.stinger.attach" )

local RagdollMgr = {}

function RagdollMgr:Filter( inputtable )

	local outputtable = {}

	for k,v in pairs ( inputtable ) do
		local vClass = v:GetClass()
		
		if ( IsValid( v ) ) && ( vClass == "prop_ragdoll" || vClass == "class C_ClientRagdoll" ) then
			table.insert( outputtable, v )
		end
	end
	
	return outputtable

end

function RagdollMgr:GetRagdollEntity()

end

function RagdollMgr:IsValidRagdoll( entity )

	if ( IsValid( entity ) && ( entity:IsRagdoll() ) ) then
		return true
	else
		return false
	end

end

local function GetFXStressCount()

	local entities = ents.GetAll()
	local valids = {}
	
	for k,v in pairs( entities ) do
		if ( v:GetNWBool( "IsVaporizing" ) ) then
			table.insert( valids, v )
		end
	end

	return #valids
	
end

local function CanUseExpensive()

	local cmd_fx_maxexpensive = GetConVarNumber( "sfw_fx_maxexpensive" )
	
	if ( GetFXStressCount() <= cmd_fx_maxexpensive ) || ( cmd_fx_maxexpensive < 0 ) then
		return true
	else
		DevMsg( "@SciFiElementals : !Warning; Can't create more low-perf effects!" )
		return false
	end
	
end

local function HwaveDissolve( v, vPhys, vPos )

	v:SetNWBool( "IsVaporizing", true )

	if ( IsValid( phys ) && vClass == "prop_ragdoll" ) then
		vPhys:SetMass( 1 )
		vPhys:EnableDrag( true ) 
		vPhys:SetDragCoefficient( 16384 )
		vPhys:SetAngleDragCoefficient( 16384 )
		vPhys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 2 )
		
		local bones = v:GetPhysicsObjectCount()
		local b = v:GetNWBool( "gravity_disabled" )

		for  i=0, bones-1 do
			local grav = v:GetPhysicsObjectNum( i )
			if ( IsValid( grav ) ) then
				grav:EnableGravity( b )
			end
		end

		vPhys:EnableDrag( true )
	end

	v:DrawShadow( false )
	v:SetNoDraw( false )
	
	local ed = EffectData()
	ed:SetOrigin( vPos )
	ed:SetEntity( v )
	util.Effect( "hwave_dissolve", ed )
	
	v:SetMaterial( mat_dslv_hwave )
	v:SetColor( Color( 100, 20, 0, 255 ) )
	v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
	v:EmitSound( snd_dslv_hwave )
	
	if ( SERVER ) then
		v:Fire( "kill", "", 1.4 )
	else
		timer.Simple( 1.4, function() v:Remove() end )
	end
	
end

function DoElementalEffect( emlinfo )
	
	if ( !emlinfo || !istable( emlinfo ) || emlinfo == nil ) then DevMsg( "@SciFiElementals : !Error; Failed to create elemental damage! No data given!" ) return end
	
	local element 				= emlinfo.Element 						-- Enum
	local target 				= emlinfo.Target						-- Entity
	local duration 				= emlinfo.Duration 						-- Float
	local attacker 				= emlinfo.Attacker						-- Entity
	local inflictor 			= emlinfo.Inflictor 					-- Entity
	local origin 				= emlinfo.Origin						-- Vector
	local range 				= emlinfo.Range							-- Float
	local indextype 			= emlinfo.IndexType 					-- Integer
	local ticks 				= emlinfo.Ticks							-- Integer
	local dissolvemasstolerance = emlinfo.DslvMaxMass					-- Integer (actually, it's a float but it's very, very unlikely to find floating points in mass values)
	local forcecheapfx 			= emlinfo.ForceCheapFX					-- Boolean
	local damage 				= emlinfo.Damage 						-- Float
	local amp 					= GetConVarNumber( "sfw_damageamp" )	-- Float (fake bool)
	local cmd_debug_showemlinfo = GetConVarNumber( "sfw_debug_showemlinfo" )
	local cmd_fx_particles 		= GetConVarNumber( "sfw_fx_particles" )
	local cmd_allow_dissolve 	= GetConVarNumber( "sfw_allow_dissolve" )
	
	if ( element == nil ) then DevMsg( "@SciFiElementals : !Error; Failed to create elemental damage! No or invalid element!" ) return end
	
	if ( cmd_debug_showemlinfo >= 1 ) then
		if ( isvector( origin ) ) then
			debugoverlay.Text( origin, "origin", 5, true ) 
			debugoverlay.Cross( origin, 4, 3, Color( 255, 20, 40, 255 ), true )
			debugoverlay.Sphere( origin, range, 3, Color( 80, 255, 175, 4 ), false )
		end
	end
	
	if ( cmd_debug_showemlinfo == 2 ) then
		MsgC( NotiColor, table.ToString( emlinfo, "emlinfo @ "..CurTime(), true ).."\n" )
	end
	
	if ( element == EML_DISSOLVE_HWAVE_ADVANCED ) then
		if ( !IsValid( attacker ) || ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then DevMsg( "@SciFiElementals : !Error; Failed to create elemental damage! Obligatory data was not given." ) return end

		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
		
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), 128, 0 )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			local vRagdolls = RagdollMgr:Filter( index )

			for k, v in pairs ( vRagdolls ) do
				if ( !IsValid( v ) ) then return end
				if ( v:GetNWBool( "IsVaporizing" ) ) then return end
				local vClass = v:GetClass()
				local vPhys = v:GetPhysicsObject()
				local vPos = v:GetPos()
				
				if ( cmd_allow_dissolve == 0 ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( !IsValid( v ) ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				
				HwaveDissolve( v, vPhys, vPos )

				if ( cmd_fx_particles >= 1 ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
					ParticleEffectAttach( "pyro_dissolve", 1, v, -1 ) 
						
					local dslfx = ents.Create( "light_dynamic" )
					if ( !IsValid( dslfx ) ) then return end
					dslfx:SetKeyValue( "_light", "255 90 10 255" )
					dslfx:SetKeyValue( "brightness", 3 )
					dslfx:SetKeyValue( "style", 1 )
					dslfx:SetPos( vPos )
					dslfx:SetParent( v )
					dslfx:Spawn()
					DLightFade( dslfx, 0, 320, 5, 2 )
					dslfx:Fire( "kill", "", 2 )
				else
					ParticleEffectAttach( "pyro_dissolve_cheap", 1, v, -1 ) 
					ParticleEffectAttach( "pyro_dissolve_ash_cheap", 1, v, 1 )
				end
			end
			
			for k, v in pairs ( index ) do
				if ( !IsValid( v ) ) then return end
				
				local vClass = v:GetClass()
				local vPhys = v:GetPhysicsObject()
				local vPos = v:GetPos()
				
				if ( cmd_allow_dissolve == 0 ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( ( v == NULL ) || ( vPhys == NULL ) ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				if ( IsValid( vPhys ) ) && ( ( vClass == "prop_physics" && vPhys:GetMass() <= 45 * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					HwaveDissolve( v, vPhys, vPos )
					
					if ( cmd_fx_particles >= 1 ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
						ParticleEffectAttach( "pyro_dissolve", 1, v, -1 )
						
						local dslfx = ents.Create( "light_dynamic" )
						if ( !IsValid( dslfx ) ) then return end
						dslfx:SetKeyValue( "_light", "255 90 10 255" )
						dslfx:SetKeyValue( "brightness", 3 )
						dslfx:SetKeyValue( "style", 1 )
						dslfx:SetPos( vPos )
						dslfx:SetParent( v )
						dslfx:Spawn()
						DLightFade( dslfx, 0, 320, 5, 2 )
						dslfx:Fire( "kill", "", 2 )
					else
						ParticleEffectAttach( "pyro_dissolve_cheap", 1, v, -1 ) 
						ParticleEffectAttach( "pyro_dissolve_ash_cheap", 1, v, 1 )
					end
				end
			end
			timer.Destroy( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_HWAVE ) then
		if ( !IsValid( attacker ) || ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then DevMsg( "@SciFiElementals : !Error; Failed to create elemental damage! Obligatory data was not given." ) return end

		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
		
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), 128, 0 )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			for k, v in pairs ( index ) do
				if ( cmd_allow_dissolve == 0 ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				
				local phys = v:GetPhysicsObject()
				
				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= 30 * amp ) || ( v:GetClass() == "prop_physics" && phys:GetMass() <= 45 * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					v:SetNWBool( "IsVaporizing", true )
					v:Extinguish()
					local vpos = v:GetPos()
					if ( !IsValid( phys ) ) then v:Remove() return end
					if ( v:GetClass() == "prop_ragdoll" ) then
						phys:SetMass( 1 )
						phys:EnableDrag( true ) 
						phys:SetDragCoefficient( 16384 )
						phys:SetAngleDragCoefficient( 16384 )
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 2 )
					else
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 1 )
					end

					local bones = v:GetPhysicsObjectCount()
					local b = v:GetNWBool( "gravity_disabled" )

					for  i=0, bones-1 do
						local grav = v:GetPhysicsObjectNum( i )
						if ( IsValid( grav ) ) then
							grav:EnableGravity( b )
						end
					end
				
					phys:EnableDrag( true )
					
					v:DrawShadow( false )
					v:SetNoDraw( false )
					
					local ed = EffectData()
					ed:SetOrigin( vpos )
					ed:SetEntity( v )
					util.Effect( "hwave_dissolve", ed, true, true )
					
					v:SetMaterial( mat_dslv_hwave )
					v:SetColor( Color( 100, 20, 0, 255 ) )
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_hwave )
					v:Fire( "kill", "", 1.4 )

					if ( cmd_fx_particles >= 1 ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
						ParticleEffectAttach( "pyro_dissolve", 1, v, -1 )
						
						local dslfx = ents.Create( "light_dynamic" )
						if ( !IsValid( dslfx ) ) then return end
						dslfx:SetKeyValue( "_light", "255 90 10 255" )
						dslfx:SetKeyValue( "brightness", 3 )
						dslfx:SetKeyValue( "style", 1 )
						dslfx:SetPos( vpos )
						dslfx:SetParent( v )
						dslfx:Spawn()
						DLightFade( dslfx, 0, 320, 5, 2 )
						dslfx:Fire( "kill", "", 2 )
					else
						ParticleEffectAttach( "pyro_dissolve_cheap", 1, v, -1 ) 
						ParticleEffectAttach( "pyro_dissolve_ash_cheap", 1, v, 1 )
					end
				end
			end
			timer.Destroy( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_VAPOR ) then
		if ( !IsValid( attacker ) || ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then DevMsg( "@SciFiElementals : !Error; Failed to create elemental damage! Obligatory data was not given." ) return end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
	
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), range, range )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			for k, v in pairs ( index ) do
				if ( cmd_allow_dissolve == 0 ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				
				local phys = v:GetPhysicsObject()
				
				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= dissolvemasstolerance * amp ) || ( v:GetClass() == "prop_physics" && phys:GetMass() <= dissolvemasstolerance * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					v:SetNWBool( "IsVaporizing", true )
					v:Extinguish()
					
					if ( !IsValid( phys ) ) then v:Remove() return end
					if ( v:GetClass() == "prop_ragdoll" ) then
						phys:SetMass( 1 )
						phys:EnableDrag( true ) 
						phys:SetDragCoefficient( 8192 )
						phys:SetAngleDragCoefficient( 4096 ) -- 4294967296 8589934592 ?
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 64 )
					else
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 8 )
					end

					local bones = v:GetPhysicsObjectCount()
					local b = v:GetNWBool( "gravity_disabled" )

					for  i=0, bones-1 do
						local grav = v:GetPhysicsObjectNum( i )
						if ( IsValid( grav ) ) then
							grav:EnableGravity( b )
						end
					end
					
					v:DrawShadow( false )
					v:SetNoDraw( false )
					v:SetMaterial( mat_dslv_vapor )
					v:SetRenderMode( RENDERMODE_TRANSADD ) --RENDERMODE_TRANSALPHA )
				--	v:SetColor( Color( 128, 128, 128, 80 ) )
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_vapor )
					v:Fire( "kill", "", 0.68 )
					
					if ( cmd_fx_particles >= 1 ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then
						ParticleEffectAttach( "vp_dissolve", 1, v, -1 )
						
						local dslfx = ents.Create( "light_dynamic" )
						if ( !IsValid( dslfx ) ) then return end
						dslfx:SetKeyValue( "_light", "40 60 255 255" )
						dslfx:SetKeyValue( "brightness", 3 )
						dslfx:SetKeyValue( "style", 1 )
						dslfx:SetPos( v:GetPos() )
						dslfx:SetParent( v )
						dslfx:Spawn()
						DLightFade( dslfx, 0, 420, 8, 0.68 )
						dslfx:Fire( "kill", "", 0.68 )
					else
						ParticleEffectAttach( "vp_dissolve_cheap", 1, v, -1 ) 
					end
				end
			end
			timer.Destroy( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_CORROSIVE ) then
		if ( !isvector( origin ) || !isnumber( range ) ) then DevMsg( "@SciFiElementals : !Error; Failed to create elemental damage! Obligatory data was not given." ) return end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
	
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = ents.FindInSphere( origin, range )
			
			for k, v in pairs ( index ) do
				if ( cmd_allow_dissolve == 0 ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				
				local phys = v:GetPhysicsObject()
				
				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= dissolvemasstolerance * amp ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then
					v:SetNWBool( "IsVaporizing", true )
					
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_hwave )
					v:Fire( "kill", "", 2 )
					
					local ed = EffectData()
					ed:SetOrigin( v:GetPos() )
					ed:SetEntity( v )
					util.Effect( "crsv_dissolve", ed, true, true )
					
					if ( cmd_fx_particles >= 1 ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then
						ParticleEffectAttach( "crsv_dissolve", 1, v, 1 )
					else
						ParticleEffectAttach( "crsv_dissolve_cheap", 1, v, 1 )
					end
				end
			end
			timer.Destroy( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end

	if ( target == nil || !IsValid( target ) ) then DevMsg( "@SciFiElementals : !Error; Invalid or no target." ) return end
	
	if ( element == EML_FIRE ) then
		if ( !duration ) then duration = 5 end
		
		local tClass = target:GetClass()
		
		if ( target:IsWeapon() && IsValid( target:GetOwner() ) ) then DevMsg( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) return end
		if ( tClass == "predicted_viewmodel" ) then DevMsg( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) return end
		if ( tClass == "gmod_hands" ) then DevMsg( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) return end
		if ( attacker == nil ) then
			target:Ignite( duration )
		else 
			if ( target ~= attacker && target:GetOwner() ~= attacker ) then
				target:Ignite( duration )
			end
		end
		return
	end

	if ( element == EML_CORROSIVE ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevMsg( "@SciFiElementals : !Error; No attacker." ) return end
		if ( !IsValid( inflictor ) ) then DevMsg( "@SciFiElementals : !Warning; No inflictor." ) inflictor = attacker:GetActiveWeapon() return end
		
		if ( target:IsNPC() || target:IsPlayer() ) then
			if ( target:GetNWBool( "edmg_corrosive" ) ~= true ) then
				target:SetNWBool( "edmg_corrosive", true )
				local dps = ents.Create( "dmg_corrosion" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )
				dps:Spawn()
				dps:Activate()
			end
--		else
--			DevMsg( "@SciFiElementals : !Warning; Unexpected entity class defined as target (" .. tostring( target ) .. ") ... Ignoring!" )
		end
		return
	end
	
	if ( element == EML_ICE ) then
		if ( !IsValid( attacker ) ) then DevMsg( "@SciFiElementals : !Error, No attacker." ) return end
		if ( duration == nil ) then duration = 2 end
		
		if ( ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) || target:IsPlayer() ) && ( target:GetMaxHealth() < 150 && target:GetNWBool( "bliz_frozen" ) == false ) then
			if ( target:IsNPC() ) then
				target:SetSchedule( SCHED_NPC_FREEZE )
				target:SetNWBool( "bliz_frozen", true )
			elseif ( target:IsPlayer() ) then
				target:AddFlags( FL_FROZEN )
				target:SetNWBool( "bliz_frozen", true )
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) then
				local ed = EffectData()
				ed:SetOrigin( target:GetPos() )
				ed:SetEntity( target )
				ed:SetScale( duration )
				util.Effect( "cryon_frozen", ed, true, true )
--[[			
				if ( target:IsPlayer() ) then 
					local ed2 = EffectData()
					ed2:SetOrigin( target:GetPos() )
					ed2:SetEntity( target:GetViewModel() )
					ed2:SetScale( duration )
					util.Effect( "cryon_frozen", ed2, true, true )
				end
]]--					
				ParticleEffectAttach( "ice_freezing_shortlt", 1, target, 1 )
			end
			
			timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 1024, function()
				if ( IsValid( target ) ) && ( target:Health() <= 1 && target:GetNWBool( "bliz_frozen" ) == true ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "bliz_frozen", false )
					if ( target:IsNPC() ) then
						target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif ( target:IsPlayer() ) then
						target:RemoveFlags( FL_FROZEN )
					end
					
					ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
					target:EmitSound( snd_stun_ice )
					
					if ( IsValid( attacker ) && IsValid( attacker:GetActiveWeapon() ) ) then
						target:TakeDamage( 5, attacker, attacker:GetActiveWeapon() )
						DoFreezeRagdolls( target:EyePos() )
					end
				end
			end )
			
			timer.Simple( duration, function()
				timer.Destroy( "FakeFrozenThink"..target:EntIndex() )
			end )

			timer.Simple( duration, function()
				if ( IsValid( target ) ) && ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "bliz_frozen", false )
					if ( target:IsNPC() ) then
						target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif( target:IsPlayer() ) then
						target:RemoveFlags( FL_FROZEN )
					end
					ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
					target:EmitSound( snd_stun_ice )
				end
			end )
		end
		return
	end
	
	if ( element == EML_SHOCK ) then
		if ( !isnumber( damage ) ) then 
			damage = 20
		end
		
		if ( IsValid( target ) && target:IsPlayer() ) then
			target:SetArmor( target:Armor() - ( damage * amp ) )
			target:ScreenFade( SCREENFADE.IN, Color( 200, 230, 255, 127 ), 0.5, 0.01 )
			target:EmitSound( snd_stun_shock )
		end
		
		if ( IsValid( target ) && target:IsNPC() && target:GetMaxHealth() < 250 ) then
			target:SetSchedule( SCHED_FAIL )
		end
		
		if ( IsValid( target ) && ( target:GetClass() == "prop_ragdoll" ) ) then
			target:Fire( "StartRagdollBoogie", "", 0 )
		end
	end
	
	if ( element == EML_BLIGHT ) then
		return
	end
	
	if ( element == EML_BLIGHT_ENT ) then
		if ( !IsValid( attacker ) ) then DevMsg( "@SciFiElementals : !Error, No attacker." ) return end
		if ( duration == nil ) then duration = 5 end
		
		if ( ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) || target:IsPlayer() ) && ( target:GetMaxHealth() < 1000 && target:GetNWBool( "fstar_entangled" ) == false ) then
			if ( target:IsNPC() ) then
				target:SetSchedule( SCHED_NPC_FREEZE )
				target:SetNWBool( "fstar_entangled", true )
			elseif ( target:IsPlayer() ) then
				target:AddFlags( FL_FROZEN )
				target:ScreenFade( SCREENFADE.IN, Color( 210, 240, 255, 80 ), duration / 2, duration / 2 )
				target:SetNWBool( "fstar_entangled", true )
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) && ( duration >= 2 ) then
				ParticleEffectAttach( "fstar_freeze_catch", 1, target, 1 )
			end
			
			timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 1024, function()
				if ( IsValid( target ) ) && ( target:Health() <= 1 && target:GetNWBool( "fstar_entangled" ) == true ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "fstar_entangled", false )
					if ( target:IsNPC() ) then
					target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif ( target:IsPlayer() ) then
					target:RemoveFlags( FL_FROZEN )
					end
					
					ParticleEffectAttach( "fstar_freeze_release", 1, target, 1 )
					target:EmitSound( snd_stun_ebl )
					
					if ( IsValid( attacker ) && IsValid( attacker:GetActiveWeapon() ) ) then
						target:TakeDamage( 5, attacker, attacker:GetActiveWeapon() )
					end
				end
			end )
			
			timer.Simple( duration, function()
				timer.Destroy( "FakeFrozenThink"..target:EntIndex() )
			end )

			timer.Simple( duration, function()
				if ( IsValid( target ) ) && ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "fstar_entangled", false )
					if ( target:IsNPC() ) then
					target:SetSchedule( SCHED_FEAR_FACE )
					target:SetSchedule( SCHED_MOVE_AWAY )
					target:SetSchedule( SCHED_BACK_AWAY_FROM_ENEMY )
					target:SetSchedule( SCHED_RUN_FROM_ENEMY )
					elseif( target:IsPlayer() ) then
					target:RemoveFlags( FL_FROZEN )
					end
					ParticleEffectAttach( "fstar_freeze_release", 1, target, 1 )
					target:EmitSound( snd_stun_ebl )
				end
			end )
		end
		return
	end

end

function DoFreezeRagdolls( pos )

	for k, v in pairs ( ents.FindInSphere( pos, 16 ) ) do
		if ( v:GetClass() == "prop_ragdoll" && v:GetNWBool( "IsStatue" ) == false ) then
			local bones = v:GetPhysicsObjectCount()
			v.StatueInfo = {}
			for bone = 1, bones-1 do
				local constraint = constraint.Weld( v, v, 0, bone, 0 )
				
				if ( constraint ) then
						v.StatueInfo[bone] = constraint
				end
				
				local effectdata = EffectData()
				effectdata:SetOrigin( v:GetPhysicsObjectNum( bone ):GetPos() )
				effectdata:SetScale( 1 )
				effectdata:SetMagnitude( 1 )
				util.Effect( "GlassImpact", effectdata, true, true )
			end		
			
			if ( cmd_fx_particles == 1 ) then
				ParticleEffectAttach( "ice_freezing", 1, v, 1 )
			end
				
			v:EmitSound( snd_stun_ice_2 )
			v:SetMaterial( mat_stun_ice )
			v:SetNWBool( "IsStatue", true )

			if ( v:GetPhysicsObject() ~= NULL ) then
				v:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
			end
		end
		
		if ( v:GetClass() == "prop_physics" || v:GetClass() == "prop_dynamic" || v:GetClass() == "player" ) then
			if ( cmd_fx_particles == 1 ) then
				ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
			end
		end
	end

end