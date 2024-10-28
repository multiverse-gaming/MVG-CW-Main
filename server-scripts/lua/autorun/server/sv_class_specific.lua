local noFallDamageTeams = {}
local fireDamageTeams = {}

timer.Simple(120, function() -- We wait 2 minutes to let darkRP create it's jobs. 
    noFallDamageTeams = {
        [TEAM_SDWGENERAL] = true,
        [TEAM_SDWMCO] = true,
        [TEAM_SDWCO] = true,
        [TEAM_SDWXO] = true,
        [TEAM_SDWMJR] = true,
        [TEAM_SDWOFF] = true,
        [TEAM_SDWSGT] = true,
        [TEAM_SDWTRP] = true,
        [TEAM_CVLD] = true,
        [TEAM_CVSPC] = true,
        [TEAM_CVTRP] = true,
        [TEAM_BOSK] = true,
        [TEAM_MAGNAGUARD] = true,
        [TEAM_JEDIPADAWAN] = true,
        [TEAM_WPJEDI] = true,
        [TEAM_GMJEDI] = true,
        [TEAM_327THJEDI] = true,
        [TEAM_501STJEDI] = true,
        [TEAM_212THJEDI] = true,
        [TEAM_JEDIKNIGHT] = true,
        [TEAM_JEDISENTINEL] = true,
        [TEAM_JEDIGUARDIAN] = true,
        [TEAM_JEDICONSULAR] = true,
        [TEAM_JEDICOUNCIL] = true,
        [TEAM_JEDIGENERALADI] = true,
        [TEAM_GMGENERALADI] = true,
        [TEAM_JEDIGENERALSHAAK] = true,
        [TEAM_CGGENERALSHAAK] = true,
        [TEAM_JEDIGENERALKIT] = true,
        [TEAM_RCGENERALKIT] = true,
        [TEAM_JEDIGENERALPLO] = true,
        [TEAM_WPGENERALPLO] = true,
        [TEAM_JEDIGENERALTANO] = true,
        [TEAM_501STGENERALTANO] = true,
        [TEAM_JEDIGENERALWINDU] = true,
        [TEAM_JEDIGENERALOBI] = true,
        [TEAM_212THGENERALOBI] = true,
        [TEAM_JEDIGENERALSKYWALKER] = true,
        [TEAM_501STGENERALSKYWALKER] = true,
        [TEAM_JEDIGRANDMASTER] = true,
        [TEAM_GCGRANDMASTER] = true,
        [TEAM_JEDIGENERALAAYLA] = true,
        [TEAM_327THGENERALAAYLA] = true,
        [TEAM_JEDIGENERALLUMINARA] = true,
        [TEAM_CGJEDI] = true,
        [TEAM_CGJEDICHIEF] = true,
        [TEAM_JEDIGENCINDRALLIG] = true,
        [TEAM_JEDITGCHIEF] = true,
        [TEAM_TGJEDI] = true,
        [TEAM_GCGENERALLUMINARA] = true,
        [TEAM_JEDIGENERALVOS] = true,
        [TEAM_SHADOWGENERALVOS] = true,
        [TEAM_JEDITOURNAMENT] = true,
        [TEAM_COUNTDOOKU] = true,
        [TEAM_ASAJJVENTRESS] = true,
        [TEAM_DARTHMAUL] = true,
        [TEAM_GENERALGRIEVOUS] = true,
        [TEAM_SAVAGEOPRESS] = true,
        [TEAM_PREVISZLA] = true,
    }

    fireDamageTeams = {
        [TEAM_GMFLAMETROOPER] = true,
        [TEAM_GMMAJOR] = true,
        [TEAM_GMEXECUTIVEOFFICER] = true,
        [TEAM_GMCOMMANDER] = true,
        [TEAM_GMGENERAL] = true,
    }
end)

hook.Add("GetFallDamage", "PowerArmor:FallDamage", function(ply, dmgInfo)
	if noFallDamageTeams[ply:Team()] then
		return 0
	end
end)

hook.Add( "EntityTakeDamage", "PowerArmor:EntityTakeDamage", function( ply, dmgInfo )
	if !ply:IsPlayer() then return end
    if ( not ply.m_bApplyingDamage ) then
		ply.m_bApplyingDamage = true

        if ply:HasPowerArmor() then
            dmgInfo:ScaleDamage(0.3) -- Powerarmor damage reduction.

        elseif fireDamageTeams[ply:Team()] && dmgInfo:GetDamageType() == DMG_BURN then
            dmgInfo:ScaleDamage(0.3) -- GM Flametrooper damage

        elseif ply:Team() == TEAM_RCWRECKER then
            dmgInfo:ScaleDamage(0.75) -- Wrecker damage reduction.

        end
        ply.m_bApplyingDamage = false
    end
end )
