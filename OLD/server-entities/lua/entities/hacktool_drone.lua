AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= "Hack Station"
ENT.Category        = "Drones Hacking"
ENT.Spawnable		= true
ENT.nextkick = 0
ENT.info_text = {}
ENT.console_log = {}
ENT.hp = 300

if CLIENT then
	usermessage.Hook("drones_open_console", function(data)
		local self = data:ReadEntity()
		local ply = LocalPlayer()

		local win = vgui.Create("DFrame")
		win:SetSize(200, 100)
		win:Center()
		win:SetTitle("Console")
		win:MakePopup()

		local text = vgui.Create("DTextEntry", win)
		text:SetPos(15, 30)
		text:SetSize(170, 20)

		local btn = vgui.Create("DButton", win)
		btn:SetPos(15, 60)
		btn:SetSize(50, 25)
		btn:SetText("Enter")
		btn.DoClick = function()
			local str = text:GetValue()

			net.Start("drones_usecmd")
				net.WriteEntity(self)
				net.WriteEntity(ply)
				net.WriteString(str)
			net.SendToServer()
		end

		local lab = vgui.Create("DLabel", win)
		lab:SetPos(90, 65)
		lab:SetText("Type 'help'")
		lab:SizeToContents()
	end)

	usermessage.Hook("upd_hp_htool", function(data)
		local self = data:ReadEntity()
		local hp = data:ReadString()

		if not self:IsValid() then return end

		self.hp = hp
	end)

	local function cl_text(self, info)
		if not self:IsValid() then return end
		if info == "/clr" then self.info_text = {} return end

		table.insert(self.info_text, string.sub(info, 1, 60))
		if string.len(info) > 60 then
			cl_text(self, string.sub(info, 61))
		end

		if table.maxn(self.info_text) > 27 then
			table.remove(self.info_text, 1)
		end
	end

	usermessage.Hook("upd_info_htool", function(data)
		local self = data:ReadEntity()
		local info = data:ReadString()
		
		cl_text(self, info)
	end)
else
	util.AddNetworkString("drones_usecmd")
	net.Receive("drones_usecmd", function()
		local self = net.ReadEntity()
		local caller = net.ReadEntity()
		local cmd = net.ReadString()
		local args = string.Explode(" ", cmd)

		if not self:IsValid() then return end
		if self:GetClass() != "hacktool_drone" then return end
		if not caller:IsPlayer() then return end

		local obj = self:GetCmd(string.lower(args[1]))
		if obj then 
			obj.func(self, caller, args) 
		else 
			self:AddText("Unknown command: " .. cmd) 
		end
	end)

	function ENT:GetCmd(cmd)
		for k, v in ipairs(drone_hacktool_commands) do
			if v.cmd == cmd then return v end
		end

		return nil
	end

	function ENT:AddText(text)
		table.insert(self.console_log, text)

		umsg.Start("upd_info_htool")
			umsg.Entity(self)
			umsg.String(text)
		umsg.End()
	end
end

function ENT:OnTakeDamage(dmg)
	if CLIENT then return end

	self.hp = math.Round(self.hp - dmg:GetDamage() / 3)

	self:AddText("WARNING! Physical damage!")

	if self.hp <= 0 then 
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		util.Effect("effect_rockboom", ef)
		
		self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 500, 100)

		SafeRemoveEntity(self)

		return
	end

	umsg.Start("upd_hp_htool")
		umsg.Entity(self)
		umsg.String(tostring(self.hp))
	umsg.End()
end

function ENT:Initialize()
	if CLIENT then
		self.info_text = { "Enter a valid drone id..." }
		self.hp = 300
	
		return
	end

	self.nextuse = 0

	self:SetModel("models/props_lab/workspace002.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
end

function ENT:Use(activator, caller)
	if CLIENT then return end

	if CurTime() < self.nextuse then return end
	self.nextuse = CurTime() + 0.5

	umsg.Start("drones_open_console", caller)
		umsg.Entity(self)
	umsg.End()
end

function ENT:Draw()
	if SERVER then return end

	self:DrawModel()

	cam.Start3D2D(self:LocalToWorld(Vector(-37, -57, 55)), self:LocalToWorldAngles(Angle(0, 135, 60)), 0.07)
		surface.SetDrawColor(Color(0, 0, 0))
		surface.DrawOutlinedRect(-10, 45, 420, 360)

		draw.SimpleText("Status: " .. self.hp .. "%", "Trebuchet18", 0, 0, Color(255, 255, 255))
		for k, v in pairs(self.info_text) do draw.SimpleText(v, "Trebuchet18", 0, 50 + k * 12, Color(255, 255, 255)) end
	cam.End3D2D()
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end
