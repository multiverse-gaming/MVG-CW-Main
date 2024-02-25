local IsValid = IsValid

AddCSLuaFile()

ENT.Type             = "anim"
ENT.Base             = "base_anim"
ENT.PrintName        = "NPC Mannable Emplacement"
ENT.Author            = "Zach88889+StrawWagen"
ENT.Information        = ""
ENT.Category        = "Emplacements"
resource.AddFile( "materials/vgui/entities/npc_manned_emplacement.vtf" )

ENT.Spawnable        = true
ENT.AdminOnly        = false

sound.Add( {
    name = "MountedTurret.Reload",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = { 90 },
    sound = { "weapons/ar2/npc_ar2_reload.wav" }
} )
sound.Add( {
    name = "MountedTurret.Initialize",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = { 80 },
    sound = { "weapons/ar2/ar2_reload.wav" }
} )
sound.Add( {
    name = "MountedTurret.ReloadFin",
    channel = 6,
    volume = 1.0,
    level = 73,
    pitch = { 150 },
    sound = { "weapons/shotgun/shotgun_empty.wav" }
} )

CreateConVar( "npcmannedemplacement_clipdecay", 120, FCVAR_ARCHIVE, "Change how fast the NPC MANNABLE EMPLACEMENT clips decay, default 120" )
CreateConVar( "npcmannedemplacement_damage", 10, FCVAR_ARCHIVE, "Change how much damage the NPC MANNABLE EMPLACEMENT does, default 10" )

local function EnabledAi()
    return GetConVar( "ai_disabled" ):GetInt() == 0
end
function ENT:SpawnFunction( ply, tr )
    if not tr.Hit then return end
    local clamped = false
    local correctModel = tr.Entity:GetModel() == "models/props_combine/combine_barricade_short01a.mdl"
    if not IsValid( tr.Entity ) or not correctModel then
        local ent = ents.Create( "prop_physics" )
        ent:SetModel( "models/props_combine/combine_barricade_short01a.mdl" )
        ent:SetPos( tr.HitPos + Vector( 0, 0, 43 ) )
        ent:SetAngles( Angle( 0, math.NormalizeAngle( ply:EyeAngles().yaw ), 0 ) )
        ent:Spawn()
        if IsValid( ent:GetPhysicsObject() ) then
            ent:GetPhysicsObject():EnableMotion( false )
        end
        tr.Entity = ent
        clamped = true
    end
    local clamp = tr.Entity
    local Turr = ents.Create( "npc_manned_emplacement" )
    Turr:Spawn()
    Turr:Activate()
    Turr:AttachToBarricade( clamp )
    return clamped and clamp or Turr
end

function ENT:AttachToBarricade( Barricade )
    if not IsValid( Barricade ) then return end
    local CorrectModel = Barricade:GetModel() == "models/props_combine/combine_barricade_short01a.mdl"
    if not CorrectModel then return end
    local PosOffsetted = Barricade:GetPos() + Barricade:GetForward() * -2 + Barricade:GetUp() * 9 + Barricade:GetRight() * 0
    self:SetPos( PosOffsetted )
    self:SetAngles( Barricade:GetAngles() )
    self:SetParent( Barricade )
end

if not SERVER then return end

local function IsAlreadyManning( ent )
    if not IsValid( ent ) then return false end
    if ent.OnEmplacementBlacklist then return false end
    if IsValid( ent.EmplacementCurrent ) then return true end
    return ( ent:IsCurrentSchedule( SCHED_FORCED_GO_RUN ) and ent.WasRunningToEmplacement ) or ent:GetNPCState() == NPC_STATE_SCRIPT
end

local function ThisCanManTurret( self, turret )
    if not ( IsValid( self ) and IsValid( turret ) ) then return false end
    if self.OnEmplacementBlacklist then return false end
    if self:GetPos():Distance( turret:GetPos() ) > turret.MaxAcquireDist then return false end
    if IsAlreadyManning( self ) then return false end
    local Enemy = self:GetEnemy()
    local HasEnemy = IsValid( Enemy )
    local TurrCanShootEnemy = false
    if HasEnemy then
        local MuzzleTach = turret:LookupAttachment( "muzzle" )
        local Attachment = turret:GetAttachment( MuzzleTach )
        local TurrVisible = Enemy:VisibleVec( Attachment.Pos )
        local EnemyFar = Enemy:GetPos():Distance( turret:GetPos() ) > ( turret.MaxAcquireDist * 1.75 )
        local Shootable = turret:EmplacementCanShoot( turret:EntShootPos( Enemy ) ) and self:Visible( Enemy ) and TurrVisible
        TurrCanShootEnemy = Shootable or EnemyFar
    end
    local CanMan = ( not HasEnemy ) or ( HasEnemy and TurrCanShootEnemy )
    return CanMan
end

local function SetupTimers( self )
    self.NextFire = 0
    self.NextRandomAim = 0
    self.NextNpcSearch = 0
    self.NextBigThink = 0
    self.NextSmallThink = 0

    self.NextSpottedSentence = 0
    self.NextAcquireSentence = 0
    self.NextMannedSentence = 0
    self.NextIdleSentence = 0
    self.NextDismountSentence = 0
    self.NextLowAmmoSentence = 0
    self.NextDoneReloadSentence = 0
end

