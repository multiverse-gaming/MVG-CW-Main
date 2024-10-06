-------------------------------------

---------------- Cuffs --------------

-------------------------------------

-- Copyright (c) 2015 Nathan Healy --

-------- All rights reserved --------

-------------------------------------

-- weapon_cuff_elastic.lua  SHARED --

--                                 --

-- Elastic handcuffs.              --

-------------------------------------

AddCSLuaFile()

SWEP.Base = "weapon_cuff_base"

SWEP.Category = "[MVG] Handcuffs"
SWEP.Author = "Jaul_is_a_simp"
SWEP.Instructions = "Stretchable restraint."

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AdminSpawnable = true

SWEP.Slot = 2
SWEP.PrintName = "Binders"

//
// Handcuff Vars
SWEP.CuffTime = 0.1 // Seconds to handcuff
SWEP.CuffSound = Sound( "buttons/lever7.wav" )

SWEP.CuffMaterial = "models/props_pipes/GutterMetal01a"
SWEP.CuffRope = "cable/red"
SWEP.CuffStrength = 1.4
SWEP.CuffRegen = 1.4
SWEP.RopeLength = 32//100
SWEP.CuffReusable = true
SWEP.CuffRecharge = 1 // Time before re-use

SWEP.CuffBlindfold = false
SWEP.CuffGag = false

SWEP.CuffStrengthVariance = 0.1 // Randomise strength
SWEP.CuffRegenVariance = 0.1 // Randomise regen