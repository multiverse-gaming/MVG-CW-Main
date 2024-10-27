/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zclib.Effect.ParticleEffectAttach(zpn.Theme.PartyPopper_Projectile.effect_main, PATTACH_POINT_FOLLOW, self, 0)
end

function ENT:DrawTranslucent()
	self:Draw()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function ENT:Draw()
	self:DrawModel()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ENT:OnRemove()
	self:StopParticles()
	zclib.Effect.ParticleEffect(zpn.Theme.PartyPopper_Projectile.effect_explo, self:GetPos(), self:GetAngles(), Entity(1))
	sound.Play(zpn.Sounds["projectile_explosion"], self:GetPos(), 90, 100, 0.5)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065
