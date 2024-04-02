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
TREE.Name = "In-dev skills, and useful things"

--Description of the skill tree
TREE.Description = "Only use these for testing or events"

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/icefuse/breach.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color(255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = { "superadmin", "activedeveloper", "developer", "admin", "headadmin" }

TREE.JobRestricted = {"TEAM_JEDIPADAWAN", "TEAM_JEDIKNIGHT","TEAM_JEDIGURDCHIEF","TEAM_JEDICONGUARD","TEAM_JEDISENGUARD","TEAM_JEDIGUARGUARD", "TEAM_JEDIGENERALTIPLEE", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDISENTINEL", "TEAM_JEDIGUARDIAN", "TEAM_JEDICONSULAR", "TEAM_JEDICOUNCIL", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER", "TEAM_JEDIGENERALVOS","TEAM_JEDIGENERALLUMINARA"}

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

-- New force powers in this tree: 
-- Gen: Master Force Breach, Force Barrier, Mundis Hardened Force Push, Force Deflect, Force Reflect, Force Blast, Shatter Point
-- Sentinel: Force Light, Force Slow, Force Blind, Fold Space, Force Cloak, Sentinel Heal, Sentinel Charge
-- Guardian: Weak Hardened Force Push, Strong Hardened Force Push, Charge, Force Stamina, Force Guard, Guardian Force Shield, Guardian Saber Throw
-- Consular: Force Sacrifice, Sense Weakness, Force Buff, Consular Force EMP, Consular Hardened Force Push
-- Other powers in this tree: 
-- On this tier:
TREE.Tier[1] = {}

TREE.Tier[1][1] = {
	Name = "General - Master Force Breach",
	Description = "Gives MFB.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Master Force Breach" ) end,
}

TREE.Tier[1][2] = {
	Name = "General - Force Barrier",
	Description = "Gives FB.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Barrier" ) end,
}

TREE.Tier[1][3] = {
	Name = "General - Mundis Hardened Force Push",
	Description = "Gives MHFP",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Mundis Hardened Force Push" ) end,
}

TREE.Tier[1][4] = {
	Name = "General - Force Deflect",
	Description = "Gives D.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Deflect" ) end,
}

TREE.Tier[1][5] = {
	Name = "General - Force Reflect",
	Description = "Gives FR.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Reflect" ) end,
}

TREE.Tier[1][6] = {
	Name = "General - Force Blast",
	Description = "Gives FB.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Blast" ) end,
}

TREE.Tier[1][7] = {
	Name = "General - Shatter Point",
	Description = "Gives SP.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Shatter Point" ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Sentinel - Force Light",
	Description = "Gives FL.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Light" ) end,
}

TREE.Tier[2][2] = {
	Name = "Sentinel - Force Slow",
	Description = "Gives FS.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Slow" ) end,
}

TREE.Tier[2][3] = {
	Name = "Sentinel - Force Blind",
	Description = "Gives FB.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Blind" ) end,
}

TREE.Tier[2][4] = {
	Name = "Sentinel - Fold Space",
	Description = "Gives FS.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Fold Space" ) end,
}

TREE.Tier[2][5] = {
	Name = "Sentinel - Force Cloak",
	Description = "Gives C.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Cloak" ) end,
}

TREE.Tier[2][6] = {
	Name = "Sentinel - Sentinel Heal",
	Description = "Gives H.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Sentinel Heal" ) end,
}

TREE.Tier[2][7] = {
	Name = "Sentinel - Sentinel Charge",
	Description = "Gives C.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Sentinel Charge" ) end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Guardian - Weak Hardened Force Push",
	Description = "Gives WHFP.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Weak Hardened Force Push" ) end,
}

TREE.Tier[3][2] = {
	Name = "Guardian - Strong Hardened Force Push",
	Description = "Gives SHFP.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Strong Hardened Force Push" ) end,
}

TREE.Tier[3][3] = {
	Name = "Guardian - Charge",
	Description = "Gives C.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Charge" ) end,
}

TREE.Tier[3][4] = {
	Name = "Guardian - Force Stamina",
	Description = "Gives FS.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Stamina" ) end,
}

TREE.Tier[3][5] = {
	Name = "Guardian - Force Guard",
	Description = "Gives FG.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Guard" ) end,
}

TREE.Tier[3][6] = {
	Name = "Guardian - Guardian Force Shield",
	Description = "Gives FS.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Guardian Force Shield" ) end,
}

TREE.Tier[3][7] = {
	Name = "Guardian - Guardian Saber Throw",
	Description = "Gives ST.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Guardian Saber Throw" ) end,
}

TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Consular - Force Sacrifice",
	Description = "Gives FS.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Sacrifice" ) end,
}

TREE.Tier[4][2] = {
	Name = "Consular - Sense Weakness",
	Description = "Gives SW.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Sense Weakness" ) end,
}

TREE.Tier[4][3] = {
	Name = "Consular - Force Buff",
	Description = "Gives FB.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Buff" ) end,
}

TREE.Tier[4][4] = {
	Name = "Consular - Consular Force EMP",
	Description = "Gives EMP.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Consular Force EMP" ) end,
}

TREE.Tier[4][5] = {
	Name = "Consular - Consular Hardened Force Push",
	Description = "Gives CFP.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Consular Hardened Force Push" ) end,
}

TREE.Tier[5] = {}

TREE.Tier[5][1] = {
	Name = "STRONG - Devestator - Sonic Discharge",
	Description = "Gives FS.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddDevestator( "Sonic Discharge" ) end,
}

TREE.Tier[5][2] = {
	Name = "STRONG - Devestator - Lightning Coil",
	Description = "Gives the devestator Lightning Coil. Alt+R if multiple are active.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddDevestator( "Lightning Coil" ) end,
}

TREE.Tier[5][3] = {
	Name = "STRONG - Force Repulse",
	Description = "Gives R.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Repulse" ) end,
}

TREE.Tier[5][4] = {
	Name = "Shadow Strike",
	Description = "Gives SS. Use with Cloak.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Shadow Strike" ) end,
}

TREE.Tier[5][5] = {
	Name = "STRONG - Funny Crush",
	Description = "Gives FC. Very gory.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Funny Crush" ) end,
}

TREE.Tier[5][6] = {
	Name = "STRONG - Fighting Chance Test",
	Description = "Gives FC. This is, uh... something.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Fighting Chance Test" ) end,
}

TREE.Tier[5][7] = {
	Name = "Disabling Strike",
	Description = "Gives DS. Use with Cloak.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Disabling Strike" ) end,
}

wOS:RegisterSkillTree( TREE )