-----
---  Config here.
-----

-- Load the job and category mappings-- Job mappings. Try and keep these in a rough order.
local jobs = {
    -- Generals
    ["Supreme General"] = {"arccw_zitracker","sw_stun_ga"},
    ["Battalion General"] = {"arccw_zitracker"},
    ["Assistant General"] = {"arccw_zitracker"},

    -- GM
    ["Galactic Marines General"] = { "ubgl_incendiary" },
    ["Galactic Marines Marshal Commander"] = { "ubgl_incendiary" },
    ["Galactic Marines Commander"] = { "ubgl_incendiary" },
    ["Galactic Marines Executive Officer"] = { "ubgl_incendiary" },
    ["Galactic Marines Major"] = { "ubgl_incendiary" },
    ["Galactic Marines Lieutenant"] = { "ubgl_incendiary" },
    ["Galactic Marines Flame Trooper"] = { "ubgl_incendiary" },
    ["Galactic Marines Alpha ARC"] = { "ubgl_incendiary" },
    ["Galactic Marines ARC"] = { "ubgl_incendiary" },
    ["Galactic Marines Medic Officer"] = { "ubgl_incendiary" },
    ["Galactic Marines Sergeant"] = { "ubgl_incendiary" },
    ["Galactic Marines Medic Trooper"] = { "ubgl_incendiary" },

    -- WP
    ["Wolfpack General"] = {"underbarrel_scandart", "underbarrel_scandart_local"},
    ["Wolfpack Marshal Commander"] = {"underbarrel_scandart", "underbarrel_scandart_local"},
    ["Wolfpack Commander"] = {"underbarrel_scandart", "underbarrel_scandart_local"},
    ["Wolfpack Executive Officer"] = {"underbarrel_scandart", "underbarrel_scandart_local"},
    ["Wolfpack Major"] = {"underbarrel_scandart", "underbarrel_scandart_local"},
    ["Wolfpack Direwolf"] = {"underbarrel_scandart", "underbarrel_scandart_local"},

    -- 501st
    ["501st General"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag", "mode_z6_sentry", "dc15-le-z6_explosivetib"},
    ["501st Marshal Commander"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag", "mode_z6_sentry", "dc15-le-z6_explosivetib"},
    ["501st Commander"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag", "mode_z6_sentry", "dc15-le-z6_explosivetib"},
    ["501st Executive Officer"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag", "mode_z6_sentry", "dc15-le-z6_explosivetib"},
    ["501st Major"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag", "dc15-le-z6_explosivetib", "mode_z6_sentry"},
    ["501st Heavy Trooper"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag", "mode_z6_sentry"},
    ["501st Lieutenant"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag"},
    ["501st Medic Officer"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag"},
    ["501st Sergeant"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_extmag"},
    ["501st Medic Trooper"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_extmag"},

    -- RC
    ["RC General"] = { "dc17m_drummag_v2_2", "dc17m_extmag_v2_2", "dc17m_quickmag_2", "dc17m_muzzle_compensator_2", "dc17m_muzzle_extbarrel_2", "dc17m_muzzle_flashhider_2", "dc17m_muzzle_muzzlebreak_2", "dc17m_explosivetib", "dc17m_greentibanna",
        "dc17m_purpletibanna", "rc_perk_ammojunkie_2", "rc_perk_doubletap_2", "rc_perk_weapon_handling_2", "rc_perk_mag_drills_2", "rc_perk_steadyaim_2", "sh_att_prk_versatile", }
}

-- Category mappings
local categories = {
    --["Wolfpack Battalion"] = {"underbarrel_scandart", "underbarrel_scandart_local"},
}

-----
---  Everything below this is setting the attachments in the job.
-----

-- Function to give a player an attachment
local function giveAttachment(ply, attachment, amount)
    ArcCW:PlayerGiveAtt(ply, attachment, amount)
    ArcCW:PlayerSendAttInv(ply)
end

-- Function to give a player attachments based on their job or category
local function giveAttachments(ply)
    local job = ply:getJobTable().name
    local category = ply:getJobTable().category

    -- Check if the player's job has any attachments
    if jobs[job] then
        for _, attachment in pairs(jobs[job]) do
            giveAttachment(ply, attachment, 1)
        end
    end

    -- Check if the player's category has any attachments
    if categories && categories[category] then
        for _, attachment in pairs(categories[category]) do
            giveAttachment(ply, attachment, 1)
        end
    end
    ArcCW:PlayerSendAttInv(ply)
end


-- Hook to give attachments to players when they spawn
hook.Add("PlayerSpawn", "GiveAttachment", function(ply)
    timer.Simple(1, function()
        giveAttachments(ply)
    end)
end)