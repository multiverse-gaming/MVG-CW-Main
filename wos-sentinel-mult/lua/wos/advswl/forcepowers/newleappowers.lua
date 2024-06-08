wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Force Leap",
		icon = "L",
		image = "wos/forceicons/leap.png",
		cooldown = 3,
		manualaim = false,
		description = "Jump longer and higher. Will be affected by your class",
		action = function( self )
			-- Master Leap
			if (self.MasterLeap) then
				if (self:GetOwner():IsOnGround() && self:GetForce() >= 15) then
					-- On ground - normal leap
					self:SetForce( self:GetForce() - 15 )
					self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
					self:PlayWeaponSound( "lightsaber/force_leap.wav" )
					self:CallOnClient( "ForceJumpAnim", "" )
					self.MasterLeapCooldown = CurTime() + 0.5
				elseif (!self:GetOwner():IsOnGround() && self:GetForce() >= 30) then
					-- In air - leap and cooldown.
					if (self.MasterLeapCooldown ~= nil && self.MasterLeapCooldown > CurTime()) then return end
					self:SetForce( self:GetForce() - 30 )
					self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 256 + Vector( 0, 0, 512 ) )
					self:PlayWeaponSound( "lightsaber/force_leap.wav" )
					self:CallOnClient( "ForceJumpAnim", "" )
					self.MasterLeapCooldown = CurTime() + 3
					return true
				end

			-- Consular Leap
			elseif (self.ConsularLeap) then
				if ( self:GetForce() < 15 || !self:GetOwner():IsOnGround() ) then return end
				if (self.LeapCD ~= nil && self.LeapCD > CurTime()) then return end
				self:SetForce( self:GetForce() - 15 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				-- Trigger the jump animation, yay
				self:CallOnClient( "ForceJumpAnim", "" )
				self.LeapCD = CurTime() + 1

			-- Sentinel Leap
			elseif (self.SentinelLeap) then
				if ( self:GetForce() < 20 || !self:GetOwner():IsOnGround() ) then return end
				if (self.LeapCD ~= nil && self.LeapCD > CurTime()) then return end
				self:SetForce( self:GetForce() - 20 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				-- Trigger the jump animation, yay
				self:CallOnClient( "ForceJumpAnim", "" )
				self.LeapCD = CurTime() + 2

			-- Guardian Leap
			elseif (self.GuardianLeap) then
				if ( self:GetForce() < 30 || !self:GetOwner():IsOnGround() ) then return end
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				-- Trigger the jump animation, yay
				self:CallOnClient( "ForceJumpAnim", "" )
				return true

			-- All Other Leapers
			else
				if ( self:GetForce() < 20 || !self:GetOwner():IsOnGround() ) then return end
				if (self.LeapCD ~= nil && self.LeapCD > CurTime()) then return end
				self:SetForce( self:GetForce() - 20 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				-- Trigger the jump animation, yay
				self:CallOnClient( "ForceJumpAnim", "" )
				self.LeapCD = CurTime() + 2
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Master Force Leap",
		icon = "ML",
		image = "wos/forceicons/leap.png",
		cooldown = 3,
		description = "Mastering the power of leap you are able to do it twice in once try",
		action = function( self )
			if ( CLIENT ) then return end
			if (self:GetOwner():IsOnGround() && self:GetForce() >= 15) then
				-- On ground - normal leap
				self:SetForce( self:GetForce() - 15 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 0.5
			elseif (!self:GetOwner():IsOnGround() && self:GetForce() >= 30) then
				-- In air - leap and cooldown.
				if (self.MasterLeapCooldown ~= nil && self.MasterLeapCooldown > CurTime()) then return end
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 256 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 3
				return true
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Master Leap",
		icon = "ML",
		image = "wos/forceicons/leap.png",
		cooldown = 3,
		description = "Mastering the power of leap you are able to do it twice in once try",
		action = function( self )
			if ( CLIENT ) then return end
			if (self:GetOwner():IsOnGround() && self:GetForce() >= 15) then
				-- On ground - normal leap
				self:SetForce( self:GetForce() - 15 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 0.5
			elseif (!self:GetOwner():IsOnGround() && self:GetForce() >= 30) then
				-- In air - leap and cooldown.
				if (self.MasterLeapCooldown ~= nil && self.MasterLeapCooldown > CurTime()) then return end
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 256 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 3
				return true
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Guardian Leap",
		icon = "L",
		image = "wos/forceicons/leap.png",
		cooldown = 3,
		manualaim = false,
		description = "Jump through the air. You're a little worse at this than your comrades. Aim higher to jump higher/further.",
		action = function( self )
			if ( self:GetForce() < 30 || !self:GetOwner():IsOnGround() ) then return end
			self:SetForce( self:GetForce() - 30 )
			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			-- Trigger the jump animation, yay
			self:CallOnClient( "ForceJumpAnim", "" )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Consular Force Leap",
		icon = "L",
		image = "wos/forceicons/leap.png",
		cooldown = 1,
		manualaim = false,
		description = "Jump through the air. You're a little better at this than your comrades. Aim higher to jump higher/further.",
		action = function( self )
			if ( self:GetForce() < 15 || !self:GetOwner():IsOnGround() ) then return end
			self:SetForce( self:GetForce() - 15 )
			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			-- Trigger the jump animation, yay
			self:CallOnClient( "ForceJumpAnim", "" )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sith Leap",
		icon = "SL",
		image = "wos/forceicons/leap.png",
		cooldown = 1,
		manualaim = false,
		description = "Jump through the air. Evily.",
		action = function( self )
			if ( self:GetForce() < 15 || !self:GetOwner():IsOnGround() ) then return end
			self:SetForce( self:GetForce() - 15 )
			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			-- Trigger the jump animation, yay
			self:CallOnClient( "ForceJumpAnim", "" )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sith Master Leap",
		icon = "SL",
		image = "wos/forceicons/leap.png",
		cooldown = 3,
		description = "Jump through the air. Evily, and twice.",
		action = function( self )
			if ( CLIENT ) then return end
			if (self:GetOwner():IsOnGround() && self:GetForce() >= 15) then
				-- On ground - normal leap
				self:SetForce( self:GetForce() - 15 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 0.5
			elseif (!self:GetOwner():IsOnGround() && self:GetForce() >= 30) then
				-- In air - leap and cooldown.
				if (self.MasterLeapCooldown ~= nil && self.MasterLeapCooldown > CurTime()) then return end
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 256 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 3
				return true
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Grevious Leap",
		icon = "L",
		image = "wos/forceicons/leap.png",
		cooldown = 3,
		manualaim = false,
		description = "Jump through the air.",
		action = function( self )
			if ( !self:GetOwner():IsOnGround() ) then return end
			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			-- Trigger the jump animation, yay
			self:CallOnClient( "ForceJumpAnim", "" )
			return true
		end
})
