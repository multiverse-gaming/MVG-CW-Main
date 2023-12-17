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
TREE.Name = "Sentinel Path"

--Description of the skill tree
TREE.Description = "This Jedi ferrets out deceit and injustice, bringing it to light."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/cloak.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 4

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {"TEAM_JEDISENTINEL", "TEAM_JEDICOUNCIL", "TEAM_JEDIGENERALTIPLEE","TEAM_JEDIGURDCHIEF","TEAM_JEDISENGUARD", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER", "TEAM_JEDIGENERALVOS", "TEAM_JEDIGENERALLUMINARA"}

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
	Name = "Jedi Sentinel",
	Description = "You have reached the rank of Sentinel",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + 20 ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

--[[TREE.Tier[1][2] = {
	Name = "Battle Meditation",
	Description = "Affect results of entire battles with just thoughts",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Battle Meditation" ) end,
}--]]

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Saber Throw",
	Description = "Throw your saber at your opponent.",
	Icon = "wos/forceicons/throw.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Saber Throw" ) end,
}

--[[TREE.Tier[2][2] = {
	Name = "Fold Space",
	Description = "Change the location of yourself for the upper hand against your opponent",
	Icon = "wos/forceicons/meditate.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Fold Space" ) end,
}--]]

TREE.Tier[2][2] = {
	Name = "Force Breach",
	Description = "Use the force to open doors with your mind",
	Icon = "wos/forceicons/icefuse/breach.png",
	PointsRequired = 3,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Breach" ) end,
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

--[[TREE.Tier[2][4] = {
	Name = "Cloak",
	Description = "Cloak yourself for 10 seconds.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Cloak" ) end,
}--]]

TREE.Tier[2][3] = {
	Name = "Force EMP",
	Description = "Destroy all the droids around you.",
	Icon = "wos/forceicons/icefuse/blind.png",
	PointsRequired = 6,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force EMP" ) end,
}


TREE.Tier[3] = {}

--[[TREE.Tier[3][1] = {
	Name = "Group Push",
	Description = "Use the force to push multiple people away from you",
	Icon = "wos/forceicons/icefuse/group_push.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Push" ) end,
}

TREE.Tier[3][2] = {
	Name = "Group Pull",
	Description = "Use the force to pull multiple people towards you",
	Icon = "wos/forceicons/icefuse/group_pull.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Pull" ) end,
} --]]

--[[TREE.Tier[3][4] = {
	Name = "Advanced Cloak",
	Description = "Cloak yourself for 25 seconds.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 4 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Advanced Cloak" ) end,
}]]--

--[[TREE.Tier[3][4] = {
	Name = "Shadow Strike",
	Description = "Strike your opponent while invisible.",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 4 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Shadow Strike" ) end,
}--]]

TREE.Tier[3][1] = {
	Name = "Crippling Slam",
	Description = "Earth shattering slams immobilize those in your path",
	Icon = "wos/forceicons/cripple.png",
	PointsRequired = 1,
	Requirements = {
		[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Crippling Slam" ) end,
}
TREE.Tier[4] = {}

wOS:RegisterSkillTree( TREE )