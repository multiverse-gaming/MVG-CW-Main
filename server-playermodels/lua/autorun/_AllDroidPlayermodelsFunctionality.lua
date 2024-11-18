local listOfAllDroidModels = {}
function IsModelADroid(modelPath)
    if (listOfAllDroidModels[modelPath]) then
        return true
    end
    return false
end

-- Hopefully this will catch a lot of the times that we 
hook.Add("Initialize", "CreateDroidModelList", function()
    -- Categories to find droid models in
    local targetCategories = {
        ["CIS Infantry"] = true,
        ["CIS Reinforcements"] = true,
        ["CIS Special Forces"] = true
    }

    -- List of teams that are droids, sans category
    local applicableTeams = {
        ["Republic Droid"] = true,
    }

    -- List of models to remove from this (In case a droid job has a human model added)
    local nonApplicableModels = {
    }

    local excludedJobs = {
        ["Sith"] = true,
        ["Enemy Bounty Hunter"] = true
    }
    
    -- Other droid models not found in jobs
    local additionalApplicableModels = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_geonosis_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_oom10_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_security_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_training_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_camo_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_snow_pm.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_training_pm.mdl",
        "models/bx_training/pm_droid_cis_bx_training.mdl",
        "models/tfa/comm/gg/pm_sw_magna_guard_season4.mdl",
        "models/tfa/comm/gg/pm_sw_magna_guard_trainer.mdl",
        "models/super_tactical_kalani/pm_droid_tactical_kalani.mdl",
        "models/super_tactical_stuxnet/pm_droid_tactical_stuxnet.mdl",
        "models/megarexcis/battledroid.mdl","models/aussiwozzi/cutter_droid.mdl",
        "models/npc_tactical_black/npc_droid_tactical_black_f.mdl",
        "models/npc_tactical_black/npc_droid_tactical_black_h.mdl",
        "models/npc_tactical_blue/npc_droid_tactical_blue_f.mdl",
        "models/npc_tactical_blue/npc_droid_tactical_blue_h.mdl",
        "models/npc_tactical_gold/npc_droid_tactical_gold_f.mdl",
        "models/npc_tactical_gold/npc_droid_tactical_gold_h.mdl",
        "models/npc_tactical_purple/npc_droid_tactical_purple_f.mdl",
        "models/npc_tactical_purple/npc_droid_tactical_purple_h.mdl",
        "models/npc_tactical_red/npc_droid_tactical_red_f.mdl",
        "models/npc_tactical_red/npc_droid_tactical_red_h.mdl",
        "models/tfa/comm/gg/npc_comb_magna_guard_trainer.mdl",
        "models/tfa/comm/gg/npc_comb_magna_guard_combined.mdl",
        "models/tfa/comm/gg/npc_comb_magna_guard_season4.mdl",
        "models/tfa/comm/gg/npc_reb_magna_guard_trainer.mdl",
        "models/tfa/comm/gg/npc_reb_magna_guard_combined.mdl",
        "models/tfa/comm/gg/npc_reb_magna_guard_season4.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pilot.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_security.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_heavy.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_aat.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_geonosis.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pointrain.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_rocket.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_snow.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_training.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_oom10.mdl",
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_commander.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_cannon.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_training.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_snow.mdl",
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_camo.mdl",
        "models/bx/npc_droid_cis_bx_f.mdl",
        "models/bx/npc_droid_cis_bx_h.mdl",
        "models/bx_captain/npc_droid_cis_bx_cpt_f.mdl",
        "models/bx_captain/npc_droid_cis_bx_cpt_h.mdl",
        "models/bx_senate/npc_droid_cis_bx_senate_f.mdl",
        "models/bx_senate/npc_droid_cis_bx_senate_h.mdl",
        "models/bx_citadel/npc_droid_cis_bx_citadel_f.mdl",
        "models/bx_citadel/npc_droid_cis_bx_citadel_h.mdl",
        "models/bx_training/npc_droid_cis_bx_training_f.mdl",
        "models/bx_training/npc_droid_cis_bx_training_h.mdl",
    }

    -- Removes duplicates
    local function removeDuplicates(tbl)
        local seen = {}
        local unique = {}
        for _, model in ipairs(tbl) do
            if not seen[model] then
                table.insert(unique, model)
                seen[model] = true
            end
        end
        return unique
    end

    -- Non-organised droid job list
    local listOfDroidJobs = {}

    -- Get all jobs, store all models
    for jobName, job in pairs(RPExtraTeams) do
        if applicableTeams[job.name] or (targetCategories[job.category] and not excludedJobs[job.name]) then
            for _, model in ipairs(job.model or {}) do
                listOfDroidJobs[model] = true
            end
        end
    end

    -- Remove known bad models
    for _, model in ipairs(nonApplicableModels) do
        listOfDroidJobs[model] = nil
    end

    -- Add non-job droid models
    for _, model in ipairs(additionalApplicableModels) do
        listOfDroidJobs[model] = true
    end

    -- Convert table for future use
    local finalModelList = {}
    for model, _ in pairs(listOfDroidJobs) do
        table.insert(finalModelList, model)
    end
    finalModelList = removeDuplicates(finalModelList)
    for _, model in ipairs(finalModelList) do
        listOfAllDroidModels[model] = true
    end
end)