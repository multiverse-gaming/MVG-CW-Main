
SWEP.PrintName = "Armour Gun"
SWEP.Category						= "MVG"
SWEP.Author = "? | Modified by Fox"
SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false


SWEP.HoldType 						= "shotgun"
SWEP.ReloadHoldTypeOverride 		= "shotgun"
SWEP.ViewModel						= "models/weapons/synbf3/c_dlt19.mdl"
SWEP.WorldModel						= "models/weapons/synbf3/w_dlt19.mdl"


SWEP.ViewModelFOV = 65

SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 3
SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.UseHands = false
SWEP.HoldType = "shotgun"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.Attack = 0
SWEP.AttackTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.Sound = Sound( "WeaponMedigun.Healing" )
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.25

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"


function SWEP:Precache()

	util.PrecacheModel("mmodels/hunter/blocks/cube025x025x025.mdl")

end

function SWEP:Initialize()
    self:SetHoldType("shotgun")
    self.Idle = 0
    self.IdleTimer = CurTime() + 1


    if CLIENT then

        -- THIS IS CONFIG FOR THE FLAMERTANK : WORLD

        local offsetvecWeaponW = Vector( 2, 0, 1 )
        local offsetangWeaponW = Angle(173, 180, 0 )

        if !IsValid(flamerWeapon) then
            flamerWeapon = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl")
            flamerWeapon:SetNoDraw( true )
        end


        hook.Add("PostPlayerDraw", "draw_medigun_kit_world_model", function(ply)

            if (IsValid(ply:GetActiveWeapon())) then

                if not ((ply:GetActiveWeapon():GetClass() == "tf_weapon_medigun" or ply:GetActiveWeapon():GetClass() == "riggs_medi_gun") and ply:Alive() and IsValid(ply)) then
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


function SWEP:DrawHUD()
        if CLIENT then
            local x, y
            if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
                local tr = util.GetPlayerTrace( self.Owner )
                local trace = util.TraceLine( tr )
                local coords = trace.HitPos:ToScreen()
                x, y = coords.x, coords.y
            else
                x, y = ScrW() / 2, ScrH() / 2
            end
        surface.SetTexture( surface.GetTextureID( "sprites/crosshair_4" ) )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )
        end
    end

function SWEP:Deploy()
        self:SetWeaponHoldType( self.HoldType )
        self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Attack = 0
        self.AttackTimer = CurTime()
        self.Idle = 0
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
        return true
    end

function SWEP:Holster()
        self:StopSound( self.Primary.Sound )
        if SERVER and self.Attack == 1 then
            self.Beam:Fire( "kill", "", 0 )
        end
        self.Attack = 0
        self.AttackTimer = CurTime()
        self.Idle = 0
        self.IdleTimer = CurTime()
        return true
    end

function SWEP:PrimaryAttack()
        local tr = util.TraceLine( {
            start = self.Owner:GetShootPos(),
            endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 450,
            filter = self.Owner,
            mask = MASK_SHOT_HULL,} )
        if !IsValid( tr.Entity ) then
            tr = util.TraceHull( {
            start = self.Owner:GetShootPos(),
            endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 450,
            filter = self.Owner,
            mins = Vector( -16, -16, 0 ),
            maxs = Vector( 16, 16, 0 ),
            mask = MASK_SHOT_HULL,} )
        end
        if self.Attack == 0 then
            if ( !( tr.Hit and IsValid( tr.Entity ) and (tr.Entity:IsPlayer()) )) then
                self.Weapon:EmitSound( "WeaponMedigun.NoTarget" )
                self:SetNextPrimaryFire( CurTime() + 0.2 )
                self:SetNextSecondaryFire( CurTime() + 0.2 )
            end
            if tr.Hit and IsValid( tr.Entity ) and (tr.Entity:IsPlayer()) and !(tr.Entity:GetMaxArmor() == 100) then
                if SERVER then
                    print(tr.Entity:GetMaxArmor())
                    local beam = ents.Create( "info_particle_system" )
                    beam:SetKeyValue( "effect_name", "medicgun_beam_blue")
                    beam:SetOwner( self.Owner )
                    local Forward = self.Owner:EyeAngles():Forward()
                    local Right = self.Owner:EyeAngles():Right()
                    local Up = self.Owner:EyeAngles():Up()
                    beam:SetPos( self.Owner:GetShootPos() )
                    beam:SetAngles( self.Owner:EyeAngles() )
                    local beamtarget = ents.Create( "tf_target_medigun" )
                    beamtarget:SetOwner( self.Owner )
                    beamtarget:SetPos( tr.Entity:GetPos() + Vector( 0, 0, 50 ) )
                    beamtarget:Spawn()
                    beam:SetKeyValue( "cpoint1", beamtarget:GetName() )
                    beam:Spawn()
                    beam:Activate()
                    beam:Fire( "start", "", 0 )
                    self.Beam = beam
                    self.BeamTarget = beamtarget
                end
                self:EmitSound( self.Primary.Sound )
                self.Owner:SetAnimation( PLAYER_ATTACK1 )
                self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
                self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
                self.Target = tr.Entity
                self.Attack = 1
                self.AttackTimer = CurTime()
                self.Idle = 0
                self.IdleTimer = CurTime()
            end
        end
    end

function SWEP:SecondaryAttack()
    end

function SWEP:Reload()
    end

function SWEP:Think()
        if IsValid( self.Target ) and self.Attack == 1 and self.AttackTimer <= CurTime() then
            if SERVER then
                local Forward = self.Owner:EyeAngles():Forward()
                local Right = self.Owner:EyeAngles():Right()
                local Up = self.Owner:EyeAngles():Up()
                self.Beam:SetPos( self.Owner:GetShootPos() + Forward * 24 + Right * 8 + Up * -6 )
                self.Beam:SetAngles( self.Owner:EyeAngles() )
                self.BeamTarget:SetPos( self.Target:GetPos() + Vector( 0, 0, 50 ) )

                self.AttackTimer = CurTime() + 0.04
                if(self.Target:Armor() < self.Target:GetMaxArmor()) then
                    self.Target:SetArmor(tonumber(self.Target:Armor() + 5))
                end
            end

        end
        if ( !IsValid( self.Target ) || !self.Owner:KeyDown( IN_ATTACK ) || self:GetPos():Distance(self.Target:GetPos()) > 600 ) and self.Attack == 1 then
            if SERVER then
                self.Beam:Fire( "kill", "", 0 )
                self.BeamTarget:Remove()
            end
            self:StopSound( self.Primary.Sound )
            self.Owner:SetAnimation( PLAYER_ATTACK1 )
            self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
            self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
            self.Attack = 0
            self.AttackTimer = CurTime()
            self.Idle = 0
            self.IdleTimer = CurTime()
        end
        if self.Idle == 0 and self.IdleTimer <= CurTime() then
            if SERVER then
                if self.Attack == 0 then
                    self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
                end
                if self.Attack == 1 then
                    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
                end
            end
        self.Idle = 1
        end
    end
