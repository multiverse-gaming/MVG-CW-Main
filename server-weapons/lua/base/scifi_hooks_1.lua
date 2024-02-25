

AddCSLuaFile()

hook.Add( "PlayerDeath", "AutoExtinguish_0", function( player )
	
	for k,v in pairs ( ents.FindInSphere( player:GetPos(), 128 ) ) do
		if ( v:GetOwner() == player || v == player ) then 
			v:Extinguish()
		end
	end

end )

local cmd_fx_firelight = GetConVarNumber( "sfw_allow_firelightemission" )

hook.Add( "Think", "scififirefx", function()

	if ( CLIENT ) && ( cmd_fx_firelight >= 1 ) then
		for k,v in pairs ( ents.GetAll() ) do
			if ( v:IsOnFire() ) then
				local pos = v:GetPos()
				local dlight = DynamicLight( v:EntIndex() + 2048 )
				
				if ( dlight ) then
					dlight.pos = pos
					dlight.r = 255
					dlight.g = 90
					dlight.b = 25
					dlight.brightness = 1.4
					dlight.Decay = 2048
					dlight.Style = 1
					dlight.DieTime = CurTime() + 1
					
					local phys = v:GetPhysicsObject()
					
					if ( IsValid( phys ) ) then
						local size = phys:GetMass()
						dlight.Size = 18 * size
					else
						dlight.Size = 320
					end
				end
			end
		end
	end

end )

hook.Add( "EntityTakeDamage", "SciFiDmgBuff", function( ent, dmginfo )

	if ( dmginfo:GetAttacker():GetNWBool( "SciFiDmgBuff" ) == true ) then
		--if ( SERVER ) then
			dmginfo:SetDamage( dmginfo:GetDamage() * 5 )
			dmginfo:SetDamageBonus( dmginfo:GetDamageBonus() * 5 )
			if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then
				ParticleEffect( "vh_hit", dmginfo:GetDamagePosition(), Angle( 0, 0, 0 ), ent )
			end
		--end
	end

end )

hook.Add( "OnNPCKilled", "NewElementalsSafeDissolve", function( npc, attacker, inflictor )

	if ( !IsValid( inflictor ) || !IsValid( attacker ) ) then return end

	if ( SERVER ) && ( inflictor:GetClass() == "sfw_seraphim" ) then
		local tpos = npc:EyePos()
		DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Attacker = attacker, Origin = tpos, Range = 72, Ticks = 24 } )
	end

	if ( SERVER ) && ( inflictor:GetClass() == "sfw_aquamarine" ) then
		local tpos = npc:EyePos()
		DoElementalEffect( { Element = EML_DISSOLVE_VAPOR, Attacker = attacker, Origin = tpos, Range = 72, Ticks = 24 } )
	end

end )

hook.Add( "OnNPCKilled", "NeutrinoSafeDissolve", function( npc, attacker, inflictor )

	if ( inflictor == NULL ) or ( attacker == NULL ) or ( npc == NULL ) then return end

	if ( inflictor:GetClass() == "sfw_neutrino" ) or ( inflictor:GetClass() == "sfw_custom" && GetConVarNumber( "sfw_cw_pfire_tech" ) == "neutrino" ) then

		if ( GetConVarNumber( "sfw_allow_dissolve" ) == 1 ) then 
		
			if ( npc == NULL ) or ( npc:GetPos() == nil ) then return end
			
			local origin = npc:GetPos()
			
			timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, 50, function() 
				
				for k, v in pairs ( ents.FindInSphere( origin, 80 ) ) do
				
					if ( v ~= NULL ) and ( v:GetOwner():IsPlayer() ) and ( v:GetOwner() ~= attacker ) then return end
					
					if ( v:GetClass() == "prop_ragdoll" ) and ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					
						v:SetNWBool( "IsVaporizing", true )
						local phys = v:GetPhysicsObject()
						local bones = v:GetPhysicsObjectCount()
						local b = v:GetNWBool( "gravity_disabled" )

						for  i=0, bones-1 do
							local grav = v:GetPhysicsObjectNum( i )
							if ( IsValid( grav ) ) then
								grav:EnableGravity( b )
							end
						end
						
						if ( !IsValid( phys ) ) then v:Remove() return end
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 20 )
						
						v:DrawShadow( false )
						v:SetNoDraw( false )
						v:SetMaterial( "models/elemental/burned" )
						v:SetRenderMode( RENDERMODE_TRANSADD )
						v:SetColor( Color( 20, 100, 0, 175 ) )
						v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
						v:EmitSound( "scifi.neutrino.dissolve" )
						v:Fire( "kill", "", 1 )
						
						if ( GetConVarNumber( "sfw_fx_particles" ) == 0 ) then
							ParticleEffectAttach( "nio_dissolve_cheap", 1, v, -1 ) 
						else
							ParticleEffectAttach( "nio_dissolve", 1, v, -1 ) 
						end
						
						local dslfx = ents.Create( "light_dynamic" )
						if ( !IsValid( dslfx ) ) then return end
						dslfx:SetKeyValue( "_light", "85 255 0 255" )
						dslfx:SetKeyValue( "spotlight_radius", 320 )
						dslfx:SetKeyValue( "distance", 420 )
						dslfx:SetKeyValue( "brightness", 1 )
						dslfx:SetKeyValue( "style", 1 )
						dslfx:SetPos( v:GetPos() )
						dslfx:SetParent( v )
						dslfx:Spawn()
						DLightFade( dslfx, 0, 600, 5.4, 0.9 )
						SafeRemoveEntityDelayed( dslfx, 4 )
						
					end
					
				end
				
				timer.Destroy( "dissolve" .. attacker:EntIndex() )
				
			end )
			
		end
	
	end

end )

hook.Add( "EntityTakeDamage", "SaphLifeSteal", function( ent, dmginfo )

	local attacker 	= dmginfo:GetAttacker()
	local saphyre 	= dmginfo:GetInflictor()
	
	if ( !IsValid( saphyre ) || saphyre:GetClass() ~= "saph_pfire" ) then return end
	local owner 	= saphyre:GetOwner()
	
	if ( SERVER ) then

	if ( ent ~= NULL && saphyre ~= NULL ) and ( ent ~= owner && dmginfo:GetDamageType() == bit.bor( DMG_RADIATION, DMG_GENERIC ) ) then

		if ( IsValid( owner ) ) && ( ent:IsNPC() || ent:IsPlayer() ) then
		
			local healthamt = math.Clamp( attacker:Health() + dmginfo:GetDamage() / math.random( 0.45, 2.8 ), 0 , attacker:GetMaxHealth() )
			
			if ( healthamt > 0 && attacker:Health() <= attacker:GetMaxHealth() ) then
			attacker:SetHealth( healthamt )
			end
			
			if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
				util.ParticleTracerEx( 
					"saphyre_absorb",
					saphyre:GetPos(),
					owner:EyePos() - Vector( 0, 0, 10 ),
					false,
					0,
					-1
				)
			end
			
		end
		
	end
	
	end

end )