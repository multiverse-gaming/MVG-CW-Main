local ITEM = {}

ITEM.Name = "Kylo's Swing"

ITEM.Description = "Kylo's Vortex Regulator"

ITEM.Type = WOSTYPE.VORTEX

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/batt/batt.mdl"
ITEM.Rarity = 60

ITEM.OnEquip = function( wep )
	wep.UseSwingSound = "sound/sabersounds/kylo_swing_sound.wav"
end

wOS:RegisterItem( ITEM )