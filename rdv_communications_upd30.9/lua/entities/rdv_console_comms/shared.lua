ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Communications Relay"
ENT.Category = "[RDV] Star Wars Systems"
ENT.AuthorName = ""
ENT.Spawnable = false
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "RelayName")
    self:NetworkVar("Bool", 0, "RelayEnabled")

    self:SetRelayEnabled(true)
end