local function NpcLikes( Npc1, Npc2 )
    if not IsValid( Npc1 ) and IsValid( Npc2 ) then return false end
    if not Npc1:IsNPC() and Npc2:IsNPC() then return false end
    if Npc1:Disposition( Npc2 ) == D_LI then return true end
    return false
end

function ENT:GetEmplacementStandPos()
    if not IsValid( self ) then return end
    local Pos = self:GetPos() + self:GetForward() * -40 + self:GetUp() * -35 + self:GetRight() * 0
    --debugoverlay.Cross( Pos, 10, 1, Color( 255,255,255 ), true )
    return Pos
end

function ENT:GetHeadingToPos( Pos )
    if not IsValid( self ) then return end
    local LocPos = self:WorldToLocal( Pos )
    local Bearing = 180 / math.pi * math.atan2( LocPos.y, LocPos.x )
    local len = LocPos:Length()
    local Elevation = 180 / math.pi * math.asin( LocPos.z / len )

    return Bearing, Elevation

end

function ENT:OnDuplicated()
    local Res = util.QuickTrace( self:GetPos(), -self:GetUp(), self )
    self:AttachToBarricade( Res.Entity )
    SetupTimers( self )
end

function ENT:Initialize()
    self:SetModel( "models/props_combine/bunker_gun01.mdl" )
    self:SetNoDraw( false )
    self:DrawShadow( true )
    self:SetTrigger( true )
    --self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType( MOVETYPE_NONE )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    self:SetUseType( SIMPLE_USE )
    self:SetPoseParameter( "aim_yaw", 0 )
    self:SetPoseParameter( "aim_pitch", 0 )
    self:ResetSequence( "idle_inactive" )
    self.MaxAmmo = 150
    self.TurretClip = self.MaxAmmo
    self.ReloadTime = 3
    self.FreeGun = true
    self.EmplaceManned = false
    self.EmplaceActive = false
    self.LocAng = Angle( 0, 0, 0 )
    self.LocAngVel = Angle( 0, 0, 0 )

    self.EmplUser = nil
    self.ManningDist = 20
    self.MaxAcquireDist = 1000

    duplicator.Allow( "npc_manned_emplacement" )

    SetupTimers( self )

    local MinBear, MaxBear = self:GetPoseParameterRange( 0 )
    local MinElev, MaxElev = self:GetPoseParameterRange( 1 )
    self.MinBearing = MinBear
    self.MaxBearing = MaxBear
    self.MinElevation = MinElev
    self.MaxElevation = MaxElev

end

function ENT:PutNpcInCorrectPos( NPC )
    if not IsValid( NPC ) then return end
    NPC:SetPos( self:GetEmplacementStandPos() )

end

local function EmitMountSound( self )
    if not IsValid( self ) then return end
    self:EmitSound( "Func_Tank.BeginUse" )
    self:EmitSound( "MountedTurret.Initialize" )

end

local function EmplacementIsFree( self )
    if self.EmplaceActive then return false end
    return true

end

function ENT:PlyEnterEmplacement( Ply )
    if not IsValid( self ) or not IsValid( Ply ) then return end
    if not EmplacementIsFree( self ) then return end
    if IsValid( self.EmplUser ) then
        self:ExitEmplacement( self.EmplUser )
        self:EmplClear()
    end
    net.Start( "TurretBlockAttackToggle" )
    net.WriteBit( true )
    net.Send( Ply )
    Ply.StrawMannedEmplacementCurrent = self
    Ply:DrawViewModel( false )
    Ply.EmplEquipWeapon = Ply:GetActiveWeapon()
    self.FreeGun = false
    self.EmplUser = Ply
    self.EmplaceManned = true
    self.HistoricUse = true -- used for disconnect in think
    local seq, dur = self:LookupSequence( "retract" )
    self:ResetSequence( seq )
    timer.Simple( dur, function()
        if not IsValid( self ) or not IsValid( self.EmplUser ) then return end
        self.EmplaceActive = true
    end )

    EmitMountSound( self )
end

function ENT:PlyExitEmplacement( Ply )
    if IsValid( Ply ) then
        net.Start( "TurretBlockAttackToggle" )
        net.WriteBit( false )
        net.Send( Ply )
        Ply:DrawViewModel( true )
        Ply.StrawMannedEmplacementCurrent = nil
    end
    if IsValid( self ) then
        self.HistoricUse = false
        self.FreeGun = true
        self.EmplUser = nil
        self.ExitedEmplacement = true
        self.EmplaceActive = false
        self.EmplaceManned = false
    end
end

function ENT:EnterEmplacement( NPC )
    if not IsValid( self ) or not IsValid( NPC ) then return end
    NPC:UseFuncTankBehavior()
    self:PutNpcInCorrectPos( NPC )
    local seq, dur = self:LookupSequence( "retract" )
    self:ResetSequence( seq )
    self.EmplaceManned = true
    timer.Simple( dur, function()
        if not IsValid( self ) or not IsValid( self.EmplUser ) then return end
        self.EmplaceActive = true
    end )
    EmitMountSound( self )
end

function ENT:ExitEmplacement( NPC )
    NPC.EmplacementCurrent = nil
    self.ExitedEmplacement = true
    self.EmplaceActive = false
    self.EmplaceManned = false
    NPC:ExitScriptedSequence()
    NPC:SetNPCState( NPC_STATE_ALERT )
    NPC:ClearCondition( 67 )
    NPC:SetCondition( 68 )
    if IsValid( NPC:GetActiveWeapon() ) then
        NPC:GetActiveWeapon():SetNoDraw( false )
    end
