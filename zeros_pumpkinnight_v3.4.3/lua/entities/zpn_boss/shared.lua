/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.Model = "models/zerochain/props_pumpkinnight/zpn_pumpkinboss.mdl"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Boss"
ENT.Category = "Zeros PumpkinNight"
ENT.RenderGroup = RENDERGROUP_BOTH
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "MonsterHealth" )
    self:NetworkVar( "Int", 1, "ActionState" )
    self:NetworkVar( "Int", 2, "Shield" )
    self:NetworkVar( "Vector", 0, "TargetPos" )

    if SERVER then
        self:SetActionState(-1)
        self:SetTargetPos(Vector(0,0,0))
        self:SetShield(0)
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
