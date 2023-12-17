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
TREE.Name = "Consular Path"

--Description of the skill tree
TREE.Description = "A Consular is a specialized kind of Jedi. They focus more on cerebral Force skills. They're our healers, our researchers, our seers."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/group_heal.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 4

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {"TEAM_JEDICONSULAR", "TEAM_JEDICOUNCIL", "TEAM_JEDIGENERALTIPLEE","TEAM_JEDIGURDCHIEF","TEAM_JEDICONGUARD", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER", "TEAM_JEDIGENERALVOS", "TEAM_JEDIGENERALLUMINARA"}

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
	Name = "Jedi Consular",
	Description = "You have reached the rank of Consular",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + 50) end,
}

TREE.Tier[1][2] = {
	Name = "Battle Meditation",
	Description = "Affect results of entire battles with just thoughts",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Battle Meditation" ) end,
}

--[[TREE.Tier[1][3] = {
	Name = "Dual Lightsabers",
	Description = "Grants you access to Dual Lightsabers",
	Icon = "wos/forceicons/icefuse/barrier.png",
	PointsRequired = 10,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply.CanUseDuals = true end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}--]]

TREE.Tier[2] = {}

--[[TREE.Tier[2][1] = {
	Name = "Advanced Force Heal",
	Description = "Heal yourself.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 4,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Advanced Force Heal" ) end,
}--]]

TREE.Tier[2][1] = {
	Name = "Group Heal",
	Description = "Heal everyone around you.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Heal" ) end,
}
TREE.Tier[3] = {}

TREE.Tier[3][1] = {
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
	Name = "Force Shield",
	Description = "Turn the air around you into shards of destruction",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 1,
	Requirements = {
		[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Shield" ) end,
}

TREE.Tier[3][3] = {
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
}


--[[TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Crippling Slam",
	Description = "Earth shattering slams immobilize those in your path",
	Icon = "wos/forceicons/cripple.png",
	PointsRequired = 1,
	Requirements = {
		[3] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Crippling Slam" ) end,
}--]]

TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Force Group Shield",
	Description = "Shield yourself and those around you",
	Icon = "wos/forceicons/meditate.png",
	PointsRequired = 1,
	Requirements = {
		[3] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Group Shield" ) end,
}

wOS:RegisterSkillTree( TREE )