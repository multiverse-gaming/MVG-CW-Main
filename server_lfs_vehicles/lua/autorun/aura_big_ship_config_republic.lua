Aura_LFS_CapitalShipsRepublic = Aura_LFS_CapitalShipsRepublic or {} -- Don't touch this
--[[

************************************************************************
                          IMPORTANT, PLEASE READ
************************************************************************

To add ships, first select the faction you want in the tables below like CIS, Republic, ect.
Next, using the format below, add a new line with the details of the ship you want to add, next save the file and it should be good to go

Format:

Aura_LFS_CapitalShipsRepublic =
{
	["Name"] = "class",
}
Name can be whatever you want it to show as in the edit properties menu, class is the actual entity class of the ship, that can be found by copying it from the spawn menu

Hopefully this was helpful, thanks!

(All ships below are just examples, they are in game currently so if you want to remove them, remove it and decrement the thing in [], although these are my preferences)
(Also I couldn't find like any Rebel ships so it has the same as republic)
]]--

Aura_LFS_Enable_Gbombs_Republic			 = true -- Set this to false to remove all gbomb related things for the ships such as death explosions
Aura_LFS_Enable_ExplodeOnShot_Republic	 = false -- Set this to false to disable mini-explosions when the ships get shot

Aura_LFS_CapitalShipsRepublic = -- Republic Ships
{
	["ARC170"] = "lunasflightschool_arc170",
	["A-Wing"] = "lunasflightschool_awing",
	["LAAT Blue"] = "lunasflightschool_laatgunshiparcblue",
	["W-Wing"] = "lunasflightschool_wwing",
	["Z-95"] = "lunasflightschool_z95",
	["V-Wing"] = "lunasflightschool_vwing",
	["Chh's ARC170"] = "lfs_arc",
	["Nick's V-Wing"] = "lunasflightschool_niksacokica_alpha-3_nimbus",
}