local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Corrupted Crystal ( Dark Inner White )"

ITEM.Description = "Cracked by the force, it bleeds with it's ignition"

ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/venator/venator_kybercrystal_wos_white.mdl"
ITEM.Rarity = 1

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Blade" ] = "Corrupted"
	Color(255, 255, 255, 255)
	wep.UseDarkInner = 1
	wep.MaxForce = wep.MaxForce + 50
end

wOS:RegisterItem( ITEM )