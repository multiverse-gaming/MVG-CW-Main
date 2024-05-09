local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Mundi's Hilt"

ITEM.Description = "(Unique)"

ITEM.Type = WOSTYPE.HILT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/lightsaber2/lightsaber2.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 15

ITEM.OnEquip = function( wep )
	wep.UseHilt = "models/lightsaber2/lightsaber2.mdl"
	wep.UseLength = 46
	wep.SaberDamage = wep.SaberDamage + 100
end

wOS:RegisterItem( ITEM )