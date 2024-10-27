/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

local ITEM = XeninInventory:CreateItemV2()
ITEM:SetMaxStack(1)
ITEM:SetModel("models/zerochain/props_saw/modern_beartrap.mdl")
ITEM:SetDescription("A prank item.")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

ITEM:AddDrop(function(self, ply, ent, tbl, tr)
	zclib.Player.SetOwner(ent, ply)
	ent.TrapOwner = ply
end)

function ITEM:OnPickup(ply, ent)
	if (not IsValid(ent)) then return end
	if ply ~= ent.TrapOwner then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	local info = {
		ent = self:GetEntityClass(ent),
		dropEnt = self:GetDropEntityClass(ent),
		amount = self:GetEntityAmount(ent),
		data = self:GetData(ent)
	}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	self:Pickup(ply, ent, info)

	return true
end

function ITEM:GetName(item)
	return "Brainteaser Beartrap"
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

function ITEM:GetCameraModifiers(tbl)
	return {
		FOV = 30,
		X = 0,
		Y = 0,
		Z = 25,
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	}
end

ITEM:Register("zpn_beartrap")