end

function ENT:EmplAssignNpc( NPC )
    local IsNpc = NPC:IsNPC()
    if IsNpc and not IsValid( self.EmplUser ) then
        NPC.EmplacementCurrent = self
        NPC.IncorrectSequenceCount = 20
        self.EmplUser = NPC
        self:EnterEmplacement( NPC )
        self.EnteredEmplacement = true
        self.FreeGun = false -- no longer acquire new npcs
    end
end

function ENT:EmplClear()
    self.FreeGun = true
    self.EmplaceActive = false
    self.EmplaceManned = false
    self.EmplUser = nil
    self.NpcToManTheTurret = nil
    self:ResetSequence( "idle_inactive" )
end

local function InRange( value, min, max )
    if value < min then return false end
    if value > max then return false end
    return true
end

function ENT:Use( activator )
    if IsValid( activator ) and not self.IsDead then
        if not activator.StrawMannedEmplacementCurrent then
            self:PlyEnterEmplacement( activator )
        elseif self == activator.StrawMannedEmplacementCurrent then
            self:PlyExitEmplacement( activator )
        end
    end
end

function ENT:EmplacementCanShoot( Pos )
    if not IsValid( self ) then return end
    local Bearing, Elevation = self:GetHeadingToPos( Pos )
    local MinBear, MaxBear = self:GetPoseParameterRange( 0 )
    local MinElev, MaxElev = self:GetPoseParameterRange( 1 )

    local InBearingRange = InRange( Bearing, MinBear, MaxBear )
    local InElevRange = InRange( Elevation, MinElev, MaxElev )

    return InBearingRange and InElevRange

end

