AddCSLuaFile()

SWEP.PrintName = "Flamethrower"
SWEP.Author = "Fox"
SWEP.Instructions = [[
    Left Click - Use flamethrower
    R - Reload
    ]]

SWEP.Category						= "MVG"
SWEP.Base = "weapon_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType 						= "shotgun"
SWEP.ReloadHoldTypeOverride 		= "shotgun"
SWEP.Slot = 4
SWEP.SlotPos = 100

SWEP.ViewModelFOV = 74

SWEP.ViewModel						= "models/weapons/synbf3/c_dlt19.mdl"
SWEP.WorldModel						= "models/weapons/synbf3/w_dlt19.mdl"

SWEP.UseHands = true

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"

-- THIS IS HERE CAUSE WE USE VELEMENTS

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false


--- EXTRA CONFIG ---
local MaxDamageRange = 500    -- This is how far it can reach in damage point_hurt.
local DirectDamage = 10       -- When shot at direct target.


-- POINT HURT DAMAGE --
local PointHurtDamage = 5     -- Fire left from a point hurt.
local PointHurtLastTime = 1   -- How long it should last.
local PointHurtRadius = 80 -- Radius of point hurt
local PointHurtDelay = 1 -- How much delay it is



-- Blacklist NPC's
local BlacklistNPCs = {} -- Just put information like {"npc_gman","..."} etc.






function SWEP:Precache()

	util.PrecacheModel("models/fox/battlefront2/flamethrower.mdl")
    util.PrecacheModel("models/fox/battlefront2/flametank.mdl")

end

function SWEP:Initialize()
    self:SetHoldType("shotgun")
    if SERVER then
        hook.Add("PostPlayerDeath", "remove_hooks_if_dead_and_detonate_flamer", function(ply)
            if (not ply:HasWeapon("weapons_flamethrower") or not IsValid(ply)) then return end
            local effect = EffectData()
            effect:SetOrigin(ply:GetPos())
            effect:SetMagnitude(100)
            effect:SetFlags(bit.bor(0x80, 0x20))
            util.Effect("Explosion", effect)
        end)
    end

    if CLIENT then

        -- THIS IS CONFIG FOR THE FLAMER : WORLD
        
        local offsetvecTank = Vector( -50, 3.7, 0 )
        local offsetangTank = Angle( 0, 90, 90 )
        -- THIS IS CONFIG FOR THE FLAMERTANK : WORLD

        local offsetvecWeaponW = Vector( 2, 0, 1 )
        local offsetangWeaponW = Angle(173, 180, 0 )

        if !IsValid(flamerModel) then
            flamerModel = ClientsideModel("models/fox/battlefront2/flametank.mdl")
            flamerModel:SetNoDraw( true )
        end

        if !IsValid(flamerWeapon) then
            flamerWeapon = ClientsideModel("models/fox/battlefront2/flamethrower.mdl")
            flamerWeapon:SetNoDraw( true )
        end


        hook.Add("PostPlayerDraw", "draw_flamethrower_kit_world_model", function(ply)
            
            if (IsValid(ply:GetActiveWeapon())) then

                if not ((ply:GetActiveWeapon():GetClass() == "weapons_flamethrower") and ply:Alive() and IsValid(ply)) then 
                    return 
                end -- Stop's drawing if not true.

                local boneid = ply:LookupBone( "ValveBiped.Bip01_R_Hand" )

                if not boneid then return end

                local matrix = ply:GetBoneMatrix( boneid )

                if not matrix then return end
                
                local newpos, newang = LocalToWorld( offsetvecWeaponW, offsetangWeaponW, matrix:GetTranslation(), matrix:GetAngles() )

                flamerWeapon:SetPos( newpos )
                flamerWeapon:SetAngles( newang )
                flamerWeapon:SetupBones()
                flamerWeapon:DrawModel()

                local boneid = ply:LookupBone( "ValveBiped.Bip01_Spine2" )

                if not boneid then return end

                local matrix = ply:GetBoneMatrix( boneid )

                if not matrix then return end

                local newpos, newang = LocalToWorld( offsetvecTank, offsetangTank, matrix:GetTranslation(), matrix:GetAngles() )
                    flamerModel:SetPos( newpos )
                    flamerModel:SetAngles( newang )
                    flamerModel:SetupBones()
                    flamerModel:DrawModel()

            end
        end)
    end

