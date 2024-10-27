AddCSLuaFile()

if ( SERVER ) then

	SWEP.Weight				= 5
	SWEP.AutoSwitchTo			= false
	SWEP.AutoSwitchFrom		= false

    CreateConVar("cod_knives_sounds", "0", bit.bor(FCVAR_NONE), "Play old sounds when swinging knife or hitting wall")
end

if ( CLIENT ) then
	SWEP.PrintName          = "Huntersbase"
	SWEP.DrawAmmo           = false
	SWEP.DrawCrosshair      = true
	SWEP.ViewModelFOV       = 65
	SWEP.ViewModelFlip      = false
	SWEP.CSMuzzleFlashes    = true
	SWEP.UseHands           = true
end

SWEP.Category			= "[MVG] Vibro Knives"
SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

-- SWEP.ViewModel 			= "models/weapons/base_knife/base_knife_t.mdl"
-- SWEP.WorldModel 			= "models/weapons/base_knife/base_knife_v.mdl"

SWEP.DrawWeaponInfoBox  	= false

SWEP.Weight					= 5
SWEP.AutoSwitchTo				= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.ClipSize			= -1
SWEP.Primary.Damage			    = -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo			    ="none"


SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Damage			= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			    ="none"


function SWEP:SetupDataTables() --This also used for variable declaration and SetVar/GetVar getting work
    self:NetworkVar( "Float", 0, "InspectTime" )
    self:NetworkVar( "Float", 1, "IdleTime" )
    self:NetworkVar( "String", 0, "Classname" ) --Do we need this?
    self:NetworkVar( "Bool", 0, "Thrown" )
    -- self:NetworkVar( "Entity", 0, "Attacker" ) --Do we need this?
    -- self:NetworkVar( "Entity", 1, "Victim" ) --Do we need this?
    self:NetworkVar( "Entity", 2, "ViewModel" )
end



function SWEP:Initialize()
	if ( CLIENT ) then surface.SetMaterial(Material( self.Skin or "models/csgo_knife/cssource" )) end --Ugly hack. Used to "precache" skin's material
    self:SetClassname(self:GetClass())
	self:SetHoldType( self.AreDaggers and "fist" or "knife" ) -- Avoid using SetWeaponHoldType! Otherwise the players could hold it wrong!
    timer.Simple(1.5, function()
        -- Capture default speeds and save them to the knife.
        self.Owner.DefaultRunSpeed = self.Owner:GetRunSpeed()
        self.Owner.DefaultWalkSpeed = self.Owner:GetWalkSpeed()
    end)
end



function SWEP:ViewModelDrawn(ViewModel)
    self:SetViewModel(ViewModel) -- Stores viewmodel's entity into NetworkVar, NOT actually changes viewmodel. Do we need this?
    self:PaintMaterial(ViewModel)
end



--function SWEP:PostDrawViewModel( vm, ply, weapon )
--    if ( CLIENT ) and IsValid(vm) then vm:SetMaterial() end
--end



function SWEP:PaintMaterial(vm)
    if ( CLIENT ) and IsValid(vm) then
            local Mat = self:GetThrown() and "" or ( self.Skin or "" )
			if IsValid(vm) and vm:GetModel() == self.ViewModel then vm:SetMaterial(Mat) end
	end
end



function SWEP:ClearMaterial()
    if IsValid(self:GetOwner()) then
		local Viewmodel = self:GetOwner():GetViewModel()
		if IsValid(Viewmodel) then Viewmodel:SetMaterial("") end
	end
end



function SWEP:Think()
	if CurTime()>=self:GetIdleTime() then
    	self:SendWeaponAnim( ACT_VM_IDLE )
    	self:SetIdleTime( CurTime() + self:GetOwner():GetViewModel():SequenceDuration() )
	end
end



function SWEP:DrawWorldModel()
	self:SetMaterial(self.Skin or "")
	self:DrawModel()
end

function SWEP:NormalSpeed() -- Resets the speed
    if self.Owner:IsValid() then
        if (self.Owner.OBRunSpeed != nil) then
            self.Owner.OBRunSpeed = self.Owner.DefaultRunSpeed
            self.Owner.OBWalkSpeed = self.Owner.DefaultWalkSpeed
            self.Owner:SetRunSpeed(self.Owner:GetRunSpeed() - 20)
            self.Owner:SetWalkSpeed(math.max(self.Owner:GetWalkSpeed() - 20, self.Owner.DefaultWalkSpeed))
        else
            self.Owner:SetRunSpeed(self.Owner.DefaultRunSpeed)
            self.Owner:SetWalkSpeed(self.Owner.DefaultWalkSpeed)
        end
    end
