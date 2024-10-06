AddCSLuaFile()
SWEP.PrintName = "Jetpack"
SWEP.Category = "[MVG] Miscellaneous Equipment"
SWEP.Author = "Stein"
SWEP.Instructions = [[
    Press left click to equip the jetpack
    If it was equipped or unequipped it will say so on your screen
    Hold jump key to go up
    Hold crouch key to go down
    Hold sprint key to hover and strafe
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
local jetpackVelocity = 1200
local maxFuel = 100 -- no point in changing this, change drain and recharge
local status = true
local sv_gravity = GetConVar"sv_gravity"
local soundCreated = false

-- SETTINGS YOU CAN CHANGE WITHOUT RUINING THE JETPACK FUNCTIONS
local jetpackStrafeSpeed = 340 -- Speed while strafing (X/Y axis); higher is faster
local jetpackFlightSpeed = 210 -- Speed that you travel up/down with. 
local jetpackFlightAcceleration = 0.7
local jetpackDeleceration = 5 -- Change to make it floatier/not
local fuelDrain = 0.5 -- Lower is slower
local fuelRecharge = 2 -- Lower is slower
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
    hook.Remove("Move", "hover_mode")
    hook.Add("SetupMove", "hover_mode", function(ply, mv, cmd)
        weaponId = ply:GetWeapon("weapon_jetpack")
        if weaponId ~= NULL and weaponId ~= nil then
            status = pcall(function() weaponId:GetActive() end)
            if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) and weaponId:GetCanFly() and not ply:OnGround() and (ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_SPEED) or ply:KeyDown(IN_DUCK)) then
                if not infiniteFuel then weaponId:SetFuel(math.Clamp(weaponId:GetFuel() - fuelDrain, 0, maxFuel)) end
                if weaponId:GetFuel() == 0 then weaponId:SetCanFly(false) end
                local vel = mv:GetVelocity()
                -- Clone vel to use after transforming values
                local oldVel = vel
                if mv:KeyDown(IN_JUMP) and vel.z < jetpackFlightSpeed then
                    -- If holding jump, Travel up quickly.
                    vel.z = vel.z + (jetpackFlightSpeed / 2)
                elseif mv:KeyDown(IN_SPEED) and (vel.z > 10) then
                    -- If holding run and traveling up, slowly equalise speed.
                    vel.z = math.Approach(vel.z, 0, 40)
                elseif mv:KeyDown(IN_SPEED) and (vel.z < -10) then
                    -- If holding run and traveling down, quickly equalise speed (gravity will pull you).
                    vel.z = math.Approach(vel.z, 0, 100)
                elseif mv:KeyDown(IN_SPEED) and (vel.z <= 10 or vel.z >= -10) then
                    -- If holding run and moving very slowly, kill speed so you can hover perfectly.
                    vel.z = 0
                end

                if mv:KeyDown(IN_DUCK) then vel.z = vel.z - (jetpackFlightSpeed / 2) end
                if vel.z == 0 and mv:KeyDown(IN_SPEED) then -- This enables stable hover.
                    ply:SetNWBool("gravityOff", true)
                    vel.z = vel.z + sv_gravity:GetFloat() * 0.5 * FrameTime()
                end

                -- Pushes the player the wanted direction
                local ang = mv:GetMoveAngles()
                ang.p = 0

                -- Setup move_vel, have it act as our wanted speed (direction player is pressing)
                local move_vel = Vector(0, 0, 0)
                move_vel:Add(ang:Right() * mv:GetSideSpeed())
                move_vel:Add(ang:Forward() * mv:GetForwardSpeed())

                -- Normalize, multipy by max velocity (for server tick?)
                move_vel:Normalize()
                move_vel:Mul(jetpackStrafeSpeed)

                -- -- Take current speed, clamp to max speeds.
                -- -- Pretty sure this is useless right? We're doing this work and then overwriting it 3 lines later
                -- vel.x = math.Clamp(vel.x, -jetpackStrafeSpeed, jetpackStrafeSpeed)
                -- vel.y = math.Clamp(vel.y, -jetpackStrafeSpeed, jetpackStrafeSpeed)
                -- local oldVel = vel

                -- Have it hover properly - and have old vel influence our speed.
                vel.x = (move_vel.x + (jetpackDeleceration * oldVel.x)) / (jetpackDeleceration + 1)
                vel.y = (move_vel.y + (jetpackDeleceration * oldVel.y)) / (jetpackDeleceration + 1)
                vel.z = oldVel.z

                mv:SetVelocity(vel)
                mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_DUCK)))
            elseif status and (weaponId:GetOwner() == ply) and ply:OnGround() then
                weaponId:SetFuel(math.Clamp(weaponId:GetFuel() + fuelRecharge, 0, maxFuel))
                if weaponId:GetFuel() > 0 then weaponId:SetCanFly(true) end
            end
        end
    end)

    hook.Add("PlayerTick", "weapon_think_while_not_equipped", function(ply, mv)
        weaponId = ply:GetWeapon("weapon_jetpack")
        if weaponId ~= NULL and weaponId ~= nil then
            if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then
                if not soundCreated then
                    soundCreated = true
                    jetpacksound = CreateSound(ply, "jetpack.thruster_loop")
                end

                if not weaponId:GetCanFly() then
                    jetpacksound:FadeOut(0.1)
                    return
                end

                if ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_DUCK) or ply:KeyDown(IN_SPEED) then
                    if not ply:OnGround() then jetpacksound:PlayEx(0.2, 125) end
                    return
                end

                jetpacksound:FadeOut(0.1)
            elseif status and not weaponId:GetActive() and (weaponId:GetOwner() == ply) then
                if soundCreated then jetpacksound:FadeOut(0.1) end
            end
        end
    end)

    hook.Add("OnPlayerHitGround", "stop_sound_whenever_player_hits_ground_or_water", function(ply, inwater)
        weaponId = ply:GetWeapon("weapon_jetpack")
        if weaponId ~= NULL and weaponId ~= nil and status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then jetpacksound:FadeOut(0.1) end
    end)

    hook.Add("FinishMove", "stable_hover", function(ply, mv)
        if ply:GetNWBool("gravityOff", false) then
            local vel = mv:GetVelocity()
            vel.z = vel.z + sv_gravity:GetFloat() * 0.5 * FrameTime()
            mv:SetVelocity(vel)
            ply:SetNWBool("gravityOff", false)
            return
        end
    end)

    hook.Add("CalcMainActivity", "override_animations_jetpack", function(ply, vec)
        weaponId = ply:GetWeapon("weapon_jetpack")
        if ply:Alive() and ply:HasWeapon("weapon_jetpack") then
            status, error = pcall(function() weaponId:GetActive() end)
            if status and weaponId:GetActive() and not ply:OnGround() and (ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_DUCK) or ply:KeyDown(IN_SPEED)) then
                local idealact = ACT_INVALID
                if IsValid(ply:GetActiveWeapon()) then
                    idealact = ACT_MP_SWIM
                else
                    idealact = ACT_HL2MP_IDLE + 9
                end
                return idealact, ACT_INVALID
            end
        end
    end)

    hook.Add("UpdateAnimation", "override_animations_jetpackupdate", function(ply, vec)
        weaponId = ply:GetWeapon("weapon_jetpack")
        if ply:Alive() and ply:HasWeapon("weapon_jetpack") then
            status, error = pcall(function() weaponId:GetActive() end)
            if status and weaponId:GetActive() and not ply:OnGround() and (ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_DUCK) or ply:KeyDown(IN_SPEED)) then
                ply:SetPlaybackRate(0)
                return true
            end
        end
    end)

    if SERVER then
        hook.Add("PostPlayerDeath", "detonate_jetpack", function(ply)
            weaponId = ply:GetWeapon("weapon_jetpack")
            if weaponId ~= NULL and weaponId ~= nil then
                if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then
                    local effect = EffectData()
                    effect:SetOrigin(ply:GetPos())
                    effect:SetMagnitude(100)
                    effect:SetFlags(bit.bor(0x80, 0x20))
                    util.Effect("Explosion", effect)
                    if soundCreated then jetpacksound:FadeOut(0.1) end
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
        hook.Add("HUDPaint", "fuel_bar_jetpack_stein", function()
            weaponId = LocalPlayer():GetWeapon("weapon_jetpack")
            if not (weaponId == NULL) and weaponId:GetActive() and (weaponId:GetOwner() == LocalPlayer()) then
                local percent = math.floor(weaponId:GetFuel() / mf * 100)
                DrawRect(col_bg, MSW / 2 - fuelbarwidth / 2, MSH - fuelbarheight * 1.4, fuelbarwidth, fuelbarheight)
                DrawRect(col_fuel, MSW / 2 - fuelbarwidth / 2 + 4, MSH - fuelbarheight * 1.4 + 4, (fuelbarwidth - 8) * percent / 100, fuelbarheight - 8)
            end
        end)
    end
end

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    self:SetNextPrimaryFire(CurTime() + 0.5)
    if self:GetActive() then
        if SERVER then self:SetActive(false) end
    else
        if SERVER then self:SetActive(true) end
    end
end

function SWEP:SecondaryAttack()
end

function PlayerTick(ply, mv)
end

function Move(owner, mv)
end