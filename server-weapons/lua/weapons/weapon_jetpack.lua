AddCSLuaFile()

SWEP.PrintName = "Jetpack"
SWEP.Category = "MVG"
SWEP.Author = "Stein"
SWEP.Instructions = [[
    Press left click to equip the jetpack
    Press right click to remove or add the jetpack model
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
local jetpackStrafeVelocity = 5000

local maxFuel = 100 -- no point in changing this, change drain and recharge
local status = true

local sv_gravity = GetConVar "sv_gravity"
local soundCreated = false

-- SETTINGS YOU CAN CHANGE WITHOUT RUINING THE JETPACK FUNCTIONS
local jetpackStrafeSpeed = 250 -- Higher is faster
local jetpackSpeed = 200 -- Higher is faster
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
    self:NetworkVar("Bool", 2, "Drawmodel")

end

function SWEP:Initialize()

    self:SetFuel(maxFuel)
    self:SetDrawmodel(false)

    hook.Add("SetupMove", "hover_mode", function(ply, mv, cmd)

        weaponId = ply:GetWeapon("weapon_jetpack")

        if weaponId != NULL and weaponId != nil then

            status = pcall(function() weaponId:GetActive() end)

            if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) and weaponId:GetCanFly() and !ply:OnGround() and (ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_SPEED) or ply:KeyDown(IN_DUCK)) then

                if !infiniteFuel then

                    weaponId:SetFuel(math.Clamp(weaponId:GetFuel() - fuelDrain, 0, maxFuel))

                end

                if weaponId:GetFuel() == 0 then

                    weaponId:SetCanFly(false)

                end

                local vel = mv:GetVelocity()

                if mv:KeyDown(IN_JUMP) and vel.z < jetpackSpeed then

                    vel.z = vel.z + jetpackVelocity * FrameTime()

                elseif mv:KeyDown(IN_SPEED) and vel.z < 0 then

                    vel.z = math.Approach( vel.z , 0 , jetpackVelocity * FrameTime() )

                end

                if mv:KeyDown(IN_DUCK) then

                    vel.z = vel.z - jetpackVelocity * FrameTime()

                end

                -- This enables stable hover.

                if vel.z == 0 and mv:KeyDown(IN_SPEED) then

                    ply:SetNWBool("gravityOff", true)

                    vel.z = vel.z + sv_gravity:GetFloat() * 0.5 * FrameTime()

                end

                -- Pushes the player the wanted direction

                local move_vel = Vector(0, 0, 0)

                local ang = mv:GetMoveAngles()
                ang.p = 0

                move_vel:Add(ang:Right() * mv:GetSideSpeed())
                move_vel:Add(ang:Forward() * mv:GetForwardSpeed())

                move_vel:Normalize()
                move_vel:Mul(jetpackStrafeVelocity * FrameTime())

                if vel:Length2D() < jetpackStrafeSpeed then

                    vel:Add(move_vel)

                end

                vel.x = math.Approach(vel.x, 0, FrameTime() * 2.5 * vel.x)
                vel.y = math.Approach(vel.y, 0, FrameTime() * 2.5 * vel.y)

                mv:SetVelocity(vel)

                mv:SetForwardSpeed(0)
                mv:SetSideSpeed(0)
                mv:SetUpSpeed(0)

                mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_DUCK)))

            elseif status and (weaponId:GetOwner() == ply) and ply:OnGround() then

                weaponId:SetFuel(math.Clamp(weaponId:GetFuel() + fuelRecharge, 0, maxFuel))

                if weaponId:GetFuel() > 0 then

                    weaponId:SetCanFly(true)

                end

            end

        end

    end)

    hook.Add("PlayerTick", "weapon_think_while_not_equipped", function(ply, mv)

        weaponId = ply:GetWeapon("weapon_jetpack")

        if weaponId != NULL and weaponId != nil then

            if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then

                if !soundCreated then

                    soundCreated = true

                    jetpacksound = CreateSound(ply, "jetpack.thruster_loop")

                end

                if !weaponId:GetCanFly() then

                    jetpacksound:FadeOut(0.1)
                    return

                end

                if ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_DUCK) or ply:KeyDown(IN_SPEED) then

                    if !ply:OnGround() then

                        jetpacksound:PlayEx(0.2, 125)

                    end

                    return

                end

                jetpacksound:FadeOut(0.1)

            elseif status and !weaponId:GetActive() and (weaponId:GetOwner() == ply) then

                if soundCreated then

                    jetpacksound:FadeOut(0.1)

                end

            end

        end

    end)

    hook.Add("OnPlayerHitGround", "stop_sound_whenever_player_hits_ground_or_water", function(ply, inwater)

        weaponId = ply:GetWeapon("weapon_jetpack")

        if weaponId != NULL and weaponId != nil and status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then

            jetpacksound:FadeOut(0.1)

        end

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

            if status and weaponId:GetActive() and !ply:OnGround() and (ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_DUCK) or ply:KeyDown(IN_SPEED)) then

                local idealact = ACT_INVALID

                if IsValid(ply:GetActiveWeapon())  then

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

            if status and weaponId:GetActive() and !ply:OnGround() and (ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_DUCK) or ply:KeyDown(IN_SPEED)) then

                ply:SetPlaybackRate(0)
                return true

            end

        end

    end)

    if SERVER then

        hook.Add("PostPlayerDeath", "detonate_jetpack", function(ply)

            weaponId = ply:GetWeapon("weapon_jetpack")

            if weaponId != NULL and weaponId != nil then

                if status and weaponId:GetActive() and (weaponId:GetOwner() == ply) then

                    local effect = EffectData()
                    effect:SetOrigin(ply:GetPos())
                    effect:SetMagnitude(100)
                    effect:SetFlags(bit.bor(0x80, 0x20))
                    util.Effect("Explosion", effect)

                    if soundCreated then

                        jetpacksound:FadeOut(0.1)

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

        hook.Add("HUDPaint", "fuel_bar_jetpack_stein", function()

            weaponId = LocalPlayer():GetWeapon("weapon_jetpack")

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

    if !IsFirstTimePredicted() then return end

    self:SetNextSecondaryFire(CurTime() + 0.5)

    if CLIENT then return end

    if self:GetDrawmodel() then

        self:SetDrawmodel(false)

    else

        self:SetDrawmodel(true)

    end

end

function PlayerTick(ply, mv)
end

function Move(owner, mv)
end

if CLIENT then

    local offsetvec = Vector( 3, -5.6, 0 )
    local offsetang = Angle( 0, 90, -90 )

    hook.Add( "PostPlayerDraw" , "draw_jetpack_model" , function( ply )

        if IsValid(ply:GetActiveWeapon()) and ply:HasWeapon("weapon_jetpack") and ply:GetWeapon("weapon_jetpack"):GetDrawmodel() then

            if jetpackModel == nil then

                jetpackModel = ClientsideModel("models/thrusters/jetpack.mdl")
                jetpackModel:SetNoDraw(true)

            end

            local boneid = ply:LookupBone( "ValveBiped.Bip01_Spine2" )

            if !boneid then

                return

            end

            local matrix = ply:GetBoneMatrix( boneid )

            if !matrix then

                return

            end

            local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

            jetpackModel:SetPos( newpos )
            jetpackModel:SetAngles( newang )
            jetpackModel:SetupBones()
            jetpackModel:DrawModel()

        end

    end)


end
