AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false
 
if CLIENT then
	ENT.Fire = 0

	ENT.WElements = {
		["element_name"] = { type = "Model", model = "models/Mechanics/robotics/a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.523, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },		
		["element_name2"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-6.369, 0, 0), angle = Angle(-90, 0, 0), size = Vector(0.082, 0.082, 0.136), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["element_name3"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-6.311, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		
		["ammo"] = { type = "Model", model = "models/Items/BoxSRounds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.899, -3.449), angle = Angle(0, 0, 0), size = Vector(0.584, 0.303, 0.316), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo++++++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.237, 1.917, 0.962), angle = Angle(2.505, 0, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo+"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.237, 3.177, -0.086), angle = Angle(2.505, 0, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo+++++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.237, 2.237, 0.879), angle = Angle(2.505, 0, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo+++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.237, 2.778, 0.481), angle = Angle(2.505, 0, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.237, 3.017, 0.243), angle = Angle(2.505, 0, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo++++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.237, 2.539, 0.722), angle = Angle(2.505, 0, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		
		["el"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(4.959, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.296, 0.296, 0.296), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },	
		["el+++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.033, 1.044, -0.593), angle = Angle(-90, 0, 0), size = Vector(0.012, 0.012, 0.257), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el++++++++"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(24.417, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.064, 0.296, 0.296), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.033, -1.037, -0.596), angle = Angle(-90, 0, 0), size = Vector(0.012, 0.012, 0.257), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el+++++++++"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(11.97, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.064, 0.296, 0.296), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el+++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.033, -1.042, 0.587), angle = Angle(-90, 0, 0), size = Vector(0.012, 0.012, 0.257), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.033, 0, -1.188), angle = Angle(-90, 0, 0), size = Vector(0.012, 0.012, 0.257), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el+++++++"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(18.218, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.064, 0.296, 0.296), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el++++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.033, 1.019, 0.591), angle = Angle(-90, 0, 0), size = Vector(0.012, 0.012, 0.257), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["el++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.033, 0, 1.187), angle = Angle(-90, 0, 0), size = Vector(0.012, 0.012, 0.257), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		
		["can"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(13.125, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.115, 0.115, 4.269), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		
		["inj+"] = { type = "Model", model = "models/mechanics/solid_steel/sheetmetal_box_4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.159, 1.59, 1.184), angle = Angle(94.818, 90, 0), size = Vector(0.009, 0.043, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["inj"] = { type = "Model", model = "models/mechanics/solid_steel/sheetmetal_box_4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.317, 3.18, 0.107), angle = Angle(0, 90, 0), size = Vector(0.009, 0.039, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		
		["gcan"] = { type = "Model", model = "models/props_lab/tpplug.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.382, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.133, 0.123, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["gcan+"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "el+", pos = Vector(0, 0, 0.64), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["gcan+++++"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "el+++++", pos = Vector(0, 0, 0.64), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["gcan++++"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "el++++++", pos = Vector(0, 0, 0.64), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["gcan++++++"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "el++++", pos = Vector(0, 0, 0.64), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["gcan++"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "el++", pos = Vector(0, 0, 0.64), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} },
		["gcan+++"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "el+++", pos = Vector(0, 0, 0.64), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/futuristictrackramp_1-2", skin = 0, bodygroup = {} }
	}

	function ENT:GetOrientation(tab)
		local pos = self:GetPos()
		local ang = self:GetAngles()

		if tab.rel and tab.rel != "" then
			local v = self.WElements[tab.rel]

			pos, ang = self:GetOrientation(v)

			if not pos then return end

			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
		end

		return pos, ang
	end

	net.Receive("minigun_drones_switch", function()
		local self = net.ReadEntity()
		local bit = net.ReadBit()

		self.Fire = bit
	end)
else
	util.AddNetworkString("minigun_drones_switch")
	function ENT:Switch(n)
		net.Start("minigun_drones_switch")
			net.WriteEntity(self)
			net.WriteBit(n)
		net.Broadcast()
	end
end

function ENT:Draw()
	if SERVER then return end

	--SWEP Construction Kit changed draw code
	if !self.WElements then return end
		
	if !self.wRenderOrder then
		self.wRenderOrder = {}

		for k, v in pairs(self.WElements) do
			table.insert(self.wRenderOrder, 1, k)
		end
	end
		
	for k, name in pairs(self.wRenderOrder) do
		local v = self.WElements[name]
		if !v then self.wRenderOrder = nil break end
			
		local pos, ang

		pos, ang = self:GetOrientation(v)
			
		local model = v.modelEnt
		local sprite = v.spriteMaterial
			
		model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
		model:SetAngles(ang)

		local matrix = Matrix()
		matrix:Scale(v.size)
		model:EnableMatrix( "RenderMultiply", matrix )
		model:SetMaterial(v.material)
		
		render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
		render.SetBlend(v.color.a/255)
		model:DrawModel()
		render.SetBlend(1)
		render.SetColorModulation(1, 1, 1)
	end
end

function ENT:Initialize()
	if CLIENT then
		self.WElements = table.FullCopy(self.WElements)
		self:CreateModels(self.WElements)

		return 
	end

	self:SetModel("models/weapons/w_crowbar.mdl")
	self:SetModelScale(1.5, 0)
	self:SetMaterial("models/effects/vol_light001")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then phys:Wake() end
end

function ENT:Think()
	if CLIENT then
		self.WElements["element_name"].angle.roll = CurTime() * self.Fire * 1500
		if self.Fire == 1 then
			local ef = EffectData()
			ef:SetOrigin(self:GetPos() + self:GetForward() * 31 + self:GetUp() * -0.5)
			ef:SetAngles(self:GetAngles())
			ef:SetScale(1)
			ef:SetAttachment(1)
			util.Effect("MuzzleEffect", ef)
		end
	end
end

--Changed SWEP Construction Kit base code

if CLIENT then
	ENT.wRenderOrder = nil

	function ENT:CreateModels(tab)
		if !tab then return end

		for k, v in pairs(tab) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME")) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
			end
		end
	end

	function table.FullCopy(tab)
		if !tab then return nil end
		
		local res = {}
		for k, v in pairs(tab) do
			if type(v) == "table" then
				res[k] = table.FullCopy(v)
			elseif type(v) == "Vector" then
				res[k] = Vector(v.x, v.y, v.z)
			elseif type(v) == "Angle" then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
	end
end
