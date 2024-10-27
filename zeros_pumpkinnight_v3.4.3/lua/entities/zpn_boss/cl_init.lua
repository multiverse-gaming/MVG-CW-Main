/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zclib.EntityTracker.Add(self)
	self:SetRenderAngles(self:GetAngles())
	self.DefaultAngle = self:GetRenderAngles()

	self.VolumeIsChanging = false

	self.HasLeafEffect = false

	self.MusicID = "zpn_boss_music" .. math.random(1,#zpn.config.Boss.MusicPaths)
end

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Draw()
	self:DrawModel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

	cam.Start2D()
		zpn.Boss.HUD(self)
	cam.End2D()

	if zclib.util.InDistance(LocalPlayer():GetPos(), self:GetPos(), 1500) and self:GetActionState() == 2 then
		local targetPos = self:GetTargetPos()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

		if targetPos then
			local dir = self:GetPos() - targetPos
			local newAngle = dir:Angle()
			newAngle = LerpAngle(FrameTime() * 2, self:GetRenderAngles(), newAngle)
			self:SetRenderAngles(Angle(0, newAngle.y, 0))
		end
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

function ENT:Think()

	if zpn.config.Boss.MusicPaths and table.Count(zpn.config.Boss.MusicPaths) > 0 then
		self:Music()
	end

	if zpn.config.Boss.Tornado then
		self:Tornado()
	end

	self:SetNextClientThink(CurTime())
	return true
end

function ENT:Music()
	if self:Music_ShouldPlay() then
		self:Music_Setup()

		if self.Sounds[self.MusicID]:IsPlaying() == false then
			self:Music_FadeIn()
		end
	else
		if self.Sounds and self.Sounds[self.MusicID] and self.Sounds[self.MusicID]:IsPlaying() == true then
			self:Music_FadeOut()
		end
	end
end

function ENT:Tornado()
	zclib.util.LoopedSound(self, "zpn_tornado_sfx", true,1500)

	if zclib.util.InDistance(LocalPlayer():GetPos(), self:GetPos(), 3000) then

		if self.HasLeafEffect == false then
			self.HasLeafEffect = true
			zclib.Effect.ParticleEffectAttach(zpn.Theme.Boss.tornado_effect, PATTACH_POINT_FOLLOW, self, 0)
		end

	else
		if self.HasLeafEffect == true then
			self:StopParticlesNamed(zpn.Theme.Boss.tornado_effect)
			self.HasLeafEffect = false
		end
	end
end

function ENT:Music_ShouldPlay()
	return self:GetActionState() ~= 4 and zclib.util.InDistance(LocalPlayer():GetPos(), self:GetPos(), 2000)
end

function ENT:Music_Setup()
	if self.Sounds == nil then
		self.Sounds = {}
	end

	if self.Sounds[self.MusicID] == nil then
		self.Sounds[self.MusicID] = CreateSound(self, self.MusicID)
	end
end

function ENT:Music_FadeIn()
	if self.VolumeIsChanging then return end
	self.VolumeIsChanging = true
	if self.Sounds[self.MusicID] == nil then
		self:Music_Setup()
	end

	self.Sounds[self.MusicID]:Play()
	self.Sounds[self.MusicID]:ChangeVolume(0, 0)
	self.Sounds[self.MusicID]:ChangeVolume(1, 3)

	timer.Simple(3, function()
		if IsValid(self) then
			self.VolumeIsChanging = false
		end
	end)
end

function ENT:Music_FadeOut()
	if self.VolumeIsChanging then return end
	self.VolumeIsChanging = true

	if self.Sounds[self.MusicID] == nil then
		self:Music_Setup()
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	self.Sounds[self.MusicID]:ChangeVolume(0, 3)

	timer.Simple(3, function()
		if IsValid(self) then
			if self:Music_ShouldPlay() == false then
				if self.Sounds[self.MusicID] then
					self.Sounds[self.MusicID]:Stop()
					self.Sounds[self.MusicID] = nil
				end

				self.VolumeIsChanging = false
			else
				self.VolumeIsChanging = false
				self:Music_FadeIn()
			end
		end
	end)
end

function ENT:OnRemove()
	self:StopSound(self.MusicID)
	self:StopSound("zpn_tornado_sfx")
end
