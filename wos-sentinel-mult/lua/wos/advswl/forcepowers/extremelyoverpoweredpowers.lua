wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
	name = "Overdrive Beam",
	icon = "OB",
	image = "wos/forceicons/overdrive.png",
	description = "Release your focused energy",
	think = function( self )
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 1 ) then return end
		if not self.Owner:IsOnGround() then return end
		if !self.Owner:KeyDown( IN_ATTACK2 ) then return end
		if self.Owner:GetVelocity():Length2DSqr() < 65 then
			local ed = EffectData()
			ed:SetEntity( self.Owner )
			ed:SetAngles( self.Owner:GetAimVector():Angle() )
			util.Effect( "wos_alcs_beamdrive", ed, true, true )
			self.Owner:SetSequenceOverride( "wos_cast_lightning", 0.25 )
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			if tr.Entity then
				if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
					if self.Owner:GetPos():DistToSqr( tr.Entity:GetPos() ) < 412000 then 
						local dmg = DamageInfo()
						dmg:SetAttacker( self.Owner )
						dmg:SetInflictor( self or self.Owner )
						dmg:SetDamage( 5 )
						tr.Entity:TakeDamageInfo( dmg )
						local wep = tr.Entity:GetActiveWeapon()
						if IsValid( wep) and tr.Entity:IsPlayer() then
							if wep.IsLightsaber then
								if wep:GetForce() > 1 then
									self:SetForce( self:GetForce() + 0.6 )
									wep:SetForce( wep:GetForce() - 0.8 )
								end
							end
						end
					end
				end
			end
			self:SetForce( self:GetForce() - 0.5 )
			self:SetNextAttack( 0.1 )
			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self.Owner, "ambient/levels/citadel/citadel_drone_loop1.wav" )
				self.SoundLightning:Play()
			else
				self.SoundLightning:Play()
			end
			timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
		end
	end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Burn Out",
	icon = "BO",
	image = "wos/forceicons/burnout.png",
	description = "Fire and flames engulf your victim",
	think = function( self )
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 1 ) then return end
		if not self.Owner:IsOnGround() then return end
		if !self.Owner:KeyDown( IN_ATTACK2 ) then return end
		if self.Owner:GetVelocity():Length2DSqr() < 65 then
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			if tr.Entity then
				if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
					if self.Owner:GetPos():DistToSqr( tr.Entity:GetPos() ) < 7000 then 
						local dmg = DamageInfo()
						dmg:SetAttacker( self.Owner )
						dmg:SetInflictor( self or self.Owner )
						dmg:SetDamage( 8 )
						tr.Entity:TakeDamageInfo( dmg )
						tr.Entity:Ignite( 0.5 )
					end
				end
			end
			local ed = EffectData()
			ed:SetEntity( self.Owner )
			ed:SetAngles( self.Owner:GetAimVector():Angle() )
			util.Effect( "wos_alcs_fireflood", ed, true, true )
			self.Owner:SetSequenceOverride( "wos_cast_lightning_armed", 0.25 )
			self:SetForce( self:GetForce() - 2 )
			self:SetNextAttack( 0.2 )
			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self.Owner, "ambient/fire/fire_med_loop1.wav" )
				self.SoundLightning:Play()
			else
				self.SoundLightning:Play()
			end
			timer.Create( "test" .. self:EntIndex(), 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
		end
	end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Vitriolic Discharge",
	icon = "VD",
	image = "wos/forceicons/vitridisc.png",
	cooldown = 0,
	manualaim = false,
	description = "Release their inner poisons onto them",
	action = function( self )
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 80 ) then return end
		if not self.Owner:IsOnGround() then return end
		if self.Owner:GetVelocity():Length2DSqr() < 30 then
			local ed = EffectData()
			ed:SetEntity( self.Owner )
			util.Effect( "wos_alcs_acidpool", ed, true, true )
			self.Owner:SetSequenceOverride( "ryoku_a_s2_land", 3 )
			self:SetForce( self:GetForce() - 80 )
			self:SetAttackDelay( CurTime() + 3 )
			self:SetNextAttack( 1.2 )
			for _, ply in pairs( ents.FindInSphere( self.Owner:GetPos(), 100 ) ) do
				if ply == self.Owner then continue end
				if not IsValid( ply ) then continue end
				if not ply:IsPlayer() then continue end
				if not ply:Alive() then continue end
				local t_id = "wOS.ALCS.DA.VDOT." .. ply:SteamID64()
				if timer.Exists( t_id ) then continue end
				timer.Create( t_id, 0.5, 5, function()
					if not ply:Alive() then timer.Destroy( t_id ) end
					local ed2 = EffectData()
					ed2:SetEntity( ply )
					util.Effect( "wos_alcs_poisontouch", ed2, true, true )				
					local dmg = DamageInfo()
					dmg:SetAttacker( self.Owner )
					dmg:SetInflictor( self or self.Owner )
					dmg:SetDamage( ply:GetMaxHealth()*0.05 )
					ply:TakeDamageInfo( dmg )
					ply:EmitSound( "npc/headcrab_poison/ph_poisonbite" .. math.random( 1, 3) .. ".wav" )
				end )					
			end
			return true
		end
	end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Crippling Slam",
	icon = "CS",
	image = "wos/forceicons/cripple.png",
	cooldown = 60,
	manualaim = false,
	description = "Earth shattering slams immobilize those in your path",
	action = function( self )
		if not self:GetEnabled() then return end
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 80 ) then return end
		if not self.Owner:IsOnGround() then return end
		if self.Owner:GetVelocity():Length2DSqr() < 30 then
			local time = self.Owner:SetSequenceOverride( "h_c2_t3" )
			timer.Simple( time*0.38, function()
				if not IsValid( self ) or not IsValid( self.Owner ) or not self.Owner:Alive() then return end
				
				local ed = EffectData()
				ed:SetEntity( self.Owner )
				local forward = self.Owner:GetForward()
				forward = Vector( forward.x, forward.y, 0 )
				ed:SetStart( forward )
				
				forward = forward*5
				ed:SetOrigin( self.Owner:GetPos() + forward )
				util.Effect( "wos_alcs_electricslam", ed, true, true )
				
				self.Owner:EmitSound( "wos/lightsabers/forceslam.wav" )
				local targets = ents.FindInCone( self.Owner:EyePos(), self.Owner:GetAimVector(), 400, math.cos( math.rad( 25 ) ) )
				for _, ent in ipairs( targets ) do
					if not ent:IsPlayer() then continue end
					if ent == self.Owner then continue end
					if not ent:IsOnGround() then continue end
					if not ent:Alive() then continue end
					local ed2 = EffectData()
					ed2:SetEntity( ent )
					ed2:SetRadius( 2 )
					util.Effect( "wos_alcs_electrictouch", ed2, true, true )
					ent:EmitSound( "weapons/stunstick/stunstick_fleshhit2.wav", nil, 75 )
					ent:SetNW2Float( "WOS_CripplingSlow", CurTime() + 3.5 )
				end

			end )
			self:SetForce( self:GetForce() - 80 )
			self:SetAttackDelay( CurTime() + time )
			self:SetNextAttack( time*1.55 )
			return true
		end
	end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Blood Sacrifice",
	icon = "BS",
	image = "wos/forceicons/blood.png",
	cooldown = 0,
	manualaim = false,
	description = "Focus your inner energy through blood",
	action = function( self )
		if not self:GetEnabled() then return end
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 80 ) then return end
		if not self.Owner:IsOnGround() then return end
		if self.Owner:GetVelocity():Length2DSqr() < 30 then
			local time = self.Owner:SetSequenceOverride( "judge_b_s2_charge", 1.2 )
			local ed = EffectData()
			ed:SetEntity( self.Owner )
			ed:SetRadius( 1 )
			util.Effect( "wos_alcs_bloodtouch", ed, true, true )
			local dmg = DamageInfo()
			dmg:SetAttacker( self.Owner )
			dmg:SetInflictor( self or self.Owner )
			dmg:SetDamage( self.Owner:GetMaxHealth()*0.20 )
			self.Owner:TakeDamageInfo( dmg )
			self.Owner:EmitSound( "physics/flesh/flesh_bloody_break.wav" )
			if #self.DevestatorList > 0 then
				self:SetDevEnergy( self:GetDevEnergy() + self.DevCharge*2 )
			end
			self:SetForce( self:GetForce() - 80 )
			self:SetAttackDelay( CurTime() + time )
			self:SetNextAttack( time*1.15 )
			return true
		end
	end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Energetic Shell",
	icon = "ES",
	image = "wos/forceicons/eshell.png",
	description = "Convert their negativity into your power",
	think = function( self )
		if self.ShellCooldown and self.ShellCooldown >= CurTime() then return end
		if ( self.Owner:KeyDown( IN_ATTACK2 ) ) and self.Owner:OnGround() then
			self._ForceEnergyShell = true
		else
			self._ForceEnergyShell = false
		end
		if self._ForceEnergyShell then
			self:SetMeditateMode( 3 )
			if not self._NextShellActivate then self._NextShellActivate = CurTime() + 4 end
			if self._NextShellActivate < CurTime() then
				local ed = EffectData()
				ed:SetEntity( self.Owner )
				ed:SetScale( 0.3 )
				util.Effect( "wos_alcs_energyshell", ed, true, true )
			end
			self.Owner:SetLocalVelocity(Vector(0, 0, 0))
			self.Owner:SetMoveType(MOVETYPE_NONE)
		else
			self:SetMeditateMode( 0 )
			if self:GetMoveType() != MOVETYPE_WALK and self.Owner:GetNW2Float( "wOS.DevestatorTime", 0 ) < CurTime() then
				self.Owner:SetMoveType(MOVETYPE_WALK)
			end
		end
		if self.Owner:KeyReleased( IN_ATTACK2 ) then
			self.ShellCooldown = CurTime() + 5
			self._NextShellActivate = nil
		end
	end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Diamond Storm",
	icon = "DS",
	image = "wos/forceicons/diamond.png",
	cooldown = 0,
	manualaim = false,
	description = "Turn the air around you into shards of destruction",
	action = function( self )
		if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		if ( self:GetForce() < 100 ) then return end
		if not self.Owner:IsOnGround() then return end
		
		local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
		local pos = tr.HitPos
		local pi = math.pi
		local bullet = {}
		bullet.Num 		= 10
		bullet.Spread 	= Vector( 0.3, 0.3, 0 )
		bullet.Tracer	= 1
		bullet.Force	= 100						
		bullet.Damage	= 50
		bullet.AmmoType = "AR2"
		bullet.Entity = self.Owner
		bullet.IgnoreEntity = self.Owner
		bullet.TracerName = "wos_alcs_diamondbullet"
		self.Owner:EmitSound( "physics/glass/glass_sheet_break3.wav" )
		local time = self.Owner:SetSequenceOverride( "pure_taunt_balanced", 1.6 )
		local ed = EffectData()
		ed:SetEntity( self.Owner )
		ed:SetScale( time )
		
		util.Effect( "wos_alcs_diamondstorm", ed, true, true )
		
		self:SetForce( self:GetForce() - 100 )
		self:SetNextAttack( time )
		self:SetAttackDelay( time )

		timer.Simple( time*0.65, function()
			if not IsValid( self.Owner ) then return end
			bullet.Src 		= self.Owner:GetShootPos()
			bullet.Dir 		= self.Owner:GetAimVector()
			self.Owner:FireBullets( bullet )
			self.Owner:EmitSound( "npc/manhack/mh_blade_snick1.wav" )
			for i=1, 6 do
				timer.Simple( 0.03*i, function()
					if not IsValid( self ) then return end
					if not IsValid( self.Owner ) then return end
					if not self.Owner:Alive() then return end
					self.Owner:EmitSound( "npc/manhack/mh_blade_snick1.wav" )
				end )
			end
		end )
		return true
	end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Attract",
	icon = "AT",
	distance = 600,
	image = "wos/forceicons/attract.png",
	target = 1,
	cooldown = 0,
	manualaim = false,
	description = "Let the world attack your enemy",
	action = function( self )
		if ( self:GetForce() < 20 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) then return end
		ent:EmitSound( "lightsaber/force_repulse.wav" )
		for i, e in pairs( ents.FindInSphere( ent:GetPos(), 256 ) ) do
			if e == ent then continue end

			local dist = ent:GetPos():Distance( e:GetPos() )

			local v = ( ent:GetPos() - e:GetPos() ):GetNormalized()
			v.z = 0

			if ( e:IsNPC() && util.IsValidRagdoll( e:GetModel() or "" ) ) then

				if ( e:IsOnGround() ) then
					e:SetVelocity( v * 2048 + Vector( 0, 0, 64 ) )
				elseif ( !e:IsOnGround() ) then
					e:SetVelocity( v * 1024 + Vector( 0, 0, 64 ) )
				end

			elseif ( e:IsPlayer() && e:IsOnGround() ) then
				e:SetVelocity( v * 2048 + Vector( 0, 0, 64 ) )
			elseif ( e:IsPlayer() && !e:IsOnGround() ) then
				e:SetVelocity( v * 384 + Vector( 0, 0, 64 ) )
			elseif ( e:GetPhysicsObjectCount() > 0 ) then
				for i = 0, e:GetPhysicsObjectCount() - 1 do
					e:GetPhysicsObjectNum( i ):ApplyForceCenter( v * 512 * math.min( e:GetPhysicsObject():GetMass(), 256 ) + Vector( 0, 0, 128 ) )
				end
			end
		end		
		self:SetForce( self:GetForce() - 35 )
		self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
		self:SetNextAttack( 1.5 )
		return true
	end
})
--[[
hook.Add( "EntityTakeDamage", "wOS.ALCS.DA.EnergyShell", function( ply, dmg )
	if ( !ply.GetActiveWeapon || !ply:IsPlayer() ) then return end
	local wep = ply:GetActiveWeapon()
	if ( !IsValid( wep ) || !wep.IsLightsaber || wep.ForcePowers[ wep:GetForceType() ].name != "Energetic Shell" ) then return end
	if not wep._NextShellActivate or wep._NextShellActivate >= CurTime() then return end
	if ( !ply:KeyDown( IN_ATTACK2 ) ) then return end
	local damage = dmg:GetDamage()*0.8 / ply:GetMaxHealth()
	dmg:SetDamage( dmg:GetDamage()*0.2 )
	wep:SetDevEnergy( math.min( wep:GetDevEnergy() + damage, 100 ) )
	return
end )]]--

hook.Add( "PlayerDeath", "wOS.ALCS.DA.RemoveModifiers", function( ply )
	ply:SetNW2Float( "WOS_CripplingSlow", nil )
end )