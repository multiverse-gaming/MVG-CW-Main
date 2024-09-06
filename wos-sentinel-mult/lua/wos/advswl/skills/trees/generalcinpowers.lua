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
TREE.Name = "Cin Drallig Skill Tree"

--Description of the skill tree
TREE.Description = "Cin Drallig's special skills."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/advanced_cloak.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 177, 201, 0, 76)

--How many tiers of skills are there?
TREE.MaxTiers = 1

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = { "TEAM_JEDIGENCINDRALLIG", "TEAM_CGJEDICHIEF" }

TREE.Tier = {}

TREE.Tier[1] = {}

TREE.Tier[1][1] = {
	Name = "Force Sense",
	Description = "Sense all lifeforms around you.",
	Icon = "wos/forceicons/meditate.png",
	PointsRequired = 3,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Sense" ) end,
}

TREE.Tier[1][2] = {
	Name = "Drallig's Stance",
	Description = "Your signature stance.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Cin", 1 ) end,
}

TREE.Tier[1][3] = {
	Name = "Health Increase",
	Description = "Cin Drallig is pretty hardy.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:SetMaxHealth( ply:GetMaxHealth() + 50 ) ply:SetHealth( ply:Health() + 50 ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

wOS:RegisterSkillTree( TREE )