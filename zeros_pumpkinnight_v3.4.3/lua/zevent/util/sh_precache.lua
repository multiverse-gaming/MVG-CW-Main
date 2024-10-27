/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

// Halloween
game.AddParticles("particles/zpn_fire_vfx.pcf")
PrecacheParticleSystem("zpn_fireball")
PrecacheParticleSystem("zpn_fireexplosion")
PrecacheParticleSystem("zpn_firearea")

game.AddParticles("particles/zpn_candy_vfx.pcf")
PrecacheParticleSystem("zpn_candy01_fx")
PrecacheParticleSystem("zpn_candy02_fx")
PrecacheParticleSystem("zpn_candy03_fx")

game.AddParticles("particles/zpn_ghost_vfx.pcf")
PrecacheParticleSystem("zpn_cloud01")
PrecacheParticleSystem("zpn_ghost_eye")

PrecacheParticleSystem("zpn_cloud02")
PrecacheParticleSystem("zpn_ghost_eye01")

PrecacheParticleSystem("zpn_cloud_slapper")


game.AddParticles("particles/zpn_minion_vfx.pcf")
PrecacheParticleSystem("zpn_minion_eye")
PrecacheParticleSystem("zpn_minion")
PrecacheParticleSystem("zpn_minion_mouth")

game.AddParticles("particles/zpn_pumpkinboss_vfx.pcf")
PrecacheParticleSystem("zpn_boss_heal")

game.AddParticles("particles/zpn_fuse_vfx.pcf")
PrecacheParticleSystem("zpn_fuse")

game.AddParticles("particles/zpn_pumpkin_vfx.pcf")
PrecacheParticleSystem("zpn_pumpkinsmash")

game.AddParticles("particles/zpn_candle_vfx.pcf")
PrecacheParticleSystem("zpn_candle")

game.AddParticles("particles/zpn_partypopper_vfx.pcf")
PrecacheParticleSystem("zpn_pumbkin_shot")
PrecacheParticleSystem("zpn_candycorn_shot")

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3


game.AddParticles("particles/zpn_partypopper_projectile.pcf")
PrecacheParticleSystem("zpn_ppp")
PrecacheParticleSystem("zpn_ppp_burst")
PrecacheParticleSystem("zpn_ppp_head")

game.AddParticles("particles/zpn_leafstorm.pcf")
PrecacheParticleSystem("zpn_leafstorm")


// Christmas
game.AddParticles("particles/zpn_icestorm.pcf")
PrecacheParticleSystem("zpn_icestorm")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

PrecacheParticleSystem("zpn_presentsmash")

game.AddParticles("particles/zpn_ice_vfx.pcf")
PrecacheParticleSystem("zpn_iceball")
PrecacheParticleSystem("zpn_iceexplosion")
PrecacheParticleSystem("zpn_icearea")

game.AddParticles("particles/zpn_snowboss_vfx.pcf")
PrecacheParticleSystem("zpn_snowboss_eye")

game.AddParticles("particles/zpn_icepopper_projectile.pcf")
PrecacheParticleSystem("zpn_ipp")
PrecacheParticleSystem("zpn_ipp_burst")
PrecacheParticleSystem("zpn_ipp_head")

game.AddParticles("particles/zpn_snowminion_vfx.pcf")
PrecacheParticleSystem("zpn_snowminion_eye")
PrecacheParticleSystem("zpn_snowminion")
PrecacheParticleSystem("zpn_snowminion_mouth")

for k, v in pairs(zpn.config.Masks) do
    util.PrecacheModel(v.mdl)
end

game.AddParticles("particles/zpn_loot.pcf")
PrecacheParticleSystem("zpn_loot01")
