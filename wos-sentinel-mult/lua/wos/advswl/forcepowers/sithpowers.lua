wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

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
			self:SetAttackDelay( CurTime() + 2 )
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
				if IsValid( wep ) and wep.IsLightsaber and wep:GetBlocking() then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					if wOS.ALCS.Config.EnableStamina then
						wep:AddStamina( -5 )
					else
						wep:SetForce( wep:GetForce() - 1 )
					end
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					if ent:IsNPC() then dmg:SetDamage( 1.6 ) end
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
		name = "Lightning Strike",
		icon = "LS",
		distance = 600,
		image = "wos/forceicons/lightning_strike.png",
		cooldown = 0,
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
			dmg:SetDamage( 200 )
			ent:TakeDamageInfo( dmg )
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
			self:SetNextAttack( 10 )
			self:GetOwner():FireBullets( bullet )
			timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Rage",
		icon = "RA",
		image = "wos/forceicons/rage.png",
		cooldown = 0,
		description = "Unleash your anger",
		action = function( self )
		if ( self:GetForce() < 50 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetOwner():GetNW2Float( "RageTime", 0 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 50 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetNW2Float( "RageTime", CurTime() + 10 )
			return true
		end
})