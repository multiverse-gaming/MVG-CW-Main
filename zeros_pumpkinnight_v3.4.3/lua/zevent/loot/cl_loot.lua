/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.Loot = zpn.Loot or {}
zpn.Loot.List = zpn.Loot.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

function zpn.Loot.Initialize(Loot)
    zclib.Debug("zpn.Loot.Initialize")
end

function zpn.Loot.OnDraw(Loot)
	Loot:DrawModel()

	if not zpn.Loot.List[Loot] then zpn.Loot.List[Loot] = true end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	if not Loot.Smashed and zclib.util.InDistance(Loot:GetPos(), LocalPlayer():GetPos(), 2000) then
		if not IsValid(Loot.HullModel) then
			local ent = zclib.ClientModel.AddProp()
			if IsValid(ent) then
				ent:SetPos(Loot:GetPos())
				ent:SetModel(Loot:GetModel())
				ent:SetAngles(Loot:GetAngles())
				ent:Spawn()
				ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
				ent:SetNoDraw(true)
				Loot.HullModel = ent
			end
		end
	else
		if IsValid(Loot.HullModel) then
			zclib.ClientModel.Remove(Loot.HullModel)
		end
	end
end

function zpn.Loot.OnRemove(Loot)
	if IsValid(Loot.HullModel) then
		zclib.ClientModel.Remove(Loot.HullModel)
	end
end

local CrackMaterial = Material("zerochain/props_christmas/present_cracks")
zclib.Hook.Remove("PostDrawTranslucentRenderables", "zpn.Loot.OnDraw")
zclib.Hook.Add("PostDrawTranslucentRenderables", "zpn.Loot.OnDraw", function(depth, bDrawingSkybox, isDraw3DSkybox)
	if not isDraw3DSkybox then
		for ent, _ in pairs(zpn.Loot.List) do
			if not IsValid(ent) then continue end
			if not IsValid(ent.HullModel) then continue end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

			ent.RndColorTick = (ent.RndColorTick or 0) + 1

			local col = HSVToColor(ent.RndColorTick,1,1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

			render.MaterialOverride(CrackMaterial)
			render.SetColorModulation((1/255) * col.r, (1/255) * col.g,(1/255) * col.b)
			ent.HullModel:SetPos(ent:GetPos())
			ent.HullModel:SetAngles(ent:GetAngles())
			ent.HullModel:DrawModel()
			render.MaterialOverride()
			render.SetColorModulation(1, 1, 1)
		end
	end
end)
