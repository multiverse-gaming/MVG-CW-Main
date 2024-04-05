wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
	-- This is now the regular Force Breach, but a bit cheaper.
	name = "Master Force Breach",
	icon = "MBR",
	description = "Make the path",
	image = "wos/forceicons/icefuse/breach.png",
	cooldown = 1,
	manualaim = false,
	action = function( self )
		if self:GetForce() < 20 then return end
		local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
		if not IsValid( tr.Entity ) then return end
			local entityClass = tr.Entity:GetClass()
            
			-- Open doors. Not all doors are interactable with e, but the ones that are could be locked.
            if (entityClass == "func_door" || entityClass == "prop_door_rotating" || entityClass == "func_door_rotating") then
                tr.Entity:Fire("unlock", "", 0)
                tr.Entity:Fire("toggle","", 0)
                self:SetForce( self:GetForce() - 20 )
                self:SetNextAttack( 1 )
                return true
			end

			-- Move linears are specfic, can't toggle. Open is probably best.
            if (entityClass == "func_movelinear") then
                tr.Entity:Fire("open","", 0)
                self:SetForce( self:GetForce() - 20 )
                self:SetNextAttack( 1 )
                return true
			end

			-- This one doesn't work great, because a lot of buttons are invisible.
			if (entityClass == "func_button") then
                tr.Entity:Fire("press", "", 0)
                self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
                self:SetForce( self:GetForce() - 20 )
                self:SetNextAttack( 1 )
                return true
			end

			-- Turned off because you're a COWARD ):<
			-- Turn off rayshields, other stuff that can toggle. 
            --[[if (entityClass == "func_brush") then
                tr.Entity:Fire("toggle", "", 0)
                self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
                self:SetForce( self:GetForce() - 25 )
                self:SetNextAttack( 1 )
                return true
			end]]--
		end,
})

wOS.ForcePowers:RegisterNewPower({
    name = "Force Blast",
    icon = "FB",
    distance = 300,
    image = "wos/forceicons/pull.png",
    target = 1,
    cooldown = 120,
    manualaim = true,
    description = "Finish your opponent with raw force",
    action = function( self )
		if self:GetForce() < 100 then return end
        local ent = self:SelectTargets( 1, 300 )[ 1 ]
        if !IsValid( ent ) or !ent:IsPlayer() or ent:Health() > 300 then self:SetNextAttack( 0.2 ) return end
		self:SetForce( self:GetForce() - 100 )

        wOS.ALCS.ExecSys:PerformExecution( self:GetOwner(), ent, "Force Blast" )
        self:SetNextAttack( 1 )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Windus Crush",
    icon = "FC",
    distance = 300,
    image = "wos/forceicons/push.png",
    target = 1,
    cooldown = 120,
    manualaim = true,
    description = "Crush and end your opponent",
    action = function( self )
		if self:GetForce() < 100 then return end
        local ent = self:SelectTargets( 1, 300 )[ 1 ]
        if !IsValid( ent ) or !ent:IsPlayer() or ent:Health() > 300 then self:SetNextAttack( 0.2 ) return end
		self:SetForce( self:GetForce() - 100 )

        wOS.ALCS.ExecSys:PerformExecution( self:GetOwner(), ent, "Force Crush" )
        self:SetNextAttack( 1 )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({ -- This is like a backstab, and only works in close proximity, when cloaked.
    name = "Shadow Strike",
    icon = "SS",
    distance = 30,
    image = "wos/forceicons/shadow_strike.png",
    cooldown = 0,
    target = 1,
    manualaim = false,
    description = "From the darkness it preys",
    action = function( self )
        if !self:GetCloaking() then return end
        local ent = self:SelectTargets( 1, 30 )[ 1 ]
        if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
        if ( self:GetForce() < 50 ) then self:SetNextAttack( 0.2 ) return end
        self:GetOwner():SetSequenceOverride("b_c3_t2", 1)
        self:SetForce( self:GetForce() - 100 )
        self:GetOwner():EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
        self:GetOwner():AnimResetGestureSlot( GESTURE_SLOT_CUSTOM )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        ent:TakeDamage( 500, self:GetOwner(), self )
        self.CloakTime = CurTime() + 0.5
        self:SetNextAttack( 0.7 )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Repulse",
		icon = "R",
		image = "wos/forceicons/repulse.png",
		description = "Hold to charge for greater distance/damage. Push back everything near you.",
		think = function( self )
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 1 ) then return end
			if ( !self:GetOwner():KeyDown( IN_ATTACK2 ) && !self:GetOwner():KeyReleased( IN_ATTACK2 ) ) then return end
			if ( !self._ForceRepulse && self:GetForce() < 16 ) then return end

			if ( !self:GetOwner():KeyReleased( IN_ATTACK2 ) ) then
				if ( !self._ForceRepulse ) then self:SetForce( self:GetForce() - 16 ) self._ForceRepulse = 1 end

				if ( !self.NextForceEffect or self.NextForceEffect < CurTime() ) then
					local ed = EffectData()
					ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 128 * self._ForceRepulse )
					util.Effect( "rb655_force_repulse_in", ed, true, true )

					self.NextForceEffect = CurTime() + math.Clamp( self._ForceRepulse / 20, 0.1, 0.5 )
				end

				self._ForceRepulse = self._ForceRepulse + 0.025
				self:SetForce( self:GetForce() - 0.5 )
				if ( self:GetForce() > 0.99 ) then return end
			else
				if ( !self._ForceRepulse ) then return end
			end

			local maxdist = 128 * self._ForceRepulse

			for i, e in pairs( ents.FindInSphere( self:GetOwner():GetPos(), maxdist ) ) do
				if ( e == self:GetOwner() ) then continue end

				local dist = self:GetOwner():GetPos():Distance( e:GetPos() )
				local mul = ( maxdist - dist ) / 256

				local v = ( self:GetOwner():GetPos() - e:GetPos() ):GetNormalized()
				v.z = 0

				if ( e:IsNPC() && util.IsValidRagdoll( e:GetModel() or "" ) ) then

					local dmg = DamageInfo()
					dmg:SetDamagePosition( e:GetPos() + e:OBBCenter() )
					dmg:SetDamage( 48 * mul )
					dmg:SetDamageType( DMG_GENERIC )
					if ( ( 1 - dist / maxdist ) > 0.8 ) then
						dmg:SetDamageType( DMG_DISSOLVE )
						dmg:SetDamage( e:Health() * 3 )
					end
					dmg:SetDamageForce( -v * math.min( mul * 40000, 80000 ) )
					dmg:SetInflictor( self:GetOwner() )
					dmg:SetAttacker( self:GetOwner() )
					e:TakeDamageInfo( dmg )

					if ( e:IsOnGround() ) then
						e:SetVelocity( v * mul * -2048 + Vector( 0, 0, 64 ) )
					elseif ( !e:IsOnGround() ) then
						e:SetVelocity( v * mul * -1024 + Vector( 0, 0, 64 ) )
					end

				elseif ( e:IsPlayer() && e:IsOnGround() ) then
					e:SetVelocity( v * mul * -2048 + Vector( 0, 0, 64 ) )
				elseif ( e:IsPlayer() && !e:IsOnGround() ) then
					e:SetVelocity( v * mul * -384 + Vector( 0, 0, 64 ) )
				elseif ( e:GetPhysicsObjectCount() > 0 ) then
					for i = 0, e:GetPhysicsObjectCount() - 1 do
						e:GetPhysicsObjectNum( i ):ApplyForceCenter( v * mul * -512 * math.min( e:GetPhysicsObject():GetMass(), 256 ) + Vector( 0, 0, 64 ) )
					end
				end
			end

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
			ed:SetRadius( maxdist )
			util.Effect( "rb655_force_repulse_out", ed, true, true )

			self._ForceRepulse = nil

			self:SetNextAttack( 1 )

			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
		end
})

