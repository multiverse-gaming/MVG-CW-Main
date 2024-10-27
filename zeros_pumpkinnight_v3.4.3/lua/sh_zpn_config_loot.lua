/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.config = zpn.config or {}
zpn.config.Loot = {}
local function AddLoot(data) return table.insert(zpn.config.Loot,data) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	This special loot can be found in the presents underneath the christmas tree

*/

/*
    "type_entity" 					= Entity Class
    "type_weapon" 					= Weapon Class
    "type_health" 					= Health
    "type_armor" 					= Armor
    "type_sh_acc" 					= Accessory HatID
    "type_pointshop01" 				= Pointshop01 Points
    "type_pointshop02_standard" 	= Pointshop02 StandardPoints
    "type_pointshop02_premium" 		= Pointshop02 PremiumPoints
    "type_bu3" 						= Blues Unboxing 3
    "type_underdone" 				= Underdone
    "type_easyskins" 				= EasySkins https://www.gmodstore.com/market/view/easy-skins
    "type_mtokens" 					= MTokens https://www.gmodstore.com/market/view/6712
    "type_ass" 						= ASS https://www.gmodstore.com/market/view/advanced-accessory-the-most-advanced-accessory-system
    "type_santosrp_giveitem" 		= SantosRP - GiveItem (.class,.amount)
    "type_wos_item" 				= WOS - Item
    "type_wos_points" 				= WOS - Points
    "type_wos_xp" 					= WOS - XP
    "type_wos_level" 				= WOS - Level
    "type_vrondakis_xp" 			= Vrondakis - XP
    "type_vrondakis_level" 			= Vrondakis - Level
    "type_glorified_xp" 			= Glorified - XP
    "type_glorified_level" 			= Glorified - Level
    "type_essentials_xp" 			= Essentials - XP
    "type_essentials_level" 		= Essentials - Level
    "type_elite_xp" 				= Elite - XP
    "type_sreward_token" 			= sReward - Tokens
	"type_zpc2_coin" 				= ZerosPyrocrafter 2 - PyroCoins
	"type_lua" 						= LUA
	"type_voidcase_item" 		= Voidcases https://www.gmodstore.com/market/view/voidcases-unboxing-system
*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

AddLoot({
	type = "type_health",
	dropchance = 25,
	notify = "You got 25 health!",
	amount = 25,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

AddLoot({
    type = "type_armor",
    dropchance = 25,
    notify = "You got 25 armor!",
    amount = 25,
})

AddLoot({
	type = "type_wos_xp",
    dropchance = 25,
    notify = "You got 25 WOS XP!",
    amount = 25,
})




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// DO NOT TOUCH ANYTHING BELLOW THIS LINE! THANK YOU (╯°□°）╯︵ ┻━┻ //////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Recalculates the final chance for all the items in the list
local function roundChance(what, precision) return math.floor(what * math.pow(10, precision) + 0.5) / math.pow(10, precision) end

local totalChance = 0
for k, v in pairs(zpn.config.Loot) do totalChance = totalChance + v.dropchance end

for k, v in pairs(zpn.config.Loot) do
	local chance = roundChance((100 / totalChance) * v.dropchance, 2)
	v.dropchance = chance
end
