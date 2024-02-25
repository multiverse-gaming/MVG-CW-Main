
    --Jump jet's thrusting force
    local JumpJet_JumpForce = 500

    --Handles launching
	hook.Add("KeyPress", "JumpJetKeyPress", function( ply, key )

		--Sanity checking
		if not IsValid( ply ) then return end 

		if not IsFirstTimePredicted() then return end
		--If we don't have a jump jet, none of this matters
		if not ply:GetNWBool( "HasJumpJet", false ) then return end
		if not ply:GetNWBool("CanJumpAgain", false) then return end
		--Can't jump jet if we're on the ground or have already done it
		if ( ply:IsOnGround()) then return end

		if key == IN_JUMP then

			if not ( ply:KeyDown( IN_DUCK ) ) then return end

			--local up = ply:EyeAngles():Up()
			local up = Vector( 0, 0, 1 )


			--Thrust the player into the air
			ply:SetVelocity( ( up * JumpJet_JumpForce) )

			ply:SetNWBool("CanJumpAgain", false)
			hook.Add("PlayerPostThink","jumpjet_how_well_its_doing" .. "_" .. ply:EntIndex(), function(player)
				if player ~= ply then return end
				if not player:GetNWBool( "HasJumpJet", false ) then return end
				if player:GetVelocity().z == 0 then
					player:SetNWBool("CanJumpAgain", true)
					hook.Remove("PlayerPostThink","jumpjet_how_well_its_doing" .. "_" .. ply:EntIndex())
                    hook.Remove("GetFallDamage","stop_fall_damage_one_time" .. "_" .. ply:EntIndex())
				end
					
			end)
			hook.Add("GetFallDamage", "stop_fall_damage_one_time" .. "_" .. ply:EntIndex(), function(player,speed)
				if player ~= ply then return end
				if not player:GetNWBool( "HasJumpJet", false ) then return end
				hook.Remove("GetFallDamage","stop_fall_damage_one_time" .. "_" .. ply:EntIndex())
				return 0 
			end)

			--Make sure we can't jump twice

			--Give us some cinematic view punching
			ply:ViewPunch( Angle( -10, 0, 0 ) )

			--Play sounds
			ply:EmitSound( "ambient/machines/thumper_hit.wav" )
			ply:EmitSound( "ambient/machines/thumper_top.wav" )
			ply:EmitSound( "weapons/ar2/npc_ar2_altfire.wav" )
			ply:EmitSound( "ambient/machines/thumper_dust.wav" )
			ply:EmitSound( "weapons/mortar/mortar_explode1.wav" )

			--Water Ripple
			local effectdata = EffectData()
			effectdata:SetStart( ply:GetPos() )
			effectdata:SetOrigin( ply:GetPos() )
			effectdata:SetEntity( ply )
			effectdata:SetScale( 25 )
			util.Effect( "waterripple", effectdata, true, true )

			--Smoke/Dust
			local effectdata = EffectData()
			effectdata:SetStart( ply:GetPos() )
			effectdata:SetOrigin( ply:GetPos() )
			effectdata:SetColor( 0 )
			effectdata:SetScale( 200 )
			util.Effect( "ThumperDust", effectdata, true, true )

		end
	end )

	--If we die, we lose our jump jet
	hook.Add( "PlayerDeath", "JumpJetPlayerDeath", function( ply ) 

		if not ply:GetNWBool( "HasJumpJet", false ) then return end
		--DarkRP.notify( ply, 1, 3, "Your jump jet has been destroyed!")
		ply:ChatPrint(  "Your jump jet has been destroyed!" )

		--Jump jet explodes
		local vPoint = ply:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin( vPoint )
		util.Effect( "Explosion", effectdata )

		ply:SetNWBool( "HasJumpJet", false )

	end )

    hook.Add("OnPlayerChangedTeam","JumpJetChangedTeam", function( ply )
        if not ply:GetNWBool( "HasJumpJet", false ) then return end
        ply:SetNWBool( "HasJumpJet", false )

    end)


