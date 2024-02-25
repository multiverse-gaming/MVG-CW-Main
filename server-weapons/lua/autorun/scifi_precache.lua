
--------------------My first SciFi weapon base--------------------

--		    	SciFi Weapons v16 - by Darken217		 		--

------------------------------------------------------------------

-- Please do NOT use any of my code without further permission! --

------------------------------------------------------------------

-- Purpose: Precache init. of misc. materials and particles,  	--

-- killicons and language override. 							--

-- Language is mainly used for entity naming in kill list.		--

-- Note, that some used particles are not listed here, 			--

-- Sounds are precached in base/scifi_sounds.lua (guess what!)	--

-- as they don't require a specific precache as ParticelSystem. --

-- Wow, much precache, very in-game performance,                --

-- such loading time, precache intensifies                      --

------------------------------------------------------------------

-- Initialized via autorun.										--

------------------------------------------------------------------



AddCSLuaFile()



-- Materials --
--[[
resource.AddFile( "materials/nil.vmt" )

resource.AddFile( "materials/effects/phaz_vapor.vmt" )

resource.AddFile( "materials/effects/phaz_impact.vmt" )

resource.AddFile( "materials/effects/phaz_vapor.vmt" )

resource.AddFile( "materials/effects/phaz_ring.vmt" )



-- Textures --

resource.AddFile( "materials/effects/combine_halo.vtf" )

resource.AddFile( "materials/effects/energy_flare_01.vtf" )

resource.AddFile( "materials/effects/energy_flare_02.vtf" )

resource.AddFile( "materials/effects/energy_flare_03.vtf" )

resource.AddFile( "materials/effects/energy_impact2_nocolor.vtf" )

resource.AddFile( "materials/effects/energy_impact3_nocolor.vtf" )

resource.AddFile( "materials/effects/frozen_blast.vtf" )

resource.AddFile( "materials/effects/impact_energy_reftint.vtf" )

resource.AddFile( "materials/effects/impact_smokey_nocolor.vtf" )

resource.AddFile( "materials/effects/muzzleblur_fx/muzzleblur_bumpmap.vtf" )

resource.AddFile( "materials/particle/beam_smoke_01.vtf" )

resource.AddFile( "materials/particle/beam_smoke_02.vtf" )

resource.AddFile( "materials/particle/beam_smoke_03.vtf" )

resource.AddFile( "materials/particle/fastsidesprites/fastsidesprite128_v2.vtf" )

resource.AddFile( "materials/models/elemental/frozen" )

resource.AddFile( "materials/models/elemental/frozen_alpha" )

resource.AddFile( "materials/models/elemental/burned" )

resource.AddFile( "materials/models/elemental/vapored" )

resource.AddFile( "materials/effects/mf_light.vtf" )
]]


-- Sounds --



-- Particles --

game.AddParticles( "particles/bloomtest.pcf" )

game.AddParticles( "particles/boxglove_fx.pcf" )

game.AddParticles( "particles/corrosion_fx.pcf" )

game.AddParticles( "particles/cryo_fx.pcf" )

game.AddParticles( "particles/darkling_fx.pcf" )

game.AddParticles( "particles/electrical_fx.pcf" )

game.AddParticles( "particles/fallingstar_fx.pcf" )

game.AddParticles( "particles/hellfire_fx.pcf" )

game.AddParticles( "particles/hwave_fx.pcf" )

game.AddParticles( "particles/misc_fx.pcf" )

game.AddParticles( "particles/ngen_fx.pcf" )

game.AddParticles( "particles/nio_fx.pcf" )

game.AddParticles( "particles/pulsar_fx.pcf" )

game.AddParticles( "particles/spectra_fx.pcf" )

game.AddParticles( "particles/stinger_fx.pcf" )

game.AddParticles( "particles/storm_fx.pcf" )

game.AddParticles( "particles/trace_fx.pcf" )

game.AddParticles( "particles/vapor_fx.pcf" )

