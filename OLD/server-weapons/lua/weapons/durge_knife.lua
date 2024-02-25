if (SERVER) then

	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "Durge's Vibro Knife"
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.UseHands			= true
	
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	--SWEP.IconLetter			= "j"

	--killicon.AddFont("weapon_knife", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
	--surface.CreateFont("CSKillIcons", {font = "csd", size = ScreenScale(30), weight = 500, antialias = true, additive = true})
	--surface.CreateFont("CSSelectIcons", {font = "csd", size = ScreenScale(60), weight = 500, antialias = true, additive = true})
end

SWEP.Base = "baseknife"

SWEP.Category			= "Vibro Knives"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel 			= "models/weapons/501st_knife/501st_knife_t.mdl"
SWEP.WorldModel 		= "models/weapons/501st_knife/501st_knife_v.mdl" 

SWEP.DrawWeaponInfoBox  	= false

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false


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
            Damage = (Altfire and 200) or 100

            local damageinfo = DamageInfo()
            damageinfo:SetAttacker( Attacker )
            damageinfo:SetInflictor( self )
            damageinfo:SetDamage( Damage )
            damageinfo:SetDamageType( bit.bor( DMG_BULLET , DMG_NEVERGIB ) )
            --damageinfo:SetDamageForce( Forward * 1000 )
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
