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
TREE.Name = "Basic Skills"

--Description of the skill tree
TREE.Description = "Skills all Jedi should have."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/meditate.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

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
	Name = "Meditate",
	Description = "Heal, and reflect on your mistakes",
	Icon = "wos/forceicons/meditate.png",
	PointsRequired = 0,
    Requirements = {  },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Meditate" ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Force Push Upgrade",
	Description = "Push an enemy away from yourself. Modifies Push And Pull.",
	Icon = "wos/forceicons/push.png",
	PointsRequired = 1,
    Requirements = {  },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.ForcePush = true end,
}

TREE.Tier[2][2] = {
	Name = "Force Push And Pull",
	Description = "If you've bought the upgrades, use or hold Shift to pull/push.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 0,
    Requirements = {  },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Push And Pull" ) end,
}

TREE.Tier[2][3] = {
	Name = "Force Pull Upgrade",
	Description = "Pull someone towards you. Modifies Push And Pull.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 1,
    Requirements = {  },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.ForcePull = true end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Force Push Skill",
	Description = "Push an enemy away from yourself. Seperate Skill.",
	Icon = "wos/forceicons/push.png",
	PointsRequired = 0,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Push" ) end,
}

TREE.Tier[3][2] = {
	Name = "Force Pull Skill",
	Description = "Pull someone towards you. Seperate Skill.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 0,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Pull" ) end,
}


wOS:RegisterSkillTree( TREE )