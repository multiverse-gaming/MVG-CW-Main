wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
	name = "Enemy Guard",
	icon = "G",
	image = "wos/skilltrees/forms/aggressive.png",
	cooldown = 60,
	description = "Gain a large amount of armor for 10 seconds",
	action = function( self )
		if ( self:GetForce() < 75 ) then return end
		self:SetForce( self:GetForce() - 75 )
    	self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        
		local originalArmor = self:GetOwner():Armor()
		self:GetOwner():SetArmor(500)
		local owner = self:GetOwner()
		timer.Simple(15, function()
			owner:SetArmor(math.min(owner:Armor(), originalArmor))
		end)
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Hardened Group Push",
		icon = "HGP",
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
		name = "Enemy Cloak",
		icon = "C",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 45,
		description = "Shrowd yourself with the force",
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
				else
					-- Left Empty
				end	
			end)
		end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Enemy Mystify",
    icon = "M",
    image = "wos/forceicons/icefuse/blind.png",
    cooldown = 50,
    manualaim = false,
    description = "An electromagnetic pulse that conufses and stumbles foes",
    action = function( self )
        if ( self:GetForce() < 100 ) then return end
        self:SetForce( self:GetForce() - 100 )
        local entpos = self.Owner:GetPos() + Vector(0, 0, 60)
        local entindex = self.Owner:EntIndex()

        timer.Create("tesla_zap" .. entindex,math.Rand(0.03,0.1), math.random(5, 10), function()
            local lightning = ents.Create( "point_tesla" )
            lightning:SetPos(entpos)
            lightning:SetKeyValue("m_SoundName", "")
            lightning:SetKeyValue("texture", "sprites/bluelight1.spr")
            lightning:SetKeyValue("m_Color", "255 255 150")
            lightning:SetKeyValue("m_flRadius", "350")
            lightning:SetKeyValue("beamcount_max", "15")
            lightning:SetKeyValue("thick_min", "15")
            lightning:SetKeyValue("thick_max", "30")
            lightning:SetKeyValue("lifetime_min", "0.3")
            lightning:SetKeyValue("lifetime_max", "0.4")
            lightning:SetKeyValue("interval_min", "0.15")
            lightning:SetKeyValue("interval_max", "0.25")
            lightning:Spawn()
            lightning:Fire("DoSpark", "", 0)
            lightning:Fire("kill", "", 0.2)

            local light = ents.Create("light_dynamic")
            light:SetPos( entpos )
            light:Spawn()
            light:SetKeyValue("_light", "100 100 255")
            light:SetKeyValue("distance","550")
            light:Fire("Kill","",0.20)
            sound.Play( "k_lab.teleport_spark" , entpos, 310)
        end)

        for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 350 ) ) do
            if v:IsValid() && v:IsPlayer() then
				if v == self.Owner then continue end
				v.WOS_CripplingSlow = CurTime() + 3
				v:SetNW2Float( "wOS.BlindTime", CurTime() + 9 )
            end
        end

        return true
    end
})