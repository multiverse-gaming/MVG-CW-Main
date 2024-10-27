/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zclib.EntityTracker.Add(self)
	self:SetRenderAngles(self:GetAngles())
	//self:SetRenderOrigin(self:GetPos())
	self.DefaultPos = self:GetPos()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	self.LastChange = 0
	self.NewDir = Vector(0,0,0)

	zclib.Effect.ParticleEffectAttach(zpn.Theme.Minions.effects["zpn_minion"], PATTACH_POINT_FOLLOW, self, 1)
	zclib.Effect.ParticleEffectAttach(zpn.Theme.Minions.effects["zpn_minion_eye"], PATTACH_POINT_FOLLOW, self, 2)
	zclib.Effect.ParticleEffectAttach(zpn.Theme.Minions.effects["zpn_minion_eye"], PATTACH_POINT_FOLLOW, self, 3)
end

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Draw()
	self:DrawModel()

	if zclib.util.InDistance(LocalPlayer():GetPos(), self:GetPos(), 1000) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040


		local target = self:GetPlayerTarget()
		if IsValid(target) then
			self.NewDir = self:GetPos() - (target:GetPos() + Vector(0, 0, 55))
			local newAngle = LerpAngle(FrameTime() * 2, self:GetRenderAngles(), self.NewDir:Angle())
			self:SetRenderAngles(newAngle)
		else
			if CurTime() > self.LastChange then
				self.LastChange = CurTime() + math.Rand(1, 3)
				local rndPos = self:GetPos()
				local randomAngle = math.random(1000)
				local circleRadius = math.random(100, 200)
				rndPos = rndPos + Vector(math.cos(randomAngle) * circleRadius, math.sin(randomAngle) * circleRadius, 200)
				self.NewDir = self:GetPos() - (rndPos + Vector(0, 0, 55))
			end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

			local newAngle = LerpAngle(FrameTime() * 2, self:GetRenderAngles(), self.NewDir:Angle())
			self:SetRenderAngles(Angle(0, newAngle.y, 0))
		end

		if zpn.config.Boss.Minions.CircleBoss == false then
			local Pos = self.DefaultPos + self:GetUp() * (2 * math.abs(math.sin(CurTime()) * 5))
			self:SetRenderOrigin(Pos)
		end

		if zclib.Convar.Get("zclib_cl_drawui") == 1 then
			self:Draw_HealthBar()
		end
	end
end

function ENT:Draw_HealthBar()
	cam.Start3D2D(self:LocalToWorld(Vector(0,0,50 + (5 * math.abs(math.sin(CurTime()) * 5)))), zclib.HUD.GetLookAngles(), 0.1)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Design.icon_health_bar_bg)
		surface.DrawTexturedRect(-200, 25 ,400, 50)

		local hbar = (400 / zpn.config.Boss.Minions.Health) * self:GetMonsterHealth()
		draw.RoundedBox(5, -200, 25 ,hbar, 50, zpn.Theme.Design.color_health)

		surface.SetDrawColor(zpn.default_colors["white02"])
		surface.SetMaterial(zpn.Theme.Design.icon_health_bar_alpha)
		surface.DrawTexturedRect(-200, 25 ,400, 50)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040


	cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73
