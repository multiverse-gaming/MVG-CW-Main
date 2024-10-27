/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.config = zpn.config or {}
zpn.config.Shop = {}
local function AddItem(data) return table.insert(zpn.config.Shop,data) end

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
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

AddItem({

    // What kind of item is this?
    type = "type_entity",

    // The Entity / Weapon Class / HatID / UB3ID / ItemID
    class = "item_ammo_pistol",

    // The Item name
    name = "Pistol Ammo",

    // Some info about this item
    desc = "Holds some pistol ammo!",

    // The path to Model
    model = "models/Items/BoxSRounds.mdl",

    // The Field of view for displaying the model (Usefull if the model is very small)
    model_fov = 25,

    // The Skin for the Model
    model_skin = 0,

    // The path to the png icon, set to nil to use the model instead
    icon = nil,

    // The Price
    price = 15,

    // How much should we give the player? (Used for stuff like Health, Armor, Points)
    amount = 1,

    // Can be used to overwrite the item color
    color = zpn.Theme.Shop.itm_bg_color,

    // What ranks are allowed to buy this item? Leave empty to allowe everyone to buy it.
    ranks = {},

    // Should the item be free after he purchased it once?
    permanent = false,

	// If set to true then the shop item can be only bought one time by the player and then never again
	ontime = false,
})

AddItem({
    type = "type_entity",
    class = "zpn_beartrap",
    name = "Brainteaser Beartrap",
    desc = "Prank the head right of your friends!",
    model = "models/zerochain/props_saw/modern_beartrap.mdl",
    model_fov = 15,
    model_skin = 1,
    price = 150,
    permanent = false,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

AddItem({
    type = "type_health",
    name = "Health",
    desc = "+25 Health.",
    icon = zpn.Theme.Design.icon_health,
    price = 50,
    amount = 25,
    ranks = {},
})

AddItem({
    type = "type_armor",
    name = "Armor",
    desc = "+25 Armor.",
    icon = zpn.Theme.Design.icon_armor,
    price = 50,
    amount = 25,
    ranks = {},
})


AddItem({
    type = "type_weapon",
    class = "zpn_partypopper",
    name = "Pumpkin Popper",
    desc = "Perfect for celebrating Halloween!",
    model = "models/zerochain/props_pumpkinnight/zpn_partypopper.mdl",
    model_skin = 0,
    model_fov = 13,
    icon = nil,
    price = 50,
    amount = 1,
    ranks = {
        ["superadmin"] = true,
        ["VIP"] = true,
    },
    permanent = true,
})

AddItem({
    type = "type_weapon",
    class = "zpn_partypopper01",
    name = "Pumpkin Slayer",
    desc = "A powerfull weapon against pumpkins!",
    model = "models/zerochain/props_pumpkinnight/zpn_partypopper.mdl",
    model_skin = 1,
    model_fov = 13,
    price = 200,
    amount = 1,
    ranks = {
        ["superadmin"] = true,
        ["VIP"] = true,
    },
    permanent = true,
})

AddItem({
    type = "type_wos_item",
    class = "Jumpscare",
    name = "Jedi Jumpscare",
    desc = "Strike spookiness into your enemies",
    model = "models/chip/chip.mdl",
    model_skin = 1,
    model_fov = 13,
    price = 2000,
    amount = 1,
    ranks = {},
    permanent = false,
})

AddItem({
    type = "type_wos_item",
    class = "Spook",
    name = "Jedi Spook",
    desc = "Distract enemies with spooky sounds",
    model = "models/chip/chip.mdl",
    model_skin = 1,
    model_fov = 13,
    price = 600,
    amount = 1,
    ranks = {},
    permanent = false,
})

AddItem({
    type = "type_entity",
    class = "zpn_slapper_default",
    name = "Slapper - Bounce",
    desc = "Makes the victim bounce!",
    model = "models/zerochain/props_pumpkinnight/zpn_slapper.mdl",
    model_fov = 15,
    model_skin = 0,
    price = 25,
    permanent = false,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

AddItem({
    type = "type_entity",
    class = "zpn_slapper_fire",
    name = "Slapper - Fire",
    desc = "Sets the victim on fire!",
    model = "models/zerochain/props_pumpkinnight/zpn_slapper.mdl",
    model_fov = 15,
    model_skin = 2,
    price = 100,
    permanent = false,
})

AddItem({
    type = "type_entity",
    class = "zpn_slapper_candy",
    name = "Slapper - Candy",
    desc = "Slaps the candy out of the victim!",
    model = "models/zerochain/props_pumpkinnight/zpn_slapper.mdl",
    model_fov = 15,
    model_skin = 1,
    price = 150,
    permanent = false,
})

for k,v in pairs(zpn.config.Masks) do
	AddItem({
		type = "type_lua",
		name = v.name,
		desc = v.desc,
		model = v.mdl,
		model_angle = Angle(0,0,0),
		model_fov = 18,
		price = v.price,
		lua = function(ply)
			zpn.Mask.Equipt(ply,k, true)
		end,
		// permanent = true,
	})
end


/*
    //////////////////////
    //Shop Item Exambles//
    //////////////////////
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73


                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73


    //////////////////////
    //////////////////////
*/
