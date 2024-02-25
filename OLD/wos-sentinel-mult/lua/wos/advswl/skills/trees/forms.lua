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
TREE.TreeIcon = "wos/skilltrees/forms/forms_skill.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 4

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
	Name = "Makashi 1",
	Description = "Gives your Form Aggressive Stance 1",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Makashi", 1 ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Soresu 1",
	Description = "Gives your Form Defensive Stance 1",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Soresu", 1 ) end,
}

TREE.Tier[2][2] = {
	Name = "Niman 1",
	Description = "Gives your Form Versatile Stance 1",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 0,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Niman", 1 ) end,
}

TREE.Tier[2][3] = {
	Name = "Makashi 2",
	Description = "Gives your Form Aggressive Stance 2",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 3,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Makashi", 2 ) end,
}

TREE.Tier[2][4] = {
	Name = "Shii-Cho 1",
	Description = "Gives your Form Agile Stance 1",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 0,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 1 ) end,
}

TREE.Tier[2][5] = {
	Name = "Ataru 1",
	Description = "Gives your Form flourish Stance 1",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 0,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Ataru", 1 ) end,
}

TREE.Tier[2][6] = {
	Name = "Shien 1",
	Description = "Gives your Form Shien Stance 1",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 0,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shien", 1 ) end,
}

TREE.Tier[2][7] = {
	Name = "Djem So 1",
	Description = "Gives your Form Arrogant Stance 1",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 0,
	Requirements = {
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Djem So", 1 ) end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Soresu 2",
	Description = "Gives your Form Defensive Stance 2",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Soresu", 2 ) end,
}

TREE.Tier[3][2] = {
	Name = "Niman 2",
	Description = "Gives your Form Versatile Stance 2",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Niman", 2 ) end,
}

TREE.Tier[3][3] = {
	Name = "Makashi 3",
	Description = "Gives your Form Aggressive Stance 3",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 4,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Makashi", 3 ) end,
}

TREE.Tier[3][4] = {
	Name = "Shii-Cho 2",
	Description = "Gives your Form Agile Stance 2",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 4 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 2 ) end,
}

TREE.Tier[3][5] = {
	Name = "Ataru 2",
	Description = "Gives your Form flourish Stance 2",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 5 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Ataru", 2 ) end,
}

TREE.Tier[3][6] = {
	Name = "Shien 2",
	Description = "Gives your Form Shien Stance 2",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 6 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shien", 2 ) end,
}

TREE.Tier[3][7] = {
	Name = "Djem So 2",
	Description = "Gives your Form Arrogant Stance 2",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 7 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Djem So", 2 ) end,
}

TREE.Tier[4] = {}
TREE.Tier[4][1] = {
	Name = "Soresu 3",
	Description = "Gives your Form Defensive Stance 3",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 4,
	Requirements = {
	[3] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Soresu", 3 ) end,
}

TREE.Tier[4][2] = {
	Name = "Niman 3",
	Description = "Gives your Form Versatile Stance 3",
	Icon = "wos/skilltrees/forms/versatile.png",
	PointsRequired = 4,
	Requirements = {
	[3] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Niman", 3 ) end,
}

TREE.Tier[4][4] = {
	Name = "Shii-Cho 3",
	Description = "Gives your Form Agile Stance 3",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 4,
	Requirements = {
	[3] = { 4 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 3 ) end,
}

TREE.Tier[4][5] = {
	Name = "Ataru 3",
	Description = "Gives your Form flourish Stance 3",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 4,
	Requirements = {
	[3] = { 5 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Ataru", 3 ) end,
}

TREE.Tier[4][6] = {
	Name = "Shien 3",
	Description = "Gives your Form flourish Stance 3",
	Icon = "wos/skilltrees/forms/agile.png",
	PointsRequired = 4,
	Requirements = {
	[3] = { 6 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shien", 3 ) end,
}

TREE.Tier[4][7] = {
	Name = "Djem So 3",
	Description = "Gives your Form Arrogant Stance 3",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 3,
	Requirements = {
	[3] = { 7 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Djem So", 3 ) end,
}
wOS:RegisterSkillTree( TREE )