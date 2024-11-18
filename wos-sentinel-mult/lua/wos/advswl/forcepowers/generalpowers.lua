wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Force Judgement",
		icon = "J",
		target = 1,
		image = "wos/forceicons/lightning.png",
		cooldown = 0,
		manualaim = false,
		description = "Let the force judge your opponent.",
		action = function( self )
			if ( self:GetForce() < 2 ) then return end
			local foundents = 0
			for id, ent in pairs( self:SelectTargets( 1 ) ) do
				if ( !IsValid( ent ) ) then continue end

				foundents = foundents + 1
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ent )
				util.Effect( "wos_emerald_lightning", ed, true, true )

				local dmg = DamageInfo()
				dmg:SetAttacker( self:GetOwner() || self )
				dmg:SetInflictor( self:GetOwner() || self )
				dmg:SetDamage( 7 )
				dmg:SetDamageForce( Vector(0,0,0) )

				local wep = ent:GetActiveWeapon()
				if IsValid( wep ) and wep.IsLightsaber and wep:GetBlocking() and wep:GetStamina() > 4 then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					wep:AddStamina( -5 )
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					ent:TakeDamageInfo( dmg )
				end
			end

			if ( foundents > 0 ) then
				self:GetOwner():SetNW2Float( "wos_cast_lightning_armed", CurTime() + 0.4 )
				self:SetForce( self:GetForce() - (foundents*2) )
				if ( !self.SoundLightning ) then
					self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
					self.SoundLightning:Play()
				else
					self.SoundLightning:Play()
				end

				timer.Create( "test", 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			end
			self:SetNextAttack( 0.1 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
name = "Force Stasis Old",
icon = "ST",
description = "The truth can bind us all.",
image = "wos/forceicons/push.png",
cooldown = 30,
manualaim = true,
action = function( self )
	if ( self:GetForce() < 5 ) then return end
	local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
	local ent = tr.Entity
	if not ent then return end
	if not ent:IsPlayer() then return end
	if self.Owner:GetPos():Distance( ent:GetPos() ) > 300 then return end
	local ed = EffectData()
	ed:SetOrigin( self:GetSaberPosAng() )
	ed:SetEntity( ent )
	util.Effect( "wos_emerald_lightning", ed, true, true )
	if ent.IsBlocking then
		ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
		if wOS.EnableStamina then
			ent:AddStamina( -5 )
		else
			ent:GetActiveWeapon():SetForce( ent:GetActiveWeapon():GetForce() - 1 )
		end
		ent:SetSequenceOverride( "h_block", 0.5 )
	else
		ent:SetNW2Float( "wOS.DisorientTime", CurTime() + 2 )
		ent:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 2 )
	end
	self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
	self:SetForce( self:GetForce() - 5 )
	if ( !self.SoundLightning ) then
		self.SoundLightning = CreateSound( self.Owner, "ambient/wind/wind_snippet2.wav" )
		self.SoundLightning:PlayEx( 0.5, 100 )
	else
		self.SoundLightning:PlayEx( 0.5, 100 )
	end
	timer.Create( "test" .. self.Owner:SteamID64(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
	-- self:SetNextAttack( 0.1 ) !!!
	return true
end,
})

wOS.ForcePowers:RegisterNewPower({
name = "Stasis",
icon = "S",
description = "The truth can bind us all.",
image = "wos/forceicons/push.png",
cooldown = 20,
manualaim = true,
action = function( self )
	if ( self:GetForce() < 20 ) then return end
	local ent = self:SelectTargets( 1 )[ 1 ]
	if not IsValid( ent ) then return end
	if not ent:IsPlayer() then return end

	self:SetForce( self:GetForce() - 20 )
	GMSERV:AddStatus(ent, self:GetOwner(), "stun", 10, 5, true)
	self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
	local ed = EffectData()
	ed:SetOrigin( self:GetSaberPosAng() )
	ed:SetEntity( ent )
	util.Effect( "wos_emerald_lightning", ed, true, true )

	return true
end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Mundis Hardened Force Push",
	icon = "HFP",
	target = 1,
	distance = 150,
	description = "Hurt your opponent for 200",
	image = "wos/forceicons/push.png",
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
		dmg:SetDamage( 200 )
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
	name = "Force Barrier",
	icon = "FS",
	image = "wos/forceicons/reflect.png",
	cooldown = 120,
	description = "Put up a force barrier that people can't pass.",
	action = function( self )
		if ( self:GetForce() < 100 || CLIENT ) then return end
			self:SetForce(self:GetForce() - 100)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/plates/plate2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 50 + self:GetOwner():EyeAngles():Forward() * 40)
			shield:SetAngles(self:GetOwner():EyeAngles() + Angle(90, 0, 0))
			shield:AddEffects(EF_NOSHADOW)
			shield:PhysicsInit( SOLID_VPHYSICS )
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
		name = "Shield",
		icon = "S",
		image = "wos/skilltrees/forms/aggressive.png",
		cooldown = 8,
		target = 1,
		manualaim = true,
		description = "Armor yourself and others. Alt to target others.",
		action = function( self )
			if ( self:GetForce() < 6 or CLIENT ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]

			if (self:GetOwner():KeyDown( IN_WALK ) && IsValid( ent ) && ent:IsPlayer()) then
				-- Give others armor.
				ent:SetArmor(math.min(self.Owner:Armor() + 100, self.Owner:GetMaxArmor()))

				self:SetForce(self:GetForce() - 20)
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				return true
			elseif (!self:GetOwner():KeyDown( IN_WALK )) then
				-- Give yourself armor.
				self.Owner:SetArmor(math.min(self.Owner:Armor() + 100, self.Owner:GetMaxArmor()))

				self:SetForce(self:GetForce() - 20)
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				return true
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sense",
		icon = "S",
		image = "wos/forceicons/meditate.png",
		cooldown = 30,
		description = "Sense all lifeforms around you.",
		action = function( self )
			if ( self:GetForce() < 50 or CLIENT ) then return end

			net.Start("arccw_scandart")
				net.WriteVector(self.Owner:GetPos())
				net.WriteInt(516, 16)
			net.Send(self.Owner)

			self:SetForce(self:GetForce() - 50)
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Choke",
		icon = "CH",
		description = "I find your lack of faith disturbing",
		image = "wos/forceicons/icefuse/choke.png",
		cooldown = 0,
		manualaim = true,
		action = function( self )
			if self:GetForce() < 4 then return end
			if IsValid( self.ChokeTarget ) then return end
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			if not tr.Entity then return end
			if not tr.Entity:IsPlayer() && not tr.Entity:IsNPC() then return end
			if self.Owner:GetPos():Distance( tr.Entity:GetPos() ) >= 300 then return end
			self.ChokeTarget = tr.Entity
			self.ChokeTarget:EmitSound( "wos/icefuse/choke_start.wav" )
			if tr.Entity:IsPlayer() then self.ChokeTarget:SetSequenceOverride( "wos_force_choke", 0.5)
			else self.ChokeTarget:SetSequence( "cower" ) end
            self.Owner:SetSequenceOverride( "wos_cast_choke_armed", 0.5)
			self.ChokePos = tr.Entity:GetPos()
			--self:SetNextAttack( 3 )
		end,
		think = function( self )
			if not IsValid( self.ChokeTarget ) then return end
			if self.ChokeTarget == nil then return end
			if not self.ChokeTarget:IsPlayer() && not self.ChokeTarget:IsNPC() then return end
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 2 ) then return end
			if ( self.ChokeTarget:IsPlayer() ) then if not self.ChokeTarget:Alive() then self.ChokeTarget = nil return end
			else if self.ChokeTarget:Health() <= 0 then self.ChokeTarget = nil return end end
			if ( !self.Owner:KeyDown( IN_ATTACK2 ) && !self.Owner:KeyReleased( IN_ATTACK2 ) ) then return end
			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			if ( !self.Owner:KeyReleased( IN_ATTACK2 ) ) then
				local dmg = DamageInfo()
				dmg:SetDamage( 3 )
				dmg:SetDamageType( DMG_SLASH )
				dmg:SetAttacker( self.Owner )
				dmg:SetInflictor( self )
				self.ChokeTarget:TakeDamageInfo( dmg )
				self.ChokeTarget:SetLocalVelocity( ( self.ChokePos - self.ChokeTarget:GetPos() + Vector( 0, 0, 55 ) )*5 )
				self.ChokeTarget:SetPos( Vector( self.ChokePos.x, self.ChokePos.y, math.min( self.ChokeTarget:GetPos().z + 0.5, self.ChokePos.z + 55 ) ) )
				self.ChokeTarget:SetLocalVelocity( Vector( 0, 0, 100 ) )
				self.ChokeTarget:SetNW2Float( "wOS.ChokeTime", CurTime() + 0.5 )
				self.Owner:SetSequenceOverride( "wos_cast_choke_armed", 0.5)
				self.ChokeTarget:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 0.5 )
				self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.1 )
				self:SetForce( self:GetForce() - 1.5 )
				if ( !self.SoundChoking ) then
					self.SoundChoking = CreateSound( self.Owner, "wos/icefuse/choke_active.wav" )
					self.SoundChoking:PlayEx( 0.25, 100 )
				else
					self.SoundChoking:PlayEx( 0.25, 100 )
				end
				timer.Create( "test" .. self.Owner:SteamID64() .. "_choke", 0.2, 1, function() if ( self.SoundChoking ) then self.SoundChoking:Stop() self.SoundChoking = nil end end )

				if ( !self.SoundGagging ) then
					self.SoundGagging = CreateSound( self.ChokeTarget, "wos/icefuse/choke_gagging.wav" )
					self.SoundGagging:Play()
				else
					self.SoundGagging:Play()
				end
				timer.Create( "test" .. self.Owner:SteamID64(), 0.2, 1, function() if ( self.SoundGagging ) then self.SoundGagging:Stop() self.SoundGagging = nil end end )
				if ( self:GetForce() < 1 ) then
					local ed = EffectData()
					self.ChokeTarget = nil
					--self:SetNextAttack( 1 )
				end
				--self.ChokeCooldown = CurTime() + 20
			else
				if not IsValid( self.ChokeTarget ) then return end
				local ed = EffectData()
				self.ChokeTarget = nil
				self:SetNextAttack( 1 )
			end
		end
})

