/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

ITEM.Name = "Brainteaser Beartrap"
ITEM.Description = "A prank item."
ITEM.Model = "models/zerochain/props_saw/modern_beartrap.mdl"
ITEM.Base = "base_darkrp"
ITEM.Stackable = false
ITEM.DropStack = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

function ITEM:CanPickup(pl, ent)
	if not IsValid(ent) then return false end
	if pl ~= ent.TrapOwner then return false end
	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

function ITEM:Drop(ply,com,slot,ent)
	if not IsValid(ent) then return end
	ent.TrapOwner = ply
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
