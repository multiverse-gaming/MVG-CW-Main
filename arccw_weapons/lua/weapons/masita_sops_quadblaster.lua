AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "Quad-Blaster"
SWEP.Trivia_Class = "Blaster Heavy Repeater"
SWEP.Trivia_Desc = "The reciprocating quad blaster, often shortened to 'Cip-Quad' was an experimental weapon developed during the Clone Wars by Merr-Sonn Munitions."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/quadblaster.png"

-- Viewmodel & Entity Properties
SWEP.AnimTime = CurTime()

SWEP.UseHands = true
SWEP.ViewModel = "models/tor/weapons/v_quadblaster.mdl"
SWEP.WorldModel = "models/tor/weapons/w_quadblaster.mdl"
SWEP.ViewModelFOV = 55
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-7, 6, -8),
    ang = Angle(0, 5, 180)
}
-- Damage & Tracer
SWEP.Damage = 30
SWEP.RangeMin = 127
SWEP.DamageMin = 30
SWEP.Range = 328
SWEP.Penetration = 7

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 150
SWEP.ExtendedClipSize = 250
SWEP.ReducedClipSize = 75

SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5

SWEP.VisualRecoilMult = 0.78
SWEP.Recoil = 0.54
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.3
SWEP.RecoilPunch = 0.2
SWEP.RecoilVMShake = 1.1

SWEP.Delay = 60 / 420
SWEP.Firemode = 2
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 0.56
SWEP.HipDispersion = 320 
SWEP.MoveDispersion = 50

-- Speed Mult
SWEP.SpeedMult = 0.67
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.23

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 110 
SWEP.ShootPitch = 87
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "weapons/nemesisstar/nmstarfire1.wav"
SWEP.ShootSound = "weapons/nemesisstar/nmstarfire2.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.NoFlash = true
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = false

-- Holdtype
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = "duel"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 17, -5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(7, -7, -1.206)
SWEP.CustomizeAng = Angle(18.291, 30.954, 17.587)

SWEP.HolsterPos = Vector(0, 17, -5)
SWEP.HolsterAng = Angle(0, 0, 0)

-- Attachments
--[[SWEP.Attachments = {     
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita", "ammo_stun"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = {"perk", "mw3_pro"},
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"uc_fg"},
    },
}--]]


-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["draw"] = {
        Source = "idle_deployed"
    },
    ["idle"] = {
        Source = "idle_deployed"
    },
    ["ready"] = {
        Source = "deploy"
    },
    ["fire"] = {
        Source = "idle_shooting"
    },
    ["holster"] = {
        Source = "retract"
    },
    ["2_to_0"] = {
        Source = "retract"
    },
}


if CLIENT then
    function SWEP:PlaceHandsOnGun()
        local leftElbow = self:GetOwner():LookupBone("ValveBiped.Bip01_L_Forearm")
        self:GetOwner():ManipulateBoneAngles(leftElbow, Angle(20, -20, 0))

        local rightShoulder = self:GetOwner():LookupBone("ValveBiped.Bip01_R_UpperArm")
        self:GetOwner():ManipulateBoneAngles(rightShoulder, Angle(0, 15, 0))

        local rightElbow = self:GetOwner():LookupBone("ValveBiped.Bip01_R_Forearm")
        self:GetOwner():ManipulateBoneAngles(rightElbow, Angle(-30, -40, 0))
    end

    function SWEP:ResetBoneAngles()
        local leftElbow = self:GetOwner():LookupBone("ValveBiped.Bip01_L_Forearm")
        self:GetOwner():ManipulateBoneAngles(leftElbow, Angle(0, 0, 0))

        local rightShoulder = self:GetOwner():LookupBone("ValveBiped.Bip01_R_UpperArm")
        self:GetOwner():ManipulateBoneAngles(rightShoulder, Angle(0, 0, 0))

        local rightElbow = self:GetOwner():LookupBone("ValveBiped.Bip01_R_Forearm")
        self:GetOwner():ManipulateBoneAngles(rightElbow, Angle(0, 0, 0))
    end
end

function SWEP:DrawWorldModel()
    if IsValid(self.Owner) then 
        self:SetPoseParameter("head_pitch", self.Owner:EyeAngles()[1])
        self:InvalidateBoneCache()
    end
    self:DrawModel()
end

function SWEP:Deploy()
    if SERVER then
        self:SetSequence(2)
        self:GetOwner():GetViewModel():SendViewModelMatchingSequence(2)
    end
end

function SWEP:Holster()
    if SERVER then
        self:SetSequence(4)
    end
    if CLIENT then
        self:ResetBoneAngles()
    end

    return true
end

function SWEP:ReloadTicker()end

function SWEP:Anims() end

function SWEP:Reload()
    return
end

function SWEP:Think()

    self.Anims()
    self.ReloadTicker()
    
    if SERVER then
        if self:GetCurrentFiremode().Mode == 2 then
            self:GetOwner():GetViewModel():SendViewModelMatchingSequence(3)
            self:SetHoldType("normal")
            self:SetSequence(1)
            self.ReloadTicker = function()
                if self:GetCurrentFiremode().Mode == 0 then
                    if CurTime() then
                        if self:Clip1() < self:GetMaxClip1() and self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
                            local ammo = math.Clamp(50, 0, self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()))
                            ammo = math.min(ammo, self:GetMaxClip1()-self:Clip1())
                            self:SetClip1(math.Clamp(self:Clip1() + ammo, 0, self:GetMaxClip1()))
                            self:GetOwner():RemoveAmmo( ammo, self:GetPrimaryAmmoType() )
                            if self:Clip1() == self:GetMaxClip1() then
                                self.ReloadTicker = function()end
                            else
                                self.ReloadWaitTime = CurTime() + 0.5
                            end
                        end
                    end
                else
                    self.ReloadTicker = function()end
                end
            end
        end
        if self:GetCurrentFiremode().Mode == 0 then
            self:SetSequence(3)
        end
        if self:GetOwner():KeyDown(IN_ATTACK) then
            self:SetSequence(5)
            self:GetOwner():GetViewModel():SendViewModelMatchingSequence(5)
            self:SetHoldType("duel")
        end
        if self:GetOwner():KeyReleased(IN_ATTACK) then
            self:SetSequence(1)
        end
        if self:GetSequence() == 5 then
            self:SetCycle( math.min(self:GetCycle() + 5*FrameTime(), 1))
        else
            self:SetCycle( math.min(self:GetCycle() + 0.5*FrameTime(), 1))
        end
        if self:GetCycle() >= 1 then
            if tonumber(self:GetSequence()) == 5 then
                self:SetCycle( 0 )
            end
        end
    end
end