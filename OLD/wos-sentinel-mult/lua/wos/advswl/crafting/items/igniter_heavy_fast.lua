local ITEM = {}

ITEM.Name = "Heavy Fast Igniter"

ITEM.Description = "Heavy Crystal Activator"

ITEM.Type = WOSTYPE.IGNITER

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/tuning/tuning.mdl"
ITEM.Rarity = 0

ITEM.OnEquip = function( wep )
	wep.UseOnSound = "lightsaber/saber_on3_fast.wav"
	wep.UseOffSound = "lightsaber/saber_off3_fast.wav"
end

wOS:RegisterItem( ITEM )