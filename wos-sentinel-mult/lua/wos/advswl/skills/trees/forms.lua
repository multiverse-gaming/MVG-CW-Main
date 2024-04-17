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
TREE.Name = "Forms"

--Description of the skill tree
TREE.Description = "Learn the Martial Arts of the Force."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/forms/versatile.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {"TEAM_JEDIPADAWAN", "TEAM_JEDIKNIGHT", "TEAM_JEDISENTINEL", "TEAM_JEDIGURDCHIEF","TEAM_JEDICONGUARD","TEAM_JEDISENGUARD","TEAM_JEDIGUARGUARD","TEAM_JEDIGENERALTIPLEE", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDIGUARDIAN", "TEAM_JEDICONSULAR", "TEAM_JEDIHEALER", "TEAM_JEDISHADOW", "TEAM_JEDICOUNCIL", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER", "TEAM_JEDIGENERALVOS", "TEAM_JEDIGENERALLUMINARA"}

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
	Name = "Soresu 1",
	Description = "Gives your Form Defensive Stance 1",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Soresu", 1 ) end,
}

TREE.Tier[1][2] = {
	Name = "Niman 1",
	Description = "Gives your Form Versatile Stance 1",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Niman", 1 ) end,
}

TREE.Tier[1][3] = {
	Name = "Makashi 1",
	Description = "Gives your Form Aggressive Stance 1",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Makashi", 1 ) end,
}

TREE.Tier[1][4] = {
	Name = "Shii-Cho 1",
	Description = "Gives your Form Agile Stance 1",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 1 ) end,
}

TREE.Tier[1][5] = {
	Name = "Ataru 1",
	Description = "Gives your Form flourish Stance 1",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Ataru", 1 ) end,
}

TREE.Tier[1][6] = {
	Name = "Shien 1",
	Description = "Gives your Form Shien Stance 1",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shien", 1 ) end,
}

TREE.Tier[1][7] = {
	Name = "Djem So 1",
	Description = "Gives your Form Arrogant Stance 1",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Djem So", 1 ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Soresu 2",
	Description = "Gives your Form Defensive Stance 2",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Soresu", 2 ) end,
}

TREE.Tier[2][2] = {
	Name = "Niman 2",
	Description = "Gives your Form Versatile Stance 2",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Niman", 2 ) end,
}

TREE.Tier[2][3] = {
	Name = "Makashi 2",
	Description = "Gives your Form Aggressive Stance 2",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Makashi", 2 ) end,
}

TREE.Tier[2][4] = {
	Name = "Shii-Cho 2",
	Description = "Gives your Form Agile Stance 2",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 2 ) end,
}

TREE.Tier[2][5] = {
	Name = "Ataru 2",
	Description = "Gives your Form flourish Stance 2",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Ataru", 2 ) end,
}

TREE.Tier[2][6] = {
	Name = "Shien 2",
	Description = "Gives your Form Shien Stance 2",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shien", 2 ) end,
}

TREE.Tier[2][7] = {
	Name = "Djem So 2",
	Description = "Gives your Form Arrogant Stance 2",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Djem So", 2 ) end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Soresu 3",
	Description = "Gives your Form Defensive Stance 3",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Soresu", 3 ) end,
}

TREE.Tier[3][2] = {
	Name = "Niman 3",
	Description = "Gives your Form Versatile Stance 3",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Niman", 3 ) end,
}

TREE.Tier[3][3] = {
	Name = "Makashi 3",
	Description = "Gives your Form Aggressive Stance 3",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Makashi", 3 ) end,
}

TREE.Tier[3][4] = {
	Name = "Shii-Cho 3",
	Description = "Gives your Form Agile Stance 3",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 3 ) end,
}

TREE.Tier[3][5] = {
	Name = "Ataru 3",
	Description = "Gives your Form flourish Stance 3",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Ataru", 3 ) end,
}

TREE.Tier[3][6] = {
	Name = "Shien 3",
	Description = "Gives your Form Shien Stance 3",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shien", 3 ) end,
}

TREE.Tier[3][7] = {
	Name = "Djem So 3",
	Description = "Gives your Form Arrogant Stance 3",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Djem So", 3 ) end,
}

TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Juyo 2",
	Description = "Gives your Form Juyo Stance 2",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Juyo", 2 ) end,
}

TREE.Tier[4][2] = {
	Name = "Juyo 1",
	Description = "Gives your Form Juyo Stance 1",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Juyo", 1 ) end,
}

TREE.Tier[4][3] = {
	Name = "Zenith 1",
	Description = "Gives your Form Zenith Stance 1",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Zenith", 1 ) end,
}

TREE.Tier[4][4] = {
	Name = "Relentless 1",
	Description = "Gives your Form Relentless Stance 1",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Relentless", 1 ) end,
}

TREE.Tier[4][5] = {
	Name = "Jar'Kai 1",
	Description = "Gives your Dual Form Jar'Kai Stance 1",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Jar'Kai", 1 ) end,
}

TREE.Tier[4][6] = {
	Name = "Jar'Kai 2",
	Description = "Gives your Dual Form Jar'Kai Stance 2",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Jar'Kai", 2 ) end,
}

TREE.Tier[5] = {}

TREE.Tier[5][1] = {
	Name = "Juyo 3",
	Description = "Gives your Form Juyo Stance 3",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Juyo", 3 ) end,
}

TREE.Tier[5][2] = {
	Name = "Zenith 3",
	Description = "Gives your Form Zenith Stance 3",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Zenith", 3 ) end,
}

TREE.Tier[5][3] = {
	Name = "Zenith 2",
	Description = "Gives your Form Zenith Stance 2",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Zenith", 2 ) end,
}

TREE.Tier[5][4] = {
	Name = "Relentless 2",
	Description = "Gives your Form Relentless Stance 2",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Relentless", 2 ) end,
}

TREE.Tier[5][5] = {
	Name = "Relentless 3",
	Description = "Gives your Form Relentless Stance 3",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Relentless", 3 ) end,
}

TREE.Tier[5][6] = {
	Name = "Jar'Kai 3",
	Description = "Gives your Dual Form Jar'Kai Stance 3",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Jar'Kai", 3 ) end,
}

wOS:RegisterSkillTree( TREE )