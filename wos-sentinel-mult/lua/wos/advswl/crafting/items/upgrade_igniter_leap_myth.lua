local ITEM = {} 
ITEM.Rarity = 100

-- The igniter type items are used for base abilities - Leap, Stat increases, thing that every Jedi has access to.
ITEM.Name = "Mythic Leap Igniter"

ITEM.Description = "Allows you to leap cheaper, further, quicker."

ITEM.Type = WOSTYPE.IGNITER

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/wos/lct/crafting/sparkplug.mdl"
ITEM.Rarity = 50

ITEM.OnEquip = function( wep )
	if (IsValid(wep.Owner)) then
		wep.LeapIgniterCost = true
		wep.LeapIgniterDistance = true
		wep.LeapIgniterCD = true
	end
end

wOS:RegisterItem( ITEM )	