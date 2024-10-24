local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Stamina Igniter"

ITEM.Description = "Allows you to tap into a unique force tree"

ITEM.Type = WOSTYPE.IGNITER

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/wos/lct/crafting/sparkplug.mdl"
ITEM.Rarity = 50

ITEM.OnEquip = function( wep )
	if (IsValid(wep.Owner)) then
		wep.Owner.StaminaTree = true
	end
end

wOS:RegisterItem( ITEM )