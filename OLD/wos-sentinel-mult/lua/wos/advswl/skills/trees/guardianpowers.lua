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
TREE.Name = "Guardian Path"

--Description of the skill tree
TREE.Description = "We Guardians are the Republic's first line of defense against the thousand enemies who seek to destroy it."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/absorb.png"

--What is the background color in the menu for this
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 4

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {"TEAM_JEDIGUARDIAN", "TEAM_JEDICOUNCIL","TEAM_JEDIGURDCHIEF","TEAM_JEDIGUARGUARD", "TEAM_JEDIGENERALTIPLEE", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER", "TEAM_JEDIGENERALVOS", "TEAM_JEDIGENERALLUMINARA"}

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
	Name = "Charge",
	Description = "Charge toward your enemies to reach them faster",
	Icon = "wos/forceicons/charge.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Charge" ) end,
}

TREE.Tier[1][2] = {
	Name = "Jedi Guardian",
	Description = "You have reached the rank of Guardian",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) --[[ply:SetMaxHealth( ply:GetMaxHealth() + 200 ) ply:SetHealth( ply:Health() + 200 )--]] end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[1][3] = {
	Name = "Battle Meditation",
	Description = "Affect results of entire battles with just thoughts",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Battle Meditation" ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Force Valor",
	Description = "Unleash the full power of the force upon your opponent",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Valor" ) end,
}

--[[TREE.Tier[2][3] = {
	Name = "Dual Lightsabers",
	Description = "Grants you access to Dual Lightsabers",
	Icon = "wos/forceicons/icefuse/barrier.png",
	PointsRequired = 10,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) ply.CanUseDuals = true end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}--]]

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Ground Slam",
	Description = "Launch your fist into the ground damaging those around you.",
	Icon = "star/icon/ground_slam.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Ground Slam" ) end,
}

TREE.Tier[3][2] = {
	Name = "Force Reflect Half",
	Description = "Reflect half of any damage coming at you.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Reflect Half" ) end,
}

TREE.Tier[4] = {}

--[[TREE.Tier[4][1] = {
	Name = "Focused Ground Slam",
	Description = "Ground Slam but focused.",
	Icon = "star/icon/ground_slam.png",
	PointsRequired = 5,
	Requirements = {
	[3] = { 1, 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Focussed Ground Slam" ) end,
}--]]

TREE.Tier[4][1] = {
	Name = "Hardened Force Push",
	Description = "Force Push with a wee bit of Damage",
	Icon = "wos/forceicons/push.png",
	PointsRequired = 5,
	Requirements = {
		[3] = { 1, 2 },
		},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Hardened Force Push" ) end,
}

wOS:RegisterSkillTree( TREE )