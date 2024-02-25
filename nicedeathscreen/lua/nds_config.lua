/*-----------------------------------------------------------
	Nice DeathScreen
	
	Copyright © 2015 Szymon (Szymekk) Jankowski
	All Rights Reserved
	Steam: https://steamcommunity.com/id/szymski
-------------------------------------------------------------*/

NDSConfig = { }
local Config = NDSConfig

/*----------------------------------------------
	Nice DeathScreen Configuration
------------------------------------------------*/

Config.DeathScreenStyle						= 1 				// Type of DeathScreen
// 0 - Gradient
// 1 - Sleek styled boxes

Config.SleekBoxColor						= Color(30, 30, 30)	// Color of boxes if style is set to 1

Config.HideHUD								= true				// Hides default HUD when true

Config.RespawnDelay							= 5					// Time the player have to wait until respawn (in seconds)

Config.GroupRespawnDelay 					= {					// Respawn delays for specific groups

}

Config.SmoothAnim							= true 				// When enabled, everything has smooth animations

Config.KillerCamera							= false				// Moves camera to killer when true

Config.ForceRespawn							= false				// Respawns player automatically after delay

/*--------------------------------
	Texts
----------------------------------*/

Config.SecondsText							= "%i seconds till respawn"		
Config.RespawnText							= "Press any key to respawn"

Config.BottomText							= ""							// Can be empty. Then it'll show killer's name

Config.ShowWeapon							= true							// Shows name of the weapon you were killed by

/*--------------------------------
	Player info
----------------------------------*/

Config.ShowKillerInfo						= true				// Shows a box with informations about killer
Config.ShowJob								= true				// Shows killer's job (DarkRP only)
Config.ShowRole								= true				// Shows killer's role (TTT only)
Config.ShowHP								= true				// Shows killer's health
Config.ShowArmor							= true				// Shows killer's armor

Config.RoleColors							= {
	Innocent 	= Color(0, 200, 0),
	Traitor 	= Color(200, 0, 0),
	Detective	= Color(0, 0, 200)
}

/*--------------------------------
	Effects
----------------------------------*/

Config.BlackAndWhite						= true				// When true, screen goes black and white
Config.BlackScreen  						= false 			// When true, screen goes black when you die and slowly comes visible
Config.ScreenBlur							= false				// Blurs screen

Config.URLSound 							= ""				// Plays streamed sound after death

/*--------------------------------
	Sounds
----------------------------------*/

Config.DefaultSound							= false				// Determines if default death sound is played
Config.StopSounds							= false				// Stops all sounds when you die
Config.SoundEffect							= 25 				// DSP sound effect. Set to 0 to disable