function ENT:Think()
    self:NextThink( CurTime() + engine.TickInterval() )
    if not self.IsDead then
        local UserIsNpc = false
        local UserIsPly = false
        if not IsValid( self.EmplUser ) and self.NextNpcSearch < CurTime() then
            self.NextNpcSearch = CurTime() + math.Rand( 0.9, 1.1 )
            self:SearchForPersonToManIt()
            --print( self.EmplUser )
        end
        if IsValid( self.EmplUser ) then -- do this isvalid twice cuz a user may have been found
            UserIsNpc = self.EmplUser:IsNPC()
            UserIsPly = self.EmplUser:IsPlayer()
        end

        if self.UserWasNpc and UserIsPly then
            self.UserWasNpc = false
        end

        if UserIsNpc or self.UserWasNpc then

            local StandPos = self:GetEmplacementStandPos()
            local DistToEmpl = 0
            local IncapableOfManning = false
            local DeadNpc = not IsValid( self.EmplUser )
            if not DeadNpc then
                DeadNpc = self.EmplUser:Health() <= 0
                DistToEmpl = self.EmplUser:GetPos():Distance( StandPos )
                IncapableOfManning = self.EmplUser.IncorrectSequenceCount <= 0
            end

            if self.NextBigThink < CurTime() then
                self.NextBigThink = CurTime() + 0.5

                if ( DeadNpc or DistToEmpl > 1000 or IncapableOfManning ) and self.FreeGun == false then
                    if IncapableOfManning and IsValid( self.EmplUser ) then
                        EmplBlacklist( self.EmplUser )
                    end
                    self:EmplClear()
                    self.UserWasNpc = false
                elseif not DeadNpc then

                    self.UserWasNpc = true
                    local Enemy = self.EmplUser:GetEnemy()
                    local ValidEnemy = IsValid( Enemy )
                    local CanShootEnemy = false
                    if ValidEnemy then
                        EnemyPos = self:EntShootPos( Enemy )
                        CanShootEnemy = self:EmplacementCanShoot( Enemy:GetPos() )
                    end
                    local CorrectSequence = self.EmplUser:GetSequenceName( self.EmplUser:GetSequence() ) == "Man_Gun"
                    local GoodEnemy = ValidEnemy and CanShootEnemy
                    local CanEnterEmplacement = GoodEnemy or not ValidEnemy

                    if CorrectSequence and DistToEmpl < self.ManningDist then
                        self.EmplUser.IncorrectSequenceCount = math.Clamp( self.EmplUser.IncorrectSequenceCount + 1, 0, 40 )
                    elseif not CorrectSequence and DistToEmpl < self.ManningDist then
                        self.EmplUser.IncorrectSequenceCount = math.Clamp( self.EmplUser.IncorrectSequenceCount + -1, 0, 40 )
                    end

                    self:LookForEnemies(self.EmplUser)

                    if DistToEmpl <= self.ManningDist and CanEnterEmplacement then
                        self.EmplUser:SetNPCState( NPC_STATE_SCRIPT )
                        -- re-mann
                        if not self.EmplaceManned then
                            self:EnterEmplacement( self.EmplUser )
                        end
                        -- angle reset
                        if self.EmplUser:GetNPCState() == NPC_STATE_SCRIPT and self.EmplUser:GetLocalAngles().y ~= self:GetAngles().y then
                            local resetang = self.EmplUser:GetAngles()
                            resetang.y = self:GetAngles().y
                            self.EmplUser:SetAngles(resetang)
                            self.EmplUser:SetSequence( "Man_Gun" )
                        end

                        if DistToEmpl > 10 then 
                            self:PutNpcInCorrectPos( self.EmplUser )
                        end

                        self.EmplUser:SetSchedule(SCHED_COMBAT_FACE)
                        self.EmplUser:ClearCondition(68)
                        self.EmplUser:SetCondition(67)

                        if self.EmplUser:GetActiveWeapon() ~= NULL then
                            self.EmplUser:GetActiveWeapon():SetNoDraw(true)
                        end

                        self.EmplUser:SetSequence( "Man_Gun" )
                    end

                    local InDanger = sound.GetLoudestSoundHint( 8, self.EmplUser:GetPos() )

                    --flee the emplacement
                    if InDanger and self.EmplUser:GetNPCState() == NPC_STATE_SCRIPT and DistToEmpl <= self.ManningDist then
                        self:ExitEmplacement( self.EmplUser )
                        self.EmplUser:SetSchedule( SCHED_TAKE_COVER_FROM_BEST_SOUND )
                        --print( "Flee" )
                    end

                    -- get out of the emplacement
                    if not CanShootEnemy and self.EmplUser:GetActiveWeapon() ~= NULL and DistToEmpl <= self.ManningDist and IsValid(self.EmplUser) and IsValid(Enemy) and self.EmplUser:GetNPCState() == NPC_STATE_SCRIPT then
                        self:ExitEmplacement( self.EmplUser )
                        --print( "badang" )
                    end

                    -- return to the emplacement
                    if not InDanger and DistToEmpl > self.ManningDist and IsValid(self.EmplUser) and CanEnterEmplacement and !self.EmplUser:IsCurrentSchedule(SCHED_FORCED_GO_RUN) and self.EmplUser:GetNPCState() ~= NPC_STATE_SCRIPT then
                        self.EmplUser:SetLastPosition( StandPos )
                        self.EmplUser:SetSchedule( SCHED_FORCED_GO_RUN )
                        --print( "return" )
                    end

                    -- got too far away from the emplacement
                    if DistToEmpl > self.ManningDist and IsValid(self.EmplUser) and self.EmplUser:GetNPCState() == NPC_STATE_SCRIPT then
                        self:ExitEmplacement( self.EmplUser )
                        --print( "far" )
                    elseif DistToEmpl > self.ManningDist or not IsValid(self.EmplUser) then
                        self:ExitEmplacement( self.EmplUser )
                        --print( "far2" )
                    end

                    if IsValid( self.EmplUser ) then-- hacky pyramid
                        local squadName = self.EmplUser:GetSquad()
                        if squadName and isstring( squadName ) then
                            local squadLeader = ai.GetSquadLeader( squadName )

                            if not self.EmplUser:IsSquadLeader() and IsValid( squadLeader ) and ThisCanManTurret( self, squadLeader ) and squadLeader:GetPos():DistToSqr( StandPos ) < self.MaxAcquireDist^2 then
                                self:ExitEmplacement( self.EmplUser )
                                self.EmplUser.JustTakeTheDamnEmplacementTime = CurTime() + -20
                                self.EmplUser:SetSchedule( SCHED_RUN_RANDOM )
                                self:EmplClear()
                                self.UserWasNpc = false
                            end
                        end
                    end
                end
            end
            if IsValid( self.EmplUser ) then
                local DeadNpc = self.EmplUser:Health() <= 0
                local Enemy = self.EmplUser:GetEnemy()
                local EnemyHealth = 0
                local ValidEnemy = IsValid( Enemy )
                local CanShootEnemy = false
                local EnemyPos = Vector(0)
                local FullAmmo = self.TurretClip >= self.MaxAmmo
                
                if ValidEnemy then
                    EnemyHealth = Enemy:Health()
                    EnemyPos = self:EntShootPos( Enemy )
                    CanShootEnemy = self:EmplacementCanShoot( EnemyPos ) and self.EmplUser:Visible( Enemy )
                end
                if self.EmplaceActive and self.EmplaceManned and self.NextSmallThink < CurTime() then 
                    self.NextSmallThink = CurTime() + 0.08
                    if CanShootEnemy and self.EmplaceActive and EnabledAi() then    
                        self:EmplacementAim( EnemyPos, Enemy )
                        self.NextRandomAim = CurTime() + math.random( 5, 8 )
                        self.IdleEmplacement = false
                        self.AcquireSentence = true
                        self.ClearFiringLine = true
                        local tr = util.TraceHull( {
                            start = self:GetPos(),
                            endpos = EnemyPos,
                            filter = { self, self:GetParent(), self.EmplUser },
                            mins = Vector( -10, -10, -10 ),
                            maxs = Vector( 10, 10, 10 ),
                            mask = MASK_SHOT_HULL
                        } )
                        if IsValid( tr.Entity ) then
                            self.ClearFiringLine = not NpcLikes( self.EmplUser, tr.Entity )
                            if not tr.Entity.NextForcedCover then tr.Entity.NextForcedCover = 0 end
                            if tr.Entity:IsNPC() and not self.ClearFiringLine and tr.Entity.NextForcedCover < CurTime() then 
                                tr.Entity:SetSchedule( SCHED_TAKE_COVER_FROM_ENEMY )
                                tr.Entity.NextForcedCover = CurTime() + 2
                            end
                        end
                        if self.TurretClip < self.MaxAmmo * 0.1 and not self.Reloading then
                            self.LowAmmo = true
                        end
                    elseif not ValidEnemy then
                        if self.NextRandomAim < CurTime() then
                            self.NextRandomAim = CurTime() + math.random( 5, 8 )
                            local RandomMul = math.random( -400, 400 )
                            self.RandomAimPos = self:GetPos() + self:GetForward() * 800 + self:GetRight() * RandomMul
                        end
                        if not self.IdleEmplacement and not FullAmmo then
                            if self.TurretClip < ( self.MaxAmmo * 0.5 ) then
                                self.IdleReload = CurTime() + math.random( 1, 2 ) 
                                --print( "fastreload" )
                            else
                                self.IdleReload = CurTime() + math.random( 8, 12 ) 
                            end
                        end
                        
                        if self.IdleReload then
                            if self.IdleReload < CurTime() then
                                --print( "reload" )
                                self.ReloadInput = true
                                self.IdleReload = math.huge
                            end
                        end
                        self:EmplacementAim( self.RandomAimPos, Enemy )
                        self.IdleEmplacement = true
                        self.IdleEmplacementSentence = true
                    end
                end
                
                if self.AimingAtEnemy and EnemyHealth > 0 and CanShootEnemy and self.ClearFiringLine and not DeadNpc then
                    self.EmplInputFire = true
                else
                    self.EmplInputFire = false            
                end
                
                local IsMetroCop = self.EmplUser:GetClass() == "npc_metropolice"
                local IsSoldier = self.EmplUser:GetClass() == "npc_combine_s"
                
                if self.EnteredEmplacement then
                    self.EnteredEmplacement = false
                    if self.NextMannedSentence < CurTime() then
                        self.NextMannedSentence = CurTime() + math.random( 5, 10 )
                        self.NextIdleSentence = CurTime() + math.random( 10, 40 )
                        if IsMetroCop then
                            self.EmplUser:PlaySentence( "METROPOLICE_FT_MOUNT", 0, 1 )
                        end
                    end
                elseif self.AcquireSentence then
                    self.AcquireSentence = false
                    if self.NextAcquireSentence < CurTime() then
                        self.NextAcquireSentence = CurTime() + math.random( 10, 40 )
                        self.EmplUser:FoundEnemySound()
                    end
                elseif self.IdleEmplacementSentence then
                    self.IdleEmplacementSentence = false
                    if self.NextIdleSentence < CurTime() then
                        self.NextIdleSentence = CurTime() + math.random( 15, 30 )
                        if IsMetroCop then
                            self.EmplUser:PlaySentence( "METROPOLICE_FT_SCAN", 0, 1 )
                        else
                            self.EmplUser:IdleSound()
                        end
                    end
                elseif self.ExitedEmplacement then
                    self.ExitedEmplacement = false
                    if self.NextDismountSentence < CurTime() then
                        self.NextDismountSentence = CurTime() + math.random( 10, 30 )
                        if IsMetroCop then
                            self.EmplUser:PlaySentence( "METROPOLICE_FT_DISMOUNT", 0, 1 )
                        else
                            self.EmplUser:AlertSound()
                        end
                    end
                elseif self.LowAmmo then
                    self.LowAmmo = false
                    if self.NextLowAmmoSentence < CurTime() then
                        self.NextLowAmmoSentence = CurTime() + math.random( 10, 40 )
                        if IsMetroCop then
                            self.EmplUser:PlaySentence( "METROPOLICE_COVER_NO_AMMO", 0, 1 )
                        end
                    end
                elseif self.DoneReload and not self.Reloading then
                    self.DoneReload = false
                    if self.NextDoneReloadSentence < CurTime() then
                        self.NextDoneReloadSentence = CurTime() + math.random( 10, 40 )
                        if IsSoldier then
                            self.EmplUser:PlaySentence( "COMBINE_ANNOUNCE", 0, 1 )
                        else
                            self.EmplUser:AlertSound()
                        end
                    end
                end
            end
        elseif UserIsPly then
            local StandPos = self:GetEmplacementStandPos()
            local DistToEmpl = 0
            local DeadPly = not IsValid( self.EmplUser )
            local ExitEmplace = false
            local UseDown = false
            if not DeadPly then
                DeadPly = self.EmplUser:Health() <= 0
                DistToEmpl = self.EmplUser:GetPos():Distance( StandPos )
                UseDown = self.EmplUser:KeyDown( IN_USE )
                
                local ChangedWeap = self.EmplUser.EmplEquipWeapon ~= self.EmplUser:GetActiveWeapon()
                local TooFar = DistToEmpl > self.ManningDist * 3
                local UseAgain = not self.HistoricUse and UseDown
                
                ExitEmplace = TooFar or ChangedWeap or UseAgain
            end
            
            if not DeadPly and not ExitEmplace then
                self.HistoricUse = UseDown
                if self.NextSmallThink < CurTime() then 
                    self.NextSmallThink = CurTime() + 0.08
                    local Trace = self.EmplUser:GetEyeTraceNoCursor()
                    --debugoverlay.Cross( Trace.HitPos, 5, 1, Color( 255, 255, 255 ), true )
                    self:EmplacementAim( Trace.HitPos, nil )
                    
                    
                    if self.EmplUser:KeyDown( IN_ATTACK ) or self.EmplUser:KeyDown( IN_BULLRUSH ) then
                        self.EmplInputFire = true
                    elseif self.EmplInputFire then
                        self.EmplInputFire = false
                    end
                    
                    if self.EmplUser:KeyDown( IN_RELOAD ) then
                        self.ReloadInput = true
                    elseif self.ReloadInput then
                        self.ReloadInput = false
                    end
                end
            elseif ExitEmplace or DeadPly then
                self:PlyExitEmplacement( self.EmplUser )
            end
        end
        if self.EmplInputFire then
            if self.NextFire < CurTime() then
                self.NextFire = CurTime() + 0.06
                self:EmplFireThink( true )
            end
        end
        if self.ReloadInput then
            self.ReloadInput = false
            self.ForceReload = true
            self:EmplFireThink( false )
        else
            self.ForceReload = false
        end
        
    elseif not self.Inactive then
        if not self.DieSetup then
            self.DieSetup = true
            self.ExplodeSoundTime = CurTime() + 4.8
            self.ExplodeTime = CurTime() + 5
            self:Ignite( 5, 0 )
            sound.EmitHint( 8, self:GetPos(), 400, 5, NULL )
            if IsValid( self.EmplUser ) then
                local UserIsNpc = self.EmplUser:IsNPC()
                local UserIsPly = self.EmplUser:IsPlayer()
                if UserIsNpc then
                    self:ExitEmplacement( self.EmplUser )
                    self.EmplUser:FearSound()
                elseif UserIsPly then
                    self:PlyExitEmplacement( self.EmplUser )
                end
            end
        else
            if self.ExplodeSoundTime < CurTime() then 
                self.ExplodeSoundTime = math.huge
                self:EmitSound( "ambient/levels/labs/electric_explosion4.wav", 90, 100, 1, CHAN_WEAPON, 0, 0 )
            end
            if self.ExplodeTime < CurTime() then
                self.Inactive = true
                self.ExplodeTime = math.huge
                self:EmitSound( "ambient/explosions/explode_4.wav", 90, 130, 1, CHAN_WEAPON, 0, 0 )
                util.BlastDamage( self, self, self:GetPos() + Vector( 0, 0, 20 ), 250, 150 )
                self:SetNoDraw( true )
                
                local ent = ents.Create('prop_physics')
                ent:SetModel('models/props_combine/bunker_gun01.mdl')
                ent:SetPos( self:GetPos() )
                ent:SetAngles( self:GetAngles() )
                ent:Spawn()
                ent:SetCollisionGroup( 11 )
                ent.DoNotDuplicate = true
                
                local Obj = ent:GetPhysicsObject()
                local RandTorque = Vector(100)
                RandTorque:Random( -100, 100 )
                Obj:ApplyForceCenter( Vector( math.random( -100, 100 ),math.random( -100, 100 ),1000 ) * Obj:GetMass() )
                Obj:ApplyTorqueCenter( RandTorque * Obj:GetMass() )
                
                SafeRemoveEntityDelayed( ent, 30 )
                SafeRemoveEntityDelayed( self, 30 )
                
                local expl = EffectData()
                expl:SetEntity(self)
                expl:SetOrigin( self:GetPos() )
                expl:SetScale(1)
                expl:SetFlags(5)
                util.Effect('Explosion', expl)
            else
                local DistToSplode = math.abs( self.ExplodeTime - CurTime() )
                if ( math.Round( CurTime(), 1 ) % math.Round( DistToSplode * 0.3, 1 ) ) == 0 then
                    self:EmitSound( "LoudSpark", 90, 100, 1, CHAN_WEAPON, 0, 0 )
                end
            end
        end
    end
    return true
