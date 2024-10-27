/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.config = zpn.config or {}
zpn.config.Masks = {}
local function AddItem(data) return table.insert(zpn.config.Masks,data) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

AddItem({
    name = "Mask of Gael",

    desc = "Increases the amount of candy collected by 300%",
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	// The model of the mask
	mdl = "models/zerochain/props_pumpkinnight/zpn_mask01.mdl",

	// How much more candy will the player collect while wearing this mask
	// 1 = 100% (NoChange)
	// 2 = 200% (Double)
	candy_mul = 3,

	// How often can the mask protect the player against the ghost before it breaks?
	ghost_protect = 1,

	// How much more damage will the wearer inflict on his enemies (Pumpkins,Ghosts,Boss,Minions)
	// 1 = 100% (NoChange)
	// 2 = 200% (Double)
	//attack_mul = 1.5,

	// How much damage will be reflected back when the wearer is attacked by enemies (Ghosts,Boss,Minions)
	// NOTE Only applys to the the script enemies
	// 1 = 100% (No Damage to the wearer and 100% of the damage goes back to the inflictor)
	// 0.5 = 50% (Half)
	// reflect_mul = 0.5,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	// If set then monsters will ignore the wearer of the mask but he also cant inflict damage to them anymore
	// monster_friend = true,

	// How many candy points does the mask costs in the shop?
	price = 200,
})

AddItem({
    name = "Mask of Shay",
    desc = "The wearer cant hurt monsters but neither will they.",
	mdl = "models/zerochain/props_pumpkinnight/zpn_mask02.mdl",
	candy_mul = 1.25,
	monster_friend = true,
	price = 150,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

AddItem({
    name = "Mask of Ulik",
    desc = "Reflects 50% of damage taken back to the monster.",
	mdl = "models/zerochain/props_pumpkinnight/zpn_mask03.mdl",
	candy_mul = 1.25,
	ghost_protect = 1,
	reflect_mul = 0.5,
	price = 150,
})

AddItem({
    name = "Mask of Ceallach",
    desc = "Increases damage inflicted to monsters by 50%",
	mdl = "models/zerochain/props_pumpkinnight/zpn_mask04.mdl",
	candy_mul = 1.25,
	ghost_protect = 1,
	attack_mul = 2,
	price = 150,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3
