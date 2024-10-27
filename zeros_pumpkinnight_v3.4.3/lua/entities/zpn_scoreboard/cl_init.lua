/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	if zpn and zpn.Scoreboard then
		zpn.Scoreboard.Initialize(self)
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

function ENT:Draw()
	self:DrawModel()
	if zpn and zpn.Scoreboard then
		zpn.Scoreboard.OnDraw(self)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

function ENT:Think()
	if zpn and zpn.Theme and zpn.Theme.Scoreboard then
		zpn.Theme.Scoreboard.onthink(self)
	end
end

function ENT:OnRemove()
	self:StopParticles()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73
