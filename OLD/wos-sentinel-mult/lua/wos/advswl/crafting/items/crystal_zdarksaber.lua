local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Darksaber ( Darksaber Blue )"

ITEM.Description = "Cracked by the force, it bleeds with it's ignition"

ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

--A simple description of what the item will ACTUALLY do
ITEM.Effects = "Permits a blue Darksaber blade"

ITEM.Model = "models/venator/venator_kybercrystal_wos_blue.mdl"
ITEM.Rarity = 1

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Blade" ] = "Darksaber"
	wep.UseColor = Color( 0, 0, 255 )
	wep.UseDarkInner = 0
end

wOS:RegisterItem( ITEM )