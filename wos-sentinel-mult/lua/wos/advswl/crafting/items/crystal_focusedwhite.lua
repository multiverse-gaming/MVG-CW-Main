local ITEM = {} 
ITEM.Rarity = 100

--The name of the item ( is also an identifier for spawning the item )
ITEM.Name = "Focused Crystal ( White )"

--The description that appears with the item name
ITEM.Description = "This crystal is flirting with perfecting, but is still unbalanced"

--The category it belongs to
ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

--The model of the item on the floor / inventory
ITEM.Model = "models/venator/venator_kybercrystal_wos_blue.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 5

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Blade" ] = "SWTOR 8"
	wep.UseColor = Color(255, 255, 255, 255)
	wep.MaxForce = wep.MaxForce + 40
end

wOS:RegisterItem( ITEM )