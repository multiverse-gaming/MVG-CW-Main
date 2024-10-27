/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Candy"
ENT.Category = "Zeros PumpkinNight"
ENT.RenderGroup = RENDERGROUP_BOTH
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

function ENT:SetupDataTables()
    self:NetworkVar("Int", 1, "Candy")
    self:NetworkVar("Bool", 0, "DisplayCandy")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

    if SERVER then
        self:SetCandy(5)
        self:SetDisplayCandy(false)
    end
end
