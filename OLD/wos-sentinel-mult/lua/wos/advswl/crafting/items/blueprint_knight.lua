local ITEM = {}

ITEM.Name = "Jedi Knight Hilt Blueprint"

ITEM.Description = "As the final step of your Jedi Training to Knight, you have been tasked to build"

ITEM.Type = WOSTYPE.BLUEPRINT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = true

ITEM.Model = "models/lt_c/sci_fi/holo_tablet.mdl"

--The raw materials required to make the item. IF THEY ARE NOI VALID MATERIALS, THEY WILL NOT BE CONSIDERED IN THE CRAFTING PROCESS!
ITEM.Ingredients = {
	[ "Refined Steel" ] = 2,
	[ "Aluminum Alloy" ] = 5,
}

--The name of the item that this blueprint will give to the player ( if they have enough slots )
ITEM.Result = "Jedi Knight's Hilt"

ITEM.OnCrafted = function( ply )
	ply:AddSkillXP( 1000 )
end

wOS:RegisterItem( ITEM )