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

hook.Add( "CreateMove", "wOS.ALCS.LegacyFreeze", function( cmd/* ply, mv, cmd*/ )
	if LocalPlayer():GetNW2Float( "wOS.SaberAttackDelay", 0 ) < CurTime() then return end
	cmd:ClearButtons() -- No attacking, we are busy
	cmd:ClearMovement() -- No moving, we are busy
end )