game.AddParticles( "particles/veho_fx.pcf" )



-- Particle systems --

PrecacheParticleSystem( "aeblast_muzzle" )

PrecacheParticleSystem( "aquamarine_tracer" )

PrecacheParticleSystem( "astra_beam" )

PrecacheParticleSystem( "astra_beam_ptru" )

PrecacheParticleSystem( "astra_bolt" )

PrecacheParticleSystem( "astra_hit" )

PrecacheParticleSystem( "astra_hit_heavy" )

PrecacheParticleSystem( "astra_muzzle" )

PrecacheParticleSystem( "astra_muzzle_heavy" )

PrecacheParticleSystem( "blade_glow" )

PrecacheParticleSystem( "blade_hit" )

PrecacheParticleSystem( "bloom_beam_0" )

PrecacheParticleSystem( "bloom_halo_0" )

PrecacheParticleSystem( "celest_dissolve" )

PrecacheParticleSystem( "corro_muzzle" )

PrecacheParticleSystem( "corro_proc" )

PrecacheParticleSystem( "corro_tracer" )

PrecacheParticleSystem( "crsv_dissolve" )

PrecacheParticleSystem( "crsv_dissolve_cheap" )

PrecacheParticleSystem( "cryo_explosion_large" )

PrecacheParticleSystem( "drake_hit" )

PrecacheParticleSystem( "drake_muzzle" )

PrecacheParticleSystem( "drake_tracer" )

PrecacheParticleSystem( "electrical_arc_01_cp1" )

PrecacheParticleSystem( "electrical_arc_01_parent" )

PrecacheParticleSystem( "electrical_arc_01_system" )

PrecacheParticleSystem( "ember_hit_entity" )

PrecacheParticleSystem( "ember_hit_nothing" )

PrecacheParticleSystem( "ember_hit_world" )

PrecacheParticleSystem( "ember_laser" )

PrecacheParticleSystem( "ember_laser_underwater" )

PrecacheParticleSystem( "ember_muzzle" )

PrecacheParticleSystem( "ember_muzzle_turnoff" )

PrecacheParticleSystem( "ember_muzzle_turnon" )

PrecacheParticleSystem( "ember_underwater_bubbles" )

PrecacheParticleSystem( "event_onwater_remove" )

PrecacheParticleSystem( "flare_halo_0" )

PrecacheParticleSystem( "flathr" )

PrecacheParticleSystem( "fstar_charge" )

PrecacheParticleSystem( "fstar_hit" )

PrecacheParticleSystem( "fstar_freeze_catch" )

PrecacheParticleSystem( "fstar_freeze_release" )

PrecacheParticleSystem( "fstar_muzzle" )

PrecacheParticleSystem( "fstar_muzzle_altfire" )

PrecacheParticleSystem( "fstar_tracer" )

PrecacheParticleSystem( "fstar_secfire" )

PrecacheParticleSystem( "fstar_sfire_hit_swave" )

PrecacheParticleSystem( "grinder_muzzle" )

PrecacheParticleSystem( "gunsmoke" )

PrecacheParticleSystem( "hellfire_muzzle" )

PrecacheParticleSystem( "hellfire_muzzle_smoke" )

PrecacheParticleSystem( "hellfire_tracer" )

PrecacheParticleSystem( "hellfire_blast" )

PrecacheParticleSystem( "hellnade_fragments" )

PrecacheParticleSystem( "hellnade_heat" )

PrecacheParticleSystem( "hellnade_shockwave" )

PrecacheParticleSystem( "hornet_blast" )

PrecacheParticleSystem( "hornet_blast_charged" )

PrecacheParticleSystem( "hornet_blast_cheap" )

PrecacheParticleSystem( "hornet_trail" )

PrecacheParticleSystem( "hornet_trail_cheaper" )

PrecacheParticleSystem( "hwave_charge" )

PrecacheParticleSystem( "hwave_charged" )

PrecacheParticleSystem( "hwave_debris_small" )

