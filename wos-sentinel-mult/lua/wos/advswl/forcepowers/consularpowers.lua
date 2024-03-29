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
	cooldown = 180,
	manualaim = true,
	description = "Hover over a friend, and protect them from harm",
	action = function( self )
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
		ent:SetArmor(originalArmor + 200)
		timer.Simple(10, function()
			ent:SetArmor(math.min(originalArmor, ent:Armor()))
		end)
		
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
		timer.Simple(45, function()
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
	description = "Protect yourself and those behind you.",
	action = function( self )
		if ( self:GetForce() < 100 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
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
			if ( self:GetForce() < 80 ) then return end
			local players = 0
			for _, ply in pairs( ents.FindInSphere( self:GetOwner():GetPos(), 200 ) ) do
				if not IsValid( ply ) then continue end
				if not ply:IsPlayer() then continue end
				if not ply:Alive() then continue end
				if players >= 8 then break end
				ply:SetHealth( math.Clamp( ply:Health() + 200, 0, ply:GetMaxHealth() ) )
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ply )
				util.Effect( "rb655_force_heal", ed, true, true )
				players = players + 1
			end
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.6 )
			self:SetForce( self:GetForce() - 80 )
			-- TODO: Add to these xp tables, figure out a healing->XP system.
			local tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ]
			if not tbl then
				tbl = wOS.ALCS.Config.Skills.ExperienceTable[ "Default" ].XPPerHeal
			else
				tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ].XPPerHeal
			end
			self:GetOwner():AddSkillXP( tbl )
    		self:PlayWeaponSound( "lightsaber/force_leap.wav" )
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
		description = "Heal yourself.",
		action = function( self )
			if ( self:GetForce() < 6 or CLIENT ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			self:SetNextAttack( 0.2 )

			if (self:GetOwner():KeyDown( IN_WALK ) && IsValid( ent ) && ent:IsPlayer()) then
				if (ent:Health() >= ent:GetMaxHealth()) then return end
				local ed = EffectData()
				ed:SetOrigin( ent:GetPos() )
				ent:SetHealth( math.min(ent:Health() + 10, ent:GetMaxHealth()))
				ent:Extinguish()
				self:SetForce( self:GetForce() - 6 )
				util.Effect( "rb655_force_heal", ed, true, true )
			elseif (self:GetOwner():KeyDown( IN_DUCK ) && self.GroupHeal ) then
				if ( self:GetForce() < 80 ) then return end
				local players = 0
				for _, ply in pairs( ents.FindInSphere( self:GetOwner():GetPos(), 200 ) ) do
					if not IsValid( ply ) then continue end
					if not ply:IsPlayer() then continue end
					if not ply:Alive() then continue end
					if players >= 8 then break end
					ply:SetHealth( math.Clamp( ply:Health() + 200, 0, ply:GetMaxHealth() ) )
					players = players + 1
				end
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ply )
				util.Effect( "rb655_force_heal", ed, true, true )
				self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.6 )
				self:SetForce( self:GetForce() - 80 )
				return true
			elseif (!self:GetOwner():KeyDown( IN_WALK )) then
				if (self:GetOwner():Health() >= self:GetOwner():GetMaxHealth()) then return end
				local ed = EffectData()
				ed:SetOrigin( self:GetOwner():GetPos() )
				self:GetOwner():SetHealth( math.min(self:GetOwner():Health() + 10, self:GetOwner():GetMaxHealth()) )
				self:GetOwner():Extinguish()
				--self:SetForce( self:GetForce() - 6 )
				util.Effect( "rb655_force_heal", ed, true, true )
			end
		end
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
			self:SetNextAttack( 1.5 )
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
			self:SetNextAttack( 1.5 )
			return true
		end,
})