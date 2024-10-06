AddCSLuaFile()



SWEP.PrintName = "Thruster"

SWEP.Category = "[MVG] Miscellaneous Equipment"

SWEP.Author = "Stein"

SWEP.Instructions = [[

    Press left click to equip the thruster

    Move in one direction and hold space to thrust in that direction

]]



SWEP.Base = "weapon_base"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.HoldType = "normal"

SWEP.Slot = 4

SWEP.SlotPos = 100



SWEP.ViewModelFOV = 74

SWEP.ViewModel = "models/weapons/c_slam.mdl"

SWEP.WorldModel = "models/weapons/w_slam.mdl"

SWEP.UseHands = true



SWEP.DrawAmmo = false

SWEP.DrawCrosshair = false



SWEP.Primary.Damage = 0

SWEP.Clipsize = -1

SWEP.DefaultClip = -1

SWEP.Primary.Automatic = false

SWEP.Primary.Ammo = "none"



local maxFuel = 100 -- no point in changing this, change drain and recharge

local status = true



local soundCreated = false



-- SETTINGS YOU CAN CHANGE WITHOUT RUINING THE THRUSTER FUNCTIONS

local thrustSpeed = 300 -- Higher is further

local fuelDrain = 100 -- Lower is slower

local fuelRecharge = 4 --2.5 -- Lower is slower

local infiniteFuel = false -- True means it"s enabled = it got infinite amount of fuel



sound.Add({



    name = "jetpack.thruster_loop",

    channel = CHAN_AUTO,

    volume = 0.6,

    level = 75,

    sound = "^thrusters/jet02.wav"



})



function SWEP:SetupDataTables()



    self:NetworkVar("Bool", 0, "Active")

    self:NetworkVar("Float", 0, "Fuel")

    self:NetworkVar("Bool", 1, "CanFly")



end



function SWEP:Initialize()



    self:SetFuel(maxFuel)

    self:SetCanFly(true)



    hook.Add("PlayerTick", "rocketboots_think_while_not_equipped", function(ply, mv)



        weaponId = ply:GetWeapon("weapon_thruster")



        if weaponId != NULL and weaponId != nil then



            status = pcall(function() weaponId:GetActive() end)



            if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then



                if !soundCreated then



                    soundCreated = true



                    rocketbootssound = CreateSound(ply, "jetpack.thruster_loop")



                end



                if ply:KeyDown(IN_JUMP) and weaponId:GetCanFly() and !ply:IsOnGround() and weaponId:GetFuel() == 100 then



                    if !infiniteFuel then



                        weaponId:SetFuel(math.Clamp(weaponId:GetFuel() - fuelDrain, 0, maxFuel))



                    end



                    if !ply:OnGround() then



                        rocketbootssound:PlayEx(0.2, 125)



                    end



                    if ply:KeyDown(IN_MOVERIGHT) then



                        ply:SetVelocity(thrustSpeed * ply:EyeAngles():Right())



                    elseif ply:KeyDown(IN_MOVELEFT) then



                        ply:SetVelocity(thrustSpeed * (ply:EyeAngles():Right() * -1))



                    elseif ply:KeyDown(IN_FORWARD) then



                        ply:SetVelocity(thrustSpeed * ply:EyeAngles():Forward())



                    elseif ply:KeyDown(IN_BACK) then



                        ply:SetVelocity(thrustSpeed * (ply:EyeAngles():Forward() * -1))



                    end



                    -- weaponId:BoostEffect(ply)



                    return



                end



                if ply:IsOnGround() or weaponId:GetCanFly() then



                    weaponId:SetFuel(math.Clamp(weaponId:GetFuel() + fuelRecharge, 0, maxFuel))



                    if weaponId:GetFuel() > 0 then



                        weaponId:SetCanFly(true)



                    end



                    rocketbootssound:FadeOut(0.1)

                    return



                end



                rocketbootssound:FadeOut(0.1)



            elseif status and !weaponId:GetActive() and (weaponId:GetOwner() == ply) then



                if soundCreated then



                    rocketbootssound:FadeOut(0.1)



                end



            end



        end



    end)



    if SERVER then



        hook.Add("PostPlayerDeath", "detonate_rocket_boots", function(ply)



            weaponId = ply:GetWeapon("weapon_thruster")



            if weaponId != NULL and weaponId != nil then



                if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then



                    local effect = EffectData()

                    effect:SetOrigin(ply:GetPos())

                    effect:SetMagnitude(100)

                    effect:SetFlags(bit.bor(0x80, 0x20))

                    util.Effect("Explosion", effect)



                    if soundCreated then



                        rocketbootssound:FadeOut(0.1)



                    end



                end



                weaponId:SetActive(false)



            end



        end)



    end



    if CLIENT then



        local function DrawRect(col, x, y, w, h)



            x, y = math.Round(x), math.Round(y)

            w, h = math.Round(w), math.Round(h)

            surface.SetDrawColor(col.r, col.g, col.b, col.a)

            surface.DrawRect(x, y, w, h)



        end



        local MSW, MSH = ScrW(), ScrH()

        local fuelbarwidth, fuelbarheight = 256, 48

        local col_bg = Color(0, 0, 0, 192)

        local col_fuel = Color(255, 128, 0, 255)

        local mf = 100



        hook.Add("HUDPaint", "fuel_bar", function()



            weaponId = LocalPlayer():GetWeapon("weapon_thruster")

            if !(weaponId == NULL) and weaponId:GetActive() and (weaponId:GetOwner() == LocalPlayer()) then



                local percent = math.floor(weaponId:GetFuel() / mf * 100)

                DrawRect(col_bg, MSW / 2 - fuelbarwidth / 2, MSH - fuelbarheight * 1.4, fuelbarwidth, fuelbarheight)

                DrawRect(col_fuel, MSW / 2 - fuelbarwidth / 2 + 4, MSH - fuelbarheight * 1.4 + 4, (fuelbarwidth - 8) * percent / 100, fuelbarheight - 8)

            end



        end)



    end



end



function SWEP:PrimaryAttack()



    if !IsFirstTimePredicted() then return end



    self:SetNextPrimaryFire(CurTime() + 0.5)



    if self:GetActive() then



        if SERVER then



            self:SetActive(false)



        end



    else



        if SERVER then



            self:SetActive(true)



        end



    end



end



function SWEP:SecondaryAttack()

end
