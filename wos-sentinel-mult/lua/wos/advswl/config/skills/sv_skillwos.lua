--[[-------------------------------------------------------------------]]--[[
							  
	Copyright wiltOS Technologies LLC, 2020
	
	Contact: www.wiltostech.com
----------------------------------------]]--

wOS = wOS or {}
wOS.ALCS = wOS.ALCS or {}
wOS.ALCS.Config = wOS.ALCS.Config or {}
wOS.ALCS.Config.Skills = wOS.ALCS.Config.Skills or {}

wOS.ALCS.Config.Skills.ExperienceTable = {}

--Your MySQL Data ( Fill in if you are using MySQL Database )
--DO NOT GIVE THIS INFORMATION OUT! Malicious users can connect to your database with it
wOS.ALCS.Config.Skills.SkillDatabase = wOS.ALCS.Config.Skills.SkillDatabase or {}
wOS.ALCS.Config.Skills.SkillDatabase.Host = "localhost"
wOS.ALCS.Config.Skills.SkillDatabase.Port = 3306
wOS.ALCS.Config.Skills.SkillDatabase.Username = "root"
wOS.ALCS.Config.Skills.SkillDatabase.Password = ""
wOS.ALCS.Config.Skills.SkillDatabase.Database = "wos-skilltree"
wOS.ALCS.Config.Skills.SkillDatabase.Socket = ""


--How often do you want to save player progression ( in seconds )
wOS.ALCS.Config.Skills.SkillDatabase.SaveFrequency = 360

--Do you want to use MySQL Database to save your data?
--PlayerData ( text files in your data folder ) are a lot less intensive but lock you in on one server
--MySQL Saving lets you sync with many servers that share the database, but has the potential to increase server load due to querying
wOS.ALCS.Config.Skills.ShouldSkillUseMySQL = false

--Should XP gained from Vrondrakis also be used for the skill point system?
wOS.ALCS.Config.Skills.VrondrakisSync = false

--How many levels do you need to progress in order to get skill points?
wOS.ALCS.Config.Skills.LevelsPerSkillPoint = 1

--How many skill points do you get when you achieve those levels above?
wOS.ALCS.Config.Skills.SkillPointPerLevel = 1

--How long before we award free xp just for playing? ( set this to false if you don't want to do this )
wOS.ALCS.Config.Skills.TimeBetweenXP = false

--Should we award skill points based on level when they reset, or how much they spent currently?
wOS.ALCS.Config.Skills.ResetBasedOnLevel = false

--[[
	Distribute the XP per usergroup here. The additions may be subject to change
	but the general format is:
	
	wOS.ALCS.Config.Skills.ExperienceTable[ "USERGROUP" ] = {
			Meditation = XP Per meditation tick ( every 3 seconds ),
			PlayerKill = XP for killing another player,
			NPCKill = XP for killing an NPC,
			XPPerInt = The XP gained from the playing internval above,
	}	
		
]]--

--Default is the DEFAULT xp awarded if they aren't getting special XP. Only change the numbers for this one!

-- Moved NPC XP outside.


wOS.ALCS.Config.Skills.ExperienceTable[ "Default" ] = {
		Meditation = 0,
		PlayerKill = 0,
		NPCKill = 0,
		XPPerInt = 0,
		XPPerHeal = 0,
}

-- Something to show every hook that exists
-- if (hookName != "hookNameHere") then return end
-- Put the above in the for loop if you want something specific.
timer.Simple(65, function()
	print("=====================================")
	for hookName, hooks in pairs(hook.GetTable()) do
		print("====================")
		print(hookName)
		print("=====")
		for identifier, func in pairs(hooks) do
			print(identifier)
		end
		print("====================")
	end
	print("=====================================")
end)

local badHooks = {
	["wOS.ALCS.DA.EnergyShell"] = "EntityTakeDamage", -- Unused and unwanted.
	["wOS.ALCS.Dueling.PreventDamageAndExecute"] = "EntityTakeDamage", -- Prevents damage on executing people - Testing this.
	["BattlemeditationMVGDamageReductionHook"] = "EntityTakeDamage", -- BattleMeditation lives somewhere, and it needs to die.
	["ArcCW_CloseOnHurt"] = "EntityTakeDamage", -- Closes the arcCW c-menu when taking damage. Not sure we need this one.
	["Sleepdamage"] = "EntityTakeDamage", -- This allows sleeping people to take damage in DarkRP - BUT it does do a player:GetAll(), so lets skip it.
	["pac_pac_projectile"] = "EntityTakeDamage", -- Pretty sure PAC Projectiles are disabled on the server, so we don't need this.
	["ArcCW_HelicopterWorkaround"] = "EntityTakeDamage", -- Let's just not kill any helicopters.
	["SciFiDamageEffectivity"] = "EntityTakeDamage", -- SciFi Shit. This exists in around 6 different areas. Let's just delete the hook instead.
	["SciFiDmgBuff"] = "EntityTakeDamage", -- SciFi Shit. Same as above.
	["SaphLifeSteal"] = "OnPlayerHitGround", -- SciFi Shit. Same as above.
	["wOS.RestartAnimationOnLand"] = "OnPlayerHitGround", -- Honestly removing this makes the aerial attacks cooler.
	["wOS.ALCS.SaberBarrierBlockage"] = "ScalePlayerDamage", -- SaberBarrier? huh?
	["rmt_nofall_trump"] = "GetFallDamage", -- RMT hook, named after a player, referencing a weapon that doesn't exist. Classic MVG.
	["rb655_lightsaber_no_fall_damage_wOS"] = "GetFallDamage", -- This is useful, but is now being taken care of, more efficiently, in the SDW code.
	["ArcCW_DoPhysBullets"] = "Tick", -- ArcCW Physical Bullet Ticks. We don't do this, so we shouldn't have it around.
	["wOS.ALCS.Dueling.PassiveThoughts"] = "Think", -- Passive Thoughts? Huh?
	["TBFY_Surrender"] = "Think", -- No idea what this is, but it's on the server somewhere.
}

timer.Simple(60, function()
	-- There are some stupid hooks built into wOS, and other places like DarkRP, that I can't get at to remove.
	-- This will have to do.
    for identifier, hookName in pairs(badHooks) do
        if identifier ~= "" and hookName ~= "" then
            local removed = hook.Remove(hookName, identifier)
            if !removed then
                print("Failed to remove hook: " .. identifier .. " from " .. hookName .. " (may not exist)")
            end
        end
    end
end)