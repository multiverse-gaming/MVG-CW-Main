
SWEP.Base = "arccw_base_nade"
--SWEP.Base = "arccw_grenade_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "MVG"
SWEP.AdminOnly = false

SWEP.PrintName = "Ammo Crate"
SWEP.Trivia_Desc = "A throable munnitons box"
SWEP.Trivia_Manufacturer = "Blas-Tech Industries"
SWEP.Trivia_Mechanism = "Gives the ammo your holding if you are not holding a weappon it gives Puls ammo"
SWEP.Trivia_Country = "GAR"

SWEP.Slot = 3

SWEP.CamAttachment = 3

SWEP.NotForNPCs = false

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/nade_frag.mdl"
SWEP.WorldModel = "models/weapons/w_nade_frag.mdl"
SWEP.HideViewmodel = true
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    scale = 0.1
}
SWEP.ForceDefaultAmmo = 15

SWEP.IconOverride = "materials/entities/rw_ammo_distributor.png"

SWEP.FuseTime = 1.5
SWEP.PullPinTime = 0.5

SWEP.ViewModelFOV = 70

SWEP.Primary.Ammo = "AR2AltFire"

SWEP.Primary.ClipSize = 1

SWEP.MuzzleVelocityAlt = 600
SWEP.MuzzleVelocity = 450
SWEP.ShootEntity = "arccw_ammo_chargepack_thr"

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "Crate",
    },
}

SWEP.DefaultElements = {"chargepack"}

SWEP.AttachmentElements = {
    ["chargepack"] = {
        VMElements = {
            {
                Model = "models/cs574/objects/ammo_box.mdl",
                Bone = "def_c_base",
                Scale = Vector(.8, .8, .8),
                Offset = {
                    pos = Vector(-6.4, 4.4, -2.2),
                    ang = Angle(-0, 0, -45)
                }
            }
        },
        WMElements = {
            {
                Model = "models/cs574/objects/ammo_box.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(0, 0, 0),
                    ang = Angle(0, 0, 180)
                }
            }
        },
    },
}

WMOverride = "models/cs574/objects/ammo_box.mdl"


SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        SoundTable = {
            {
                t = 0,
                s = "arccw/mun/grenade_throw.wav",
                c = CHAN_WEAPON
            }
        }
    },
    ["throw"] = {
        Source = "throw",
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
        SoundTable = {
            {
                t = 0,
                s = "arccw/mun/grenade_throw.wav",
                c = CHAN_WEAPON
            }
        }
    }
}

sound.Add({
    name = "ARCCW_MUN.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw/mun/grenade_throw.wav"
})