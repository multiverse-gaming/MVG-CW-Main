local ITEM = {}

ITEM.Name = "Guardian Pike Blueprint"

ITEM.Description = "Creates a pike for the guardians"

ITEM.Type = WOSTYPE.BLUEPRINT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = true

ITEM.Model = "models/lt_c/sci_fi/holo_tablet.mdl"

--The raw materials required to make the item. IF THEY ARE NOI VALID MATERIALS, THEY WILL NOT BE CONSIDERED IN THE CRAFTING PROCESS!
ITEM.Ingredients = {
	[ "Refined Steel" ] = 7,
	[ "Aluminum Alloy" ] = 10,
}

--The name of the item that this blueprint will give to the player ( if they have enough slots )
ITEM.Result = "Pike 4 Hilt"

ITEM.OnCrafted = function( ply )
	ply:AddSkillXP( 1000 )
end

wOS:RegisterItem( ITEM )