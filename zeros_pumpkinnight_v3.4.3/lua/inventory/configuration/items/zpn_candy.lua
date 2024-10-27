/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

local ITEM = XeninInventory:CreateItemV2()
ITEM:SetMaxStack(1)
ITEM:SetModel("models/zerochain/props_pumpkinnight/zpn_candydrop.mdl")
ITEM:SetDescription("Sweet Sweet Candy!")

ITEM:AddDrop(function(self, ply, ent, tbl, tr)
	local data = tbl.data

	ent:SetCandy(data.Candy)
	ent:SetModel("models/zerochain/props_pumpkinnight/zpn_candydrop.mdl")
	ent:SetDisplayCandy(true)
	ent:SetColor(zpn.Theme.Design.color03)
	zclib.Player.SetOwner(ent, ply)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function ITEM:GetData(ent)
	return {
		Candy = ent:GetCandy(),
	}
end

function ITEM:GetCameraModifiers(tbl)
	return {
		FOV = 40,
		X = 0,
		Y = -22,
		Z = 25,
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, -1)
	}
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ITEM:GetVisualAmount(item)
	return item.data.Candy
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ITEM:GetDisplayName(item)
	return self:GetName(item)
end

function ITEM:GetName(item)
	local name = "Candy"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	return name
end

function ITEM:GetClientsideModel(tbl, mdlPanel)
	mdlPanel:SetColor(zpn.Theme.Design.color03)
end

ITEM:Register("zpn_candy")
