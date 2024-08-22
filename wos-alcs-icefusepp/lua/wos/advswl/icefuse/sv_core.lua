wOS = wOS or {}
wOS.ALCS = wOS.ALCS or {}

hook.Add( "wOS.ALCS.GetSequenceOverride", "wOS.ALCS.ForceChokeAnim", function( ply, _ )

	if ply:GetNW2Float( "wOS.ChokeTime", 0 ) >= CurTime() then
		seq = ply:LookupSequence( "wos_force_choke" )
		if seq and seq > 0 then
			return -1, seq	
		end
	end

end )								

--[[
hook.Add( "Move", "wOS.ALCS.SlowingEffects", function( ply, mv )

	local mod = 1

	if ply.SlowTime and ply.SlowTime >= CurTime() then
		mod = mod*0.5 -- 50$
	end
	
	if ply.SpeedTime and ply.SpeedTime >= CurTime() then
		if ply:KeyDown( IN_SPEED ) then
			mod = mod*1.75
		else
			mod = mod*1.5
		end
	end
	
	if ply.StasisTime and ply.StasisTime >= CurTime() then
		mod = 0.01
	end
	
	if mod != 1 then
		mv:SetMaxSpeed( ply:GetWalkSpeed()*mod )
		mv:SetMaxClientSpeed( ply:GetWalkSpeed()*mod )
	end
	
end )]]--

hook.Add( "PlayerDeath", "wOS.ALCS.RemoveIceModifiers", function( ply )
	ply.SlowTime = nil
	ply.SpeedTime = nil
	ply.StasisTime = nil
	ply:SetNW2Float( "wOS.SaberAttackDelay", 0 )
end )

--[[
hook.Add( "ScalePlayerDamage", "wOS.ALCS.SaberBarrierBlockage", function( ent, hitgroup, dmginfo )
	if not ent:IsPlayer() then return end
	local wep = ent:GetActiveWeapon()
	if ( IsValid( ent ) && IsValid( wep ) && wep.IsLightsaber ) then
		if ent:GetNW2Bool( "wOS.BarrierStuff", false ) then
			if dmginfo:IsDamageType( DMG_BULLET ) || dmginfo:IsDamageType( DMG_SHOCK ) then
				local att = dmginfo:GetAttacker()
				local bullet = {}
				bullet.Num 		= 1
				bullet.Src 		= ent:EyePos()			
				bullet.Dir 		= ent:GetAimVector()
				bullet.Spread 	= 0		
				bullet.Tracer	= 1
				bullet.Force	= 0						
				bullet.Damage	= dmginfo:GetDamage()
				if bullet.Damage < 0 then bullet.Damage = bullet.Damage*-1 end
				bullet.AmmoType = "Pistol"
				local trace = ( att:GetActiveWeapon().Primary and att:GetActiveWeapon().Primary.Tracer ) or nil
				bullet.TracerName = trace or att:GetActiveWeapon().Tracer or att:GetActiveWeapon().TracerName or "Ar2Tracer"
				ent:FireBullets( bullet )
				ent:EmitSound( "lightsaber/saber_hit_laser" .. math.random( 1, 4 ) .. ".wav" )
				dmginfo:SetDamage( 0 )
			end
		end
	end
end )]]--