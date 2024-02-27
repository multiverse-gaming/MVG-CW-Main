--[[-------------------------------------------------------------------]]--[[

	Copyright wiltOS Technologies LLC, 2020

	Contact: www.wiltostech.com
		----------------------------------------]]--

wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Force Pull",
		icon = "PL",
		target = 1,
		description = "Get over here!",
		image = "wos/forceicons/pull.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 20 ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ent ) then return end
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
			newpos = newpos / newpos:Length()
			ent:SetVelocity( newpos*700 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 50 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
			self:SetNextAttack( 1.5 )
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
			if ( self:GetForce() < 20 ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ent ) then return end
			self:GetOwner():SetSequenceOverride("idle_magic", 1)
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
			newpos = newpos / newpos:Length()
			ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 50 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
			self:SetNextAttack( 1.5 )
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
					self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*0.01 ), self:GetOwner():GetMaxHealth() ) )
					if #self.DevestatorList > 0 then
						self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge )
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