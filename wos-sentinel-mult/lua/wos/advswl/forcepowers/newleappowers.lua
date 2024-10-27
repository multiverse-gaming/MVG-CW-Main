wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Old Force Leap",
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
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 576 + Vector( 0, 0, 576 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				self:CallOnClient( "ForceJumpAnim", "" )
				self.MasterLeapCooldown = CurTime() + 0.5
			elseif (!self:GetOwner():IsOnGround() && self:GetForce() >= 30) then
				-- In air - leap and cooldown.
				if (self.MasterLeapCooldown ~= nil && self.MasterLeapCooldown > CurTime()) then return end
				self:SetForce( self:GetForce() - 30 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 576 + Vector( 0, 0, 576 ) )
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

wOS.ForcePowers:RegisterNewPower({
	name = "Force Leap",
	icon = "L",
	image = "wos/forceicons/leap.png",
	cooldown = 4,
	manualaim = false,
	description = "Jump through the air.",
	action = function( self )
		if ( self:GetOwner():IsOnGround() ) then
			if ( self.LeapCD ~= nil && self.LeapCD > CurTime() ) then return end

			if (not self.LeapComputed) then
				self.LeapCost = 30
				self.LeapCDValue = 4.5
				self.LeapStrength = 448

				if (self.LeapCostUpgrade ~= nil) then self.LeapCost = self.LeapCost - (self.LeapCostUpgrade*5) end
				if (self.ConsularLeapUpgrade ~= nil) then self.LeapCost = self.LeapCost - 5 end
				if (self.LeapIgniterCost ~= nil) then self.LeapCost = self.LeapCost - 5 end

				if (self.LeapCDUpgrade ~= nil) then self.LeapCDValue = self.LeapCDValue - self.LeapCDUpgrade end
				if (self.SentinelLeapUpgrade ~= nil) then self.LeapCDValue = self.LeapCDValue - 1 end
				if (self.LeapIgniterCD ~= nil) then self.LeapCDValue = self.LeapCDValue - 0.5 end

				if (self.LeapDistanceUpgrade ~= nil) then self.LeapStrength = self.LeapStrength + (self.LeapDistanceUpgrade*64) end
				if (self.LeapIgniterDistance ~= nil) then self.LeapStrength = self.LeapStrength + 64 end

				self.LeapComputed = true
			end
			if (self:GetForce() < self.LeapCost) then return end

			-- Group Leaping will be handled by the Think code.
			if ( self.GroupLeap && self.Owner:Crouching() && self.Owner:GetVelocity():Length() < 120 ) then return end

			-- If Crouching, and moving slowly, do a bigger leap.
			local leapStr = self.LeapStrength
			if ( self.CrouchingLeap && self.Owner:GetVelocity():Length() < 120 && self.Owner:Crouching() ) then
				leapStr = leapStr + 250
			end

			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * leapStr + Vector( 0, 0, leapStr ) )
			self:SetForce( self:GetForce() - self.LeapCost )
			self:CallOnClient( "ForceJumpAnim", "" )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.AdditionalLeapCooldown = CurTime() + 1
			self.LeapCD = CurTime() + self.LeapCDValue
		elseif ( self.MasterLeap ) then
			-- Have them do a large additional leap - but only if they're currently going upwards.
			if (self.AdditionalLeapCooldown ~= nil && self.AdditionalLeapCooldown > CurTime()) then return end
			if (self.Owner:GetVelocity().z <= 0) then return end
			if (self:GetForce() < 15) then return end
			self:SetForce( self:GetForce() - 15 )
			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 350 + Vector( 0, 0, 512 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:CallOnClient( "ForceJumpAnim", "" )
			self.AdditionalLeapCooldown = CurTime() + 2
		elseif ( self.AdditionalLeap ) then
			-- Have them do a small additional leap - but only if they're currently going upwards.
			if (self.AdditionalLeapCooldown ~= nil && self.AdditionalLeapCooldown > CurTime()) then return end
			if (self.Owner:GetVelocity().z <= 0) then return end
			if (self:GetForce() < 30) then return end
			self:SetForce( self:GetForce() - 30 )
			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 128 + Vector( 0, 0, 256 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:CallOnClient( "ForceJumpAnim", "" )
			self.AdditionalLeapCooldown = CurTime() + 3
		end
	end,
	think = function ( self )
		if ( self.SlowFall && !self.Owner:IsOnGround() && self.Owner:KeyDown( IN_ATTACK2 ) ) then
			local vel = self.Owner:GetVelocity()
			if (vel.z > 50) then return end
			self.Owner:SetVelocity(Vector(0, 0, 17))
			self:SetForce( self:GetForce() - 0.01 )
		elseif ( self.GroupLeap && self.Owner:IsOnGround()) then
			if (not self.LeapComputed) then
				self.LeapCost = 30
				self.LeapCDValue = 4.5
				self.LeapStrength = 448

				if (self.LeapCostUpgrade ~= nil) then self.LeapCost = self.LeapCost - (self.LeapCostUpgrade*5) end
				if (self.ConsularLeapUpgrade) then self.LeapCost = self.LeapCost - 5 end

				if (self.LeapCDUpgrade ~= nil) then self.LeapCDValue = self.LeapCDValue - self.LeapCDUpgrade end
				if (self.SentinelLeapUpgrade) then self.LeapCDValue = self.LeapCDValue - 1 end

				if (self.LeapDistanceUpgrade ~= nil) then self.LeapStrength = self.LeapStrength + (self.LeapDistanceUpgrade*64) end

				self.LeapComputed = true
			end

			if ( self.LeapCD ~= nil && self.LeapCD > CurTime()) then return end
			if ( self:GetForce() < self.LeapCost) then return end
			if ( self.Owner:KeyDown( IN_ATTACK2 ) ) then
				-- Player is building charge.
				if ( self.LeapTimer == nil || self.LeapTimer == 0 ) then
					self.LeapTimer = 1
				else
					self.LeapTimer = self.LeapTimer + 1
				end
			else
				-- Player has released charge? If charge above 10, Launch everyone around. If less, just release self.
				if (not self.Owner:Crouching()) then self.GroupLeap = 0 end
				self.LeapTimer = self.LeapTimer or 0
				local leapStr = self.LeapStrength
				if ( self.LeapTimer > 20 ) then
					-- Leap Everyone if you're crouching
					for _, ply in pairs( ents.FindInSphere( self:GetOwner():GetPos(), 100 ) ) do
						if not IsValid( ply ) || not ply:IsPlayer() || not ply:Alive() then continue end
						ply:SetVelocity( self:GetOwner():GetAimVector() * leapStr + Vector( 0, 0, leapStr ) )
					end
					self:CallOnClient( "ForceJumpAnim", "" )
					self:PlayWeaponSound( "lightsaber/force_leap.wav" )
					self.AdditionalLeapCooldown = CurTime() + 1
					self.LeapCD = CurTime() + self.LeapCDValue
					self.LeapTimer = 0
				elseif ( self.LeapTimer > 0 ) then
					-- Leap Self
					if ( self.CrouchingLeap && self.Owner:GetVelocity():Length() < 120 && self.Owner:Crouching() ) then
						leapStr = leapStr + 250
					end
					self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * leapStr + Vector( 0, 0, leapStr ) )
					self:SetForce( self:GetForce() - self.LeapCost )
					self:CallOnClient( "ForceJumpAnim", "" )
					self:PlayWeaponSound( "lightsaber/force_leap.wav" )
					self.AdditionalLeapCooldown = CurTime() + 1
					self.LeapCD = CurTime() + self.LeapCDValue
					self.LeapTimer = 0
				end
			end

		elseif ( self.GroupLeap ) then
			self.LeapTimer = 0
		end
	end
})