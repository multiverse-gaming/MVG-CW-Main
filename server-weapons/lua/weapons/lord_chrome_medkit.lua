if SERVER then
    AddCSLuaFile("lord_chrome_medkit.lua")
end

SWEP.PrintName = "Hydron Medical Kit"
SWEP.Author = "Lord Chrome"
SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.Description = "Heal the wounds of your fellow troopers"
SWEP.Contact = "chromamods@gmail.com"
SWEP.Purpose = ""
SWEP.Instructions = "Left click to heal someone\nRight click to heal yourself"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "[MVG] Medical Equipment"

SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = "models/weapons/w_medkit.mdl"
SWEP.UseHands = true

SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic  = true
SWEP.Primary.Delay = 0.1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Recoil = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = 0.3
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    local found
    local lastDot = -1 -- the opposite of what you're looking at
    self:GetOwner():LagCompensation(true)
    local aimVec = self:GetOwner():GetAimVector()

    for k,v in pairs(player.GetAll()) do
        local maxhealth = v:GetMaxHealth() or 100
        if v == self:GetOwner() or v:GetShootPos():Distance(self:GetOwner():GetShootPos()) > 85 or not v:Alive() then continue end

        if v:Health() >= maxhealth then self.Owner:EmitSound("WallHealth.Deny") continue end

        local direction = v:GetShootPos() - self:GetOwner():GetShootPos()
        direction:Normalize()
        local dot = direction:Dot(aimVec)

        -- Looking more in the direction of this player
        if dot > lastDot then
            lastDot = dot
            found = v
        end
    end
    self:GetOwner():LagCompensation(false)

    --[[if found then
        if (found:Health() >= found:GetMaxHealth()) then 
           self.Owner:EmitSound("starwars/items/bacta.wav")
            print("Hello world")
        else 
            found:SetHealth(math.min(found:Health() + 10, found:GetMaxHealth()))
            print("Health"..found:Health())
        end
    end --]]

    if found then
        if (found:Health() + 10) >= found:GetMaxHealth() then
            found:SetHealth(found:GetMaxHealth())
            self.Owner:EmitSound("WallHealth.Deny")
        else
            found:SetHealth(found:Health() + 10)
        end
        self:EmitSound("weapons/physcannon/physcannon_charge.wav", 10, found:Health() / found:GetMaxHealth() * 100, 1)
    end
end

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
    local ply = self:GetOwner()
    local maxhealth = self:GetOwner():GetMaxHealth() or 100
    if ply:Health() < maxhealth then
        ply:SetHealth(ply:Health() + 10)
        self:EmitSound("weapons/physcannon/physcannon_charge.wav", 10, ply:Health() / ply:GetMaxHealth() * 100, 1)
    end
end