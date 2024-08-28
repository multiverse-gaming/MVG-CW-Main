--[[-------------------------------------------------------------------]]--[[

	Copyright wiltOS Technologies LLC, 2020

	Contact: www.wiltostech.com
		----------------------------------------]]--

wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Push And Pull",
		icon = "P",
		target = 1,
		description = "Default - Force Pull, Sprint - Force Push",
		image = "wos/forceicons/pull.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetOwner():KeyDown( IN_SPEED ) && self.ForcePush ) then
				if ( self:GetForce() < 30 ) then return end
				local ent = self:SelectTargets( 1 )[ 1 ]
				if not IsValid( ent ) then return end
				self:GetOwner():SetSequenceOverride("idle_magic", 1)
				self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
				local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )

				if (self.HardenedForcePush != nil && self.HardenedForcePush) then
					if (self.ForceHardenedPushCD != nil && self.ForceHardenedPushCD > CurTime()) then return true end
					local dmg = DamageInfo()
					dmg:SetAttacker( self:GetOwner() || self )
					dmg:SetInflictor( self:GetOwner() || self )
					dmg:SetDamageType( DMG_DISSOLVE )
					dmg:SetDamage( 75 )
					ent:TakeDamageInfo( dmg )
					self.ForceHardenedPushCD = CurTime() + 8
				end

				return true

			elseif ( self.ForcePull ) then
				if ( self:GetForce() < 30 ) then return end
				local ent = self:SelectTargets( 1 )[ 1 ]
				if not IsValid( ent ) then return end
				self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
				local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*700 + Vector( 0, 0, 300 ) )
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
				return true
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Pull",
		icon = "PL",
		target = 1,
		description = "Get over here!",
		image = "wos/forceicons/pull.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 30 ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ent ) then return end
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
			newpos = newpos / newpos:Length()
			ent:SetVelocity( newpos*700 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 30 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Push",
		icon = "PH",
		target = 1,
		distance = 150,
		description = "They are no harm at a distance",
		image = "wos/forceicons/push.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 30 ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ent ) then return end
			self:GetOwner():SetSequenceOverride("idle_magic", 1)
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
			newpos = newpos / newpos:Length()
			ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 30 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Meditate",
		icon = "M",
		image = "wos/forceicons/meditate.png",
		description = "Relax yourself, heal, and channel your energy",
		think = function( self )
			if self.MeditateCooldown and self.MeditateCooldown >= CurTime() then return end
			if ( self:GetOwner():KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self:GetOwner():OnGround() then
				self._ForceMeditating = true
			else
				self._ForceMeditating = false
			end
			if self._ForceMeditating then
				self:SetMeditateMode( 1 )
				if not self._NextMeditateHeal then self._NextMeditateHeal = 0 end
				if self._NextMeditateHeal < CurTime() then
					local meditatePercentage
					if (self.Meditate ~= nil && self.Meditate >= 1) then
						meditatePercentage = 0.1
					else
						meditatePercentage = 0.05
					end

					self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*meditatePercentage ), self:GetOwner():GetMaxHealth() ) )
					if #self.DevestatorList > 0 then
						self:SetDevEnergy( self:GetDevEnergy() + 15 )
					end
					self._NextMeditateHeal = CurTime() + 3
				end
				self:GetOwner():SetLocalVelocity(Vector(0, 0, 0))
				self:GetOwner():SetMoveType(MOVETYPE_NONE)
			else
				self:SetMeditateMode( 0 )
				if self:GetMoveType() != MOVETYPE_WALK and self:GetOwner():GetNW2Float( "wOS.DevestatorTime", 0 ) < CurTime() then
					self:GetOwner():SetMoveType(MOVETYPE_WALK)
				end
			end
			if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
				self.MeditateCooldown = CurTime() + 3
			end
		end
})