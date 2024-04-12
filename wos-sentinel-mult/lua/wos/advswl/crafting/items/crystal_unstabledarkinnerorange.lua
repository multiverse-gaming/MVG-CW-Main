local ITEM = {} 
ITEM.Rarity = 100

--The name of the item ( is also an identifier for spawning the item )
ITEM.Name = "Unstable Crystal ( Dark Inner Orange )"

--The description that appears with the item name
ITEM.Description = "A broken crystal, giving an unsteady blade"

--The category it belongs to
ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

--The model of the item on the floor / inventory
ITEM.Model = "models/venator/venator_kybercrystal_wos_orange.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 1

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Blade" ] = "Unstable"
	wep.UseColor = Color(227, 125, 2, 255)
	wep.UseDarkInner = 1
	wep.MaxForce = wep.MaxForce + 10
	wep.UseWidth = wep.UseWidth - wep.UseWidth*0.25
end

wOS:RegisterItem( ITEM )