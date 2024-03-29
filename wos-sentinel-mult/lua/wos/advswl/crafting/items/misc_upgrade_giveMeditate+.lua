local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Meditate+"

ITEM.Description = "Empower your meditate skill. Will be destroyed on removal."

ITEM.Type = WOSTYPE.MISC2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = true

ITEM.Model = "models/chip/chip.mdl"

ITEM.OnEquip = function( wep )
	if wep.Meditate ~= nil then
		wep.Meditate = wep.Meditate + 1
	else
		wep.Meditate = 1
	end
end

wOS:RegisterItem( ITEM )