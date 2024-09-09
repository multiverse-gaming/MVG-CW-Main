local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Obi-Wan Kenobi's Hilt EP3"

ITEM.Description = "(UNIQUE)"

ITEM.Type = WOSTYPE.HILT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/sgg/starwars/weapons/w_obiwan_ep3_saber_hilt.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 15

ITEM.OnEquip = function( wep )
	if (IsValid(wep) && wep.Owner) then
		local team_name = team.GetName(wep.Owner:Team())
		if (string.match(team_name, "General")) then
			wep.UseHilt = "models/sgg/starwars/weapons/w_obiwan_ep3_saber_hilt.mdl"
			wep.UseLength = 46
			wep.SaberDamage = wep.SaberDamage + 100
		end
		return
	else
		wep.UseHilt = "models/sgg/starwars/weapons/w_obiwan_ep3_saber_hilt.mdl"
		wep.UseLength = 46
		wep.SaberDamage = wep.SaberDamage + 100
	end
end

wOS:RegisterItem( ITEM )