PrecacheParticleSystem( "hwave_hit" )

PrecacheParticleSystem( "hwave_hit_fleks" )

PrecacheParticleSystem( "hwave_muzzle" )

PrecacheParticleSystem( "hwave_muzzle_embers" )

PrecacheParticleSystem( "hwave_muzzle_finish" )

PrecacheParticleSystem( "hwave_tracer" )

PrecacheParticleSystem( "hwave_tracer_cheap" )

PrecacheParticleSystem( "hwave_tracer_bloomtest" )

PrecacheParticleSystem( "ice_crystals" )

PrecacheParticleSystem( "ice_crystals_2" )

PrecacheParticleSystem( "ice_crystals_3" )

PrecacheParticleSystem( "ice_freezing" )

PrecacheParticleSystem( "ice_freezing_shortlt" )

PrecacheParticleSystem( "ice_freezing_release" )

PrecacheParticleSystem( "ice_impact" )

PrecacheParticleSystem( "ice_impact_heavy" )

PrecacheParticleSystem( "ice_tracer_smoke" )

PrecacheParticleSystem( "ice_muzzle_small" )

PrecacheParticleSystem( "ice_sfire_charge" )

PrecacheParticleSystem( "item_flare" )

PrecacheParticleSystem( "item_orb_battery" )

PrecacheParticleSystem( "item_orb_health" )

PrecacheParticleSystem( "item_orb_upgrade" )

PrecacheParticleSystem( "item_pfx_battery" )

PrecacheParticleSystem( "item_pfx_health" )

PrecacheParticleSystem( "item_pfx_upgrade" )

PrecacheParticleSystem( "item_pkin_amb" )

PrecacheParticleSystem( "item_pkin_break" )

PrecacheParticleSystem( "item_upg_break" )

--PrecacheParticleSystem( "jotunn_bolt_break" )

--PrecacheParticleSystem( "jotunn_bolt_impact" )

PrecacheParticleSystem( "jotunn_charge_init" )

PrecacheParticleSystem( "jotunn_charging" )

PrecacheParticleSystem( "jotunn_muzzle" )

PrecacheParticleSystem( "moby_hit" )

PrecacheParticleSystem( "moby_muzzle" )

PrecacheParticleSystem( "moby_tracer" )

PrecacheParticleSystem( "ngen_core_playerfx" )

PrecacheParticleSystem( "ngen_core_small" )

PrecacheParticleSystem( "ngen_core_small_cheap" )

PrecacheParticleSystem( "ngen_explosion" )

PrecacheParticleSystem( "ngen_explosion_energy" )

PrecacheParticleSystem( "ngen_hit" )

PrecacheParticleSystem( "ngen_hit_lgtning" )

PrecacheParticleSystem( "ngen_hit_sparks_2" )

PrecacheParticleSystem( "ngen_missile_smoke" )

PrecacheParticleSystem( "ngen_muzzle" )

PrecacheParticleSystem( "ngen_muzzle_2" )

PrecacheParticleSystem( "ngen_muzzle_3" )

PrecacheParticleSystem( "ngen_muzzle_4" )

PrecacheParticleSystem( "ngen_tracer" )

PrecacheParticleSystem( "nio_tracer" )

PrecacheParticleSystem( "nio_muzzle" )

PrecacheParticleSystem( "nio_impact" )

PrecacheParticleSystem( "nio_dissolve" )

PrecacheParticleSystem( "nio_dissolve_cheap" )

PrecacheParticleSystem( "nio_charge" )

PrecacheParticleSystem( "nrg_hit" )

PrecacheParticleSystem( "nrg_tracer" )

PrecacheParticleSystem( "onwater_bubbles" )

PrecacheParticleSystem( "panda_charge" )

PrecacheParticleSystem( "panda_charged" )

PrecacheParticleSystem( "panda_hit" )

PrecacheParticleSystem( "panda_muzzle" )

PrecacheParticleSystem( "panda_tracer" )

