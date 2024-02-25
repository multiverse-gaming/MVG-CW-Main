--[[-------------------------------------------------------------------]]--[[
							  
	Copyright wiltOS Technologies LLC, 2019
	
	Contact: www.wiltostech.com
		
----------------------------------------]]--

hook.Add( "wOS.ALCS.GetSequenceOverride", "wOS.ALCS.DarkAscensionAnimations", function( ply, velocity )

	local wep = ply:GetActiveWeapon()
	if not IsValid( wep ) then return end
	if not wep.IsLightsaber then return end
	
	if wep:GetMeditateMode() == 3 then
        return -1, ply:LookupSequence( "judge_h_s2_charge" )
    end
	
end )