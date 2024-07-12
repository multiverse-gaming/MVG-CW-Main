wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({ -- This is like a backstab, and only works in close proximity, when cloaked.
    name = "Shadow Strike",
    icon = "SS",
    distance = 30,
    image = "wos/forceicons/shadow_strike.png",
    cooldown = 15,
    target = 1,
    manualaim = false,
    description = "From the darkness it preys",
    action = function( self )
        if !self:GetCloaking() then return end
        local ent = self:SelectTargets( 1, 30 )[ 1 ]
        if (!IsValid( ent ) || !ent:IsPlayer()) then return end
        if ( self:GetForce() < 50 ) then return end
        self:GetOwner():SetSequenceOverride("b_c3_t2", 0.4)
        self:SetForce( self:GetForce() - 50 )
        self:GetOwner():EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
        self:GetOwner():AnimResetGestureSlot( GESTURE_SLOT_CUSTOM )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        ent:TakeDamage( 400, self:GetOwner(), self )
		
		ent:SetNW2Float( "wOS.BlindTime", CurTime() + 6 )
		ent:SetNW2Float( "wOS.DisorientTime", CurTime() + 1 )
		ent:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 1 )
		ent.WOS_CripplingSlow = CurTime() + 2
		
        self.CloakTime = CurTime() + 0.2
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sith Cloak",
		icon = "SC",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 45,
		description = "Shrowd yourself with the force.",
		action = function( self )
			if (self:GetCloaking()) then
				-- If cloaking, go on CD and turn cloak off so you can attack.
				self.CloakTime = CurTime()
				self:GetOwner():SetNoTarget(false)
				timer.Remove("wos.Custom.Cloaking." .. self:GetOwner():SteamID64())
				return true
			end
			if ( self:GetForce() < 50) then return end

			self:SetForce( self:GetForce() - 25 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			self.CloakTime = CurTime() + 3600
			-- Look up timer.Create and see delay and repitions in the arguments. You will see why it's like this.
			timer.Create("wos.Custom.Cloaking." .. self:GetOwner():SteamID64(), 0.25, 0, function() 
				if self:GetCloaking() then 
					if (self:GetForce() <= 1) then
						-- If out of force, turn cloak off.
						self.CloakTime = CurTime()
						timer.Remove("wos.Custom.Cloaking." .. self:GetOwner():SteamID64())
						do return end
					end

					if self.Owner:GetVelocity():Length() > 130 then
						self:SetForce( self:GetForce() - 2 )
					elseif self.Owner:GetVelocity():Length() > 40 then
						self:SetForce( self:GetForce() - 1 )
					end
				end	
			end)
		end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Channel Hatred",
    icon = "HT",
    image = "wos/forceicons/channel_hatred.png",
    description = "I can feel your anger",
    think = function( self )
        if self.ChannelCooldown and self.ChannelCooldown >= CurTime() then return end
        if ( self:GetOwner():KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self:GetOwner():OnGround() then
            self._ForceChanneling = true
        else
            self._ForceChanneling = false
        end
        if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
            self.ChannelCooldown = CurTime() + 3
        end
        if self._ForceChanneling then
            if not self._NextChannelHeal then self._NextChannelHeal = 0 end
            self:SetMeditateMode( 2 )
            if self._NextChannelHeal < CurTime() then
                self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*0.01 ), self:GetOwner():GetMaxHealth() ) )
                if #self.DevestatorList > 0 then
                    self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge )
                end
                local tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ]
                if not tbl then
                    tbl = wOS.ALCS.Config.Skills.ExperienceTable[ "Default" ].Meditation
                else
                    tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ].Meditation
                end
                self:GetOwner():AddSkillXP( tbl )
                self._NextChannelHeal = CurTime() + 3
            end
            self:GetOwner():SetLocalVelocity(Vector(0, 0, 0))
            self:GetOwner():SetMoveType(MOVETYPE_NONE)
            if ( !self.SoundChanneling ) then
                self.SoundChanneling = CreateSound( self:GetOwner(), "ambient/levels/citadel/field_loop1.wav" )
                self.SoundChanneling:Play()
            else
                self.SoundChanneling:Play()
            end

            timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundChanneling ) then self.SoundChanneling:Stop() self.SoundChanneling = nil end end )
        else
            self:SetMeditateMode( 0 )
            if self:GetMoveType() != MOVETYPE_WALK and self:GetOwner():GetNW2Float( "wOS.DevestatorTime", 0 ) < CurTime() then
                self:GetOwner():SetMoveType(MOVETYPE_WALK)
            end
        end
        if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
            self.ChannelCooldown = CurTime() + 3
        end
    end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Sith Force Push",
	icon = "WFP",
	target = 1,
	distance = 150,
	description = "Hurl your opponent for 100 damage",
	image = "wos/forceicons/pull.png",
	cooldown = 8,
	manualaim = false,
	action = function( self )
		if ( self:GetForce() < 50 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) then return end
		self:SetForce( self:GetForce() - 50 )
		self:PlayWeaponSound( "lightsaber/force_repulse.wav" )

		local dmg = DamageInfo()
		dmg:SetAttacker( self:GetOwner() || self )
		dmg:SetInflictor( self:GetOwner() || self )
		dmg:SetDamageType( DMG_DISSOLVE )
		dmg:SetDamage( 100 )
		ent:TakeDamageInfo( dmg )
		local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
		newpos = newpos / newpos:Length()
		ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
		self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sith Group Push",
		icon = "SPH",
		target = 50,
		distance = 650,
		description = "Push and damage everyone in front of you for 75",
		image = "wos/forceicons/icefuse/group_push.png",
		cooldown = 16,
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

				local dmg = DamageInfo()
				dmg:SetAttacker( self:GetOwner() || self )
				dmg:SetInflictor( self:GetOwner() || self )
				dmg:SetDamageType( DMG_DISSOLVE )
				dmg:SetDamage( 75 )
				ent:TakeDamageInfo( dmg )
			end
			self:SetForce( self:GetForce() - 40 )
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Storm",
		icon = "STR",
		image = "wos/forceicons/storm.png",
		cooldown = 0,
		description = "Charge for 2 seconds, unleash a storm on your enemies",
		action = function( self )
			if ( self:GetForce() < 100 ) then self:SetNextAttack( 0.2 ) return end
			if self:GetAttackDelay() >= CurTime() then return end
			self:SetForce( self:GetForce() - 100 )
			self:GetOwner():EmitSound( Sound( "npc/strider/charging.wav" ) )
			self:SetAttackDelay( CurTime() + 1 )
			local tr = util.TraceLine( util.GetPlayerTrace( self:GetOwner() ) )
			local pos = tr.HitPos + Vector( 0, 0, 600 )
			local pi = math.pi
			local bullet = {}
			bullet.Num 		= 1
			bullet.Spread 	= 0
			bullet.Tracer	= 1
			bullet.Force	= 0
			bullet.Damage	= 500
			bullet.AmmoType = "Pistol"
			bullet.Entity = self:GetOwner()
			bullet.TracerName = "thor_storm"
			timer.Simple( 2, function()
				if not IsValid( self:GetOwner() ) then return end
				self:GetOwner():EmitSound( Sound( "ambient/atmosphere/thunder1.wav" ) )
				bullet.Src 		= pos
				bullet.Dir 		= Vector( 0, 0, -1 )
				self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
				self:GetOwner():FireBullets( bullet )
				timer.Simple( 0.1, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*2/5 ), 65*math.cos( pi*2/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.2, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*4/5 ), 65*math.cos( pi*4/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.3, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*6/5 ), 65*math.cos( pi*6/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.4, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*8/5 ), 65*math.cos( pi*8/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.5, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( 2*pi ), 65*math.cos( 2*pi ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
			end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Combust",
		icon = "C",
		target = 1,
		description = "Ignite stuff infront of you.",
		image = "wos/forceicons/combust.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )

			local ent = self:SelectTargets( 1 )[ 1 ]

			if ( !IsValid( ent ) or ent:IsOnFire() ) then self:SetNextAttack( 0.2 ) return end

			local time = math.Clamp( 512 / self:GetOwner():GetPos():Distance( ent:GetPos() ), 1, 16 )
			local neededForce = math.ceil( math.Clamp( time * 2, 10, 32 ) ) -- huh? what does this even do? further away = less fire = less force?

			if ( self:GetForce() < neededForce ) then self:SetNextAttack( 0.2 ) return end

			ent:Ignite( time, 0 )
			self:SetForce( self:GetForce() - neededForce )

			self:SetNextAttack( 1 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Lightning Stream",
	icon = "LST",
	image = "wos/forceicons/lightstream.png",
	description = "An endless stream of lightning",
	think = function( self )
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 1 ) then return end
		if not self.Owner:IsOnGround() then return end
		if !self.Owner:KeyDown( IN_ATTACK2 ) then return end
		if self.Owner:GetVelocity():Length2DSqr() < 65 then
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			if tr.Entity then
				if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
					if self.Owner:GetPos():DistToSqr( tr.Entity:GetPos() ) < 200000 then 
						local dmg = DamageInfo()
						dmg:SetAttacker( self.Owner )
						dmg:SetInflictor( self or self.Owner )
						dmg:SetDamage( 10 )
						tr.Entity:TakeDamageInfo( dmg )
					end
				end
			end
			local ed = EffectData()
			ed:SetEntity( self.Owner )
			ed:SetAngles( self.Owner:GetAimVector():Angle() )
			ed:SetEntity( self.Owner )
			util.Effect( "wos_alcs_lightstream", ed, true, true )
			self.Owner:SetSequenceOverride( "wos_cast_lightning_armed", 0.25 )
			self:SetForce( self:GetForce() - 2 )
			self:SetNextAttack( 0.1 )
			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self.Owner, "ambient/energy/force_field_loop1.wav" )
				self.SoundLightning:Play()
			else
				self.SoundLightning:Play()
			end
			timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
		end
	end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Mandalorian Fire",
		icon = "C",
		description = "Shoot out flames.",
		image = "wos/forceicons/combust.png",
		cooldown = 5,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 50 ) then return end
			self:SetForce( self:GetForce() - 50 )
			
			-- Set a flame-wristy enough animation.
			self.Owner:SetSequenceOverride( "walk_revolver", 2 )
			self:SetNextAttack(2)

			-- Set a stream of fire every X seconds, capture current player to continue doing it in case of weapon switching.
			local mando = self.Owner
			mando:EmitSound( "ambient/fire/fire_big_loop1.wav", 100, math.random( 95, 110 ) )
			timer.Create(self.Owner:SteamID64().."-MandalorianFire", 0.1, 20, function()
				
				-- Get direction of fire.
				local trace = mando:GetEyeTrace()
				local distance = mando:GetPos():Distance(trace.HitPos)

				-- Setup fire effects.
				local flamefx = EffectData()
				flamefx:SetOrigin(trace.HitPos)
				flamefx:SetStart(mando:GetShootPos())
				flamefx:SetAttachment(1)
				flamefx:SetEntity(mando:GetActiveWeapon())
				util.Effect("flame_thrower_fire",flamefx, true, true)
				
				-- Ignite stuff.
				if distance < 500 then
					if !self:IsValid() then return end
					
					for i, v in pairs (ents.FindInSphere(trace.HitPos, 80)) do
						if v:IsValid() then
							local damageinfo = DamageInfo()
							damageinfo:SetDamage( 20 )
							damageinfo:SetAttacker( mando )
							damageinfo:SetDamageType( DMG_BURN ) 
							v:TakeDamageInfo( damageinfo )
						end
					end
	
					if trace.Entity:IsValid() then
						if trace.Entity:IsPlayer() then
							if trace.Entity:GetPhysicsObject():IsValid() then
								trace.Entity:Ignite(math.random(2,4), 100) 
							end 
						elseif trace.Entity:IsNPC() then
							if trace.Entity:GetPhysicsObject():IsValid() then
								trace.Entity:Fire("Ignite","",1)
								trace.Entity:Ignite(math.random(12,16), 100) 
							end 
						elseif trace.Entity:GetPhysicsObject():IsValid() then
							if !trace.Entity:IsOnFire() then 
								trace.Entity:Ignite(math.random(16,32), 100) 
							end 
						end
					end
				end
				
			end)
			timer.Simple (2, function() mando:StopSound( "ambient/fire/fire_big_loop1.wav" ) end)
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Lightning",
		icon = "L",
		target = 1,
		image = "wos/forceicons/lightning.png",
		cooldown = 0,
		manualaim = false,
		description = "Torture people ( and monsters ) at will.",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end

			local foundents = 0
			for id, ent in pairs( self:SelectTargets( 1 ) ) do
				if ( !IsValid( ent ) ) then continue end

				foundents = foundents + 1
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ent )
				util.Effect( "rb655_force_lighting", ed, true, true )

				local dmg = DamageInfo()
				dmg:SetAttacker( self:GetOwner() || self )
				dmg:SetInflictor( self:GetOwner() || self )
				dmg:SetDamage( 8 )
				local wep = ent:GetActiveWeapon()
				if IsValid( wep ) and wep.IsLightsaber and wep:GetBlocking() and wep:GetStamina() > 4 then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					if wOS.ALCS.Config.EnableStamina then
						wep:AddStamina( -5 )
					else
						wep:SetForce( wep:GetForce() - 1 )
					end
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					ent:TakeDamageInfo( dmg )
				end
			end

			if ( foundents > 0 ) then
				self:SetForce( self:GetForce() - foundents )
				if ( !self.SoundLightning ) then
					self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
					self.SoundLightning:Play()
				else
					self.SoundLightning:Play()
				end

				timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			end
			self:SetNextAttack( 0.1 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Advanced Force Heal",
		icon = "H",
		image = "wos/forceicons/heal.png",
		cooldown = 0,
		target = 1,
		manualaim = false,
		description = "Heal yourself.",
		action = function( self )
			if ( self:GetForce() < 4 or self:GetOwner():Health() >= self:GetOwner():GetMaxHealth() or CLIENT ) then return end
			self:SetForce( self:GetForce() - 4 )

			self:SetNextAttack( 0.2 )

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() )
			util.Effect( "rb655_force_heal", ed, true, true )

			self:GetOwner():SetHealth( math.min(self:GetOwner():Health() + 20, self:GetOwner():GetMaxHealth()) )
			self:GetOwner():Extinguish()
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Lightning Strike",
		icon = "LS",
		distance = 600,
		image = "wos/forceicons/lightning_strike.png",
		cooldown = 20,
		target = 1,
		manualaim = false,
		description = "A focused charge of lightning",
		action = function( self )
			local ent = self:SelectTargets( 1, 600 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 75 ) then self:SetNextAttack( 0.2 ) return end
			self:SetForce( self:GetForce() - 75 )

			local ed = EffectData()
			ed:SetOrigin( self:GetSaberPosAng() )
			ed:SetEntity( ent )
			util.Effect( "rb655_force_lighting", ed, true, true )

			local dmg = DamageInfo()
			dmg:SetAttacker( self:GetOwner() || self )
			dmg:SetInflictor( self:GetOwner() || self )
			
			local wep = ent:GetActiveWeapon()
			if IsValid( wep ) and wep.IsLightsaber and wep:GetBlocking() then
				ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
				if wOS.ALCS.Config.EnableStamina then
					wep:AddStamina( -100 )
				else
					wep:SetForce( wep:GetForce() - 1 )
				end
				ent:SetSequenceOverride( "h_block", 0.5 )
			else
				dmg:SetDamage( 200 )	
				ent:TakeDamageInfo( dmg )
			end

			self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
			self:GetOwner():EmitSound( Sound( "ambient/atmosphere/thunder1.wav" ) )
			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
				self.SoundLightning:Play()
			else
				self.SoundLightning:Play()
			end
			local bullet = {}
			bullet.Num 		= 1
			bullet.Src 		= self:GetOwner():GetPos() + Vector( 0, 0, 10 )
			bullet.Dir 		= ( ent:GetPos() - ( self:GetOwner():GetPos() + Vector( 0, 0, 10 ) ) )
			bullet.Spread 	= 0
			bullet.Tracer	= 1
			bullet.Force	= 0
			bullet.Damage	= 0
			bullet.AmmoType = "Pistol"
			bullet.Entity = self:GetOwner()
			bullet.TracerName = "thor_thunder"
			self:GetOwner():FireBullets( bullet )
			timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Rage",
		icon = "RA",
		image = "wos/forceicons/rage.png",
		cooldown = 30,
		description = "Unleash your anger",
		action = function( self )
		if ( self:GetForce() < 50 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetOwner():GetNW2Float( "RageTime", 0 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 50 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetNW2Float( "RageTime", CurTime() + 10 )
			return true
		end
})