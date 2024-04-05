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
TREE.Name = "Yoda Skill Tree"

--Description of the skill tree
TREE.Description = "Master Yoda's special skills."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/advanced_cloak.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 177, 201, 0, 76)

--How many tiers of skills are there?
TREE.MaxTiers = 2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = { "TEAM_JEDIGRANDMASTER" }

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

--[[
local function giveChosenDevestator(wep)
	-- If DevestatorChoice variable is 1/2, give devestator 1/2. This is to ensure only one can be taken.
	if wep:GetOwner().DevestatorChoice == 1 then
		wep:AddDevestator( "Kyber Slam" )
	elseif wep:GetOwner().DevestatorChoice == 2 then
		wep:AddDevestator( "Sonic Discharge" )
	end
end]]--

TREE.Tier[1] = {}

TREE.Tier[1][1] = {
	Name = "Yoda's Stance",
	Description = "Your signature stance.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {},
	OnPlayerSpawn = function( ply ) timer.Create("yodaJumpAttackTimer", 0.25, 0, function() 
		local localWep = ply:GetActiveWeapon()
		if (IsValid(localWep)) then localWep.AerialLand = false end end)
        ply:SetJumpPower(280)
	end,
	OnPlayerDeath = function( ply ) timer.Remove("yodaJumpAttackTimer") end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Yoda", 1 ) end,
}

TREE.Tier[1][2] = {
	Name = "Regenerate Force Quicker",
	Description = "Yoda is an extremely powerful force user, and can use his powers the most often.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:Give("weapon_lightsaber_personal_yoda") end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 30 ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Kyber Slam",
	Description = "Slam enemies for 1200.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 3,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, --ply.DevestatorChoice = 1 end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddDevestator( "Kyber Slam" ) wep:AddForcePower( "Force Channel" ) end,
}

TREE.Tier[2][2] = {
	Name = "Sonic Discharge",
	Description = "Blind the stronger enemies around you, but destory the weaker ones.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 3,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, --ply.DevestatorChoice = 2 end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddDevestator( "Sonic Discharge" ) wep:AddForcePower( "Force Channel" ) end,
}


wOS:RegisterSkillTree( TREE )