wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
    name = "Sentinel Speed",
    icon = "SS",
    description = "Quick and large speed boost",
    target = 1,
    image = "wos/forceicons/charge.png",
    cooldown = 15,
    manualaim = false,
    action = function( self )
        if ( self:GetForce() < 40 || CLIENT ) then return end
        self:SetForce( self:GetForce() - 40 )

        self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 320 )
        local ed = EffectData()
        ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
        ed:SetRadius( 30 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        timer.Simple( 5, function() self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() - 320 ) end )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Consular Speed",
    icon = "CS",
    description = "Reliable and long speed boost",
    target = 15,
    image = "wos/forceicons/charge.png",
    cooldown = 15,
    manualaim = false,
    action = function( self )
        if ( self:GetForce() < 40 || CLIENT ) then return end
        self:SetForce( self:GetForce() - 40 )

        self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 220 )
        local ed = EffectData()
        ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
        ed:SetRadius( 30 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        timer.Simple( 10, function() self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() - 220 ) end )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Sith Speed",
    icon = "SS",
    description = "Reliable and long speed boost",
    target = 15,
    image = "wos/forceicons/charge.png",
    cooldown = 15,
    manualaim = false,
    action = function( self )
        if ( self:GetForce() < 30 || CLIENT ) then return end
        self:SetForce( self:GetForce() - 30 )

        self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 200 )
        local ed = EffectData()
        ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
        ed:SetRadius( 30 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        timer.Simple( 8, function() self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() - 200 ) end )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Speed",
		icon = "FS",
		description = "A good speed boost",
		target = 1,
		image = "wos/forceicons/charge.png",
		cooldown = 15,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 30 || CLIENT ) then return end
			self:SetForce( self:GetForce() - 30 )

			self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 175 )
			local ed = EffectData()
			ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
			ed:SetRadius( 30 )
			util.Effect( "rb655_force_repulse_out", ed, true, true )
			timer.Simple( 5, function() self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() - 175 ) end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Master Force Speed",
		icon = "MFS",
		description = "Master Speed Burst",
		target = 1,
		image = "wos/forceicons/charge.png",
		cooldown = 10,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 40 || CLIENT ) then return end
			self:SetForce( self:GetForce() - 40 )
			self:SetNextAttack( 1.1 )

		    local sped = self.Owner:GetRunSpeed()
			self.Owner:SetRunSpeed( sped + 500 )
			local ed = EffectData()
			ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
			ed:SetRadius( 30 )
			util.Effect( "rb655_force_repulse_out", ed, true, true )
			timer.Simple( 5, function() self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() - 500 ) end )
			return true
		end
})