wOS.ForcePowers:RegisterNewPower({ -- This really isn't clear, but I think it's supposed to grevious animation you towards people.
		name = "Unrelenting Advance",
		icon = "UA",
		image = "wos/forceicons/absorb.png",
		cooldown = 0,
		description = "You spin me right round, baby right round, like a record baby, right round round round",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end
			self:SetForce( self:GetForce() - 0.1 )
			self:GetOwner():SetNW2Float( "wOS.GrievousAnim", CurTime() + 0.6 )
			self:SetNextAttack( 0.3 )
			self:GetOwner():SetNW2Float( "BlockTime", CurTime() + 0.6 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Absorb",
		icon = "A",
		image = "wos/forceicons/absorb.png",
		cooldown = 0,
		description = "Hold Mouse 2 to protect yourself from harm",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end
			self:SetForce( self:GetForce() - 0.1 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.6 )
			self:SetNextAttack( 0.3 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({ -- this might just be charge under a different name.
		name = "Dash",
		icon = "DH",
		image = "wos/forceicons/charge.png",
		cooldown = 0,
		description = "Dash toward your enemies to reach them faster",
		action = function ( self )
			if ( self:GetForce() < 20 || CLIENT ) then return end
			self:SetForce( self:GetForce() - 20 )
			self:SetNextAttack( 2.5 )
			self:GetOwner():SetVelocity( self:GetOwner():GetForward() * 750 + Vector( 0, 0, 100 ) )
			--self:GetOwner():SetVelocity( self:GetOwner():GetForward() * 2000 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetSequence( "dash_forward" )
			return true
		end
})
hook.Add( "PlayerCanJoinTeam", "wOS.Lightsaber.StopTheChoke", function( ply )

    if ply:GetNW2Float( "wOS.ChokeTime", 0 ) >= CurTime() then return false end

end)

local BattlemeditationMVGDamageReduction = false

hook.Add("EntityTakeDamage", "BattlemeditationMVGDamageReductionHook", function(target, dmg)
	if BattlemeditationMVGDamageReduction and target:IsPlayer() then
		dmg:ScaleDamage(0.9)
	end
end)

wOS.ForcePowers:RegisterNewPower({

		name = "Force Blind Dev",

		icon = "FB",

		image = "wos/forceicons/icefuse/blind.png",

		cooldown = 0,

		manualaim = false,

		description = "Make your escape or final blow.",

		action = function( self )

			if ( self:GetForce() < 75 ) then return end

			for _, ply in pairs( ents.FindInSphere( self.Owner:GetPos(), 200 ) ) do

				if not IsValid( ply ) then continue end

				if not ply:IsPlayer() then continue end

				if not ply:Alive() then continue end

				if ply == self.Owner then continue end

				ply:SetNW2Float( "wOS.BlindTime", CurTime() + 15 )
				local coil = ents.Create( "wos_sonic_discharge" )
				coil:SetPos( self.Owner:GetPos() )
				coil:Spawn()
				coil:SetOwner( self.Owner )
			end

			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )

			self:SetForce( self:GetForce() - 75 )

			self:SetNextAttack( 1 )

			return true

		end

})

wOS.ForcePowers:RegisterNewPower({
    name = "Mind Trick",
    icon = "MT",
    image = "wos/forceicons/pull.png",
    cooldown = 60,
    description = "Briefly trick lesser minds",
    action = function( self )
		if self:GetForce() < 100 then return end
		self:SetForce( self:GetForce() - 100 )
		
		self:GetOwner():SetNoTarget(true)
		local jedi = self:GetOwner()
		timer.Simple(10, function()
			jedi:SetNoTarget(false)
		end)

        return true
    end
})

wOS.ForcePowers:RegisterNewPower({

		name = "Force Crumble",

	 icon = "LM",
        distance = 300,
        image = "wos/forceicons/advanced_cloak.png",
        cooldown = 0,
        target = 1,
        manualaim = false,
        description = "Your will be done",
        action = function( self )
            local ent = self:SelectTargets( 1, 300 )[ 1 ]
            if !IsValid( ent ) then ent:SetSequenceOverride( "wos_force_choke") return end
            if ( self:GetForce() < 20 ) then self:SetNextAttack( 1.0 ) return end
            self:SetForce( self:GetForce() - 20 )
            self:SetNextAttack( 1.0 )
            local ed = EffectData()
            ed:SetOrigin( self:GetSaberPosAng() )
            ed:SetEntity( ent )
            util.Effect( "ThumperDust", ed, true, true )

            local dmg = DamageInfo()
            dmg:SetAttacker( self.Owner || self )
            dmg:SetInflictor( self.Owner || self )
            dmg:SetDamage( 15 )
            ent:TakeDamageInfo( dmg )
            self.Owner:EmitSound( Sound( "physics/body/body_medium_break2.wav" ) )
        end


        })

wOS.ForcePowers:RegisterNewPower({

		name = "Force Crush",

	 icon = "LM",
        distance = 200,
        image = "wos/forceicons/rage.png",
        cooldown = 0,
        target = 1,
        manualaim = false,
        description = "Your will be done",
        action = function( self )
            local ent = self:SelectTargets( 1, 200 )[ 1 ]
            ent:EmitSound( "wos/icefuse/choke_start.wav" )
				ent:SetSequenceOverride( "wos_force_crush", 4)
                self.Owner:SetSequenceOverride( "wos_cast_choke_armed", 4)
            if !IsValid( ent ) then --[[ent:SetSequenceOverride( "wos_force_choke")]] return end
            if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.1 ) return end
            self:SetForce( self:GetForce() - 20 )
            self:SetNextAttack( 0.1 )
            local ed = EffectData()
            ed:SetOrigin( self:GetSaberPosAng() )
            ed:SetEntity( ent )
            util.Effect( "ThumperDust", ed, true, true )




				--ent:EmitSound( "wos/icefuse/choke_start.wav" )
				--ent:SetSequenceOverride( "wos_force_crush", 4)
                --self.Owner:SetSequenceOverride( "wos_cast_choke_armed", 4)


            local dmg = DamageInfo()
            dmg:SetAttacker( self.Owner || self )
            dmg:SetInflictor( self.Owner || self )
            dmg:SetDamage( 100 )
            ent:TakeDamageInfo( dmg )
            self.Owner:EmitSound( Sound( "physics/body/body_medium_break2.wav" ) )
        end


        })


    wOS.ForcePowers:RegisterNewPower({

		name = "Force Devastate",

	 icon = "LM",
        distance = 600,
        image = "wos/forceicons/advanced_cloak.png",
        cooldown = 0,
        target = 1,
        manualaim = false,
        description = "Your will be done",
        action = function( self )
            local ent = self:SelectTargets( 1, 600 )[ 1 ]
            if !IsValid( ent ) then ent:SetSequenceOverride( "wos_force_choke") return end
            if ( self:GetForce() < 20 ) then self:SetNextAttack( 1.0 ) return end
            self:SetForce( self:GetForce() - 20 )
            self:SetNextAttack( 1.0 )
            local ed = EffectData()
            ed:SetOrigin( self:GetSaberPosAng() )
            ed:SetEntity( ent )
            util.Effect( "ThumperDust", ed, true, true )

            local dmg = DamageInfo()
            dmg:SetAttacker( self.Owner || self )
            dmg:SetInflictor( self.Owner || self )
            dmg:SetDamage( 60 )
            ent:TakeDamageInfo( dmg )
            self.Owner:EmitSound( Sound( "physics/body/body_medium_break2.wav" ) )
        end
        })

wOS.ForcePowers:RegisterNewPower({
   name = "Force Replace",
        icon = "RP",
        image = "wos/forceicons/group_heal.png",
            cooldown = 5,
        target = 1,
        description = "Strike Up to 4 Enemys",
        action = function(self)
            if CLIENT then return end
            if self:GetForce() < 80 then return end
           local ent = self:SelectTargets( 1, 400 )[ 1 ]
            if !IsValid( ent ) then self:SetNextAttack( 5.0 ) return end
            if ( self:GetForce() < 20 ) then self:SetNextAttack( 5.0 ) return end
            if !ent:IsNPC() and !ent:IsPlayer() then return end
				if not IsValid( self ) then return end
                --Setup damageinfo
            local dmg = DamageInfo()
            dmg:SetDamage( 0 )
            dmg:SetDamageType( DMG_DIRECT )
            dmg:SetInflictor( self.Owner )
            dmg:SetAttacker( self.Owner )

            local Hit = {[ent:EntIndex()] = ent}
            local count = 0
            for x = 1,4 do
                local org = ent:GetPos()
                local sound = CreateSound( ent, Sound( self.SwingSound ) )
                ent:TakeDamageInfo( dmg )
                sound:Play()
                timer.Simple(3.75, function()
                    sound:Stop()
                end)
                    //sound:ChangeVolume( 0, 0 )
                   // ent = nil

                for x,y in pairs(ents.FindInSphere(org, 512) ) do
                    if (y:IsPlayer() or y:IsNPC()) and y != self.Owner and !Hit[y:EntIndex()] then
                        Hit[y:EntIndex()]   = y
                        ent                 = y
                    end
                end

                ent = ent or table.Random(Hit)
                if x == 4 then
                    pos1 = self.Owner:GetPos()
                    pos2 = ent:GetPos()
                    self.Owner:SetPos(pos2)
                    ent:SetPos(pos1)
                end
            end

        end

        })

wOS.ForcePowers:RegisterNewPower({
		name = "Burst of Healing",
		icon = "BH",
		image = "wos/forceicons/heal.png",
		cooldown = 3,
		target = 1,
		manualaim = false,
		description = "Heal yourself.",
		action = function( self )
			if ( self:GetForce() < 60 or self:GetOwner():Health() >= self:GetOwner():GetMaxHealth() or CLIENT ) then return end
			self:SetForce( self:GetForce() - 60 )

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() )
			util.Effect( "rb655_force_heal", ed, true, true )

			self:GetOwner():SetHealth( math.Clamp( self:GetOwner():Health() + 150, 0, self:GetOwner():GetMaxHealth() ) )
			self:GetOwner():Extinguish()
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({ -- This seems like group pull but for 10 instead of 5
		name = "Crowd Pull",
		icon = "GPL",
		target = 50,
		description = "Get over here!",
		image = "wos/forceicons/icefuse/group_pull.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 40 ) then return end
			local foundents = self:SelectTargets( 10 )

			if #foundents < 1 then return end
			for id, ent in pairs( foundents ) do
				local newpos = ( self.Owner:GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*100 + Vector( 0, 0, 300 ) )
				if ent:IsPlayer() then
					local time = ent:SetSequenceOverride( "wos_bs_shared_recover_forward", 2)
				end
			end
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			self:SetForce( self:GetForce() - 40 )
			self:SetNextAttack( 1.5 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({ --  This one... just does more pepple? Bruh
		name = "Crowd Push",
		icon = "GPH",
		target = 50,
		distance = 650,
		description = "They are no harm at a distance",
		image = "wos/forceicons/icefuse/group_push.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 40 ) then return end
			local foundents = self:SelectTargets( 50, 650 )
			if #foundents < 1 then return end
			for id, ent in pairs( foundents ) do
				local newpos = ( self.Owner:GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*-850 + Vector( 0, 0, 300 ) )
				if ent:IsPlayer() then
					local time = ent:SetSequenceOverride( "h_reaction_upper", 2 )
				end
			end
			self:SetForce( self:GetForce() - 40 )
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			self:SetNextAttack( 1.5 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Crowd Lightning",
		icon = "GL",
		target = 10,
		description = "Send a jolt to wake up groups of victims.",
		image = "wos/forceicons/icefuse/group_lightning.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 15 ) then return end

			local foundents = 0
			for id, ent in pairs( self:SelectTargets( 5 ) ) do
				if ( !IsValid( ent ) ) then continue end

				foundents = foundents + 1
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ent )
				util.Effect( "rb655_force_lighting", ed, true, true )

				local dmg = DamageInfo()
				dmg:SetAttacker( self.Owner || self )
				dmg:SetInflictor( self.Owner || self )
				dmg:SetDamage( 25 )

				if ent.IsBlocking then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					if wOS.EnableStamina then
						ent:AddStamina( -5 )
					else
						ent:GetActiveWeapon():SetForce( ent:GetActiveWeapon():GetForce() - 1 )
					end
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					ent:TakeDamageInfo( dmg )
				end
				if ( ent:IsNPC() ) then dmg:SetDamage( 1.6 ) end
			end

			if ( foundents > 0 ) then
				self:SetForce( self:GetForce() - foundents )
				if ( !self.SoundLightning ) then
					self.SoundLightning = CreateSound( self.Owner, "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
					self.SoundLightning:Play()
				else
					self.SoundLightning:Play()
				end
				self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
				timer.Create( "test" .. self.Owner:SteamID64(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			end
			self:SetNextAttack( 0.1 )
			return true
		end,
})


wOS.ForcePowers:RegisterNewPower({ -- This kicks the naming convention and is MORE than the crowd option. Fuck you icefuse.
		name = "Group Lightning",
		icon = "GL",
		target = 10,
		description = "Send a jolt to wake up groups of victims.",
		image = "wos/forceicons/icefuse/group_lightning.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 1 ) then return end

			local foundents = 0
			for id, ent in pairs( self:SelectTargets( 10 ) ) do
				if ( !IsValid( ent ) ) then continue end
				foundents = foundents + 1
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ent )
				util.Effect( "rb655_force_lighting", ed, true, true )

				local dmg = DamageInfo()
				dmg:SetAttacker( self.Owner || self )
				dmg:SetInflictor( self.Owner || self )
				dmg:SetDamage( 20 )

				if ent.IsBlocking then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					if wOS.EnableStamina then
						ent:AddStamina( -5 )
					else
						ent:GetActiveWeapon():SetForce( ent:GetActiveWeapon():GetForce() - 1 )
					end
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					ent:TakeDamageInfo( dmg )
				end
				if ( ent:IsNPC() ) then dmg:SetDamage( 1.6 ) end
			end

			if ( foundents > 0 ) then
				self:SetForce( self:GetForce() - foundents )
				if ( !self.SoundLightning ) then
					self.SoundLightning = CreateSound( self.Owner, "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
					self.SoundLightning:Play()
				else
					self.SoundLightning:Play()
				end
				self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
				timer.Create( "test" .. self.Owner:SteamID64(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			end
			self:SetNextAttack( 0.1 )
			return true
		end,
})


wOS.ForcePowers:RegisterNewPower({
		name = "Force Move",
		icon = "WW",
		description = "That which you harness is all around you",
		image = "wos/forceicons/icefuse/whirlwind.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if self:GetForce() < 1 then return end
			if IsValid( self.WindTarget ) then return end
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			local dist = tr.HitPos:Distance( self.Owner:GetPos() )
			if not tr.Entity then return end
			if dist >= 400 then return end
			self.WindTarget = tr.Entity
			self.WindDistance = dist
		end,

		think = function( self )
			if not IsValid( self.WindTarget ) then return end
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 1 ) then return end
			if self.WindTarget:IsPlayer() and not self.WindTarget:Alive() then self.WindTarget = nil return end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			if ( !self.Owner:KeyReleased( IN_ATTACK2 ) ) then
				--self.WindTarget:SetLocalVelocity( Vector( 0, 0, 0 ) )
				--self.WindTarget:SetPos( ply:EyePos() + ply:GetAimVector()*self.WindDistance )
				local vec = ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )
				local vec2 = ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*2*self.WindDistance  ) - self.WindTarget:GetPos() )
				if self.WindTarget:IsPlayer() or self.WindTarget:IsNPC() then
					self.WindTarget:SetLocalVelocity( vec*10 )
					self.WindTarget:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 0.2 )
				else
					--self.WindTarget:SetVelocity( ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )*30 )
					local phys = self.WindTarget:GetPhysicsObject()
					phys:SetVelocity( vec*10 )
				end

				self:SetForce( self:GetForce() - 0.25 )
				if ( self:GetForce() < 1 ) then
					local ed = EffectData()
					ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 128 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
					self.WindTarget = nil
					self:SetNextAttack( 1 )
					self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
				end

				if self.Owner:KeyReleased( IN_ATTACK ) then
					local ed = EffectData()
					ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 500 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
					self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
					if self.WindTarget:IsPlayer() or self.WindTarget:IsNPC() then
						self.WindTarget:SetLocalVelocity( vec2*10 )
					else
						--self.WindTarget:SetVelocity( ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )*30 )
						local phys = self.WindTarget:GetPhysicsObject()
						phys:SetVelocity( vec2*10 )
					end
					self.WindTarget = nil
					self:SetNextAttack( 1 )
				end
			else
				if not IsValid( self.WindTarget ) then return end
				local ed = EffectData()
				ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
				ed:SetRadius( 128 )
				util.Effect( "rb655_force_repulse_out", ed, true, true )

				self.WindTarget = nil
				self:SetNextAttack( 1 )
				self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Hurl",
		icon = "WW",
		description = "That which you harness is all around you",
		image = "wos/forceicons/icefuse/whirlwind.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if self:GetForce() < 1 then return end
			if IsValid( self.WindTarget ) then return end
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			local dist = tr.HitPos:Distance( self.Owner:GetPos() )
			if not tr.Entity then return end
			if dist >= 400 then return end
			self.WindTarget = tr.Entity
			self.WindDistance = dist
		end,

		think = function( self )
			if not IsValid( self.WindTarget ) then return end
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 1 ) then return end
			if self.WindTarget:IsPlayer() and not self.WindTarget:Alive() then self.WindTarget = nil return end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			if ( !self.Owner:KeyReleased( IN_ATTACK2 ) ) then
				--self.WindTarget:SetLocalVelocity( Vector( 0, 0, 0 ) )
				--self.WindTarget:SetPos( ply:EyePos() + ply:GetAimVector()*self.WindDistance )
				local vec = ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )
				local vec2 = ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*2*self.WindDistance  ) - self.WindTarget:GetPos() )
				if self.WindTarget:IsPlayer() or self.WindTarget:IsNPC() then
					self.WindTarget:SetLocalVelocity( vec*20 )
					self.WindTarget:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 0.2 )
				else
					--self.WindTarget:SetVelocity( ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )*30 )
					local phys = self.WindTarget:GetPhysicsObject()
					phys:SetVelocity( vec*20 )
				end

				self:SetForce(self:GetForce() - 0.25 )
				if ( self:GetForce() < 1 ) then
					local ed = EffectData()
					ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 128 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
					self.WindTarget = nil
					self:SetNextAttack( 1 )
					self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
				end

				if self.Owner:KeyReleased( IN_ATTACK ) then
					local ed = EffectData()
					ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 500 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
					self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
					if self.WindTarget:IsPlayer() or self.WindTarget:IsNPC() then
						self.WindTarget:SetLocalVelocity( vec2*20 )
					else
						--self.WindTarget:SetVelocity( ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )*30 )
						local phys = self.WindTarget:GetPhysicsObject()
						phys:SetVelocity( vec2*20 )
					end
					self.WindTarget = nil
					self:SetNextAttack( 1 )
				end
			else
				if not IsValid( self.WindTarget ) then return end
				local ed = EffectData()
				ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
				ed:SetRadius( 128 )
				util.Effect( "rb655_force_repulse_out", ed, true, true )

				self.WindTarget = nil
				self:SetNextAttack( 1 )
				self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			end
		end
})


