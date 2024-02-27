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
TREE.Description = "These Jedi ferret out deceit and injustice, bringing it to light."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/absorb.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 177, 201, 0, 76)

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = {"TEAM_JEDISENTINEL", "TEAM_JEDICOUNCIL", "TEAM_JEDIGENERALTIPLEE","TEAM_JEDIGURDCHIEF","TEAM_JEDISENGUARD", "TEAM_JEDIGENERALTIPLAR", "TEAM_JEDIGENERALADI", "TEAM_JEDIGENERALSHAAK", "TEAM_JEDIGENERALAAYLA", "TEAM_JEDIGENERALKIT", "TEAM_JEDIGENERALPLO", "TEAM_JEDIGENERALTANO", "TEAM_JEDIGENERALWINDU", "TEAM_JEDIGENERALOBI", "TEAM_JEDIGENERALSKYWALKER", "TEAM_JEDIGRANDMASTER", "TEAM_JEDIGENERALVOS", "TEAM_JEDIGENERALLUMINARA"}

local ForceHpSpeedStamina = {20, 50, 10, 12}

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
	Name = "Sentinel equipment",
	Description = "Needed equipment to help clone engineers.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) 
		ply:Give("weapon_physcannon")
		ply:Give("datapad_player")
		ply:Give("defuser_bomb")
		ply:Give("defuse_kit")
		ply:Give("weapon_dronerepair")
		ply:Give("weapon_extinguisher_infinite")
		ply:Give("alydus_fusioncutter")
		ply:Give("weapon_remotedrone")
	end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[1][2] = {
	Name = "Sentinel Leap",
	Description = "Use the force to leap forwards.",
	Icon = "wos/forceicons/leap.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Leap" ) end,
}

TREE.Tier[1][3] = {
	Name = "Jedi Sentinel",
	Description = "Welcome to the rank of Sentinel.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + 10) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[1][4] = {
	Name = "Sentinel Tradeoff",
	Description = "Focus your hardiness into your speed.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + 10 ) ply:SetMaxHealth( ply:GetMaxHealth() - 50 ) ply:SetHealth( ply:Health() - 50 ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[1][5] = {
	Name = "Sentinel Tradeoff",
	Description = "Focus your hardiness into your speed.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 4 },
	},
	-- For whatever reason, the two HP changes dont stack, so double the changes.
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + 20 ) ply:SetMaxHealth( ply:GetMaxHealth() - 100 ) ply:SetHealth( ply:Health() - 100 ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Saber Throw",
	Description = "Throw your saber at your opponent.",
	Icon = "wos/forceicons/throw.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Saber Throw" ) end,
}

TREE.Tier[2][2] = {
	Name = "Force Breach",
	Description = "Open doors, move elevators, and create opportunity.",
	Icon = "wos/forceicons/icefuse/breach.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Breach" ) end,
}

TREE.Tier[2][3] = {
	Name = "Force Slow",
	Description = "Use the force to hinder your opponents movement",
	Icon = "wos/forceicons/push.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Slow" ) end,
}

TREE.Tier[2][4] = {
	Name = "Force Blind",
	Description = "Use the force to hinder your opponents sight.",
	Icon = "wos/forceicons/icefuse/blind.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Blind" ) end,
}

TREE.Tier[2][5] = {
	Name = "Force Light",
	Description = "Light the way for yourself and others.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Light" ) end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Fold Space",
	Description = "Step through space to your target - but beware the stun.",
	Icon = "wos/forceicons/icefuse/teleport.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Fold Space" ) end,
}

TREE.Tier[3][2] = {
	Name = "Force Speed",
	Description = "Move much faster for a brief period.",
	Icon = "wos/forceicons/charge.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Sentinel Speed" ) end,
}

TREE.Tier[3][3] = {
	Name = "Force EMP",
	Description = "Destroy all the droids around you.",
	Icon = "wos/forceicons/icefuse/blind.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force EMP" ) end,
}

TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Sentinel Speed Upgrade 1",
	Description = "You feel faster.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + ForceHpSpeedStamina[3] ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[4][2] = {
	Name = "On The Mark...",
	Description = "When you spawn in, you get a brief burst of speed, to get you in or out of danger.",
	Icon = "wos/forceicons/cripple.png",
	PointsRequired = 3,
	Requirements = {
		[4] = { 1, 3 },
	},
	OnPlayerSpawn = function( ply ) 
		ply:SetRunSpeed( ply:GetRunSpeed() + 100 )
		timer.Simple(5, function ()
			ply:SetRunSpeed( ply:GetRunSpeed() - 100 )
		end)
	end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[4][3] = {
	Name = "Sentinel Force Upgrade 1",
	Description = "You feel stronger.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + ForceHpSpeedStamina[1] ) end,
}

TREE.Tier[5] = {}

TREE.Tier[5][1] = {
	Name = "Sentinel Speed Upgrade 2",
	Description = "You feel faster.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 2,
	Requirements = {
		[4] = { 1 },
	},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + ForceHpSpeedStamina[3] ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[5][2] = {
	Name = "Force Cloak",
	Description = "Hide yourself from simple minded and programmed enemies.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 10,
	Requirements = {
		[5] = { 1, 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Cloak" ) end,
}

TREE.Tier[5][3] = {
	Name = "Sentinel Force Upgrade 2",
	Description = "You feel stronger.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 2,
	Requirements = {
		[4] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + ForceHpSpeedStamina[1] ) end,
}

wOS:RegisterSkillTree( TREE )