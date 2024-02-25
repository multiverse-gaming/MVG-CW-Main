include("shared.lua")

function ENT:Initialize()
    local sound1 = "vanilla/hyperspace/vanilla_hyperspace_01.wav"
    local sound2 = "vanilla/hyperspace/vanilla_hyperspace_02.wav"

    if self:GetPlaySound() == "1" then
        local choose = math.random(0,1)
    	if choose == 0 then
    		surface.PlaySound(sound1)
    	else
    		surface.PlaySound(sound2)
    	end
    end
end

function ENT:Draw()
    self:DrawModel()
end