PrecacheParticleSystem( "pele_hit")

PrecacheParticleSystem( "pele_muzzle")

PrecacheParticleSystem( "pele_tracer")

PrecacheParticleSystem( "pest_muzzle" )

PrecacheParticleSystem( "pest_hit" )

PrecacheParticleSystem( "prisma_core" )

--PrecacheParticleSystem( "prisma_tracer" )

PrecacheParticleSystem( "pulsar_charge" )

PrecacheParticleSystem( "pulsar_charge_fail" )

PrecacheParticleSystem( "pulsar_beam" )

PrecacheParticleSystem( "pulsar_hit_weak" )

PrecacheParticleSystem( "pulsar_muzzle" )

PrecacheParticleSystem( "pyro_dissolve" )

PrecacheParticleSystem( "pyro_dissolve_ash_0" )

PrecacheParticleSystem( "pyro_dissolve_ash_3" )

PrecacheParticleSystem( "pyro_dissolve_cheap" )

PrecacheParticleSystem( "pyro_dissolve_ash_cheap" )

PrecacheParticleSystem( "pyro_explode" )

PrecacheParticleSystem( "pyro_nade" )

PrecacheParticleSystem( "saphyre_absorb" )

PrecacheParticleSystem( "saphyre_hit" )

PrecacheParticleSystem( "saphyre_hit_fleks" )

PrecacheParticleSystem( "saphyre_muzzle" )

PrecacheParticleSystem( "saphyre_muzzle_embers" )

PrecacheParticleSystem( "saphyre_muzzle_flames_0a" )

PrecacheParticleSystem( "saphyre_tracer" )

PrecacheParticleSystem( "sentinel_hit" )

PrecacheParticleSystem( "sentinel_muzzle" )

PrecacheParticleSystem( "seraph_hit" )

PrecacheParticleSystem( "seraph_muzzle" )

PrecacheParticleSystem( "seraph_tracer" )

PrecacheParticleSystem( "shk_hit" )

PrecacheParticleSystem( "shk_muzzle" )

PrecacheParticleSystem( "shk_tracer" )

PrecacheParticleSystem( "spectra_blast" )

PrecacheParticleSystem( "spectra_charging" )

PrecacheParticleSystem( "spectra_core" )

PrecacheParticleSystem( "spectra_core_crsv" )

PrecacheParticleSystem( "spectra_core_evensmaller" )

PrecacheParticleSystem( "spectra_core_fire" )

PrecacheParticleSystem( "spectra_core_ice" )

PrecacheParticleSystem( "spectra_core_small" )

PrecacheParticleSystem( "spectra_explode" )

PrecacheParticleSystem( "spectra_fmchange" )

PrecacheParticleSystem( "spectra_hit" )

PrecacheParticleSystem( "spectra_muzzle" )

PrecacheParticleSystem( "spectra_tracer" )

PrecacheParticleSystem( "spr_explosion" )

PrecacheParticleSystem( "spr_explosion_large" )

PrecacheParticleSystem( "spr_explosion_large_flash_noz" )

PrecacheParticleSystem( "spr_explosion_large_smoshroom" )

PrecacheParticleSystem( "spr_hit" )

PrecacheParticleSystem( "spr_muzzle" )

PrecacheParticleSystem( "spr_nade_tick" )

PrecacheParticleSystem( "spr_tracer" )

PrecacheParticleSystem( "stinger_muzzle" )

PrecacheParticleSystem( "stinger_core_small" )

PrecacheParticleSystem( "stinger_explode" )

PrecacheParticleSystem( "stinger_muzzle_2" )

PrecacheParticleSystem( "stinger_core_small_2" )

PrecacheParticleSystem( "stinger_explode_2" )

PrecacheParticleSystem( "supra_c_hit" )

PrecacheParticleSystem( "supra_charging" )

PrecacheParticleSystem( "supra_mirv" )

PrecacheParticleSystem( "supra_nade" )

PrecacheParticleSystem( "supra_p_hit" )

