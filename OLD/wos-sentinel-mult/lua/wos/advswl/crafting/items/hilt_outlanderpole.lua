local ITEM = {}

ITEM.Name = "Outlander Dual Hilt"

ITEM.Description = "(LEGENDARY)"

ITEM.Type = WOSTYPE.HILT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/swtor/arsenic/lightsabers/outlanderpolesaber2.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 0

ITEM.OnEquip = function( wep )
	wep.UseHilt = "models/swtor/arsenic/lightsabers/outlanderpolesaber2.mdl"
	wep.UseLength = 46
	wep.SaberDamage = wep.SaberDamage + 100
end

wOS:RegisterItem( ITEM )