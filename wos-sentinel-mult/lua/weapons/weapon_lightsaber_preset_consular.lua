
--[[-------------------------------------------------------------------
	Modified Lightsaber:
		Runs on the intuitive wOS Lightsaber Base
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
	Contact: www.wiltostech.com
		
-- Copyright 2017, David "King David" Wiltos ]]--

AddCSLuaFile()


SWEP.Author = "Robotboy655 + King David"
SWEP.Category = "Lightsabers"
SWEP.Contact = ""
SWEP.RenderGroup = RENDERGROUP_BOTH
SWEP.Slot = 0
SWEP.SlotPos = 4
SWEP.Spawnable = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawWeaponInfoBox = false
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/starwars/w_maul_saber_staff_hilt.mdl"
SWEP.ViewModelFOV = 55
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

------------------------------------------------------------THINGS YOU WILL EDIT ARE BELOW HERE-------------------------------------------------------------------------
SWEP.PrintName = "Consular Lightsaber" --Name of the lightsaber
SWEP.Class = "weapon_lightsaber_preset_consular" --The file name of this swep
SWEP.DualWielded = false --Should this be a dual wielded saber?
SWEP.CanMoveWhileAttacking = true -- Can the user move while attacking
SWEP.SaberDamage = 200 --How much damage the saber does when it's being swung
SWEP.SaberBurnDamage = 0 -- How much damage the saber does when it's colliding with someone ( coming in contact with laser )
SWEP.MaxForce = 200 --The maximum amount of force in the meter
SWEP.RegenSpeed = 1 --The MULTIPLIER for the regen speed. Half speed = 0.5, Double speed = 2, etc.
SWEP.CanKnockback = true --Should this saber be able to push people back when they get hit?
SWEP.ForcePowerList = { "Consular Force Leap", "Sense Weakness", "Consular Speed", "Force Protect", "Force Shield", "Force Group Shield", "Consular Force Heal", "Group Heal", "Group Push" } 
--Force powers you want the saber to have ( REMEMBER TO PUT A COMMA AFTER EACH ONE, AND COPY THE TITLE EXACTLY AS IT'S LISTED )
--For a list of options, just look at the keys in autorun/client/wos_forcematerialbuilding.lua

SWEP.UseSkills = false
SWEP.PersonalLightsaber = false

SWEP.CustomSettings = {}

SWEP.UseForms = {
	["Shien"] = {1, 2, 3},
	["Djem So"] = {1, 2, 3},
	["Shii-Cho"] = {1, 2, 3}, 
	["Makashi"] = {1, 2, 3}, 
	["Soresu"] = {1, 2, 3}, 
	["Ataru"] = {1, 2, 3}, 
	["Niman"] = {1, 2, 3},
	["Juyo"] = {1, 2, 3}, 
	["Adept"] = {1, 2, 3}, 
	["Relentless"] = {1, 2, 3},
}

--Use these options to overwrite the player's commands
SWEP.UseHilt = "models/starwars/cwa/lightsabers/aaylasecura.mdl" -- Model path of the hilt
SWEP.UseLength = 46 -- Length of the saber 
SWEP.UseWidth = 2 -- Width of the saber
SWEP.UseColor = Color( 0, 255, 0 ) -- RGB Color of saber. Red = Color( 255, 0, 0 ) Blue = Color( 0, 0, 255 ), etc.
SWEP.UseDarkInner = false -- Does it have a dark inner? 1 = true
SWEP.UseLoopSound = false -- The loop sound path
SWEP.UseSwingSound = false -- The swing sound path
SWEP.UseOnSound = false -- The on sound path
SWEP.UseOffSound = false -- The off sound path

--These are the ones for the second saber for dual wielding. If you are using a single saber, this doesn't do shit
SWEP.UseSecHilt = false
SWEP.UseSecLength = 41
SWEP.UseSecWidth = false
SWEP.UseSecColor = false
SWEP.UseSecDarkInner = false

-----------------------------------------------------------END OF EDIT----------------------------------------------------------------


if !SWEP.DualWielded then
	SWEP.Base = "wos_adv_single_lightsaber_base"
else
	SWEP.Base = "wos_adv_dual_lightsaber_base"
end



if CLIENT then
	killicon.Add( SWEP.Class, "lightsaber/lightsaber_killicon", color_white )
end
