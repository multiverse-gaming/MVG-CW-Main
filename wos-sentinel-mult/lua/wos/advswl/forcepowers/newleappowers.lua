wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Force Leap",
		icon = "L",
		image = "wos/forceicons/leap.png",
		cooldown = 2,
		manualaim = false,
		description = "Jump longer and higher. Aim higher to jump higher/further.",
		action = function( self )
			if ( self:GetForce() < 20 || !self:GetOwner():IsOnGround() ) then return end
			self:SetForce( self:GetForce() - 20 )

			self:SetNextAttack( 0.5 )

			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )

			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			// Trigger the jump animation, yay
			self:CallOnClient( "ForceJumpAnim", "" )
			return true
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

			self:SetNextAttack( 0.5 )

			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )

			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			// Trigger the jump animation, yay
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

			self:SetNextAttack( 0.5 )

			self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )

			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			// Trigger the jump animation, yay
			self:CallOnClient( "ForceJumpAnim", "" )
			return true
		end
})