end

function ENT:OnTakeDamage( damage )
    if damage:GetDamage() > 80 and damage:IsExplosionDamage() then
        self.IsDead = true
    end
end

function ENT:LookForEnemies(ent)
    if IsValid(ent:GetEnemy()) and ent:GetEnemy() then
        self.HasEnemy = true
    else
        self.HasEnemy = false
    end
end

function ENT:EntShootPos( ent, random )
    local hitboxes = {}
    local sets = ent:GetHitboxSetCount()

    if sets then
        for i = 0, sets - 1 do
            for j = 0,ent:GetHitBoxCount( i ) - 1 do
                local group = ent:GetHitBoxHitGroup( j, i )

                hitboxes[group] = hitboxes[group] or {}
                hitboxes[group][#hitboxes[group] + 1] = { ent:GetHitBoxBone( j, i ), ent:GetHitBoxBounds( j, i ) }
            end
        end

        local data

        if hitboxes[HITGROUP_HEAD] then
            data = hitboxes[HITGROUP_HEAD][ random and math.random( #hitboxes[HITGROUP_HEAD] ) or 1 ]
        elseif hitboxes[HITGROUP_CHEST] then
            data = hitboxes[HITGROUP_CHEST][ random and math.random( #hitboxes[HITGROUP_CHEST] ) or 1 ]
        elseif hitboxes[HITGROUP_GENERIC] then
            data = hitboxes[HITGROUP_GENERIC][ random and math.random( #hitboxes[HITGROUP_GENERIC] ) or 1 ]
        end

        if data then
            local bonem = ent:GetBoneMatrix( data[1] )
            local theCenter = data[2] + ( data[3] - data[2] ) / 2

            local pos = LocalToWorld( theCenter, angle_zero, bonem:GetTranslation(), bonem:GetAngles() )
            return pos
        end
    end

    if ent.EyePos then
        local pos = ent:EyePos()
        return pos
    end

    --debugoverlay.Cross( ent:WorldSpaceCenter(), 5, 10, Color( 255,255,255 ), true )

    return ent:WorldSpaceCenter()
end

-- if(yaw > a)
--   yaw = a
-- if(yaw < b)
--   yaw = b

function ENT:EmplacementAim( AimTargetPos, AimTargetEnt )
    if AimTargetPos == nil then return end
    local MuzzleTach = self:LookupAttachment( "muzzle" )
    local Attachment = self:GetAttachment( MuzzleTach )
    
    local DoMarch = true
    if IsValid( AimTargetEnt ) and not AimTargetEnt:VisibleVec( Attachment.Pos ) then 
        DoMarch = false
    end
    
    local TargetAng = ( AimTargetPos - Attachment.Pos ):Angle()
    
    if not self.EmplAimDir then
        self.EmplAimDir = self:GetAngles()
    end

    local TargetAngLocal = self:WorldToLocalAngles( TargetAng )
    --debugoverlay.Axis( self:GetPos(), self.EmplAimDir, 10, 2, true )
    

    local LocalStart = self:WorldToLocalAngles( self.EmplAimDir )
    local LocalMarched = LocalStart
    
    if DoMarch then
        local Start = LocalStart
        local NewPitch = math.ApproachAngle( Start.p, TargetAngLocal.p, 8 )
        local NewYaw = math.ApproachAngle( Start.y, TargetAngLocal.y, 8 )
        
        local NewPitch = math.Clamp( NewPitch, self.MinElevation, self.MaxElevation )
        local NewYaw = math.Clamp( NewYaw, self.MinBearing, self.MaxBearing )
        
        LocalMarched = Angle( NewPitch, NewYaw, 0 )
        self.EmplAimDir = self:LocalToWorldAngles( LocalMarched )
    end
    
    self.AimingAtEnemy = false
    if math.AngleDifference( LocalMarched.p, TargetAngLocal.p ) < 10 and math.AngleDifference( LocalMarched.y, TargetAngLocal.y ) < 10 then
        self.AimingAtEnemy = true
    end
    
    
    local PitchAdj = LocalMarched.p + 12
    
    self:SetPoseParameter( "aim_yaw", math.Clamp( LocalMarched.y, -59.9, 59.9 ) )
    self:SetPoseParameter( "aim_pitch", math.Clamp( PitchAdj, -34.9, 49.9 ) )
    self:FrameAdvance()
end

-- reloading handled here
function ENT:EmplFireThink( Fire )
    if not IsValid( self ) then return end
    if not self.EmplaceActive then return end
    local Forced = self.ForceReload and self.TurretClip ~= self.MaxAmmo
    local DoReload = self.TurretClip <= 0 or Forced
    
    if DoReload and self.Reloading == nil then
        self.DoneReload = true
        self.Reloading = true
        self.ForceReload = false
        self:EmitSound("MountedTurret.Reload")
        self:EmitSound( "weapons/slam/mine_mode.wav", 85, 80, 1, 6 )
        
        local Forward = self.EmplAimDir:Forward()
        local Left = -self.EmplAimDir:Right()
        local Up = self.EmplAimDir:Up()
        local ent = ents.Create('prop_physics')
        ent:SetModel('models/items/combine_rifle_cartridge01.mdl')
        ent:SetPos( self:GetPos() + Forward * 7 + -Left * 6 + Up * 15 )
        ent:SetAngles( Angle( Left ) )
        ent:Spawn()
        ent:SetCollisionGroup( 11 )
        SafeRemoveEntityDelayed( ent, GetConVar( "npcmannedemplacement_clipdecay" ):GetInt() )
        ent.DoNotDuplicate = true
        
        local Obj = ent:GetPhysicsObject()
        Obj:ApplyForceCenter( ( -Left + Up ) * 130 * Obj:GetMass() )
        Obj:ApplyTorqueCenter( -Forward * 30 * Obj:GetMass() )
        
        timer.Simple(self.ReloadTime,function()
            if not IsValid( self ) then return end 
            self:EmitSound("MountedTurret.ReloadFin")
            self.Reloading = nil
            self.TurretClip = self.MaxAmmo
        end)
    elseif not self.Reloading and self.TurretClip > 0 and Fire then
        self:FireMountedTurret()
    end
end
    
    
    
function ENT:FireMountedTurret()
    local ValidNpc = IsValid( self.EmplUser )
    if not ValidNpc then return end
    local MuzzleTach = self:LookupAttachment( "muzzle" )
    local Attachment = self:GetAttachment( MuzzleTach )
    local bullet = {}
    
    local damage = GetConVar( "npcmannedemplacement_damage" ):GetInt() 
    local dmgBite = damage / 5

    bullet.Num = 1 
    bullet.Src = Attachment.Pos
    bullet.Dir = self.EmplAimDir:Forward()
    bullet.Tracer= 1
    bullet.Spread = Vector(0.035,0.035,0)
    bullet.Damage = math.random(damage + dmgBite,damage)
    bullet.Force = 2
    bullet.Attacker = self.EmplUser
    bullet.TracerName = "AR2Tracer"

    self:FireBullets(bullet)

    local muzzleff = EffectData()
    muzzleff:SetEntity(self)
    muzzleff:SetAngles(Attachment.Ang)
    muzzleff:SetOrigin(Attachment.Pos + Attachment.Ang:Forward()*5)
    muzzleff:SetScale(1)
    muzzleff:SetAttachment(MuzzleTach)
    muzzleff:SetFlags(5)
    util.Effect('MuzzleFlash', muzzleff)
    
    if self.TurretClip < 30 then
        if ( self.TurretClip % 4 ) == 0 then end
        local Pitch = math.abs( self.TurretClip + 30 )
        self:EmitSound( "weapons/pistol/pistol_empty.wav", 73, Pitch, 0.7, 6 )
    end
    
    self.TurretClip = self.TurretClip - 1
    self:EmitSound("Weapon_FuncTank.Single")
    self:ResetSequence("fire")
end

function EmplBlacklist( ent )
    if not IsValid( ent ) then return end
    ent.OnEmplacementBlacklist = true
end

local function WaitToGiveLeaderAChance( ent )
    if ent:IsSquadLeader() then return nil end -- don't block
    local JustTakeTheDamnEmplacementTime = ent.JustTakeTheDamnEmplacementTime or 0
    if JustTakeTheDamnEmplacementTime > CurTime() then return nil end -- don't block
    ent.JustTakeTheDamnEmplacementTime = CurTime() + 5
    return true -- block it

end

local function IsValidManner( ent )
    if not IsValid( ent ) then return false end
    if ent.OnEmplacementBlacklist then return false end
    if not ent:IsNPC() then return false end
    --debugoverlay.Cross( ent:GetPos(), 5, 1, Color( 255, 255, 255 ), true )
    local SeqId, SeqLen = ent:LookupSequence( "Man_Gun" )
    if not SeqId then return false end
    if SeqId <= -1 then return false end

    return true
end

function ENT:SearchForPersonToManIt()
    local turret = self
    local disabled = turret:LookupSequence( "idle_inactive" )
    local StandPos = self:GetEmplacementStandPos()
    if not EnabledAi() then return end

    if IsValid( self.NpcToManTheTurret ) and not IsValid( self.EmplUser ) then

        local DistToEmpl = self.NpcToManTheTurret:GetPos():Distance( StandPos )
        local IsAlive = self.NpcToManTheTurret:Health() > 0
        local IsRunnin = self.NpcToManTheTurret:IsCurrentSchedule( SCHED_FORCED_GO_RUN ) and self.NpcToManTheTurret.WasRunningToEmplacement
        local IsClose = DistToEmpl < self.ManningDist
        local CanMan = ThisCanManTurret( self.NpcToManTheTurret, turret )
        local FailedTask = self.NpcToManTheTurret:IsCurrentSchedule( SCHED_FAIL )

        if not IsAlive and IsClose then
            EmplBlacklist( self.NpcToManTheTurret )
            self.NpcToManTheTurret:SetSchedule( SCHED_RUN_RANDOM )
        elseif IsAlive and IsClose then
            self.NpcToManTheTurret.WasRunningToEmplacement = nil
            self:EmplAssignNpc( self.NpcToManTheTurret )
        elseif not IsRunnin and not IsClose and CanMan then
            self.NpcToManTheTurret:SetLastPosition( StandPos )
            self.NpcToManTheTurret:SetSchedule( SCHED_FORCED_GO_RUN )
            self.NpcToManTheTurret.WasRunningToEmplacement = true
            --debugoverlay.Line( StandPos, self.NpcToManTheTurret:GetPos(), 1, Color( 255, 255, 255 ), true )
        elseif ( not IsRunnin and not IsClose and not CanMan ) or not IsAlive or FailedTask then
            self.NpcToManTheTurret = nil
        end

    elseif self.FreeGun and not IsAlreadyManning( self.NpcToManTheTurret ) then
        local NearbyNpcs = {}
        local NearbyEnts = ents.FindInSphere( StandPos, turret.MaxAcquireDist )
        for _, CurrentEnt in ipairs( NearbyEnts ) do
            if IsValidManner( CurrentEnt ) then
                if WaitToGiveLeaderAChance( CurrentEnt ) == nil then -- we have not been told to wait
                    table.insert( NearbyNpcs, CurrentEnt )
                end
            else
                EmplBlacklist( CurrentEnt )
            end
        end
        table.sort( NearbyNpcs, function( a, b ) -- sort areas by distance to nextbot
            local ADist = a:GetPos():DistToSqr( StandPos )
            local BDist = b:GetPos():DistToSqr( StandPos )
            return ADist < BDist 
        end )
        for _, NpcToManTheTurret in pairs( NearbyNpcs ) do
            if IsValid( NpcToManTheTurret ) and ThisCanManTurret( NpcToManTheTurret, turret ) then
                
                --debugoverlay.Line( StandPos, NpcToManTheTurret:GetPos(), 1, Color( 255, 255, 255 ), true )
                
                NpcToManTheTurret:SetLastPosition( StandPos )
                NpcToManTheTurret:SetSchedule(SCHED_FORCED_GO_RUN) 
                self.NpcToManTheTurret = NpcToManTheTurret
                NpcToManTheTurret.WasRunningToEmplacement = true
                break
                
            end
        end
    end
end

function ENT:OnRemove()
    local UserIsNpc = false
    local UserIsPly = false
    if IsValid( self.EmplUser ) then
        UserIsNpc = self.EmplUser:IsNPC()
        UserIsPly = self.EmplUser:IsPlayer()
    end  
    if UserIsNpc then
        self:ExitEmplacement( self.EmplUser )
    elseif UserIsPly then
        self:PlyExitEmplacement( self.EmplUser )
    end
end
