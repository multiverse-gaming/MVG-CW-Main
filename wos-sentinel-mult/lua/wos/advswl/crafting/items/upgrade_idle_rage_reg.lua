local ITEM = {} 
ITEM.Rarity = 100

-- The idle type items are used for spec abilities - Consular Healing, Guardian reflecting, Sentinel blinding.
ITEM.Name = "Regular Valor Idler"

ITEM.Description = "Allows you to valor cheaper."

ITEM.Type = WOSTYPE.IDLE

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/wos/lct/crafting/idle_generator.mdl"
ITEM.Rarity = 50

ITEM.OnEquip = function( wep )
	if (IsValid(wep.Owner)) then
		wep.RageIdleCost = true
	end
end

wOS:RegisterItem( ITEM )