end

function SWEP:CustomSpeed() -- New speed
    if self.Owner:IsValid() then
        if (self.Owner.OBRunSpeed != nil) then
            self.Owner.OBRunSpeed = self.Owner.DefaultRunSpeed + 20
            self.Owner.OBWalkSpeed = self.Owner.DefaultWalkSpeed + 20
            self.Owner:SetRunSpeed(self.Owner:GetRunSpeed() + 20)
            self.Owner:SetWalkSpeed(math.max(self.Owner:GetWalkSpeed() + 20, self.Owner.DefaultWalkSpeed + 20))
        else
            self.Owner:SetRunSpeed(self.Owner.DefaultRunSpeed + 20)
            self.Owner:SetWalkSpeed(self.Owner.DefaultWalkSpeed + 20)
        end
    end
end

function SWEP:Deploy()
    self:SetInspectTime( 0 )
	self:SetIdleTime( CurTime() + self:GetOwner():GetViewModel():SequenceDuration() )
	self:SendWeaponAnim( ACT_VM_DRAW )
    local NextAttack = 1
	self:SetNextPrimaryFire( CurTime() + NextAttack )
	self:SetNextSecondaryFire( CurTime() + NextAttack )
	self:EmitSound( "weapons/knife/ghost/knife_deploy1.wav" )
	if self.Owner:IsValid() then
        self:CustomSpeed() -- call the custom speed funciton above
    end
	return true
end



function SWEP:EntityFaceBack(ent)
	local angle = self:GetOwner():GetAngles().y -ent:GetAngles().y
	if angle < -180 then angle = 360 +angle end
	if angle <= 90 and angle >= -90 then return true end
	return false
end



function SWEP:PrimaryAttack()
    if CurTime() < self:GetNextPrimaryFire() then return end
    if self:GetOwner():GetNWBool("CloakPlayerCloaked", false) then self:GetOwner():SetNWBool("CloakPlayerCloaked", false) self:GetOwner():SetNWBool("CloakPlayerCloakAttack", true) end
    self:DoAttack( false )
end



function SWEP:SecondaryAttack()
    if CurTime() < self:GetNextSecondaryFire() then return end
    self:DoAttack( true )
end