wOS.ForcePowers:RegisterNewPower({
		name = "Force Whirlwind",
		icon = "WW",
		description = "That which you harness is all around you",
		image = "wos/forceicons/icefuse/whirlwind.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )
			if self:GetForce() < 1 then return end
			if IsValid( self.WindTarget ) then return end
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			local dist = tr.HitPos:Distance( self.Owner:GetPos() )
			if not tr.Entity then return end
			if dist >= 400 then return end
			self.WindTarget = tr.Entity
			self.WindDistance = dist
		end,
		think = function( self )
			if not IsValid( self.WindTarget ) then return end
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 1 ) then return end
			if self.WindTarget:IsPlayer() and not self.WindTarget:Alive() then self.WindTarget = nil return end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			if ( !self.Owner:KeyReleased( IN_ATTACK2 ) ) then
				--self.WindTarget:SetLocalVelocity( Vector( 0, 0, 0 ) )
				--self.WindTarget:SetPos( ply:EyePos() + ply:GetAimVector()*self.WindDistance )
				local vec = ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )
				local vec2 = ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*2*self.WindDistance  ) - self.WindTarget:GetPos() )
				if self.WindTarget:IsPlayer() or self.WindTarget:IsNPC() then
					self.WindTarget:SetLocalVelocity( vec*60 )
					self.WindTarget:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 0.2 )
				else
					--self.WindTarget:SetVelocity( ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )*30 )
					local phys = self.WindTarget:GetPhysicsObject()
					phys:SetVelocity( vec*20 )
				end

				self:SetForce( self:GetForce() - 0.25 )
				if ( self:GetForce() < 1 ) then
					local ed = EffectData()
					ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 128 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
					self.WindTarget = nil
					self:SetNextAttack( 1 )
					self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
				end

				if self.Owner:KeyReleased( IN_ATTACK ) then
					local ed = EffectData()
					ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 500 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
					self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
					if self.WindTarget:IsPlayer() or self.WindTarget:IsNPC() then
						self.WindTarget:SetLocalVelocity( vec2*60 )
					else
						--self.WindTarget:SetVelocity( ( ( self.Owner:EyePos() + self.Owner:GetAimVector()*self.WindDistance  ) - self.WindTarget:GetPos() )*30 )
						local phys = self.WindTarget:GetPhysicsObject()
						phys:SetVelocity( vec2*60 )
					end
					self.WindTarget = nil
					self:SetNextAttack( 1 )
				end
			else
				if not IsValid( self.WindTarget ) then return end
				local ed = EffectData()
				ed:SetOrigin( self.WindTarget:GetPos() + Vector( 0, 0, 36 ) )
				ed:SetRadius( 128 )
				util.Effect( "rb655_force_repulse_out", ed, true, true )

				self.WindTarget = nil
				self:SetNextAttack( 1 )
				self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Destruction",
		icon = "DES",
		description = "Hold to unleash true power on your enemies",
		image = "wos/forceicons/icefuse/destruction.png",
		cooldown = 0,
		manualaim = false,
		think = function( self )
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 1 ) then return end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			if ( !self._ForceDestruction && self:GetForce() < 50 ) then return end

			if ( !self.Owner:KeyReleased( IN_ATTACK2 ) ) then
				if ( !self._ForceDestruction ) then self:SetForce( self:GetForce() - 50 ) self._ForceDestruction = 5 end
				self._ForceDestruction = self._ForceDestruction + 1
				self:SetForce( self:GetForce() - 2 )
				if ( self:GetForce() > 0.99 ) then return end
			else
				if ( !self._ForceDestruction ) then return end
			end

			self.Owner:EmitSound( Sound( "npc/strider/charging.wav" ) )
			self.Owner:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 2 )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 2 )
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			local pos = tr.HitPos + Vector( 0, 0, 600 )
			local pi = math.pi
			local max = self._ForceDestruction
			local bullet = {}
			bullet.Num 		= 1
			bullet.Spread 	= 0
			bullet.Tracer	= 1
			bullet.Force	= 0
			bullet.Damage	= 500
			bullet.AmmoType = "Pistol"
			bullet.Entity = self.Owner
			bullet.TracerName = "thor_storm"
			bullet.Callback = function( ply, tr, dmginfo )
				sound.Play( "npc/strider/fire.wav", tr.HitPos )
			end
			timer.Simple( 2, function()
				if not IsValid( self ) then return end
				bullet.Src 		= pos
				bullet.Dir 		= Vector( 0, 0, -1 )
				self.Owner:FireBullets( bullet )
				for i=1, max do
					timer.Simple( 0.1*i, function()
						if not IsValid( self ) then return end
						local dis = i + i*30
						if not IsValid( self.Owner ) then return end
						bullet.Src 		= pos + Vector( dis*math.sin( i*pi*1/8 ), dis*math.cos( i*pi*1/8 ), 0 )
						bullet.Dir 		= Vector( 0, 0, -1 )
						self.Owner:FireBullets( bullet )
						bullet.Src 		= pos + Vector( dis*math.sin( i*pi*3/8 ), dis*math.cos( i*pi*3/8 ), 0 )
						bullet.Dir 		= Vector( 0, 0, -1 )
						self.Owner:FireBullets( bullet )
						bullet.Src 		= pos + Vector( dis*math.sin( i*pi*5/8 ), dis*math.cos( i*pi*5/8 ), 0 )
						bullet.Dir 		= Vector( 0, 0, -1 )
						self.Owner:FireBullets( bullet )
						bullet.Src 		= pos + Vector( dis*math.sin( i*pi*7/8 ), dis*math.cos( i*pi*7/8 ), 0 )
						bullet.Dir 		= Vector( 0, 0, -1 )
						self.Owner:FireBullets( bullet )
					end )
				end
			end )
			self._ForceDestruction = nil
			self:SetNextAttack( 3 )
		end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Group Choke",
		icon = "GCH",
		description = "Choke them all",
		image = "wos/forceicons/icefuse/choke.png",
		cooldown = 0,
		manualaim = false,
		distance = 400,
		target = 10,
		action = function( self )
			if self:GetForce() < 1 then return end
			if self.IsGroupChoking then return end
			local foundents = self:SelectTargets( 10, 400 )
			if #foundents < 1 then return end
			self.ChokeTargets = {}
			self.ChokePoss = {}
			for id, ent in pairs( foundents ) do
				if not ent:IsPlayer() then continue end
				self.ChokeTargets[ id ] = ent
				ent:EmitSound( "wos/icefuse/choke_start.wav" )
				ent:SetSequenceOverride( "wos_force_choke", 4)
                self.Owner:SetSequenceOverride( "wos_cast_choke_armed", 4)
				self.ChokePoss[ id ] = ent:GetPos()
			end
		end,

		think = function( self )
			if not self.ChokeTargets then self.IsGroupChoking = false return end
			if ( self:GetNextSecondaryFire() > CurTime() ) then self.IsGroupChoking = false return end
			if ( self:GetForce() < 1 ) then self.IsGroupChoking = false return end
			if #self.ChokeTargets < 1 then self.IsGroupChoking = false return end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			self.Owner:SetNW2Float( "wOS.IceForceAnim", CurTime() + 0.5 )
			if ( !self.Owner:KeyReleased( IN_ATTACK2 ) ) then
			self:SetForce( self:GetForce() - 0.02 )
			if ( !self.SoundChoking ) then
				self.SoundChoking = CreateSound( self.Owner, "wos/icefuse/choke_active.wav" )
				self.SoundChoking:PlayEx( 0.25, 100 )
			else
				self.SoundChoking:PlayEx( 0.25, 100 )
			end
			timer.Create( "test" .. self.Owner:SteamID64() .. "_choke", 0.2, 1, function() if ( self.SoundChoking ) then self.SoundChoking:Stop() self.SoundChoking = nil end end )
			self.IsGroupChoking = true
				for id, ply in pairs( self.ChokeTargets ) do
					if not IsValid( ply ) then self.ChokeTargets[ id ] = nil continue end
					if not ply:Alive() then self.ChokeTargets[ id ] = nil continue end
					local dmg = DamageInfo()
					dmg:SetDamage( 0.4 ) --0.21
					dmg:SetDamageType( DMG_CRUSH )
					dmg:SetAttacker( self.Owner )
					dmg:SetInflictor( self )
					ply:TakeDamageInfo( dmg )
					ply:SetLocalVelocity( ( self.ChokePoss[ id ] - ply:GetPos() + Vector( 0, 0, 55 ) )*5 )
					ply:SetPos( Vector( self.ChokePoss[id].x, self.ChokePoss[id].y, math.min( ply:GetPos().z + 0.5, self.ChokePoss[id].z + 55 ) ) )
					ply:SetLocalVelocity( Vector( 0, 0, 100 ) )
					ply:SetNW2Float( "wOS.ChokeTime", CurTime() + 0.5 )
					ply:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 0.5 )
					self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.1 )
					if ( !ply.SoundGagging ) then
						ply.SoundGagging = CreateSound( ply, "wos/icefuse/choke_gagging.wav" )
						ply.SoundGagging:Play()
					else
						ply.SoundGagging:Play()
					end
					timer.Create( "test" .. ply:SteamID64(), 0.2, 1, function() if ( ply.SoundGagging ) then ply.SoundGagging:Stop() ply.SoundGagging = nil end end )

					if ( self:GetForce() < 1 ) then
						self.ChokeTargets = {}
						self:SetNextAttack( 1 )
						self.IsGroupChoking = false
						return
					end
				end
			else
				self.ChokeTargets = {}
				self:SetNextAttack( 1 )
				self.IsGroupChoking = false
			end
		end
})

