/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

local ITEM = XeninInventory:CreateItemV2()
ITEM:SetMaxStack(10)
ITEM:SetModel("models/zerochain/props_pumpkinnight/zpn_partypopper.mdl")
ITEM:SetDescription("Perfect for celebrating Halloween!")
ITEM:AddDrop(function(self, ply, ent, tbl, tr)
end)

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ITEM:GetCameraModifiers(tbl)
	return {
		FOV = 17,
		X = 0,
		Y = -22,
		Z = 25,
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, -1)
	}
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function ITEM:GetDisplayName(item)
	return self:GetName(item)
end

function ITEM:GetName(item)
	local name = "Partypopper"

	return name
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

ITEM:Register("zpn_partypopper")
