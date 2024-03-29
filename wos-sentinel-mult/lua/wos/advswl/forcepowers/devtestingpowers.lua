--[[-------------------------------------------------------------------]]--[[
							  
	Copyright wiltOS Technologies LLC, 2020
	
	Contact: www.wiltostech.com
		----------------------------------------]]--

wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
			name = "Force Crush Test",
			icon = "CH",
			distance = 600,
			image = "wos/forceicons/charge.png",
			target = 1,
			cooldown = 0,
			manualaim = true,
			description = "LCRUSH",
			action = function( self )
				local ent = self:SelectTargets( 1, 600 )[ 1 ]
				if !IsValid( ent ) or !ent:IsPlayer() then self:SetNextAttack( 0.2 ) return end
				wOS.ALCS.ExecSys:PerformExecution( self.Owner, ent, "Force Crush" )
				self:SetNextAttack( 1 )
				return true
			end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Funny Crush",
    icon = "FC",
    distance = 300,
    image = "wos/forceicons/push.png",
    target = 1,
    cooldown = 0,
    manualaim = true,
    description = "Funny Crush Dev Power",
    action = function( self )
		local ent = self:SelectTargets( 1, 600 )[ 1 ]
		if !IsValid( ent ) or !ent:IsPlayer() then self:SetNextAttack( 0.2 ) return end
		wOS.ALCS.ExecSys:PerformExecution( self.Owner, ent, "Funny Execution Crush" )
		self:SetNextAttack( 1 )
		return true
    end
})

wOS.ForcePowers:RegisterNewPower({
			name = "Fighting Chance Test",
			icon = "FC",
			distance = 600,
			image = "wos/forceicons/charge.png",
			target = 1,
			cooldown = 0,
			manualaim = true,
			description = "Fighting Chance Dev Power",
			action = function( self )
				local ent = self:SelectTargets( 1, 600 )[ 1 ]
				if !IsValid( ent ) or !ent:IsPlayer() then self:SetNextAttack( 0.2 ) return end
				wOS.ALCS.ExecSys:PerformExecution( self.Owner, ent, "Fighting Chance" )
				self:SetNextAttack( 1 )
				return true
			end
})

wOS.ForcePowers:RegisterNewPower({
			name = "Head Splitter Test",
			icon = "CH",
			distance = 600,
			image = "wos/forceicons/charge.png",
			target = 1,
			cooldown = 0,
			manualaim = true,
			description = "LCRUSH",
			action = function( self )
				local ent = self:SelectTargets( 1, 600 )[ 1 ]
				if !IsValid( ent ) or !ent:IsPlayer() then self:SetNextAttack( 0.2 ) return end
				wOS.ALCS.ExecSys:PerformExecution( self.Owner, ent, "Head Splitter" )
				self:SetNextAttack( 1 )
				return true
			end
})

wOS.ForcePowers:RegisterNewPower({
			name = "Force Blast Test",
			icon = "CH",
			distance = 600,
			image = "wos/forceicons/charge.png",
			target = 1,
			cooldown = 0,
			manualaim = true,
			description = "LCRUSH",
			action = function( self )
				local ent = self:SelectTargets( 1, 600 )[ 1 ]
				if !IsValid( ent ) or !ent:IsPlayer() then self:SetNextAttack( 0.2 ) return end
				wOS.ALCS.ExecSys:PerformExecution( self.Owner, ent, "Force Blast" )
				self:SetNextAttack( 1 )
				return true
			end
})

wOS.ForcePowers:RegisterNewPower({ -- This, uh, doesn't work. You can see what I was trying, however. 
    name = "Trick Minds", -- Try to change NPC team. 
    icon = "TM",
    image = "wos/forceicons/charge.png",
    cooldown = 60,
    target = 1,
    manualaim = true,
    description = "Briefly trick lesser minds",
    action = function( self )
		if self:GetForce() < 100 then return end
		self:SetForce( self:GetForce() - 100 )
        local ent = self:SelectTargets( 1, 600 )[ 1 ]
        if !IsValid( ent ) or !ent:IsNPC() then self:SetNextAttack( 0.2 ) return end
		
		ent:AddRelationship("CLASS_COMBINE D_HT 50")

		timer.Simple(15, function()
			ent:AddRelationship("CLASS_COMBINE D_LI 99")
		end)
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Unused Charge",
    icon = "CH",
    distance = 600,
    image = "wos/forceicons/charge.png",
    target = 1,
    cooldown = 0,
    manualaim = false,
    description = "Lunge at your enemy",
    action = function( self )
        local ent = self:SelectTargets( 1, 600 )[ 1 ]
        if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
        if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.2 ) return end
        local newpos = ( ent:GetPos() - self:GetOwner():GetPos() )
        newpos = newpos / newpos:Length()
        self:GetOwner():SetLocalVelocity( newpos*700 + Vector( 0, 0, 300 ) )
        self:SetForce( self:GetForce() - 20 )
        self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        self:GetOwner():SetSequenceOverride( "phalanx_a_s2_t1", 5 )
        self:SetNextAttack( 1 )
        self.AerialLand = true
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({ -- As is, does not yet work.
	name = "Force Sacrifice",
	icon = "SC",
	target = 1,
	distance = 150,
	description = "Sacrifice your life for your ally",
	image = "wos/forceicons/throw.png",
	cooldown = 300,
	manualaim = true,
	action = function( self )
		-- If force below a certain amount, or owner would instantly get removed from the EntityTakeDamage, or bad target, stop.
		if ( self:GetForce() < 100 || self:GetOwner():Health() < 50 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) || !ent:IsPlayer() then return end
		
		-- Play sound.
    	self:PlayWeaponSound( "lightsaber/force_leap.wav" )

		-- Add callback to entity.
		local jedi = self:GetOwner()
		local identifier = math.Rand(1, 10000)
		
		hook.Add("EntityTakeDamage", "ForceSacrificeHook" .. identifier, function ()
				if (not self.takingDamage) then
					self.takingDamage = true
					-- If jedi would live, deal damage to jedi. Otherwise, remove the force power.
					if jedi:Health() < dmg:GetDamage() then 
						hook.Remove("EntityTakeDamage", "ForceSacrificeHook" .. identifier)
					else
						jedi:TakeDamage(dmg:GetDamage(), dmg:GetAttacker(), dmg:GetInflictor())
						dmg:SetDamage(0)
				end
				self.takingDamage = false
			end
		end)

		timer.Simple(60, function ()
			hook.Remove("EntityTakeDamage", "ForceSacrificeHook" .. identifier)
		end)

		-- Successful force power - remove force.
		self:SetForce(self:GetForce() - 100)
		return true
	end
})