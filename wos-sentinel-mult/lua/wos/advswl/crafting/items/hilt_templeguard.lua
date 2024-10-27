local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Temple Guard Hilt"

ITEM.Description = "(Very Rare) Only useable by Temple Guard"

ITEM.Type = WOSTYPE.HILT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/twinsaber/twinsaber.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 0

ITEM.OnEquip = function( wep )
	if (IsValid(wep) && wep.Owner) then
		local team_name = team.GetName(wep.Owner:Team())
		if (team_name == "Coruscant Guard Temple Guard" || team_name == "CG Temple Guard Chief" || team_name == "Temple Guard Chief" || team_name == "Jedi Temple Guard") then
			wep.UseHilt = "models/twinsaber/twinsaber.mdl"
			wep.UseLength = 42
			wep.SaberDamage = wep.SaberDamage + 60
		end
		return
	else
		wep.UseHilt = "models/twinsaber/twinsaber.mdl"
		wep.UseLength = 42
		wep.SaberDamage = wep.SaberDamage + 60
	end
end

wOS:RegisterItem( ITEM )