wOS.ForcePowers:RegisterNewPower({ -- This swaps peoples locaiton.
    name = "Force Swap",
    icon = "FS",
    image = "wos/forceicons/group_heal.png",
    cooldown = 5,
    target = 1,
    description = "Swap location with your target",
    action = function(self)
    if CLIENT then return end
    if self:GetForce() < 80 then return end
    local ent = self:SelectTargets( 1, 600 )[ 1 ]
    if !IsValid( ent ) then self:SetNextAttack( 1.0 ) return end
    if ( self:GetForce() < 20 ) then self:SetNextAttack( 1.0 ) return end
    if !ent:IsNPC() and !ent:IsPlayer() then return end
    if not IsValid( self ) then return end

    --Setup damageinfo
    local dmg = DamageInfo()
    dmg:SetDamage( 0 )
    dmg:SetDamageType( DMG_DIRECT )
    dmg:SetInflictor( self.Owner )
    dmg:SetAttacker( self.Owner )

    local Hit = {[ent:EntIndex()] = ent}
    local count = 0
    for x = 1,4 do
        local org = ent:GetPos()
        local sound = CreateSound( ent, Sound( self.SwingSound ) )
        ent:TakeDamageInfo( dmg )
        sound:Play()
        timer.Simple(0.75, function()
            sound:Stop()
        end)
        //sound:ChangeVolume( 0, 0 )
        // ent = nil
 
        for x,y in pairs(ents.FindInSphere(org, 512) ) do
            if (y:IsPlayer() or y:IsNPC()) and y != self.Owner and !Hit[y:EntIndex()] then
                Hit[y:EntIndex()]   = y
                ent                 = y
            end
        end
 
        ent = ent or table.Random(Hit)
        if x == 4 then
            pos1 = self.Owner:GetPos()
            pos2 = ent:GetPos()
            self.Owner:SetPos(pos2)
            ent:SetPos(pos1)
            end
        end
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Focussed Ground Slam",
		icon = "FGS",
		texture = "star/icon/ground_slam.png",
        cooldown = 40,
		description = "Shocks and destroys everything around you - carefully",
		action = function( self )
			if ( self:GetForce() < 60 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			local elev = 400
			local time = 1
			ent = self:GetOwner()

			self:SetForce(self:GetForce() - 100)
			self:SetNextAttack( 20 )

			for j = 0,6 do
				for i = 0, 24 do
					local ed = EffectData()
					ed:SetOrigin( self:GetOwner():GetPos() + Vector(0,0,0) )
					ed:SetStart( self:GetOwner():GetPos() + Vector(0,0,0) + Angle(0 , i * 15, 0):Forward() * 128)
					util.Effect( "force_groundslam", ed, true, true )
				end
			end

			local maxdist = 128

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
			ed:SetRadius( maxdist )
			util.Effect( "judge_h_s2_t3", ed, true, true )
			for i, e in pairs( ents.FindInSphere( self:GetOwner():GetPos(), maxdist ) ) do
			if(e == self:GetOwner()) then continue end
			--if (e.Team and e:Team() == self:GetOwner():Team()) or (e.PlayerTeam and e.PlayerTeam == self:GetOwner():Team()) then continue end

				local dist = self:GetOwner():GetPos():Distance( e:GetPos() )
				local mul = ( maxdist - dist ) / 256

				local v = ( self:GetOwner():GetPos() - e:GetPos() ):GetNormalized()
				v.z = 0

				local dmg = DamageInfo()
				dmg:SetDamagePosition( e:GetPos() + e:OBBCenter() )
				dmg:SetDamage( 600 * mul )
				dmg:SetDamageType( DMG_DISSOLVE )
				dmg:SetDamageForce( -v * math.min( mul * 20000, 40000 ) )
				dmg:SetInflictor( self:GetOwner() )
				dmg:SetAttacker( self:GetOwner() )
				e:TakeDamageInfo( dmg )

				if ( e:IsOnGround() ) then
					e:SetVelocity( v * mul * -2048 + Vector( 0, 0, 64 ) )
				elseif ( !e:IsOnGround() ) then
					e:SetVelocity( v * mul * -1024 + Vector( 0, 0, 64 ) )
				end
			end

			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
				self.SoundLightning:Play()
				self.SoundLightning:ChangeVolume(0,0.3)
			else
				self.SoundLightning:Play()
			end
			timer.Create( "test", 0.6, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )

			self:PlayWeaponSound( "ambient/explosions/explode_7.wav" )
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Unnerfed Fold Space",
		icon = "TP",
		description = "Phase to a new location.",
		image = "wos/forceicons/icefuse/teleport.png",
		cooldown = 12,
		manualaim = false,
		think = function( self )
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 100 ) then return end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			if self.Owner:KeyReleased( IN_ATTACK2 ) and self.groundTrace then
				local speed = 4000;
				local bFoundEdge = false;

				self.Owner:SetNW2Float("wOS.ShowBlink", 0 );
				local hullTrace = util.TraceHull({
					start = self.Owner:EyePos(),
					endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 2400,
					filter = self.Owner,
					mins = Vector(-16, -16, 0),
					maxs = Vector(16, 16, 9)
				});

				local groundTrace = util.TraceEntity({
					start = hullTrace.HitPos + Vector(0, 0, 1),
					endpos = hullTrace.HitPos - (self.Owner:EyePos() - self.Owner:GetPos()),
					filter = self.Owner
				}, self.Owner);

				local edgeTrace;
				if (hullTrace.Hit and hullTrace.HitNormal.z <= 0) then
					local ledgeForward = Angle(0, hullTrace.HitNormal:Angle().y, 0):Forward();
					edgeTrace = util.TraceEntity({
						start = hullTrace.HitPos - ledgeForward * 33 + Vector(0, 0, 40),
						endpos = hullTrace.HitPos - ledgeForward * 33,
						filter = self.Owner
					}, self.Owner);

					if (edgeTrace.Hit and !edgeTrace.AllSolid) then
						local clearTrace = util.TraceHull({
							start = hullTrace.HitPos,
							endpos = hullTrace.HitPos + Vector(0, 0, 35),
							mins = Vector(-16, -16, 0),
							maxs = Vector(16, 16, 1),
							filter = self.Owner
						});
						bFoundEdge = !clearTrace.Hit;
					end;
				end;

				if (!bFoundEdge and groundTrace.AllSolid) then
					self.groundTrace = nil
					self:SetNextSecondaryFire( CurTime() + 1 )
					return;
				end;

				local endPos = ( bFoundEdge and edgeTrace.HitPos ) or groundTrace.HitPos;
				self.Owner:SetPos( endPos )
				self.Owner:EmitSound("ambient/energy/zap" .. math.random(1, 2) .. ".wav");

				self.groundTrace = nil
				self:SetForce( self:GetForce() - 100 )
				self:SetNextSecondaryFire( CurTime() + 1 )
				return
			end;

			if self.Owner:KeyDown( IN_ATTACK2 ) then
				local bFoundEdge = false;
				self.Owner:SetNW2Float( "wOS.ShowBlink", CurTime() + 0.5 )
				local hullTrace = util.TraceHull({
					start = self.Owner:EyePos(),
					endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 2400,
					filter = self.Owner,
					mins = Vector(-16, -16, 0),
					maxs = Vector(16, 16, 9)
				});

				self.groundTrace = util.TraceHull({
					start = hullTrace.HitPos + Vector(0, 0, 1),
					endpos = hullTrace.HitPos - Vector(0, 0, 1000),
					filter = self.Owner,
					mins = Vector(-16, -16, 0),
					maxs = Vector(16, 16, 1)
				});

				local edgeTrace;

				if (hullTrace.Hit and hullTrace.HitNormal.z <= 0) then
					local ledgeForward = Angle(0, hullTrace.HitNormal:Angle().y, 0):Forward();
					edgeTrace = util.TraceEntity({
						start = hullTrace.HitPos - ledgeForward * 33 + Vector(0, 0, 40),
						endpos = hullTrace.HitPos - ledgeForward * 33,
						filter = self.Owner
					}, self.Owner);

					if (edgeTrace.Hit and !edgeTrace.AllSolid) then
						local clearTrace = util.TraceHull({
							start = hullTrace.HitPos,
							endpos = hullTrace.HitPos + Vector(0, 0, 35),
							mins = Vector(-16, -16, 0),
							maxs = Vector(16, 16, 1),
							filter = self.Owner
						});

						if (!clearTrace.Hit) then
							self.groundTrace.HitPos = edgeTrace.HitPos;
							bFoundEdge = true;
						end;
					end;
				end;
			end
		end,
})