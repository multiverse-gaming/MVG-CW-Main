/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile()
DEFINE_BASECLASS("zpn_slapper_base")
ENT.Type                    = "anim"
ENT.Base                    = "zpn_slapper_base"
ENT.Model                   = "models/zerochain/props_pumpkinnight/zpn_slapper.mdl"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.PrintName               = "Slapper - Fire"
ENT.Category                = "Zeros PumpkinNight"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

ENT.OnTrigger = function(ent,ply)
    if SERVER then
        local firearea = ents.Create("zpn_firearea")
        firearea:SetPos(ent:GetPos())
        firearea:Spawn()
        firearea:Activate()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

        ply:Ignite(1.5,1)
    else
        zclib.Effect.ParticleEffect("zpn_fireexplosion", ent:GetPos(), ent:GetAngles(), ent)
    end
end
ENT.SkinValue = 2
ENT.MakeBounch = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
