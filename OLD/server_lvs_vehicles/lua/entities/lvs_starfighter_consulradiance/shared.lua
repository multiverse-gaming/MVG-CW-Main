
ENT.Base = "lvs_base_starfighter"

ENT.PrintName = "Radiant VII Consular Cruiser"
ENT.Author = "CR90"
ENT.Information = "Repub Retrofitted Consular Class Radiant VII Escort"
ENT.Category = "[LVS] - Republic Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/salty/consularclassradiance.mdl"
ENT.GibModels = {
	"models/gibs/helicopter_brokenpiece_01.mdl",
	"models/gibs/helicopter_brokenpiece_02.mdl",
	"models/gibs/helicopter_brokenpiece_03.mdl",
	"models/combine_apc_destroyed_gib02.mdl",
	"models/combine_apc_destroyed_gib04.mdl",
	"models/combine_apc_destroyed_gib05.mdl",
	"models/props_c17/trappropeller_engine.mdl",
	"models/gibs/airboat_broken_engine.mdl",
	"models/salty/ConsGib1.mdl",
	"models/salty/ConsGib2.mdl",
	"models/salty/ConsGib3.mdl",
	"models/salty/ConsGib4.mdl",

}

ENT.AITEAM = 2

ENT.MaxVelocity = 1900
ENT.MaxThrust = 3000

ENT.ThrustVtol = 55
ENT.ThrustRateVtol = 3

ENT.TurnRatePitch = 0.8
ENT.TurnRateYaw = 0.8
ENT.TurnRateRoll = 0.35

ENT.ForceLinearMultiplier = 0.5

ENT.ForceAngleMultiplier = 0.5
ENT.ForceAngleDampingMultiplier = 0.5

ENT.MaxHealth = 8500
ENT.MaxShield = 1000

ENT.FlyByAdvance = 0.90
ENT.FlyBySound = "lvs/vehicles/frigates/flyby.wav" 
ENT.DeathSound = "lvs/vehicles/crash/crashingdown.wav"

ENT.EngineSounds = {
	{
		sound = "lvs/vehicles/frigates/loop3.wav",
		Pitch = 120,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
	},
}