PrecacheParticleSystem( "storm_muzzle" )

PrecacheParticleSystem( "trace_muzzle" )

PrecacheParticleSystem( "trace_trace" )

PrecacheParticleSystem( "trace_projectile" )

PrecacheParticleSystem( "trace_projectile_pws" )

PrecacheParticleSystem( "vapor" )

PrecacheParticleSystem( "vapor_cheap" )

PrecacheParticleSystem( "vapor_charge_glow" )

PrecacheParticleSystem( "vapor_charge_secfire" )

PrecacheParticleSystem( "vapor_collapse" )

PrecacheParticleSystem( "vapor_collapse_cheap" )

PrecacheParticleSystem( "vapor_muzzle" )

PrecacheParticleSystem( "vapor_muzzle_altfire" )

PrecacheParticleSystem( "vapor_muzzle_evensmaller" )

PrecacheParticleSystem( "vapor_muzzle_small" )

PrecacheParticleSystem( "vectra_charged" )

PrecacheParticleSystem( "vectra_charging" )

PrecacheParticleSystem( "vp_binary_muzzle" )

PrecacheParticleSystem( "vp_binary_tracer" )

PrecacheParticleSystem( "vp_dissolve" )

PrecacheParticleSystem( "vp_dissolve_cheap" )

PrecacheParticleSystem( "vsecfire_shockwave" )

PrecacheParticleSystem( "vh_muzzle" )

PrecacheParticleSystem( "vh_tracer_old" )

PrecacheParticleSystem( "vh_hit" )

PrecacheParticleSystem( "xplo_tracer" )

PrecacheParticleSystem( "xplo_hit" )

PrecacheParticleSystem( "xplo_hit_cheap" )

PrecacheParticleSystem( "zeala_charged" )

PrecacheParticleSystem( "zeala_charging" )

PrecacheParticleSystem( "zeala_burst" )

PrecacheParticleSystem( "zeala_muzzle" )

PrecacheParticleSystem( "zeala_nade" )

PrecacheParticleSystem( "zeala_vortex" )

PrecacheParticleSystem( "zeala_vortex_cheap" )



if ( CLIENT ) then



-- Killicons --

--killicon.Add( "point_hurt", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) ) -- Legacy

killicon.Add( "sfw_pulsar", "vgui/icons/icon_pulsar.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_hellfire", "vgui/icons/icon_hfire.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "hfire_pfire", "vgui/icons/icon_hfire.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_storm", "vgui/icons/icon_storm.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "storm_pfire", "vgui/icons/icon_storm.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_neutrino", "vgui/icons/icon_nio.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_stinger", "vgui/icons/icon_stinger.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sting_pfire", "vgui/icons/icon_stinger.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sting_sfire", "vgui/icons/icon_stinger.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_trace", "vgui/icons/icon_nio.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "trace_pfire", "vgui/icons/icon_nio.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "trace_sfire", "vgui/icons/icon_nio.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_grinder", "vgui/icons/icon_grinder.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_behemoth", "vgui/icons/icon_grinder.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_frag", "vgui/icons/icon_grinder.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_frag_ent", "vgui/icons/icon_grinder.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_thunderbolt", "vgui/icons/icon_tbolt.vmt", Color( 255, 255, 255, 255 ) )



	-- custom --

killicon.Add( "sfw_custom", "vgui/icons/icon_custom.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "bane_hurt", "vgui/icons/icon_custom.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfi_pkin", "vgui/icons/icon_custom.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "mtm_missile", "vgui/icons/icon_custom.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfi_flare", "vgui/icons/icon_custom.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfi_sentinel", "vgui/icons/icon_custom.vmt", Color( 255, 255, 255, 255 ) )



	-- t3i: cryo --

