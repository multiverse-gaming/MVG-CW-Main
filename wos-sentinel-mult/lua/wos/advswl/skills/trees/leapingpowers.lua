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
TREE.Name = "Leaping Path"

--Description of the skill tree
TREE.Description = "The ability to jump is a core skill - improve it."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/leap.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 177, 201, 0, 76)

--How many tiers of skills are there?
TREE.MaxTiers = 3

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = JediAll

TREE.Tier = {}

--Tier format is as follows:
--To create the TIER Table, do the following
--TREE.Tier[ TIER NUMBER ] = {} 
--To populate it with data, the format follows this
--TREE.Tier[ TIER NUMBER ][ SKILL NUMBER ] = DATA
--Name, description, and icon are exactly the same as before
--PointsRequired is for how many skill points are needed to unlock this particular skill
--Requirements prevent you from unlocking this skill unless you have the pre-requisite skills from the last tiers. If you are on tier 1, this should be {}
--OnPlayerSpawn is a function called when the player just spawns
--OnPlayerDeath is a function called when the player has just died
--OnSaberDeploy is a function called when the player has just pulled out their lightsaber ( assuming you have SWEP.UsePlayerSkills = true )

TREE.Tier[1] = {}

TREE.Tier[1][1] = {
	Name = "Leaping Cost 1",
	Description = "Reduce the leaping FP cost by 5.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep )
		if (wep.LeapCostUpgrade == nil || wep.LeapCostUpgrade < 1) then
			wep.LeapCostUpgrade = 1
		end
	end,
}

TREE.Tier[1][2] = {
	Name = "Reduce Leap Cooldown 1",
	Description = "Reduces Leap CD by 1 second.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep )
		if (wep.LeapCDUpgrade == nil || wep.LeapCDUpgrade < 1) then
			wep.LeapCDUpgrade = 1
		end
	end,
}

TREE.Tier[1][3] = {
	Name = "Leap Distance Upgrade 1",
	Description = "Increase the power of your leap.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep )
		if (wep.LeapDistanceUpgrade == nil || wep.LeapDistanceUpgrade < 1) then
			wep.LeapDistanceUpgrade = 1
		end
	end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Leaping Cost 2",
	Description = "Reduce the leaping FP cost by 5.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 1,
	Requirements = {
		[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep )
		if (wep.LeapCostUpgrade == nil || wep.LeapCostUpgrade < 2) then
			wep.LeapCostUpgrade = 2
		end
	end,
}

TREE.Tier[2][2] = {
	Name = "Reduce Leap Cooldown 2",
	Description = "Reduces Leap CD by 1 second.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 1,
	Requirements = {
		[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep )
		if (wep.LeapCDUpgrade == nil || wep.LeapCDUpgrade < 2) then
			wep.LeapCDUpgrade = 2
		end
	end,
}

TREE.Tier[2][3] = {
	Name = "Leap Distance Upgrade 2",
	Description = "Increase the power of your leap.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 1,
	Requirements = {
		[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep )
		if (wep.LeapDistanceUpgrade == nil || wep.LeapDistanceUpgrade < 2) then
			wep.LeapDistanceUpgrade = 2
		end
	end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Additional Leap",
	Description = "Gain another, smaller leap mid air.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 3,
	Requirements = {
		[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.AdditionalLeap = true end,
}

TREE.Tier[3][2] = {
	Name = "Group Leap",
	Description = "Holding leap whilst crouching will launch those around you with you.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 3,
	Requirements = {
		[2] = { 1, 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.GroupLeap = true end,
}

TREE.Tier[3][3] = {
	Name = "Slow Falling",
	Description = "Holding Leap whilst falling slightly slows your fall.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 3,
	Requirements = {
		[2] = { 2, 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.SlowFall = true end,
}

TREE.Tier[3][4] = {
	Name = "Crouching Leap",
	Description = "Increase the power of your first leap whilst crouching",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 3,
	Requirements = {
		[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.CrouchingLeap = true end,
}

wOS:RegisterSkillTree( TREE )