function SWEP:DoAttack( Altfire )
    local Weapon    = self
    local Attacker  = self:GetOwner()
    local Range     = Altfire and 48 or 64
    local Forward 	= Attacker:GetAimVector()
	local AttackSrc = Attacker:EyePos()
	local AttackEnd = AttackSrc + Forward * Range
    local Act
    local Snd
    local Backstab
    local Damage

    if Attacker:GetNWBool("CloakPlayerCloaked", false) then Attacker:SetNWBool("CloakPlayerCloakAttack", true) end


    Attacker:LagCompensation(true)

    local tracedata = {}

	tracedata.start     = AttackSrc
	tracedata.endpos    = AttackEnd
	tracedata.filter    = Attacker
    tracedata.mask      = MASK_SOLID
    tracedata.mins      = Vector( -16 , -16 , -18 )
    tracedata.maxs      = Vector( 16, 16 , 18 )

    -- We should calculate trajectory twice. If TraceHull hits entity, then we use second trace, otherwise - first.
    -- It's needed to prevent head-shooting since in CS:GO you cannot headshot with knife
    local tr1 = util.TraceLine( tracedata )
    local tr2 = util.TraceHull( tracedata )
    local tr = IsValid(tr2.Entity) and tr2 or tr1

    Attacker:LagCompensation(false) -- Don't forget to disable it!

    local DidHit            = tr.Hit and not tr.HitSky
    -- local trHitPos          = tr.HitPos -- Unused
    local HitEntity         = tr.Entity
    local DidHitPlrOrNPC    = HitEntity and ( HitEntity:IsPlayer() or HitEntity:IsNPC() ) and IsValid( HitEntity )

    -- Calculate damage and deal hurt if we can
    if DidHit then
        if HitEntity and IsValid( HitEntity ) then
            Backstab = DidHitPlrOrNPC and self:EntityFaceBack( HitEntity ) -- Because we can only backstab creatures
            Damage = (Altfire and 200) or 50

            local damageinfo = DamageInfo()
            damageinfo:SetAttacker( Attacker )
            damageinfo:SetInflictor( self )
            damageinfo:SetDamage( Damage )
            damageinfo:SetDamageType( bit.bor( DMG_BULLET , DMG_NEVERGIB ) )
            damageinfo:SetDamageForce( Forward * 10 )
            damageinfo:SetDamagePosition( AttackEnd )
            HitEntity:DispatchTraceAttack( damageinfo, tr, Forward )

        else
            util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
            -- Old bullet's mechanic. Caused an one hilarious bug. Left for history.

            --local Dir = ( trHitPos - AttackSrc )
            --local Bulletinfo = {}
            --Bulletinfo.Attacker = Attacker
            --Bulletinfo.Num      = 1
            --Bulletinfo.Damage   = 0
            --Bulletinfo.Distance = Range
            --Bulletinfo.Force    = 10
            --Bulletinfo.Tracer   = 0
            --Bulletinfo.Dir      = Dir
            --Bulletinfo.Src      = AttackSrc
            --self:FireBullets( Bulletinfo )
        end
    end

    --Change next attack time
    local NextAttack = Altfire and 1.0 or DidHit and 0.5 or 0.4
    Weapon:SetNextPrimaryFire( CurTime() + NextAttack )
	Weapon:SetNextSecondaryFire( CurTime() + NextAttack )

    --Send animation to attacker
    Attacker:SetAnimation( PLAYER_ATTACK1 )

    --Анимация для viewmodel
    Act = DidHit and ( Altfire and ( Backstab and ACT_VM_HITCENTER or ACT_VM_HITCENTER2 ) or ( Backstab and ACT_VM_HITCENTER or ACT_VM_HITCENTER) ) or ( Altfire and ACT_VM_MISSCENTER or ACT_VM_HITCENTER)
    if Act then
        Weapon:SendWeaponAnim( Act )
        self:SetIdleTime( CurTime() + self:GetOwner():GetViewModel():SequenceDuration() )
    end

    --Звуки
    local CODsounds
    if GetConVar("cod_knives_sounds") then CODsounds = GetConVar("cod_knives_sounds"):GetBool() else CODsounds = false end
    local StabSnd    = "weapons/knife/ghost/knife_stab.wav"
    local HitSnd     = "weapons/knife/ghost/knife_hit"..math.random(1,2,3,4)..".wav", 100, 100
    local HitwallSnd = "weapons/knife/ghost/knife_hitwall1.wav"
    local SlashSnd   = "weapons/knife/ghost/knife_slash"..math.random(1,2)..".wav"
    Snd = DidHitPlrOrNPC and (Altfire and StabSnd or HitSnd) or DidHit and HitwallSnd or SlashSnd
    if Snd then Weapon:EmitSound( Snd ) end

    return true
end



function SWEP:Reload() -- Анимация осмотра оружия

	local getseq = self:GetSequence()
	local act = self:GetSequenceActivity(getseq) --GetActivity() method doesn't work :\
	if (act == ACT_VM_IDLE_LOWERED and CurTime() < self:GetInspectTime()) then
        self:SetInspectTime( CurTime() + 0.1 ) -- We should press R repeately instead of holding it to loop
        return end

	self:SendWeaponAnim(ACT_VM_IDLE_LOWERED)
	self:SetIdleTime( CurTime() + self:GetOwner():GetViewModel():SequenceDuration() )
    self:SetInspectTime( CurTime() + 0.1 )
	return true
end

SWEP.FirstTime = true
function SWEP:Equip()
    if (self.FirstTime) then
        -- Capture default speeds and save them to the knife.
        self.Owner.DefaultRunSpeed = self.Owner:GetRunSpeed()
        self.Owner.DefaultWalkSpeed = self.Owner:GetWalkSpeed()
        self.FirstTime = false
    end
    self:SetThrown(false)
    if self.Owner:IsValid() then
    self:CustomSpeed() -- call the custom speed funciton above
end
end

function SWEP:OwnerChanged()
    self:ClearMaterial()
	return true
end

function SWEP:OnRemove()
    self:ClearMaterial()
	return true
end

function SWEP:OnDrop()
    self:Remove()
end

function SWEP:Holster()
        self:ClearMaterial()
        if self.Owner:IsValid() then
        self:NormalSpeed() -- call the normal speed function above
        end
        return true
end