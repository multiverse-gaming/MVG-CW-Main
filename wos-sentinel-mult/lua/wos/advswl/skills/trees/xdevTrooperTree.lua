--[[-------------------------------------------------------------------
	Lightsaber Force Powers:
		The available powers that the new saber base uses.
			Powered by
						  _ _ _    ___  ____
				__      _(_) | |_ / _ \/ ___|
				\ \ /\ / / | | __| | | \___ \
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/

 _____         _                 _             _
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[

	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech

-- Copyright 2017, David "King David" Wiltos ]]--

local TREE = {}

--Name of the skill tree
TREE.Name = "Trooper Skills"

--Description of the skill tree
TREE.Description = "A dev testing trooper tree, for all your wildest needs." --"Killing enough clankers will make anyone better."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/advanced_cloak.png"

--What is the background color in the menu for this
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = { "superadmin", "activedeveloper", "developer", "admin", "headadmin" }

TREE.JobRestricted = { "TEAM_CADET" }

TREE.Tier = {}

TREE.Tier[1] = {}

-- Thing we can do: Drop Ammo/Medkits/Bombs on death, Give people HP, Give people MS, Give people SWEPS, Give people Attachments
-- Gravity, Jump Power, armor, max armor, model scale within reason, ply:GiveAmmo(10,"grenade"), add dynamic light, projected texture
-- Try and give/remove the same thing for weapons - so we can't have people abusing reloads. 
-- "neutral" weapons - fists, knife, pistol, 
-- On death - All dropped things need to delete theirself in 1m. Trash, medkit, ammo, 
-- Good idea for everyone: Compounding buffs: Increase by something small (1/2/3/4/5/10 hp/ms), costs are exorbitant. Point sink.

local function givePistol(ply)
	-- Timer, so all the wiltOS stuff can finish.
	timer.Simple(2, function ()
		-- If pistol variable is 2, give specific weapon, 1, give other specific weapon, else just skip.
		if ply.Pistol1 == 1 then
			ply:Give("weapon_lightsaber_personal") -- !!! Could be doing this stuff better with enums, if they work like C#.
		elseif ply.Pistol1 == 2 then
			ply:Give("weapon_force_heal")
		elseif ply.Pistol1 == 3 then
			ply:Give("weapon_physcannon")
		end
	end)
end

TREE.Tier[1][1] = {
	Name = "Give yourself gun 1",
	Description = "Bababooey",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
    Requirements = {},
	OnPlayerSpawn = function( ply )
		-- Call shared function, ensuring person is given weaponry.
		givePistol(ply)

		-- Set PLY variable.
		if ply.Pistol1 ~= nil then
			ply.Pistol1 = math.max(1, ply.Pistol1)
		else
			ply.Pistol1 = 1
		end
	end,
	OnPlayerDeath = function( ply ) 
		ply.Pistol1 = 0
	end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Give yourself gun 2",
	Description = "Bababooey",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
	Requirements = {[1] = { 1 },},
	OnPlayerSpawn = function( ply )
		-- Set PLY variable.
		if ply.Pistol1 ~= nil then
			ply.Pistol1 = math.max(2, ply.Pistol1)
		else
			ply.Pistol1 = 2
		end
	end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

wOS:RegisterSkillTree( TREE )