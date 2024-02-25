--[[-------------------------------------------------------------------]]--[[

	Copyright wiltOS Technologies LLC, 2020

	Contact: www.wiltostech.com
		----------------------------------------]]--








































































wOS = wOS or {}

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
			name = "Charge",
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

wOS.ForcePowers:RegisterNewPower({
			name = "Master Force Leap",
			icon = "DL",
			image = "wos/forceicons/leap.png",
			description = "Mastering the power of leap you are able to do it twice in once try",
			action = function( self )
				if ( self:GetForce() < 40 || CLIENT ) then return end
				self:SetForce( self:GetForce() - 40 )
				self:SetNextAttack( 0.5 )
				self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 512 + Vector( 0, 0, 512 ) )
				self:PlayWeaponSound( "lightsaber/force_leap.wav" )
				// Trigger the jump animation, yay
				self:CallOnClient( "ForceJumpAnim", "" )
				--self:SetNextAttack( 1.0 )
			end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Charge",
		icon = "CH",
		distance = 600,
		image = "wos/forceicons/charge.png",
		target = 1,
		cooldown = 0,
		manualaim = true,
		description = "Lunge at your enemy",
		action = function( self )
			local ent = self:SelectTargets( 1, 1000 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.2 ) return end
			local newpos = ( ent:GetPos() - self:GetOwner():GetPos() )
			newpos = newpos / newpos:Length()
			self:GetOwner():SetLocalVelocity( newpos*500 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 20 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetSequenceOverride( "dash_forward", 5 )
			self:SetNextAttack( 0.5 )
			self.AerialLand = false
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Dash",
		icon = "DH",
		image = "wos/forceicons/charge.png",
		cooldown = 0,
		description = "Dash toward your enemies to reach them faster",
		action = function ( self )
			if ( self:GetForce() < 20 || CLIENT ) then return end
			self:SetForce( self:GetForce() - 20 )
			self:SetNextAttack( 2.5 )
			self:GetOwner():SetVelocity( self:GetOwner():GetForward() * 750 + Vector( 0, 0, 100 ) )
			--self:GetOwner():SetVelocity( self:GetOwner():GetForward() * 2000 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetSequence( "dash_forward" )
			return true
		end
})



wOS.ForcePowers:RegisterNewPower({
		name = "Force Absorb",
		icon = "A",
		image = "wos/forceicons/absorb.png",
		cooldown = 0,
		description = "Hold Mouse 2 to protect yourself from harm",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end
			self:SetForce( self:GetForce() - 0.1 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.6 )
			self:SetNextAttack( 0.3 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Saber Throw",
		icon = "T",
		image = "wos/forceicons/throw.png",
		cooldown = 5,
		manualaim = false,
		description = "Throws your lightsaber. It will return to you.",
		action = function(self)
			if self:GetForce() < 20 then return end
			self:SetForce( self:GetForce() - 20 )
			self:SetEnabled(false)
			self:SetBladeLength(0)
			self:SetNextAttack( 1 )
			self:GetOwner():DrawWorldModel(false)

			local ent = ents.Create("ent_lightsaber_thrown")
			ent:SetModel(self:GetWorldModel())
			ent:Spawn()
			ent.CustomSettings = table.Copy( self.CustomSettings )
			ent:SetBladeLength(self:GetMaxLength())
			ent:SetMaxLength(self:GetMaxLength())
			ent:SetBladeWidth( self:GetBladeWidth() )

			ent:SetCrystalColor(self:GetCrystalColor())
			ent:SetInnerColor( self:GetInnerColor() )

			ent:SetDarkInner( self:GetDarkInner() )

			ent:SetWorldModel( self:GetWorldModel() )
			ent.SaberThrowDamage = self.SaberThrowDamage
			local pos = self:GetSaberPosAng()
			ent:SetPos(pos)
			pos = pos + self:GetOwner():GetAimVector() * 750
			ent:SetEndPos(pos)
			ent:SetOwner(self:GetOwner())
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Unrelenting Advance",
		icon = "UA",
		image = "wos/forceicons/absorb.png",
		cooldown = 0,
		description = "You spin me right round, baby right round, like a record baby, right round round round",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end
			self:SetForce( self:GetForce() - 0.1 )
			self:GetOwner():SetNW2Float( "wOS.GrievousAnim", CurTime() + 0.6 )
			self:SetNextAttack( 0.3 )
			--self:GetOwner():SetNW2Float( "BlockTime", CurTime() + 0.6 )
			return true
		end
})


wOS.ForcePowers:RegisterNewPower({
		name = "Force Heal",
		icon = "H",
		image = "wos/forceicons/heal.png",
		cooldown = 0,
		target = 1,
		manualaim = false,
		description = "Heal yourself.",
		action = function( self )
			if ( self:GetForce() < 1 --[[|| !self:GetOwner():IsOnGround()]] or self:GetOwner():Health() >= 1000 or CLIENT ) then return end
			self:SetForce( self:GetForce() - 1 )

			self:SetNextAttack( 0.2 )

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() )
			util.Effect( "rb655_force_heal", ed, true, true )

			self:GetOwner():SetHealth( self:GetOwner():Health() + 5 )
			self:GetOwner():Extinguish()
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Advanced Force Heal",
		icon = "H",
		image = "wos/forceicons/heal.png",
		cooldown = 0,
		target = 1,
		manualaim = false,
		description = "Heal yourself.",
		action = function( self )
			if ( self:GetForce() < 4 --[[|| !self:GetOwner():IsOnGround()]] or self:GetOwner():Health() >= 1000 or CLIENT ) then return end
			self:SetForce( self:GetForce() - 4 )

			self:SetNextAttack( 0.2 )

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() )
			util.Effect( "rb655_force_heal", ed, true, true )

			self:GetOwner():SetHealth( self:GetOwner():Health() + 20 )
			self:GetOwner():Extinguish()
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
			self:SetForce( self:GetForce() - 150 )
			local tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ]
			if not tbl then
				tbl = wOS.ALCS.Config.Skills.ExperienceTable[ "Default" ].XPPerHeal
			else
				tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ].XPPerHeal
			end
			self:GetOwner():AddSkillXP( tbl )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Reflect",
		icon = "FR",
		image = "wos/forceicons/reflect.png",
		cooldown = 60,
		description = "An eye for an eye",
		action = function( self )
		if ( self:GetForce() < 100 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetOwner():GetNW2Float( "ReflectTime", 5 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 100 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetNW2Float( "ReflectTime", CurTime() + 5 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Reflect Half",
	icon = "FR",
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
		name = "Rage",
		icon = "RA",
		image = "wos/forceicons/rage.png",
		cooldown = 0,
		description = "Unleash your anger",
		action = function( self )
		if ( self:GetForce() < 50 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetOwner():GetNW2Float( "RageTime", 0 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 50 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetNW2Float( "RageTime", CurTime() + 10 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Valor",
		icon = "RA",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 60,
		description = "Unleash your focused mind",
		action = function( self )
		if ( self:GetForce() < 50 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetOwner():GetNW2Float( "RageTime", 10 ) >= CurTime() then return end
			self:SetForce( self:GetForce() - 60 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self:GetOwner():SetNW2Float( "RageTime", CurTime() + 20 )
			return true
		end
})


wOS.ForcePowers:RegisterNewPower({
		name = "Force Judgement",
		icon = "L",
		target = 1,
		image = "wos/forceicons/lightning.png",
		cooldown = 0,
		manualaim = false,
		description = "Torture people ( and monsters ) at will.",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end
            --self:GetOwner():SetNW2Float( "wOS.LightningAnim", CurTime() + 0.6 )
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
				dmg:SetDamage( 8 )
				if ( ent:IsNPC() ) then dmg:SetDamage( 1.6 ) end
				ent:TakeDamageInfo( dmg )

			end

			if ( foundents > 0 ) then
				self:SetForce( self:GetForce() - foundents )
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
		name = "Force Lightning",
		icon = "L",
		target = 1,
		image = "wos/forceicons/lightning.png",
		cooldown = 0,
		manualaim = false,
		description = "Torture people ( and monsters ) at will.",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end

			local foundents = 0
			for id, ent in pairs( self:SelectTargets( 1 ) ) do
				if ( !IsValid( ent ) ) then continue end

				foundents = foundents + 1
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ent )
				util.Effect( "rb655_force_lighting", ed, true, true )

				local dmg = DamageInfo()
				dmg:SetAttacker( self:GetOwner() || self )
				dmg:SetInflictor( self:GetOwner() || self )
				dmg:SetDamage( 8 )
				local wep = ent:GetActiveWeapon()
				if IsValid( wep ) and wep.IsLightsaber and wep:GetBlocking() then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					if wOS.ALCS.Config.EnableStamina then
						wep:AddStamina( -5 )
					else
						wep:SetForce( wep:GetForce() - 1 )
					end
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					if ent:IsNPC() then dmg:SetDamage( 1.6 ) end
					ent:TakeDamageInfo( dmg )
				end
			end

			if ( foundents > 0 ) then
				self:SetForce( self:GetForce() - foundents )
				if ( !self.SoundLightning ) then
					self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
					self.SoundLightning:Play()
				else
					self.SoundLightning:Play()
				end

				timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			end
			self:SetNextAttack( 0.1 )
			return true
		end
})


wOS.ForcePowers:RegisterNewPower({
		name = "Shadow Strike",
		icon = "SS",
		distance = 30,
		image = "wos/forceicons/shadow_strike.png",
		cooldown = 0,
		target = 1,
		manualaim = false,
		description = "From the darkness it preys",
		action = function( self )
			if !self:GetCloaking() then return end
			local ent = self:SelectTargets( 1, 30 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 50 ) then self:SetNextAttack( 0.2 ) return end
			self:GetOwner():SetSequenceOverride("b_c3_t2", 1)
			self:SetForce( self:GetForce() - 100 )
			self:GetOwner():EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
			self:GetOwner():AnimResetGestureSlot( GESTURE_SLOT_CUSTOM )
			self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
			ent:TakeDamage( 500, self:GetOwner(), self )
			self.CloakTime = CurTime() + 0.5
			self:SetNextAttack( 0.7 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Pull",
		icon = "PL",
		target = 1,
		description = "Get over here!",
		image = "wos/forceicons/pull.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 20 ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ent ) then return end
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
			newpos = newpos / newpos:Length()
			ent:SetVelocity( newpos*700 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 50 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
			self:SetNextAttack( 1.5 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Push",
		icon = "PH",
		target = 1,
		distance = 150,
		description = "They are no harm at a distance",
		image = "wos/forceicons/push.png",
		cooldown = 8,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 20 ) then return end
			local ent = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ent ) then return end
			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
			local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
			newpos = newpos / newpos:Length()
			ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
			self:SetForce( self:GetForce() - 50 )
			self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
			self:SetNextAttack( 1.5 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Hardened Force Push",
	icon = "HPH",
	target = 1,
	distance = 150,
	description = "Push your opponent with a Shattering Blow",
	image = "wos/forceicons/push.png",
	cooldown = 7,
	manualaim = false,
	action = function( self )
		if ( self:GetForce() < 75 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) then return end
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
		self:SetForce( self:GetForce() - 75 )
		self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
		self:SetNextAttack( 1.5 )
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Lightning Strike",
		icon = "LS",
		distance = 600,
		image = "wos/forceicons/lightning_strike.png",
		cooldown = 0,
		target = 1,
		manualaim = false,
		description = "A focused charge of lightning",
		action = function( self )
			local ent = self:SelectTargets( 1, 600 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 75 ) then self:SetNextAttack( 0.2 ) return end
			self:SetForce( self:GetForce() - 75 )

			local ed = EffectData()
			ed:SetOrigin( self:GetSaberPosAng() )
			ed:SetEntity( ent )
			util.Effect( "rb655_force_lighting", ed, true, true )

			local dmg = DamageInfo()
			dmg:SetAttacker( self:GetOwner() || self )
			dmg:SetInflictor( self:GetOwner() || self )
			dmg:SetDamage( 200 )
			ent:TakeDamageInfo( dmg )
			self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
			self:GetOwner():EmitSound( Sound( "ambient/atmosphere/thunder1.wav" ) )
			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
				self.SoundLightning:Play()
			else
				self.SoundLightning:Play()
			end
			local bullet = {}
			bullet.Num 		= 1
			bullet.Src 		= self:GetOwner():GetPos() + Vector( 0, 0, 10 )
			bullet.Dir 		= ( ent:GetPos() - ( self:GetOwner():GetPos() + Vector( 0, 0, 10 ) ) )
			bullet.Spread 	= 0
			bullet.Tracer	= 1
			bullet.Force	= 0
			bullet.Damage	= 0
			bullet.AmmoType = "Pistol"
			bullet.Entity = self:GetOwner()
			bullet.TracerName = "thor_thunder"
			self:SetNextAttack( 10 )
			self:GetOwner():FireBullets( bullet )
			timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Cloak",
		icon = "C",
		image = "wos/forceicons/cloak.png",
		cooldown = 120,
		description = "Shrowd yourself with the force for 10 seconds",
		action = function( self )
			if ( self:GetForce() < 50 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetCloaking() then return end
			self:SetForce( self:GetForce() - 60 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.CloakTime = CurTime() + 60
			-- Look up timer.Create and see delay and repitions in the arguments. You will see why it's like this.
			timer.Create("wos.Custom.Cloaking." .. self:GetOwner():SteamID64(), 0.25, 40 + 1, function() 
				if self:GetCloaking() then 
					if self.Owner:GetVelocity():Length() > 130 then
						self:GetOwner():SetNoTarget(false)
					else
						self:GetOwner():SetNoTarget(true)
					end
				else
					self:GetOwner():SetNoTarget(false)
				end	
			end)

			timer.Simple(62, function()
				if self:GetCloaking() then
					self:SetCloaking(false)
				end
				self:SetNoTarget(false)
			end)
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Advanced Cloak",
		icon = "AC",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 30,
		manualaim = false,
		description = "Shrowd yourself with the force",
		action = function( self )
		--if ( self:GetForce() < 50 || !self:GetOwner():IsOnGround() ) then return end

--			if self:GetOwner():GetNW2Float( "CloakTime", 0 ) >= CurTime() then return end
--			self:SetForce( self:GetForce() - 50 )
--			self:SetNextAttack( 0.7 )
--			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
--			self:GetOwner():SetNW2Float( "CloakTime", CurTime() + 25 )
--			return true
--		end
			if ( self:GetForce() < 100 || !self:GetOwner():IsOnGround() ) then return end
			if self:GetCloaking() then return end
			self:SetForce( self:GetForce() - 50 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.CloakTime = CurTime() + 25
			-- Look up timer.Create and see delay and repitions in the arguments. You will see why it's like this.
			timer.Create("wos.Custom.CloakingAdv." .. self.Owner:SteamID64(), 0.25, 100 + 1, function() 
				if self:GetCloaking() then 
					--[[ if self.Owner:GetVelocity():Length() > 130 then
						self.Owner:SetNoTarget(false)
					else
						self.Owner:SetNoTarget(true)
					end --]]
					self.Owner:SetNoTarget(true)
				else
					self.Owner:SetNoTarget(false)
				end
			end)

			timer.Simple(27, function()
				if self:GetCloaking() then
					self:SetCloaking(false)
				end
				self:SetNoTarget(false)
			end)

			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Lightning",
		icon = "L",
		target = 1,
		image = "wos/forceicons/lightning.png",
		cooldown = 0,
		manualaim = false,
		description = "Torture people ( and monsters ) at will.",
		action = function( self )
			if ( self:GetForce() < 1 ) then return end

			local foundents = 0
			for id, ent in pairs( self:SelectTargets( 1 ) ) do
				if ( !IsValid( ent ) ) then continue end

				foundents = foundents + 1
				local ed = EffectData()
				ed:SetOrigin( self:GetSaberPosAng() )
				ed:SetEntity( ent )
				util.Effect( "rb655_force_lighting", ed, true, true )

				local dmg = DamageInfo()
				dmg:SetAttacker( self:GetOwner() || self )
				dmg:SetInflictor( self:GetOwner() || self )
				dmg:SetDamage( 8 )
				local wep = ent:GetActiveWeapon()
				if IsValid( wep ) and wep.IsLightsaber and wep:GetBlocking() then
					ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
					if wOS.ALCS.Config.EnableStamina then
						wep:AddStamina( -5 )
					else
						wep:SetForce( wep:GetForce() - 1 )
					end
					ent:SetSequenceOverride( "h_block", 0.5 )
				else
					if ent:IsNPC() then dmg:SetDamage( 1.6 ) end
					ent:TakeDamageInfo( dmg )
				end
			end

			if ( foundents > 0 ) then
				self:SetForce( self:GetForce() - foundents )
				if ( !self.SoundLightning ) then
					self.SoundLightning = CreateSound( self:GetOwner(), "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
					self.SoundLightning:Play()
				else
					self.SoundLightning:Play()
				end

				timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
			end
			self:SetNextAttack( 0.1 )
			return true
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
					self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*0.10 ), self:GetOwner():GetMaxHealth() ) )
					if #self.DevestatorList > 0 then
						self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge + 25 )
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
		name = "Force Combust",
		icon = "C",
		target = 1,
		description = "Ignite stuff infront of you.",
		image = "wos/forceicons/combust.png",
		cooldown = 0,
		manualaim = false,
		action = function( self )

			local ent = self:SelectTargets( 1 )[ 1 ]

			if ( !IsValid( ent ) or ent:IsOnFire() ) then self:SetNextAttack( 0.2 ) return end

			local time = math.Clamp( 512 / self:GetOwner():GetPos():Distance( ent:GetPos() ), 1, 16 )
			local neededForce = math.ceil( math.Clamp( time * 2, 10, 32 ) )

			if ( self:GetForce() < neededForce ) then self:SetNextAttack( 0.2 ) return end

			ent:Ignite( time, 0 )
			self:SetForce( self:GetForce() - neededForce )

			self:SetNextAttack( 1 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Repulse",
		icon = "R",
		image = "wos/forceicons/repulse.png",
		description = "Hold to charge for greater distance/damage. Push back everything near you.",
		think = function( self )
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
			if ( self:GetForce() < 1 ) then return end
			if ( !self:GetOwner():KeyDown( IN_ATTACK2 ) && !self:GetOwner():KeyReleased( IN_ATTACK2 ) ) then return end
			if ( !self._ForceRepulse && self:GetForce() < 16 ) then return end

			if ( !self:GetOwner():KeyReleased( IN_ATTACK2 ) ) then
				if ( !self._ForceRepulse ) then self:SetForce( self:GetForce() - 16 ) self._ForceRepulse = 1 end

				if ( !self.NextForceEffect or self.NextForceEffect < CurTime() ) then
					local ed = EffectData()
					ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
					ed:SetRadius( 128 * self._ForceRepulse )
					util.Effect( "rb655_force_repulse_in", ed, true, true )

					self.NextForceEffect = CurTime() + math.Clamp( self._ForceRepulse / 20, 0.1, 0.5 )
				end

				self._ForceRepulse = self._ForceRepulse + 0.025
				self:SetForce( self:GetForce() - 0.5 )
				if ( self:GetForce() > 0.99 ) then return end
			else
				if ( !self._ForceRepulse ) then return end
			end

			local maxdist = 128 * self._ForceRepulse

			for i, e in pairs( ents.FindInSphere( self:GetOwner():GetPos(), maxdist ) ) do
				if ( e == self:GetOwner() ) then continue end

				local dist = self:GetOwner():GetPos():Distance( e:GetPos() )
				local mul = ( maxdist - dist ) / 256

				local v = ( self:GetOwner():GetPos() - e:GetPos() ):GetNormalized()
				v.z = 0

				if ( e:IsNPC() && util.IsValidRagdoll( e:GetModel() or "" ) ) then

					local dmg = DamageInfo()
					dmg:SetDamagePosition( e:GetPos() + e:OBBCenter() )
					dmg:SetDamage( 48 * mul )
					dmg:SetDamageType( DMG_GENERIC )
					if ( ( 1 - dist / maxdist ) > 0.8 ) then
						dmg:SetDamageType( DMG_DISSOLVE )
						dmg:SetDamage( e:Health() * 3 )
					end
					dmg:SetDamageForce( -v * math.min( mul * 40000, 80000 ) )
					dmg:SetInflictor( self:GetOwner() )
					dmg:SetAttacker( self:GetOwner() )
					e:TakeDamageInfo( dmg )

					if ( e:IsOnGround() ) then
						e:SetVelocity( v * mul * -2048 + Vector( 0, 0, 64 ) )
					elseif ( !e:IsOnGround() ) then
						e:SetVelocity( v * mul * -1024 + Vector( 0, 0, 64 ) )
					end

				elseif ( e:IsPlayer() && e:IsOnGround() ) then
					e:SetVelocity( v * mul * -2048 + Vector( 0, 0, 64 ) )
				elseif ( e:IsPlayer() && !e:IsOnGround() ) then
					e:SetVelocity( v * mul * -384 + Vector( 0, 0, 64 ) )
				elseif ( e:GetPhysicsObjectCount() > 0 ) then
					for i = 0, e:GetPhysicsObjectCount() - 1 do
						e:GetPhysicsObjectNum( i ):ApplyForceCenter( v * mul * -512 * math.min( e:GetPhysicsObject():GetMass(), 256 ) + Vector( 0, 0, 64 ) )
					end
				end
			end

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
			ed:SetRadius( maxdist )
			util.Effect( "rb655_force_repulse_out", ed, true, true )

			self._ForceRepulse = nil

			self:SetNextAttack( 1 )

			self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Storm",
		icon = "STR",
		image = "wos/forceicons/storm.png",
		cooldown = 0,
		description = "Charge for 2 seconds, unleash a storm on your enemies",
		action = function( self )
			if ( self:GetForce() < 100 ) then self:SetNextAttack( 0.2 ) return end
			if self:GetAttackDelay() >= CurTime() then return end
			self:SetForce( self:GetForce() - 100 )
			self:GetOwner():EmitSound( Sound( "npc/strider/charging.wav" ) )
			self:SetAttackDelay( CurTime() + 2 )
			local tr = util.TraceLine( util.GetPlayerTrace( self:GetOwner() ) )
			local pos = tr.HitPos + Vector( 0, 0, 600 )
			local pi = math.pi
			local bullet = {}
			bullet.Num 		= 1
			bullet.Spread 	= 0
			bullet.Tracer	= 1
			bullet.Force	= 0
			bullet.Damage	= 500
			bullet.AmmoType = "Pistol"
			bullet.Entity = self:GetOwner()
			bullet.TracerName = "thor_storm"
			timer.Simple( 2, function()
				if not IsValid( self:GetOwner() ) then return end
				self:GetOwner():EmitSound( Sound( "ambient/atmosphere/thunder1.wav" ) )
				bullet.Src 		= pos
				bullet.Dir 		= Vector( 0, 0, -1 )
				self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
				self:GetOwner():FireBullets( bullet )
				timer.Simple( 0.1, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*2/5 ), 65*math.cos( pi*2/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.2, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*4/5 ), 65*math.cos( pi*4/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.3, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*6/5 ), 65*math.cos( pi*6/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.4, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*8/5 ), 65*math.cos( pi*8/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
				timer.Simple( 0.5, function()
					if not IsValid( self:GetOwner() ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( 2*pi ), 65*math.cos( 2*pi ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self:GetOwner():EmitSound( Sound( "npc/strider/fire.wav" ) )
					self:GetOwner():FireBullets( bullet )
				end )
			end )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Meditate",
		icon = "M",
		image = "wos/forceicons/meditate.png",
		description = "Relax yourself and channel your energy",
		think = function( self )
			if self.MeditateCooldown and self.MeditateCooldown >= CurTime() then return end
			if ( self:GetOwner():KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self:GetOwner():OnGround() then
				self._ForceMeditating = true
			else
				self._ForceMeditating = false
			end
			if self._ForceMeditating then
				self:SetMeditateMode( 1 )
				if not self._NextMeditateHeal then self._NextMeditateHeal = 0 end
				if self._NextMeditateHeal < CurTime() then
					self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*0.01 ), self:GetOwner():GetMaxHealth() ) )
					if #self.DevestatorList > 0 then
						self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge )
					end
					self._NextMeditateHeal = CurTime() + 3
				end
				self:GetOwner():SetLocalVelocity(Vector(0, 0, 0))
				self:GetOwner():SetMoveType(MOVETYPE_NONE)
			else
				self:SetMeditateMode( 0 )
				if self:GetMoveType() != MOVETYPE_WALK and self:GetOwner():GetNW2Float( "wOS.DevestatorTime", 0 ) < CurTime() then
					self:GetOwner():SetMoveType(MOVETYPE_WALK)
				end
			end
			if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
				self.MeditateCooldown = CurTime() + 3
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Channel Hatred",
		icon = "HT",
		image = "wos/forceicons/channel_hatred.png",
		description = "I can feel your anger",
		think = function( self )
			if self.ChannelCooldown and self.ChannelCooldown >= CurTime() then return end
			if ( self:GetOwner():KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self:GetOwner():OnGround() then
				self._ForceChanneling = true
			else
				self._ForceChanneling = false
			end
			if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
				self.ChannelCooldown = CurTime() + 3
			end
			if self._ForceChanneling then
				if not self._NextChannelHeal then self._NextChannelHeal = 0 end
				self:SetMeditateMode( 2 )
				if self._NextChannelHeal < CurTime() then
					self:GetOwner():SetHealth( math.min( self:GetOwner():Health() + ( self:GetOwner():GetMaxHealth()*0.01 ), self:GetOwner():GetMaxHealth() ) )
					if #self.DevestatorList > 0 then
						self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge )
					end
					local tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ]
					if not tbl then
						tbl = wOS.ALCS.Config.Skills.ExperienceTable[ "Default" ].Meditation
					else
						tbl = wOS.ALCS.Config.Skills.ExperienceTable[ self:GetOwner():GetUserGroup() ].Meditation
					end
					self:GetOwner():AddSkillXP( tbl )
					self._NextChannelHeal = CurTime() + 3
				end
				self:GetOwner():SetLocalVelocity(Vector(0, 0, 0))
				self:GetOwner():SetMoveType(MOVETYPE_NONE)
				if ( !self.SoundChanneling ) then
					self.SoundChanneling = CreateSound( self:GetOwner(), "ambient/levels/citadel/field_loop1.wav" )
					self.SoundChanneling:Play()
				else
					self.SoundChanneling:Play()
				end

				timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundChanneling ) then self.SoundChanneling:Stop() self.SoundChanneling = nil end end )
			else
				self:SetMeditateMode( 0 )
				if self:GetMoveType() != MOVETYPE_WALK and self:GetOwner():GetNW2Float( "wOS.DevestatorTime", 0 ) < CurTime() then
					self:GetOwner():SetMoveType(MOVETYPE_WALK)
				end
			end
			if self:GetOwner():KeyReleased( IN_ATTACK2 ) then
				self.ChannelCooldown = CurTime() + 3
			end
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Ground Slam",
		icon = "GS",
		image = "wos/forceicons/icefuse/group_lightning.png",
		texture = "star/icon/ground_slam.png",
        cooldown = 60,
		description = "Shocks and destroys everything around you.",
		action = function( self )
			if ( self:GetForce() < 60 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			local elev = 400
			local time = 1
			ent = self:GetOwner()
			self:GetOwner():SetSequenceOverride( "h_c2_t3", 5 )
			self:SetForce(self:GetForce() - 60)
			self:SetNextAttack( 30 )

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
		end
})


wOS.ForcePowers:RegisterNewPower({
		name = "Focussed Ground Slam",
		icon = "GS",
		texture = "star/icon/ground_slam.png",
        cooldown = 40,
		description = "Shocks and destroys everything around you.",
		action = function( self )
			if ( self:GetForce() < 60 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			local elev = 400
			local time = 1
			ent = self:GetOwner()

			self:SetForce(self:GetForce() - 100)
			self:SetNextAttack( 20 )

			for j = 0,6 do
				for i = 0, 24 do
					local ed = EffectData()
					ed:SetOrigin( self:GetOwner():GetPos() + Vector(0,0,0) )
					ed:SetStart( self:GetOwner():GetPos() + Vector(0,0,0) + Angle(0 , i * 15, 0):Forward() * 128)
					util.Effect( "force_groundslam", ed, true, true )
				end
			end

			local maxdist = 128

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 36 ) )
			ed:SetRadius( maxdist )
			util.Effect( "judge_h_s2_t3", ed, true, true )
			for i, e in pairs( ents.FindInSphere( self:GetOwner():GetPos(), maxdist ) ) do
			if(e == self:GetOwner()) then continue end
			--if (e.Team and e:Team() == self:GetOwner():Team()) or (e.PlayerTeam and e.PlayerTeam == self:GetOwner():Team()) then continue end

				local dist = self:GetOwner():GetPos():Distance( e:GetPos() )
				local mul = ( maxdist - dist ) / 256

				local v = ( self:GetOwner():GetPos() - e:GetPos() ):GetNormalized()
				v.z = 0

				local dmg = DamageInfo()
				dmg:SetDamagePosition( e:GetPos() + e:OBBCenter() )
				dmg:SetDamage( 600 * mul )
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
			self:SetForce(self:GetForce() - 100)
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
