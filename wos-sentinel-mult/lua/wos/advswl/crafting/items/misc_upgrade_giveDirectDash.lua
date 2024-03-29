local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Direct Dash"

ITEM.Description = "Imbue your lightsaber with the ability propel you forwards"

ITEM.Type = WOSTYPE.MISC2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/chip/chip.mdl"

ITEM.OnEquip = function( wep )
	wep:AddForcePower( "Direct Dash" )
end

wOS:RegisterItem( ITEM )