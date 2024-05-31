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
TREE.Name = "Aayla Skill Tree"

--Description of the skill tree
TREE.Description = "Aayla Secura's special skills."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/advanced_cloak.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 177, 201, 0, 76)

--How many tiers of skills are there?
TREE.MaxTiers = 1

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = { "TEAM_JEDIGENERALAAYLA" }

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
	Name = "The Engineer's Dream",
	Description = "Engineering equipment, along with the speed to use it.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 3,
	Requirements = {},
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
	OnPlayerDeath = function( ply ) ply.IsSpeeding = nil end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Master Force Speed" ) end,
}

TREE.Tier[1][2] = {
	Name = "Aayla's Stance",
	Description = "Your signature stance.",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Aayla", 1 ) end,
}

TREE.Tier[1][3] = {
	Name = "Speed Increase",
	Description = "A reasonable increase to speed.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() + 10) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

wOS:RegisterSkillTree( TREE )