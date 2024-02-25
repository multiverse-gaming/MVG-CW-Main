local ITEM = {}

ITEM.Name = "Kylo's Hum"

ITEM.Description = "Kylo's Idle Regulator"

ITEM.Type = WOSTYPE.IDLE

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/barrel/barrel.mdl"
ITEM.Rarity = 40

ITEM.OnEquip = function( wep )
	wep.UseLoopSound = "sound/sabersounds/kylo_hum_sound.wav.wav"
end

wOS:RegisterItem( ITEM )