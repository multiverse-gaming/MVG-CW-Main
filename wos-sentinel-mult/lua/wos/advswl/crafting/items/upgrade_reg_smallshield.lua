local ITEM = {} 
ITEM.Rarity = 100

-- The vortex/regulator type items are used for special abilities - giving unique powers, unique stats, small game-changers.
ITEM.Name = "Small Shield Regulator"

ITEM.Description = "Allows you to do use Small Shield."

ITEM.Type = WOSTYPE.VORTEX

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/wos/lct/crafting/power_vortex_regulator.mdl"
ITEM.Rarity = 50

ITEM.OnEquip = function( wep )
	if (IsValid(wep.Owner)) then
		wep:AddForcePower( "Small Shield" )
	end
end

wOS:RegisterItem( ITEM )