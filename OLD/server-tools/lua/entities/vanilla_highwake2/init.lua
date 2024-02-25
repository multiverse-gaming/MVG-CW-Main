AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
    timer.Simple(5,function()
        if not IsValid(self) then return end
        self:Remove()
    end)
end
