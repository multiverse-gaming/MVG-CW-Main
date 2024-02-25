include("shared.lua")
AddCSLuaFile()

local w, h = 0, 0
local COL_1 = Color(0,0,0,180)

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    RDV.LIBRARY.AddOverhead(self, {
        Accent = RDV.VEHICLE_REQ.CFG.Overhead.Accent,
        Position = true, -- OBBMax or Head Position (you can also use a vector relative to the entities position.)
        Lines = {
            {
                Text = RDV.LIBRARY.GetLang(nil, "VR_npcOverhead"), 
                Color = Color(255,255,255),
                Font = "RD_FONTS_CORE_OVERHEAD",
            },
        }
    })
end