util.AddNetworkString( "Battlemeditation" )
wOS.ForcePowers:RegisterNewPower({
		name = "Battle Meditation",
		icon = "BM",
		image = "wos/forceicons/absorb.png",
		cooldown = 0,
		description = "Affect results of entire battles with just thoughts",
		think = function( self )
			if self.MeditateCooldown and self.MeditateCooldown >= CurTime() then return end
			if ( self.Owner:KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() then
				if !self._ForceMeditating then
					GAMEMODE.battlemeditation = self.Owner:Nick()
					--[[net.Start("Battlemeditation")
						net.WriteBool(true)
						net.WriteUInt(self.Owner:EntIndex(), 32)
					net.Broadcast()]]
					BattlemeditationMVGDamageReduction = true
				end
				self._ForceMeditating = true
			else
				if self._ForceMeditating then
					--[[net.Start("Battlemeditation")
						net.WriteBool(false)
					net.Broadcast()]]
					BattlemeditationMVGDamageReduction = false
				end
				self._ForceMeditating = false
			end
			if self._ForceMeditating then
				self.Owner:SetNW2Bool("IsMeditating", true)
				self.Owner:SetLocalVelocity(Vector(0, 0, 0))
				self.Owner:SetMoveType(MOVETYPE_NONE)
				local ed = EffectData()
				ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 0 ) )
				ed:SetRadius( 50 )
				util.Effect( "rb655_force_repulse_out", ed, true, true )
			else
				self.Owner:SetNW2Bool("IsMeditating", false)
				GAMEMODE.battlemeditation = false
				if self:GetMoveType() != MOVETYPE_WALK then
					self.Owner:SetMoveType(MOVETYPE_WALK)
				end
			end
			if self.Owner:KeyReleased( IN_ATTACK2 ) then
				self.MeditateCooldown = CurTime() + 3
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Channel",
		icon = "HT",
		image = "wos/forceicons/channel_hatred.png",
		description = "I can feel the force that surrounds us",
		think = function( self )
			if self.ChannelCooldown and self.ChannelCooldown >= CurTime() then return end
			if ( self:GetOwner():KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self:GetOwner():OnGround() then
				self._ForceChanneling = true
			else
				self._ForceChanneling = false
			end
			if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
				self.ChannelCooldown = CurTime() + 5
			end
			if self._ForceChanneling then
				if not self._NextChannelHeal then self._NextChannelHeal = 0 end
				self:GetOwner():SetNW2Bool("wOS.IsChanneling", true)
				if self._NextChannelHeal < CurTime() then
					-- Force Channeling no longer heals.
					--self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*0.10 ), self:GetOwner():GetMaxHealth() ) )
					if #self.DevestatorList > 0 then
						self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge + 10 )
					end
					local tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ]
					if not tbl then
						tbl = wOS.ALCS.Config.Skills.ExperienceTable[ "Default" ].Meditation
					else
						tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ].Meditation
					end
					self:GetOwner():AddSkillXP( tbl )
					self._NextChannelHeal = CurTime() + 2
				end
				self:GetOwner():SetLocalVelocity(Vector(0, 0, 0))
				self:GetOwner():SetMoveType(MOVETYPE_NONE)
				if ( !self.SoundChanneling ) then
					self.SoundChanneling = CreateSound( self:GetOwner(), "ambient/levels/citadel/portal_beam_loop1.wav" )
					self.SoundChanneling:Play()
				else
					self.SoundChanneling:Play()
				end

				timer.Create( "test", 0.2, 1, function() if ( self.SoundChanneling ) then self.SoundChanneling:Stop() self.SoundChanneling = nil end end )
			else
				self:GetOwner():SetNW2Bool("wOS.IsChanneling", false)
				if self:GetMoveType() != MOVETYPE_WALK and self:GetOwner():GetNW2Float( "wOS.DevestatorTime", 0 ) < CurTime() then
					self:GetOwner():SetMoveType(MOVETYPE_WALK)
				end
			end
			if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
				self.ChannelCooldown = CurTime() + 5
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Force Reflect",
    icon = "FR",
    image = "wos/forceicons/reflect.png",
    cooldown = 45,
    description = "Reflect all damage for 2 seconds",
    action = function( self )
    if ( self:GetForce() < 100 || !self:GetOwner():IsOnGround() ) then return end
        if self:GetOwner():GetNW2Float( "ReflectTime", 2 ) >= CurTime() then return end
        self:SetForce( self:GetForce() - 100 )
        self:SetNextAttack( 0.7 )
        self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        self:GetOwner():SetNW2Float( "ReflectTime", CurTime() + 2.5 )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Advanced Cloak",
		icon = "AC",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 45,
		description = "Shrowd yourself with the force.",
		action = function( self )
			if (self:GetCloaking()) then
				-- If cloaking, go on CD and turn cloak off so you can attack.
				self.CloakTime = CurTime()
				self:GetOwner():SetNoTarget(false)
				timer.Remove("wos.Custom.Cloaking." .. self:GetOwner():SteamID64() .. self.CloakRandomNumber)
				return true
			end	
			if ( self:GetForce() < 50) then return end

			self:SetForce( self:GetForce() - 25 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.CloakRandomNumber = math.random(1, 1000)

			self.CloakTime = CurTime() + 3600
			-- Look up timer.Create and see delay and repitions in the arguments. You will see why it's like this.
			timer.Create("wos.Custom.Cloaking." .. self:GetOwner():SteamID64() .. self.CloakRandomNumber, 0.25, 0, function()
				if self:GetCloaking() then 
					if (self:GetForce() <= 1) then
						-- If out of force, turn cloak off.
						self.CloakTime = CurTime()
						self:GetOwner():SetNoTarget(false)
						timer.Remove("wos.Custom.Cloaking." .. self:GetOwner():SteamID64() .. self.CloakRandomNumber)
						do return end
					end

					if self.Owner:GetVelocity():Length() > 130 then
						self:SetForce( self:GetForce() - 1.5 )
					elseif self.Owner:GetVelocity():Length() > 40 then
						self:SetForce( self:GetForce() - 0.5 )
					end

					self:GetOwner():SetNoTarget(true)
				else
					self:GetOwner():SetNoTarget(false)
				end	
			end)
		end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Disabling Strike",
    icon = "DS",
    distance = 30,
    image = "wos/forceicons/shadow_strike.png",
    cooldown = 45,
    target = 1,
    manualaim = false,
    description = "Disable an opponent - hopefully they'll surrender",
    action = function( self )
        if !self:GetCloaking() then return end
        local ent = self:SelectTargets( 1, 30 )[ 1 ]
        if (!IsValid( ent ) || !ent:IsPlayer()) then return end
        if ( self:GetForce() < 50 ) then return end
        self:GetOwner():SetSequenceOverride("b_c3_t2", 0.4)
        self:SetForce( self:GetForce() - 50 )
        self:GetOwner():EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
        self:GetOwner():AnimResetGestureSlot( GESTURE_SLOT_CUSTOM )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        ent:TakeDamage( 200, self:GetOwner(), self )
		
		ent:SetNW2Float( "wOS.BlindTime", CurTime() + 11 )
		ent:SetNW2Float( "wOS.DisorientTime", CurTime() + 1 )
		ent:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 1 )
		ent:SetNW2Float( "WOS_CripplingSlow", CurTime() + 4 )
		
        self.CloakTime = CurTime() + 0.2
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Deflect",
		icon = "D",
		image = "wos/forceicons/absorb.png",
		cooldown = 60,
		description = "For a brief period, be able to deflect anything",
		action = function( self )
			if ( self:GetForce() < 80) then return end
			self:SetForce( self:GetForce() - 80 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			local maxStamina = self:GetMaxStamina()
			self:SetMaxStamina(98)
			local wep = self
			-- Every X seconds, give Obi full stamina. 
			timer.Create("wos.Custom.ObiStamina." .. self.Owner:SteamID64(), 0.5, 20, function() 
				wep:SetStamina(wep:GetMaxStamina())
			end)
			timer.Simple(10, function()
				wep:SetMaxStamina(maxStamina)
			end)
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Shatter Point",
		icon = "SP",
		image = "wos/forceicons/shadow_strike.png",
		cooldown = 50,
		description = "Unleash your focused mind",
		action = function( self )
		if ( self:GetForce() < 80 ) then return end
			if self:GetOwner():GetNW2Float( "WinduRageTime", 25 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 80 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			local saberDamage = self.SaberDamage
			self.SaberDamage = saberDamage + 200
			self:GetOwner():SetNW2Float( "WinduRageTime", CurTime() + 25 )
			timer.Simple(25, function()
				self.SaberDamage = saberDamage
			end)
			return true
		end
})