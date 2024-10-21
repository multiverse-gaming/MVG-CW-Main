//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

AddCSLuaFile()


SWEP.PrintName          = "Satellite Test Tablet"
SWEP.Category = "[Kaito] Artillery System"
SWEP.Author             = "Kaito"

SWEP.Spawnable          = false
SWEP.AdminOnly          = true
SWEP.HoldType           = "camera"

SWEP.Primary.ClipSize   = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic  = false
SWEP.Primary.Ammo       = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false


SWEP.IconOverride = "materials/weapons/kaito/ksus_icon.png"

SWEP.MainUseTimeout = -1        // might want to not spam
SWEP.SecondaryTimeout = -1      // same.
SWEP.isSatelliteActive = false  // 

function SWEP:PrimaryAttack()
    if SERVER then return end
    net.Start('ksus.net.fromClient.toServer.launchSatelliteView',false)
    net.SendToServer()
end