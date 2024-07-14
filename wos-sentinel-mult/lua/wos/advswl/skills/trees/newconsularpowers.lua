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
TREE.Name = "Consular Path"

--Description of the skill tree
TREE.Description = "These Jedi are our healers, our researchers, our seers. Pioneers in the force."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/forceicons/lightstream.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 177, 201, 0, 76)

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.JobRestricted = JediConsular

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
	Name = "Consular equipment",
	Description = "Needed equipment to heal your fellows.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) ply:Give("weapon_force_heal", true) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[1][2] = {
	Name = "Jedi Consular",
	Description = "Welcome to the rank of Consular.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply )
		CheckIfPlayerIsCheatingConsular(ply)
	end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + 30) wep.ConsularLeap = true end,
}

TREE.Tier[1][3] = {
	Name = "Consular Tradeoff 1",
	Description = "Focus your hardiness into your force.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) ply:SetMaxHealth( ply:GetMaxHealth() - 25 ) ply:SetHealth( ply:Health() - 25 ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + 20) end,
}

TREE.Tier[1][4] = {
	Name = "Consular Tradeoff 2",
	Description = "Focus your hardiness into your force.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 0,
	Requirements = {
	[1] = { 3 },
	},
	OnPlayerSpawn = function( ply ) ply:SetMaxHealth( ply:GetMaxHealth() - 25 ) ply:SetHealth( ply:Health() - 25 ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + 20) end,
}

TREE.Tier[2] = {}

TREE.Tier[2][1] = {
	Name = "Group Heal Skill",
	Description = "Heal people around you. Seperate Skill.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 0,
	Requirements = {
	[2] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Heal" ) end,
}

TREE.Tier[2][2] = {
	Name = "Group Heal Upgrade",
	Description = "Heal people around you. Crouching Force Heal skill.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.GroupHeal = true end,
}

TREE.Tier[2][3] = {
	Name = "Force Heal",
	Description = "Stay ready whilst getting ready to get back in the fight.",
	Icon = "wos/forceicons/meditate.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Consular Force Heal" ) end,
}

TREE.Tier[2][4] = {
	Name = "Force Shield",
	Description = "Shield yourself from oncoming fire.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Shield" ) end,
}

TREE.Tier[2][5] = {
	Name = "Force Protect",
	Description = "Give another a chance to live.",
	Icon = "wos/forceicons/throw.png",
	PointsRequired = 2,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Protect" ) end,
}


TREE.Tier[3] = {}

TREE.Tier[3][1] = {
	Name = "Sense Weakness",
	Description = "Sense when allies or enemies are nearing the end.",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Sense Weakness" ) end,
}

TREE.Tier[3][2] = {
	Name = "Consular Speed",
	Description = "Cover a great distance at great speed.",
	Icon = "wos/forceicons/charge.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) ply.IsSpeeding = nil end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Consular Speed" )
	if (wep:GetOwner():GetRunSpeed() > 450) then
		RunConsoleCommand("sam", "asay", "Player " .. wep:GetOwner():GetName() .. " is likely abusing force speed")
	end	end,
}

TREE.Tier[3][3] = {
	Name = "Force Group Shield",
	Description = "Shield yourself, and those around you.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Group Shield" ) end,
}

TREE.Tier[3][4] = {
	Name = "Force Group Push",
	Description = "Push everyone around you.",
	Icon = "wos/forceicons/icefuse/group_push.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Push" ) end,
}

TREE.Tier[3][5] = {
	Name = "Force Group Pull",
	Description = "Pull everyone around you.",
	Icon = "wos/forceicons/icefuse/group_pull.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Pull" ) end,
}

TREE.Tier[4] = {}

TREE.Tier[4][1] = {
	Name = "Consular Force Upgrade 1",
	Description = "You feel stronger.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce(wep:GetMaxForce() + ForceHpSpeedStamina[1] ) end,
}

TREE.Tier[4][2] = {
	Name = "Protect the Living",
	Description = "Leave behind a group force shield when you pass.",
	Icon = "wos/forceicons/cripple.png",
	PointsRequired = 3,
	Requirements = {
		[4] = { 1, 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) 
		-- Creates the group shield from the consular force power. 
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/tubes/tube4x4x2to2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(ply:GetPos() + ply:EyeAngles():Up() * 45)
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_VPHYSICS)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()
			timer.Simple(15, function()
				if shield:IsValid() then
					shield:Remove()
			end
		end)
	end,
	OnSaberDeploy = function( wep ) end,
}

TREE.Tier[4][3] = {
	Name = "Consular Stamina Upgrade 1",
	Description = "You feel safer.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxStamina( wep:GetMaxStamina() + ForceHpSpeedStamina[4] ) end,
}

TREE.Tier[5] = {}

TREE.Tier[5][1] = {
	Name = "Consular Force Upgrade 2",
	Description = "You feel stronger.",
	Icon = "wos/forceicons/lightstream.png",
	PointsRequired = 2,
	Requirements = {
		[4] = { 1 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
}

TREE.Tier[5][2] = {
	Name = "Force Sacrifice",
	Description = "Channel damage to an ally into yourself.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 10,
	Requirements = {
		[5] = { 1, 3 },
	},
	OnPlayerSpawn = function( ply ) end,
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Sacrifice" ) end,
}

TREE.Tier[5][3] = {
	Name = "Consular Stamina Upgrade 2",
	Description = "You feel safer.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 2,
	Requirements = {
		[4] = { 3 },
	},
	OnPlayerSpawn = function( ply ) end, 
	OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxStamina( wep:GetMaxStamina() + ForceHpSpeedStamina[4] + 1 ) end,
}

wOS:RegisterSkillTree( TREE )

function CheckIfPlayerIsCheatingConsular(ply)
	local teamName = team.GetName(ply:Team())
	if (string.match(teamName, "501") || string.match(teamName, "212") || string.match(teamName, "327")) then
		-- Player is playing reg jedi - make sure they have "High" or "uardian" in their name.
		if (!string.match(ply:Name(), "onsular") && !string.match(ply:Name(), "age") && !string.match(ply:Name(), "	orekeeper") && !string.match(ply:Name(), "cholar")
		&& !string.match(ply:Name(), "High")) then
			RunConsoleCommand("sam", "asay", "Player " .. ply:GetName() .. " is likely abusing consular powers")
		end
	end
end