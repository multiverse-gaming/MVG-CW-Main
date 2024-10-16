AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Special Forces Weapons"
SWEP.Credits = "TOMERY"
SWEP.PrintName = "Repulsor Blast"
SWEP.Trivia_Class = "Energy Weapon"
SWEP.Trivia_Desc = "A repulsive blast that deals damage and stuns enemies in a cone-shaped area of effect."
SWEP.Trivia_Manufacturer = "Republic"
SWEP.Trivia_Calibre = "Energy Pulse"
SWEP.Trivia_Mechanism = "Repulsor Technology"
SWEP.Trivia_Country = "Republic"
SWEP.Trivia_Year = 2024

SWEP.Slot = 3
SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 70
SWEP.MirrorVMWM = false
SWEP.MirrorWorldModel = false
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 75
SWEP.RangeMin = 100
SWEP.DamageMin = 50
SWEP.Range = 1000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BLAST
SWEP.MuzzleVelocity = 400

SWEP.Recoil = 0
SWEP.RecoilSide = 0
SWEP.RecoilPunch = 0
SWEP.RecoilRise = 0

SWEP.Delay = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "ar2"

SWEP.RepulsorKnockbackForce = 500
SWEP.RepulsorBlastRadius = 1000
SWEP.RepulsorBlastDamage = 75
SWEP.RepulsorStunDuration = 0.5

SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.ShootSound = "weapons/airboat/airboat_gun_lastshot1.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-2.92, -12, 0.7),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    ViewModelFOV = 70,
}

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ActivePos = Vector(0, 0.8, -2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, 0, 0)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(2, -5, 1)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "ar2"

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["draw"] = {
        Source = "draw",
    },
    ["holster"] = {
        Source = "holster",
    },
    ["reload"] = {
        Source = "reload",
        Time = 3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1, 
        SoundTable = {
            {s = "ArcCW_dc15a.reload2", t = 4 / 30}, 
        },
    },


sound.Add({
    name =          "ArcCW_dc15a.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/heavy.wav"
    }),
}

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    self:ShootRepulsorBlast()
    self:SetNextPrimaryFire(CurTime() + self.Delay)
end

function SWEP:ShootRepulsorBlast()
    local owner = self:GetOwner()
    self:EmitSound(self.ShootSound)
    local blastOrigin = owner:GetShootPos()
    local forward = owner:GetAimVector()

    local entities = ents.FindInCone(blastOrigin, forward, self.RepulsorBlastRadius, math.cos(math.rad(60)))

    print("Entities in blast cone:")
    for _, ent in pairs(entities) do
        print(ent:GetClass(), IsValid(ent))
    end

    local validClasses = {
        ["npc_combine_s"] = true,
        ["npc_metropolice"] = true,
        ["npc_zombie"] = true,
        ["npc_monk"] = true,
    }

    for _, ent in pairs(entities) do
        if IsValid(ent) and validClasses[ent:GetClass()] then
            if ent:Health() > 0 then 
                local dmg = DamageInfo()
                dmg:SetDamage(self.RepulsorBlastDamage)
                dmg:SetAttacker(owner)
                dmg:SetInflictor(self)
                dmg:SetDamageType(DMG_BLAST)
                ent:TakeDamageInfo(dmg)

                local direction = (ent:GetPos() - blastOrigin):GetNormalized()
                if IsValid(ent:GetPhysicsObject()) then
                    ent:GetPhysicsObject():ApplyForceCenter(direction * self.RepulsorKnockbackForce)
                else
                    ent:SetVelocity(direction * self.RepulsorKnockbackForce)
                end
            else
                print("Entity is already dead:", ent:GetClass())
            end
        else
            print("Entity is invalid or not a valid type:", ent:GetClass())
        end
    end

    self:TakePrimaryAmmo(1)
end




function SWEP:CanPrimaryAttack()
    if self:Clip1() <= 0 then
        self:Reload()
        return false
    end
    return true
end

