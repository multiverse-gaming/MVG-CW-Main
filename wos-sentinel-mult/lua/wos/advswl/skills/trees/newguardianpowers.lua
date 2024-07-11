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
TREE.Name = "Guardian Path"

--Description of the skill tree
TREE.Description = "These Jedi are the Republic's first line of defense against the thousand enemies who seek to destroy it."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/reflect.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 19, 0, 189, 35)

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = JediGuardian

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
	Name = "Force Speed",
	Description = "A brief burst of speed.",
	Icon = "wos/forceicons/charge.png",
	PointsRequired = 1,
    Requirements = {
	    [1] = { 3 },
	    },
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Speed" )
	if (wep:GetOwner():GetRunSpeed() > 450) then
		RunConsoleCommand("sam", "asay", "Player " .. wep:GetOwner():GetName() .. " is likely abusing force speed")
	end	end,
}
TREE.Tier[1][2] = {
	Name = "Dueling Abilities",
	Description = "Use this to use valor, stamina and reflect.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Dueling Abilities" ) end,
}

TREE.Tier[1][3] = {
	Name = "Jedi Guardian",
	Description = "Welcome to the rank of Guardian.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) CheckIfPlayerIsCheating(ply) ply:SetMaxHealth( ply:GetMaxHealth() + 50 ) ply:SetHealth( ply:Health() + 50 ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.GuardianLeap = true end,
}

TREE.Tier[1][4] = {
	Name = "Guardian Tradeoff 1",
	Description = "Focus your speed into your hardiness.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() - 10) ply:SetMaxHealth( ply:GetMaxHealth() + 50 ) ply:SetHealth( ply:Health() + 50 ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[1][5] = {
	Name = "Guardian Tradeoff 2",
	Description = "Focus your speed into your hardiness.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 4 },
	},
	OnPlayerSpawn = function( ply ) ply:SetRunSpeed( ply:GetRunSpeed() - 10) ply:SetMaxHealth( ply:GetMaxHealth() + 50 ) ply:SetHealth( ply:Health() + 50 ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Weak Hardened Force Push Skill",
	Description = "Hurt your enemy, and push them away.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 0,
	Requirements = {
	[2] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Weak Hardened Force Push" ) end,
}

TREE.Tier[2][2] = {
	Name = "Weak Hardened Force Push Upgrade",
	Description = "Upgrades the basic Push And Pull skill to do damage.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.HardenedForcePush = true end,
}

TREE.Tier[2][3] = {
	Name = "Force Reflect Half Upgrade",
	Description = "Use the force to reflect half damage for a time. Default Dueling Abilities skill.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.ForceReflect = true end,
}

TREE.Tier[2][4] = {
	Name = "Force Reflect Half Skill",
	Description = "Use the force to reflect half damage for a time. Seperate Skill.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 0,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Reflect Half" ) end,
}

TREE.Tier[2][5] = {
	Name = "Charge",
	Description = "Launch yourself at your opponent.",
	Icon = "wos/forceicons/charge.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Charge" ) end,
}

TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Force Stamina Skill",
	Description = "Channel the force into yourself, and regain your lost stamina.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 0,
	Requirements = {
		[3] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Stamina" ) end,
}

TREE.Tier[3][2] = {
	Name = "Force Stamina Upgrade",
	Description = "Channel the force into yourself, and regain your lost stamina.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 2,
	Requirements = {
		[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.ForceStamina = true end,
}

TREE.Tier[3][3] = {
	Name = "Saber Throw",
	Description = "Throw your saber at your opponent.",
	Icon = "wos/forceicons/throw.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Saber Throw" ) end,
}

TREE.Tier[3][4] = {
	Name = "Ground Slam",
	Description = "Slam your fist into the ground and damage the enemies before you.",
	Icon = "wos/devestators/slam.png",
	PointsRequired = 2,
	Requirements = {
		[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Ground Slam" ) end,
}

TREE.Tier[3][5] = {	
	Name = "Focused Ground Slam",
	Description = "Make Ground Slam safer to use near allies. ",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 0,
	Requirements = {
		[3] = { 4 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.FocussedGroundSlam = true end,
}

TREE.Tier[3][6] = {	
	Name = "Force Valor Upgrade",
	Description = "Deal more damage briefly.",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 2,
	Requirements = {
		[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.ForceValor = true end,
}

TREE.Tier[3][7] = {	
	Name = "Force Valor Skill",
	Description = "Deal more damage briefly. Seperate Skill. ",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 0,
	Requirements = {
		[3] = { 6 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Valor" ) end,
}

TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Guardian Health Upgrade 1",
	Description = "You feel heartier.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) ply:SetMaxHealth( ply:GetMaxHealth() + ForceHpSpeedStamina[2] ) ply:SetHealth( ply:Health() + ForceHpSpeedStamina[2] ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[4][2] = {
	Name = "Guardian Armour",
	Description = "The first few hits against you are weakened.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 3,
	Requirements = {
	[4] = { 1, 3 },
	},
	OnPlayerSpawn = function( ply ) ply:SetArmor(150) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[4][3] = {
	Name = "Guardian Stamina Upgrade 1",
	Description = "You feel safer.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxStamina( wep:GetMaxStamina() + ForceHpSpeedStamina[4] + 1 ) end,
}

TREE.Tier[5] = {}

TREE.Tier[5][1] = {
	Name = "Guardian Health Upgrade 2",
	Description = "You feel heartier.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 2,
	Requirements = {
		[4] = { 1 },
	},
	OnPlayerSpawn = function( ply ) ply:SetMaxHealth( ply:GetMaxHealth() + ForceHpSpeedStamina[2] ) ply:SetHealth( ply:Health() + ForceHpSpeedStamina[2] ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[5][2] = {
	Name = "Force Guard",
	Description = "Gain enough armour to live through most attacks - briefly.",
	Icon = "wos/skilltrees/forms/aggressive.png",
	PointsRequired = 10,
	Requirements = {
		[5] = { 1, 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Guard" ) end,
}

TREE.Tier[5][3] = {
	Name = "Guardian Stamina Upgrade 2",
	Description = "You feel safer.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 2,
	Requirements = {
		[4] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxStamina( wep:GetMaxStamina() + ForceHpSpeedStamina[4] ) end,
}

wOS:RegisterSkillTree( TREE )

function CheckIfPlayerIsCheating(ply)
	local team = ply:Team()
	if (string.match(team, "501") || string.match(team, "212") || string.match(team, "327")) then
		-- Player is playing reg jedi - make sure they have "High" or "uardian" in their name.
		if (!string.match(ply:Name(), "uardian") || !string.match(ply:Name(), "High")) then
			hook.Call("WILTOS.PlayerCouldBeCheating", nil, ply, "Guardian Skills")
		end
	end
end