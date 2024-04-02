wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
	name = "Force Stamina",
	icon = "S",
	image = "wos/forceicons/reflect.png",
	cooldown = 60,
	description = "Regenerate your stamina",
	action = function( self )
		if ( self:GetForce() < 50 ) then return end
		self:SetForce( self:GetForce() - 50 )
    	self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        
        self:SetStamina(self:GetMaxStamina())
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Guard",
	icon = "FG",
	image = "wos/skilltrees/forms/aggressive.png",
	cooldown = 60,
	description = "Gain a large amount of armor for 10 seconds",
	action = function( self )
		if ( self:GetForce() < 75 ) then return end
		self:SetForce( self:GetForce() - 75 )
    	self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        
		local originalArmor = self:GetOwner():Armor()
		self:GetOwner():SetArmor(200)
		timer.Simple(10, function()
			self:GetOwner():SetArmor(math.min(self:GetOwner():Armor(), originalArmor))
		end)
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Charge",
		icon = "CH",
		distance = 1200,
		image = "wos/forceicons/charge.png",
		target = 1,
		cooldown = 1,
		manualaim = false,
		description = "Lunge at your enemy",
		action = function( self )
			local ent = self:SelectTargets( 1, 1000 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.2 ) return end
			local newpos = ( ent:GetPos() - self:GetOwner():GetPos() )
			newpos = newpos / newpos:Length()
			self:GetOwner():SetLocalVelocity( newpos*500 + Vector( 0, 0, 275 ) )
			self:SetForce( self:GetForce() - 20 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        	self:GetOwner():SetSequenceOverride( "ryoku_a_left_t1", 3 )
			self:SetNextAttack( 0.9 )
			self.AerialLand = false
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Ground Slam",
		icon = "GS",
		image = "wos/forceicons/icefuse/group_lightning.png",
		texture = "star/icon/ground_slam.png",
        cooldown = 60,
		description = "Shocks and destroys everything around you",
		action = function( self )
			if ( self:GetForce() < 60 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			local elev = 400
			local time = 1
			ent = self:GetOwner()
			self:GetOwner():SetSequenceOverride( "h_c2_t3", 0.8 )
			self:SetForce(self:GetForce() - 60)
			self:SetNextAttack( 0.8 )

			for j = 0,6 do
				for i = 0, 24 do
					local ed = EffectData()
					ed:SetOrigin( self:GetOwner():GetPos() + Vector(0,0,0) )
					ed:SetStart( self:GetOwner():GetPos() + Vector(0,0,0) + Angle(0 , i * 15, 0):Forward() * 512)
					util.Effect( "force_groundslam", ed, true, true )
				end
			end

			local maxdist = 128 * 4

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
			ed:SetRadius( maxdist )
			util.Effect( "h_c2_t3", ed, true, true )
			for i, e in pairs( ents.FindInSphere( self:GetOwner():GetPos(), maxdist ) ) do
			if(e == self:GetOwner()) then continue end
			--if (e.Team and e:Team() == self:GetOwner():Team()) or (e.PlayerTeam and e.PlayerTeam == self:GetOwner():Team()) then continue end

				local dist = self:GetOwner():GetPos():Distance( e:GetPos() )
				local mul = ( maxdist - dist ) / 256

				local v = ( self:GetOwner():GetPos() - e:GetPos() ):GetNormalized()
				v.z = 0

				local dmg = DamageInfo()
				dmg:SetDamagePosition( e:GetPos() + e:OBBCenter() )
				dmg:SetDamage( 200 * mul )
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
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
name = "Force Reflect Half",
icon = "FRH",
image = "wos/forceicons/reflect.png",
cooldown = 20,
description = "An eye for an eye",
action = function(self)
    if (self:GetForce() < 100 || !self:GetOwner():IsOnGround() ) then return end
    if self:GetOwner():GetNWFloat("ReflectTimeHalf", 0) == 0 or self:GetOwner():GetNWFloat("ReflectTimeHalf", 0) == nil then 
        self:GetOwner():SetNWFloat("ReflectTimeHalf", CurTime()) 
    end
    if self:GetOwner():GetNWFloat( "ReflectTimeHalf", 5 ) >= CurTime() then return end
    self:SetForce( self:GetForce() - 100 )
    self:SetNextAttack( 0.7 )
    self:PlayWeaponSound( "lightsaber/force_leap.wav" )
    self:GetOwner():SetNWFloat( "ReflectTimeHalf", CurTime() + 5 )
    return true
end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Weak Hardened Force Push",
	icon = "WFP",
	target = 1,
	distance = 150,
	description = "Hurt your opponent for 75",
	image = "wos/forceicons/pull.png",
	cooldown = 10,
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
		dmg:SetDamage( 75 )
		ent:TakeDamageInfo( dmg )
		local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
		newpos = newpos / newpos:Length()
		ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
		self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
		self:SetNextAttack( 1.5 )
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Strong Hardened Force Push",
	icon = "SFP",
	target = 1,
	distance = 150,
	description = "Hurt your opponent for 200, yourself for 75",
	image = "wos/forceicons/push.png",
	cooldown = 10,
	manualaim = false,
	action = function( self )
		if ( self:GetForce() < 75 || self:Health() > 75 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) then return end
		self:SetForce( self:GetForce() - 75 )
		self:PlayWeaponSound( "lightsaber/force_repulse.wav" )

		local dmg = DamageInfo()
		dmg:SetAttacker( self:GetOwner() || self )
		dmg:SetInflictor( self:GetOwner() || self )
		dmg:SetDamageType( DMG_DISSOLVE )
		dmg:SetDamage( 200 )
		ent:TakeDamageInfo( dmg )
		dmg:SetDamage( 75 )
		self:GetOwner():TakeDamageInfo( dmg )
		local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
		newpos = newpos / newpos:Length()
		ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
		self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
		self:SetNextAttack( 1.5 )
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Valor",
		icon = "RA",
		image = "wos/forceicons/shadow_strike.png",
		cooldown = 60,
		description = "Unleash your focused mind",
		action = function( self )
		if ( self:GetForce() < 60 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetOwner():GetNW2Float( "RageTime", 10 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 60 )

			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetNW2Float( "RageTime", CurTime() + 20 )
			return true
		end
})