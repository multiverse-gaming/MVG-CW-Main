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
TREE.Name = "The True Path to the Light"

--Description of the skill tree
TREE.Description = "Now you have followed the path, master your abilities and learn the true power of the force."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/advanced_cloak.png"

--What is the background color in the menu for this
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {"TEAM_JEDICOUNCIL", "TEAM_JEDIGENERALTIPLEE", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER","TEAM_JEDIGENERALVOS","TEAM_JEDIGENERALLUMINARA","TEAM_JEDIGURDCHIEF"}

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

--[[TREE.Tier[1][1] = {
	Name = "The Grey Path",
	Description = "You have reached the rank of Council Member",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 5,
    Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}]]

TREE.Tier[1][1] = {
	Name = "Jedi Council Member",
	Description = "You have reached the rank of Council Member",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
    Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + 50) end,
}

--[[TREE.Tier[1][3] = {
	Name = "Dual Lightsabers",
	Description = "Grants you access to Dual Lightsabers",
	Icon = "wos/forceicons/icefuse/barrier.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply.CanUseDuals = true end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}]]

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Force Judgement",
	Description = "Learn the power of force judgement to extract information from your enemies.",
	Icon = "wos/forceicons/lightning.png",
	PointsRequired = 5,
	Requirements = {
	    [2] = { 2 },
	    },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Judgement" ) end,
}

TREE.Tier[2][2] = {
	Name = "The Grey Path",
	Description = "You have reached the rank of Council Member",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 5,
	Requirements = {
	    [1] = { 1 },
	    },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[2][3] = {
	Name = "Force Channel",
	Description = "Learn to control the things around you as you master the art of combat meditiating, focusing your power against hatred",
	Icon = "wos/forceicons/channel_hatred.png",
	PointsRequired = 5,
	Requirements = {
	    [2] = { 2 },
	    },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Channel" ) end,
}


TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Advanced Cloak",
	Description = "Vanish into the shadows, Special Ability for Quilan Vos Only.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Advanced Cloak" ) end,
}


TREE.Tier[3][2] = {
	Name = "Force Choke",
	Description = "Learn the power of force choke to end your enemies. Special Ability for Anakin Skywalker Only.",
	Icon = "wos/forceicons/icefuse/choke.png",
	PointsRequired = 5,
	Requirements = {
	    [2] = { 2 },
	    },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Choke" ) end,
}

TREE.Tier[3][3] = {
	Name = "Vapaad 1",
	Description = "Unique form based on Juyo, Special Ability for Mace Windu Only.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 3,
	Requirements = {
	[2] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Dynamic", 1 ) end,
}

TREE.Tier[3][4] = {
	Name = "Kyber Slam",
	Description = "Unleash the true power of your crystal.",
	Icon = "wos/devestators/slam.png",
	PointsRequired = 20,
	Requirements = {
	    [2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddDevestator( "Kyber Slam" ) end,
}

TREE.Tier[3][5] = {
	Name = "Force Stasis",
	Description = "A Small Burst - For Shaak Ti Only",
	Icon = "wos/forceicons/icefuse/stasis.png",
	PointsRequired = 5,
	Requirements = {
	    [2] = { 2 },
	    },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Stasis" ) end,
}


TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Vapaad 2",
	Description = "Unique form based on Juyo, Special Ability for Mace Windu Only.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 3,
	Requirements = {
	[3] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Dynamic", 2 ) end,

}

TREE.Tier[5] = {}

TREE.Tier[5][1] = {
	Name = "Vapaad 3",
	Description = "Unique form based on Juyo, Special Ability for Mace Windu Only.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 3,
	Requirements = {
	[4] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Dynamic", 3 ) end,

}

wOS:RegisterSkillTree( TREE )