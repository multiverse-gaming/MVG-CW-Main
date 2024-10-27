wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
	name = "Sense Weakness",
	icon = "SW",
	target = 1,
	image = "wos/forceicons/shadow_strike.png",
	cooldown = 3,
	manualaim = true,
	description = "They glow red if they're weak",
	action = function( self )
		if (self:GetForce() < 15) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) || !ent:IsPlayer() then return end
		self:SetForce( self:GetForce() - 15 )
		self:PlayWeaponSound( "lightsaber/force_leap.wav" )
		
		-- Takes 15 force to scan people, but only goes on cooldown if it successfully shows someone up.
		if ent:Health() <= 200 then
			ent:SetNW2Float( "WeaknessTime", CurTime() + 5 )
			return true
		end
		
		return
	end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Protect",
	icon = "FP",
	target = 1,
	image = "wos/forceicons/pull.png",
	cooldown = 20,
	manualaim = true,
	description = "Hover over a friend, and protect them from harm",
	action = function( self )
		if (self.ProtectCD ~= nil && self.ProtectCD > CurTime()) then return end
		if (self:GetForce() < 90) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) || !ent:IsPlayer() then return end
		self:SetForce( self:GetForce() - 90 )
		self:PlayWeaponSound( "lightsaber/force_leap.wav" )
		
		timer.Create( "ProtectTimer", 1, 9, function()
			local ed = EffectData()
			ed:SetOrigin( ent:GetPos() + Vector( 0, 0, 0 ) )
			ed:SetRadius( 50 )
			util.Effect( "rb655_force_repulse_out", ed, true, true )
		end )

		local originalArmor = ent:Armor()
		ent:SetArmor(originalArmor + 150)
		timer.Simple(20, function()
			ent:SetArmor(math.min(ent:Armor(), math.max(originalArmor, ent:GetMaxArmor())))
		end)

		-- Global CD for shared ability.
		self.ProtectCD = CurTime() + 20
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Buff",
	icon = "FB",
	image = "wos/devestators/sonic.png",
	cooldown = 120,
	description = "Have a higher cap of force for a time",
	action = function( self )
		if ( self:GetForce() < 50 ) then return end
		self:SetForce( self:GetForce() - 50 )
    	self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        
		self:SetMaxForce(self:GetMaxForce() + 100)
		timer.Simple(120, function()
			self:SetMaxForce(self:GetMaxForce() - 100)
		end)
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Shield",
	icon = "FS",
	image = "wos/forceicons/reflect.png",
	cooldown = 120,
	description = "Default - Shield, Run - Group Shield",
	action = function( self )
		local shieldDuration = 15
		if (self.ShieldIdleDuration != nil) then shieldDuration = 25 end
		local shieldCD = 120
		if (self.ShieldIdleCD != nil) then shieldCD = 90 end
		local shieldCost = 100
		if (self.ShieldIdleCost != nil) then shieldCost = 80 end
		
		if ((!self:GetOwner():KeyDown( IN_SPEED ))) then
			if ( self:GetForce() < shieldCost || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			if ( !(self.ForceShield) ) then return end
			if (self.ShieldCD ~= nil && self.ShieldCD > CurTime()) then return end
			self:SetForce(self:GetForce() - shieldCost)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/plates/plate2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 50 + self:GetOwner():EyeAngles():Forward() * 40)
			shield:SetAngles(self:GetOwner():EyeAngles() + Angle(90, 0, 0))
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_BSP)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()

			timer.Simple(shieldDuration, function()
				if shield:IsValid() then
					shield:Remove()
				end
			end)

			-- Global CD for shared ability.
			self.ShieldCD = CurTime() + shieldCD
		elseif self.GroupShield then
			if ( self:GetForce() < shieldCost + 50 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			if (self.GroupShieldCD ~= nil && self.GroupShieldCD > CurTime()) then return end
			self:SetForce(self:GetForce() - shieldCost + 50)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/tubes/tube4x4x2to2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 45)
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_VPHYSICS)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()

			timer.Simple(shieldDuration, function()
				if shield:IsValid() then
					shield:Remove()
				end
			end)

			-- Global CD for shared ability.
			self.GroupShieldCD = CurTime() + shieldCD + 30
		end
	end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Small Shield",
	icon = "S",
	image = "wos/forceicons/reflect.png",
	cooldown = 120,
	description = "A smaller version of the main shield",
	action = function( self )
			local shieldDuration = 15
			if (self.ShieldIdleDuration != nil) then shieldDuration = 25 end
			local shieldCost = 100
			if (self.ShieldIdleCost != nil) then shieldCost = 80 end
		
			if ( self:GetForce() < shieldCost || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			self:SetForce(self:GetForce() - shieldCost)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/props_phx/construct/glass/glass_curve180x1.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 45)
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_VPHYSICS)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()

			timer.Simple(shieldDuration, function()
				if shield:IsValid() then
					shield:Remove()
				end
			end)
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Shield Old",
	icon = "FS",
	image = "wos/forceicons/reflect.png",
	cooldown = 120,
	description = "Protect yourself and those behind you.",
	action = function( self )
		if ( self:GetForce() < 100 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
		if (self.ShieldCD ~= nil && self.ShieldCD > CurTime()) then return end
			self:SetForce(self:GetForce() - 100)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/plates/plate2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 50 + self:GetOwner():EyeAngles():Forward() * 40)
			shield:SetAngles(self:GetOwner():EyeAngles() + Angle(90, 0, 0))
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_BSP)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()

			timer.Simple(15, function()
				if shield:IsValid() then
					shield:Remove()
				end
			end)

			-- Global CD for shared ability.
			self.ShieldCD = CurTime() + 120
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Group Shield",
	icon = "FGS",
	image = "wos/forceicons/reflect.png",
	cooldown = 150,
	description = "Protect yourself and those around you.",
	action = function( self )
		if ( self:GetForce() < 150 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
		if (self.GroupShieldCD ~= nil && self.GroupShieldCD > CurTime()) then return end
			self:SetForce(self:GetForce() - 150)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/tubes/tube4x4x2to2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 45)
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_VPHYSICS)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()

			timer.Simple(15, function()
				if shield:IsValid() then
					shield:Remove()
				end
			end)

			-- Global CD for shared ability.
			self.GroupShieldCD = CurTime() + 150
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Group Heal",
		icon = "GH",
		image = "wos/forceicons/group_heal.png",
		cooldown = 60,
		manualaim = false,
		description = "Heals all around you.",
		action = function( self )
			-- Check Global CD for shared skill.
			if (self.GroupHealCD != nil && self.GroupHealCD > CurTime()) then return end
			local groupHealAmount = 200
			if (self.HealIdleAmount != nil) then groupHealAmount = 250 end

			-- Do the regular ability.
			if ( self:GetForce() < 80 ) then return end
			local players = 0
			for _, ply in pairs( ents.FindInSphere( self:GetOwner():GetPos(), 200 ) ) do
				if not IsValid( ply ) then continue end
				if not ply:IsPlayer() then continue end
				if not ply:Alive() then continue end
				if players >= 8 then break end
				ply:SetHealth( math.Clamp( ply:Health() + groupHealAmount, 0, ply:GetMaxHealth() ) )
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ply )
				util.Effect( "rb655_force_heal", ed, true, true )
				players = players + 1
			end
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.6 )
			self:SetForce( self:GetForce() - 80 )
			-- TODO: Add to these xp tables, figure out a healing->XP system.
			if (players > 2) then
				self:GetOwner():AddSkillXP( 15 )
			end
    		self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			-- Global CD for shared ability.
			self.GroupHealCD = CurTime() + 60
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Consular Force Heal",
		icon = "H",
		image = "wos/forceicons/heal.png",
		cooldown = 60,
		target = 1,
		manualaim = true,
		description = "Default - Heal Self, Sprint - Protect, Crouch - Group Heal, Walk - Heal Others",
		action = function( self )
			if ( self:GetForce() < 6 or CLIENT ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]

			if (self:GetOwner():KeyDown( IN_WALK )) then
				if (self:GetOwner():Health() >= self:GetOwner():GetMaxHealth()) then return end
				local healSelfAmount = 10
				if (self.HealIdleAmount != nil) then healSelfAmount = 12 end
				
				local ed = EffectData()
				ed:SetOrigin( self:GetOwner():GetPos() )
				util.Effect( "rb655_force_heal", ed, true, true )
				self:GetOwner():SetHealth( math.min(self:GetOwner():Health() + healSelfAmount, self:GetOwner():GetMaxHealth()) )
				self:GetOwner():Extinguish()

				local forceCost = 6
				if (self.HealIdleCost != nil) then forceCost = 5 end
				self:SetForce( self:GetForce() - forceCost )

				local healCD = 0.3
				if (self.HealIdleCD != nil) then healCD = 0.2 end
				self:SetNextAttack( healCD )
			elseif (self:GetOwner():KeyDown( IN_DUCK ) && self.GroupHeal ) then
				-- Check Global CD for shared skill.
				if (self.GroupHealCD ~= nil && self.GroupHealCD > CurTime()) then return end
				local groupHealAmount = 200
				if (self.HealIdleAmount != nil) then groupHealAmount = 250 end
	
				-- Do the regular ability.
				if ( self:GetForce() < 80 ) then return end
				local players = 0
				for _, ply in pairs( ents.FindInSphere( self:GetOwner():GetPos(), 200 ) ) do
					if not IsValid( ply ) then continue end
					if not ply:IsPlayer() then continue end
					if not ply:Alive() then continue end
					if players >= 8 then break end
					ply:SetHealth( math.Clamp( ply:Health() + groupHealAmount, 0, ply:GetMaxHealth() ) )
					players = players + 1
				end
				if (players > 2) then
					self:GetOwner():AddSkillXP( 15 )
				end
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ply )
				util.Effect( "rb655_force_heal", ed, true, true )
				self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.6 )

				local forceCost = 80
				if (self.HealIdleCost != nil) then forceCost = 60 end
				self:SetForce( self:GetForce() - forceCost )

				-- Global CD for shared ability.
				self.GroupHealCD = CurTime() + 60

			elseif (self:GetOwner():KeyDown( IN_SPEED ) && self.ForceProtect ) then
				if (self.ProtectCD ~= nil && self.ProtectCD > CurTime()) then return end
				if (self:GetForce() < 90) then return end
				local ent = self:SelectTargets( 1 )[ 1 ]
				if not IsValid( ent ) || !ent:IsPlayer() then return end
				self:SetForce( self:GetForce() - 90 )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )

				timer.Create( "ProtectTimer", 1, 9, function()
					local ed = EffectData()
					ed:SetOrigin( ent:GetPos() + Vector( 0, 0, 0 ) )
					ed:SetRadius( 50 )
					util.Effect( "rb655_force_repulse_out", ed, true, true )
				end )

				local originalArmor = ent:Armor()
				ent:SetArmor(originalArmor + 150)
				timer.Simple(20, function()
					ent:SetArmor(math.min(ent:Armor(), math.max(originalArmor, ent:GetMaxArmor())))
				end)

				-- Global CD for shared ability.
				self.ProtectCD = CurTime() + 20

			elseif (!self:GetOwner():KeyDown( IN_WALK ) && IsValid( ent ) && ent:IsPlayer()) then
				if (ent:Health() >= ent:GetMaxHealth()) then return end
				local healCD = 0.3
				if (self.HealIdleCD != nil) then healCD = 0.2 end
				self:SetNextAttack( healCD )

				local healOtherAmount = 20
				if (self.HealIdleAmount != nil) then healOtherAmount = 25 end

				local ed = EffectData()
				ed:SetOrigin( ent:GetPos() )
				ent:SetHealth( math.min(ent:Health() + healOtherAmount, ent:GetMaxHealth()))
				ent:Extinguish()
				--self:SetForce( self:GetForce() - 6 )
				util.Effect( "rb655_force_heal", ed, true, true )
				self:GetOwner():AddSkillXP( 1 )
		end
	end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Group Push Pull",
		icon = "GPP",
		target = 50,
		distance = 650,
		description = "Default - Pull All, Sprint - Push All",
		image = "wos/forceicons/icefuse/group_push.png",
		manualaim = false,
		action = function( self )
		if (self:GetOwner():KeyDown( IN_SPEED )) then
			if (!(self.GroupPush)) then return end
			if (self.GroupPushCD ~= nil && self.GroupPushCD > CurTime()) then return end
			if ( self:GetForce() < 20 ) then return end
			local foundents = self:SelectTargets( 50 )
			if #foundents < 1 then return end
			for id, ent in pairs( foundents ) do
				local newpos = ( self.Owner:GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*-850 + Vector( 0, 0, 300 ) )
				if ent:IsPlayer() then
					local time = ent:SetSequenceOverride( "h_reaction_upper", 2 )
				end
			end
			self:SetForce( self:GetForce() - 20 )
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			
			self.GroupPushCD = CurTime() + 8

		elseif self.GroupPull then
			if ( self:GetForce() < 20 ) then return end
			if (self.GroupPullCD ~= nil && self.GroupPullCD > CurTime()) then return end
			local foundents = self:SelectTargets( 15 )

			if #foundents < 1 then return end
			for id, ent in pairs( foundents ) do
				local newpos = ( self.Owner:GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*300 + Vector( 0, 0, 300 ) ) --ent:SetVelocity( newpos*100 + Vector( 0, 0, 300 ) )
				if ent:IsPlayer() then
					local time = ent:SetSequenceOverride( "wos_bs_shared_recover_forward", 2)
				end
			end

			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			self:SetForce( self:GetForce() - 20 )
			
			self.GroupPullCD = CurTime() + 8
		end
		end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Group Push",
		icon = "GPH",
		target = 50,
		distance = 650,
		description = "They are no harm at a distance",
		image = "wos/forceicons/icefuse/group_push.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 20 ) then return end
			local foundents = self:SelectTargets( 50, 650 )
			if #foundents < 1 then return end
			for id, ent in pairs( foundents ) do
				local newpos = ( self.Owner:GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*-850 + Vector( 0, 0, 300 ) )
				if ent:IsPlayer() then
					local time = ent:SetSequenceOverride( "h_reaction_upper", 2 )
				end
			end
			self:SetForce( self:GetForce() - 20 )
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Group Pull",
		icon = "GPL",
		target = 50,
		description = "Get over here!",
		image = "wos/forceicons/icefuse/group_pull.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 20 ) then return end
			local foundents = self:SelectTargets( 5 )

			if #foundents < 1 then return end
			for id, ent in pairs( foundents ) do
				local newpos = ( self.Owner:GetPos() - ent:GetPos() )
				newpos = newpos / newpos:Length()
				ent:SetVelocity( newpos*300 + Vector( 0, 0, 300 ) ) --ent:SetVelocity( newpos*100 + Vector( 0, 0, 300 ) )
				if ent:IsPlayer() then
					local time = ent:SetSequenceOverride( "wos_bs_shared_recover_forward", 2)
				end
			end

			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			self:SetForce( self:GetForce() - 20 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({ -- As is, does not yet work.
	name = "Force Sacrifice",
	icon = "SC",
	target = 1,
	distance = 150,
	description = "Sacrifice your life for your ally",
	image = "wos/forceicons/throw.png",
	cooldown = 150,
	manualaim = true,
	action = function( self )
		-- If force below a certain amount, or owner would instantly get removed from the EntityTakeDamage, or bad target, stop.
		if ( self:GetForce() < 100 || self:GetOwner():Health() < 50 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) || !ent:IsPlayer() then return end
		
		-- Play sound.
    	self:PlayWeaponSound( "lightsaber/force_leap.wav" )

		-- Add hook, with a specific name and only applying to the targeted player.
		local jedi = self:GetOwner()
		local hookName = jedi:SteamID64() .. ".ForceSacrificeHook." .. math.random(1, 100000)
		local deathHookName = jedi:SteamID64() .. ".ForceSacrificeDeathHook"
		hook.Add("EntityTakeDamage", hookName, function ( target, dmginfo )
			-- If the player targeted is the entity.
			if (target == ent) then
				if (jedi.fsac_takingDamag == nil || not jedi.fsac_takingDamage) then
					jedi.fsac_takingDamage = true
					-- If jedi would live, deal damage to jedi. Otherwise, remove the force power.
					if jedi:Health() < dmginfo:GetDamage() then 
						hook.Remove("EntityTakeDamage", hookName)
						hook.Remove("PostPlayerDeath", deathHookName)
					else
						jedi:TakeDamage(dmginfo:GetDamage(), dmginfo:GetAttacker(), dmginfo:GetInflictor())
						dmginfo:SetDamage(0)
						jedi.fsac_takingDamage = false
					end
				end
			end
		end)
		hook.Add("PostPlayerDeath", deathHookName, function ( ply )
			if (ply == jedi || ply == ent) then --if (ply:SteamID64() == jedi:SteamID64()) then
				hook.Remove("EntityTakeDamage", hookName)
				hook.Remove("PostPlayerDeath", deathHookName)
			end			
		end)

		timer.Simple(10, function ()
			hook.Remove("EntityTakeDamage", hookName)
			hook.Remove("PostPlayerDeath", deathHookName)
		end)

		-- Successful force power - remove force.
		self:SetForce(self:GetForce() - 100)
		return true
	end
})

util.AddNetworkString( "SetReviveOnWeapon" )
wOS.ForcePowers:RegisterNewPower({
		name = "Revive",
		icon = "R",
		description = "Sacrifice your own health for an ally.",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 180,
		action = function( self )
			if ( self:GetForce() < 150 ) then return end
			if ( self:GetOwner():Health() < 200 ) then return end
			
			self.HPAfterRespawn = self:GetOwner():Health() / 2
			net.Start("defibgetents")
			net.Send(self.Owner)
			
			self:SetForce(self:GetForce() - 150)
			self:GetOwner():SetHealth(self:GetOwner():Health() / 2)
			return true
		end,
})