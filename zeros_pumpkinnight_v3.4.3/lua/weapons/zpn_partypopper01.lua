/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

include("sh_zpn_config_main.lua")

DEFINE_BASECLASS("zpn_partypopper")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

SWEP.Base = "zpn_partypopper"
SWEP.PrintName = "Pumpkin Slayer" // The name of your SWEP
SWEP.Category = "Zeros PumpkinNight"
SWEP.ViewModelFOV = 90
SWEP.ViewModel = "models/zerochain/props_pumpkinnight/zpn_partypopper_vm.mdl"
SWEP.WorldModel = "models/zerochain/props_pumpkinnight/zpn_partypopper.mdl"
SWEP.AdminSpawnable = true
SWEP.Spawnable = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

SWEP.PartyPopperID = 2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("zerochain/zpn/vgui/zpn_swep_partypopper01")
    SWEP.BounceWeaponIcon = false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
