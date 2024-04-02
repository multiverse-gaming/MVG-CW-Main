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
        if ( self:GetForce() < 40 || CLIENT || self.Owner:GetRunSpeed() > 500 ) then return end
        self:SetForce( self:GetForce() - 40 )

        if (self.Owner:GetRunSpeed() > 500) then
            self.Owner:SetRunSpeed(240)
            self:SetForce(-200)
            return true
        end

        self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 280 )
        local ed = EffectData()
        ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
        ed:SetRadius( 30 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        local jedi = self.Owner
        timer.Simple( 5, function() jedi:SetRunSpeed( jedi:GetRunSpeed() - 280 ) end )
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
        if ( self:GetForce() < 40 || CLIENT || self.Owner:GetRunSpeed() > 500 ) then return end
        self:SetForce( self:GetForce() - 40 )

        if (self.Owner:GetRunSpeed() > 500) then -- 370 (10 over max speed) + 100 (sentinel spawn boost) + speed
            self.Owner:SetRunSpeed(240)
            self:SetForce(-200)
            return true
        end

        self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 220 )
        local ed = EffectData()
        ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
        ed:SetRadius( 30 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        local jedi = self.Owner
        timer.Simple( 10, function() jedi:SetRunSpeed( jedi:GetRunSpeed() - 220 ) end )
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
        if ( self:GetForce() < 30 || CLIENT || self.Owner:GetRunSpeed() > 500 ) then return end
        self:SetForce( self:GetForce() - 30 )

        self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 200 )
        local ed = EffectData()
        ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
        ed:SetRadius( 30 )
        util.Effect( "rb655_force_repulse_out", ed, true, true )
        local jedi = self.Owner
        timer.Simple( 8, function() jedi:SetRunSpeed( jedi:GetRunSpeed() - 200 ) end )
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
			if ( self:GetForce() < 30 || CLIENT || self.Owner:GetRunSpeed() > 500 ) then return end
			self:SetForce( self:GetForce() - 30 )

            if (self.Owner:GetRunSpeed() > 500) then -- 370 (silly max speed) + speed
                self.Owner:SetRunSpeed(240)
                self:SetForce(-200)
                return true
            end

			self.Owner:SetRunSpeed( self.Owner:GetRunSpeed() + 175 )
			local ed = EffectData()
			ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
			ed:SetRadius( 30 )
			util.Effect( "rb655_force_repulse_out", ed, true, true )
            local jedi = self.Owner
			timer.Simple( 5, function() jedi:SetRunSpeed( jedi:GetRunSpeed() - 175 ) end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Master Force Speed",
		icon = "MFS",
		description = "Master Speed Burst",
		target = 1,
		image = "wos/forceicons/charge.png",
		cooldown = 20,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 40 || CLIENT ) then return end
			self:SetForce( self:GetForce() - 40 )

		    local sped = self.Owner:GetRunSpeed()
			self.Owner:SetRunSpeed( sped + 280 )
			local ed = EffectData()
			ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
			ed:SetRadius( 30 )
			util.Effect( "rb655_force_repulse_out", ed, true, true )
            local jedi = self.Owner
			timer.Simple( 10, function() jedi:SetRunSpeed( jedi:GetRunSpeed() - 280 ) end )
			return true
		end
})