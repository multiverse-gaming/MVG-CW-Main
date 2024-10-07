-----
---  Config here.
-----

-- Load the job and category mappings-- Job mappings. Try and keep these in a rough order.
local jobs = {
    -- Generals
    ["Supreme General"] = {"arccw_zitracker"},
    ["Battalion General"] = {"arccw_zitracker"},
    ["Assistant General"] = {"arccw_zitracker"},
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
    ["501st Heavy Trooper"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag"},
    ["501st Medic Officer"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_greentibanna", "dc15le_purpletibanna", "dc15le_extmag"},
    ["501st Sergeant"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_extmag"},
    ["501st Medic Trooper"] = {"perk_trp_run_gun", "dc15le_carbine", "dc15le_heavy", "dc15le_extmag"},
    
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
hook.Add("PlayerSpawn", "GiveAttachments", function(ply)
    timer.Simple(1, function()
        giveAttachments(ply)
    end)
end)