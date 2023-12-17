--[[


************************************************************************
                          IMPORTANT, PLEASE READ
************************************************************************

To add ships, first select the faction you want in the tables below like CIS, Republic, ect.
Next, using the format below, add a new line with the details of the ship you want to add, next save the file and it should be good to go

Format:

Aura_LFS_CapitalShipsCIS =
{
	["Name"] = "class",
}
Name can be whatever you want it to show as in the edit properties menu, class is the actual entity class of the ship, that can be found by copying it from the spawn menu


(All ships below are just examples, they are in game currently so if you want to remove them, remove it and decrement the thing in [], although these are my preferences)
(Also I couldn't find like any Rebel ships so it has the same as republic)
]]--

Aura_LFS_Enable_Gbombs_CIS		 	= true -- Set this to false to remove all gbomb related things for the ships such as death explosions
Aura_LFS_Enable_ExplodeOnShot_CIS 	= false -- Set this to false to disable mini-explosions when the ships get shot

Aura_LFS_CapitalShipsCIS = -- CIS Ships
{
	["Vulture Droid"] = "lunasflightschool_vulturedroid_cis",
	["Tri Fighter"] = "lunasflightschool_tridroid",
	["Hyena Bomber"] = "lunasflightschool_bf2hyenabomber",
	["Advanced Bomber"] = "lunasflightschool_advdroid",
	["Havoc Fighter"] = "lunasflightschool_havoc",
	["Geo Fighter"] = "lunasflightschool_geofighter",
	["SCYK Fighter"] = "lunasflightschool_scyk",
}