end

function SWEP:PostDrawViewModel(viewmodel, weapon, ply)



        local boneid = viewmodel:LookupBone( "ValveBiped.Bip01_R_Hand" )

        if not boneid then return end

        local matrix = viewmodel:GetBoneMatrix( boneid )

        if not matrix then return end
        
        local newpos, newang = LocalToWorld( Vector( 6, -2, 1 ), Angle(175, 178, -10 ), matrix:GetTranslation(), matrix:GetAngles() )

        flamerWeapon:SetPos( newpos )
        flamerWeapon:SetAngles( newang )
        flamerWeapon:SetupBones()
        flamerWeapon:DrawModel()
        
end




function SWEP:PrimaryAttack()

    if (SERVER) then 
        if (self:Clip1() < 1) then return end -- VALIDATION 

        local ammoCurrent = self:Clip1()

        self:SetClip1(ammoCurrent - 1 )
    
        self.Owner:MuzzleFlash()
        
        self.Weapon:SetNextPrimaryFire( CurTime() + 0.04 )

        -- END OF REMOVING AMMO AND RPM thing
        local trace = self.Owner:GetEyeTrace()
        local Distance = self.Owner:GetPos():Distance(trace.HitPos)
        if not (self.Owner:WaterLevel() <= 1) then return end -- Stops from using flamer in water
        if SERVER then
            local flamefx = EffectData()
            flamefx:SetOrigin(trace.HitPos)
            flamefx:SetStart(self.Owner:GetShootPos())
            flamefx:SetAttachment(1)
            flamefx:SetEntity(self.Weapon)
            util.Effect("flame_thrower_fire",flamefx, true, true)
        end
        if Distance < MaxDamageRange then

            --This is how we ignite stuff
                    
                --Safeguard
                if !self:IsValid() then return end
                
                --Damage things in radius of impact
                --[[
                local flame = ents.Create("point_hurt")
                flame:SetPos(trace.HitPos)
                if flame:WaterLevel() == 3 then return end
                flame:SetOwner(self.Owner)
                flame:SetKeyValue("DamageRadius",PointHurtRadius)
                flame:SetKeyValue("Damage",0)
                flame:SetKeyValue("DamageDelay",PointHurtDelay)
                flame:SetKeyValue("DamageType",8)
                flame:Spawn()
                flame:Fire("TurnOn","",0) 
                flame:Fire("kill","",PointHurtLastTime)
                ]]
                for i, v in pairs (ents.FindInSphere(trace.HitPos,PointHurtRadius)) do
                    if v:IsValid() then
                        local damageinfo = DamageInfo()
                        damageinfo:SetDamage( PointHurtDamage )
                        damageinfo:SetAttacker( self.Owner )
                        damageinfo:SetDamageType( DMG_BURN ) 

                        v:TakeDamageInfo( damageinfo )
                    end
                end
                
                if trace.Entity:IsValid() then
                    if trace.Entity:IsPlayer() then
                        if trace.Entity:GetPhysicsObject():IsValid() then
                            trace.Entity:Ignite(math.random(1,2), 100) 
                        end 
                    elseif trace.Entity:IsNPC() then
                        if trace.Entity:GetPhysicsObject():IsValid() then
                            trace.Entity:Fire("Ignite","",1)
                            trace.Entity:Ignite(math.random(12,16), 100) 
                        end 
                    elseif trace.Entity:GetPhysicsObject():IsValid() then
                        if !trace.Entity:IsOnFire() then 
                            trace.Entity:Ignite(math.random(16,32), 100) 
                        end 
                    else
                        -- I don't think this will ever happen..
                    end
                end
            end


            
    end

end


        

function SWEP:SecondaryAttack()

end
