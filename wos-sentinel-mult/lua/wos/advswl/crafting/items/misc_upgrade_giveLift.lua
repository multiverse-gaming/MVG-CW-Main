local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Lift"

ITEM.Description = "Imbue your lightsaber with the ability to lift foes"

ITEM.Type = WOSTYPE.MISC2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = true

ITEM.Model = "models/chip/chip.mdl"

ITEM.OnEquip = function( wep )
	wep:AddForcePower( "Lift" )
end

wOS:RegisterItem( ITEM )