killicon.Add( "sfw_blizzard", "vgui/icons/icon_cryon.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_cryon", "vgui/icons/icon_cryon.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_cryon_ent", "vgui/icons/icon_cryon.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_jotunn", "vgui/icons/icon_cryon.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "jotunn_arrow", "vgui/icons/icon_cryon.vmt", Color( 255, 255, 255, 255 ) )



	-- t3i: corrosive --

killicon.Add( "sfw_acidrain", "vgui/icons/icon_arain.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "grenade_spit", "vgui/icons/icon_arain.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_pandemic", "vgui/icons/icon_arain.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "panda_pfire", "vgui/icons/icon_arain.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "dmg_corrosion", "vgui/icons/icon_arain.vmt", Color( 255, 255, 255, 255 ) )



	-- vaportec / VP series --

killicon.Add( "sfw_vapor", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "vapor_pfire", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "vapor_sfire", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "vapor_nade", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_eblade", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "fstar_pfire", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "fstar_sfire", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_fallingstar", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_saphyre", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "saph_pfire", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_aquamarine", "vgui/icons/icon_vapor.vmt", Color( 255, 255, 255, 255 ) )



	-- heatwave / HS series --

killicon.Add( "sfw_hwave", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "hwave_pfire", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_hwave_tx", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "hwave_grenade", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_phoenix", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_seraphim", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_ember", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "ember_endpoint", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_draco", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "drac_pfire", "vgui/icons/icon_phurt.vmt", Color( 255, 255, 255, 255 ) )



	-- celestials and hybrid tech --

killicon.Add( "sfw_hornet", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "hornet_pfire", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_alchemy", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "spectra_pfire", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_prisma", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_supra", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "supra_nade_parent", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "supra_nade_child", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_astra", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "astra_pfire", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_vectra", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "vectra_pfire", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_zeala", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )

killicon.Add( "sfw_vortex_world", "vgui/icons/icon_trace.vmt", Color( 255, 255, 255, 255 ) )



-- Entity names --

language.Add( "vapor_pfire", "Vapor Projectile" )

language.Add( "vapor_sfire", "Vapor Blast" )

language.Add( "storm_pfire", "Storm Fling" )

language.Add( "hfire_pfire", "Hellfire Projectile" )

language.Add( "trace_pfire", "Trace Projectile" )

language.Add( "trace_sfire", "Trace Powershot" )

language.Add( "hornet_pfire", "Hornet Flechette" )

language.Add( "#grenade_spit", "Acid blob" )

language.Add( "grenade_spit", "Acid blob" )

language.Add( "sfi_supplies", "Scifi Supplies" )

language.Add( "dmg_corrosion", "Corrosion" )

language.Add( "sfi_pkin", "A Vicious Treat" )

language.Add( "sfi_sentinel", "Sentinel Turret" )

language.Add( "sfi_flare", "Tactical Flare" )

language.Add( "jotunn_arrow", "Jotunn Arrow" )

language.Add( "sfw_vortex_world", "Zeala" )

language.Add( "astra_pfire", "Light Bolt" )



-- Hints --

language.Add( "hint_sfw_remi_dmgamp", "If you feel uncomfortable with the amount of damage, the scifi weapons deal, you can reduce or increase it in the settings." )

language.Add( "hint_sfw_remi_melee", "Most of these weapons can be used along with a passive melee attack. Check out the options for more info." )

language.Add( "hint_sfw_custom_equip_1", "Custom scifi weapon equipped." )

language.Add( "hint_sfw_custom_equip_2", "You can change the weapon's function and firerate in the options, located in the spawn menu." )

language.Add( "hint_sfw_bfire_equip_1", "Press 'E' + 'Mouse2' to switch firemodes." )

language.Add( "hint_sfw_bnade_equip_1", "Press 'E' + 'Mouse1' to use altfire." )

language.Add( "hint_sfw_charge_equip_1", "Hold Mouse1 to charge the weapon, release it to fire." )

language.Add( "hint_sfw_autoregen_equip_1", "This weapon automatically regenerates ammo." )

language.Add( "hint_sfw_passivemelee", "You can perform a passive melee attack. Check out the options for details." )



end