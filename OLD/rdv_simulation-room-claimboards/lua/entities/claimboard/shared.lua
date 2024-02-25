ENT.Base = "gmod_base"
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Claim Board"
ENT.AuthorName = "Nicolas"
ENT.Category = "[RDV] Starwars Systems"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()

    self:NetworkVar("String", 0, "ClaimBoardTitle")
    self:NetworkVar("String", 1, "ClaimBoardBat")
    self:NetworkVar("Bool", 0, "ClaimBoardOpen")
    self:NetworkVar("Bool", 1, "ClaimBoardClaimed")
    self:NetworkVar("Entity", 1, "ClaimBoardClaimer")

    self:SetClaimBoardClaimed( false )
    self:SetClaimBoardOpen( true )
    self:SetClaimBoardBat( "N/A" )
    self:SetClaimBoardTitle( "N/A" )
end