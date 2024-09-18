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
TREE.Name = "Dead Path"

--Description of the skill tree
TREE.Description = "You shouldn't be able to see this. Please contact a developer. None of this works."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/group_heal.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 4

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {}

TREE.Tier = {}

TREE.Tier[1] = {}

-- This is just going to contain stuff we AREN'T using - useful hooks and code so that it isn't forgotten.

TREE.Tier[1][1] = {
	Name = "Dual Lightsabers",
	Description = "Grants you access to Dual Lightsabers",
	Icon = "wos/forceicons/icefuse/barrier.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply.CanUseDuals = true end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

wOS:RegisterSkillTree( TREE )