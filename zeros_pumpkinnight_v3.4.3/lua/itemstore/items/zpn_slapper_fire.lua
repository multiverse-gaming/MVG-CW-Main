/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

ITEM.Name = "Slapper - Fire"
ITEM.Description = "Its a Trap!"
ITEM.Model = "models/zerochain/props_pumpkinnight/zpn_slapper.mdl"
ITEM.Base = "base_darkrp"
ITEM.Stackable = false
ITEM.DropStack = false
ITEM.Skin = 2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

function ITEM:GetSkin()
	return 2
end

function ITEM:CanPickup(pl, ent)
	if ent.GotPlaced then
		return false
	else
		return true
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
