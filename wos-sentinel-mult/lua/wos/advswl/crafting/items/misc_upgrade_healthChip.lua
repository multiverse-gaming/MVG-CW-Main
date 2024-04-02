local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Health Amplifier"

ITEM.Description = "Increases health by 5"

ITEM.Type = WOSTYPE.MISC2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/chip/chip.mdl"

ITEM.OnEquip = function( wep )
	wep:GetOwner():SetMaxHealth( wep:GetOwner():GetMaxHealth() + 5 ) 
	wep:GetOwner():SetHealth( wep:GetOwner():Health() + 5 ) 
end

wOS:RegisterItem( ITEM )