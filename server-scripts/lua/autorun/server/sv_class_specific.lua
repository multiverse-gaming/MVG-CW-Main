local WhitelistJobsNames = { --jobs to not take fall damage
		"Shadow General",
		"Shadow Marshal Commander",
        "Shadow Commander",
        "Shadow Executive Officer",
		"Shadow Major",
		"Shadow Officer",
		"Shadow Sergeant",
		"Shadow Trooper",
        "Covert Lead",
        "Covert Specialists",
        "Covert Trooper",
		"Bossk",
		"CIS Elite Melee",
		"Magna Guard",
		"Shadow General Quinlan Vos",
        "Jedi General Quinlan Vos",
}

local function JobCheck(ply)

    if not teamCache then
        teamCache = {}

        for k, v in ipairs( WhitelistJobsNames ) do
            teamCache[ v ] = true
        end
    end
    local pms = team.GetName(ply:Team())

    return teamCache[ pms ]
end

hook.Add("GetFallDamage", "PowerArmor:FallDamage", function(ply, dmgInfo)

	local team = ply:Team() //local team = team.GetName(ply:Team())

	if JobCheck(ply) then

		return 0

	end

end)



hook.Add( "EntityTakeDamage", "PowerArmor:EntityTakeDamage", function( ply, dmgInfo )

	if !ply:IsPlayer() then return end

    if ( not ply.m_bApplyingDamage ) then

		ply.m_bApplyingDamage = true

        if ply:HasPowerArmor() then

            dmgInfo:ScaleDamage(0.3) -- Powerarmor damage reduction.
            ply.m_bApplyingDamage = false
            
        elseif ply:Team() == TEAM_RCWRECKER then

            dmgInfo:ScaleDamage(0.75)

            ply.m_bApplyingDamage = false


        elseif dmgInfo:GetDamageType() == DMG_BURN then

            if ply:Team() == TEAM_GMFLAMETROOPER or ply:Team() == TEAM_GMMAJOR or ply:Team() == TEAM_GMEXECUTIVEOFFICER or ply:Team() == TEAM_GMCOMMANDER or ply:Team() == TEAM_GMGENERAL then

                dmgInfo:ScaleDamage(0.3) -- GM Flametrooper damage

                ply.m_bApplyingDamage = false

            end
        else
            ply.m_bApplyingDamage = false
        end

    end

end )
