att.PrintName = "Beam Cycler"
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = [[Changes alternative shot to a charged pistol. Hold fire to charge up a more powerful shot.]]
att.Desc_Pros = {"Enables charge shots"}
att.Desc_Cons = {"Consumes more ammo for charged shots", "Don't let it hit 0!"}
att.Desc_Neutrals = {}

att.Slot = {"WPShot"}
att.Free = false
att.HideIfUnavailable = true
att.AutoStats = true
att.NotForNPC = true

att.UBGL = true
att.UBGL_PrintName = "Charged Shot"
att.UBGL_Automatic = true
att.UBGL_ClipSize = 25
att.UBGL_Ammo = "ar2"
att.UBGL_RPM = 300
att.UBGL_Recoil = 0.1
att.UBGL_Capacity = 25

-- Handle releasing the UBGL charge
function Fire(wep)
    -- Invalid, return
    if (!IsValid(wep)) then return end

    -- If ammo is completely drained, either stop, or blow yourself up, depending on ammo drained.
    if (wep:Clip2() <= 0) then
        if (wep.AmmoDrained > 10) then
            wep.ChargingUnderbarrel = false
            if (wep.Sound) then
                wep.Sound:Stop()
                wep.Sound = false
                wep.AmmoDrained = 0
            end
            local explosion = EffectData()
            explosion:SetOrigin(wep.Owner:GetPos())
            explosion:SetScale(0.5)
            explosion:SetRadius(64)
            explosion:SetMagnitude(1)
            util.Effect("Explosion", explosion)
            util.BlastDamage(wep, wep.Owner, wep.Owner:GetPos(), 100, 300)
        end

        -- Stop any firing stuff.
        wep.ChargingUnderbarrel = false
        if (wep.Sound) then
            wep.Sound:Stop()
            wep.Sound = false
        end
    end

    -- Shoot if they let go.
    if (wep:GetOwner():KeyDown(IN_SPEED) && !wep:GetBuff_Override("Override_ShootWhileSprint", wep.ShootWhileSprint)) then
        -- If you can't fire (currently just due to running) stop charging.
        wep.ChargingUnderbarrel = false
        if (wep.Sound) then
            wep.Sound:Stop()
            wep.Sound = false
            wep.AmmoDrained = 0
        end
        return
    end
    local fired = false
    if wep.HasntFiredRecently and not wep:GetOwner():KeyDown(IN_ATTACK) and wep.ChargingUnderbarrel then
        if (wep.AmmoDrained < 4) then
            -- If not enough ammo to shoot, stop.
            wep.ChargingUnderbarrel = false
            if (wep.Sound) then
                wep.Sound:Stop()
                wep.Sound = false
                wep.AmmoDrained = 0
            end
            return
        end

        -- Reset some stuff to allow the gun to fire again
        fired = true
        wep.ChargingUnderbarrel = false
        wep.HasntFiredRecently = false
        local ammoShot = wep.AmmoDrained
        wep.AmmoDrained = 0
        timer.Simple(0.5, function()
            if IsValid(wep) then wep.HasntFiredRecently = true end
        end)

        if (!CLIENT) then
            -- Calculate the damage for the charged shot
            local adjustedDamage = wep.Damage + (ammoShot * 15)
    
            -- Fire the charged shot
            local bullet = {}
            bullet.Damage = adjustedDamage
            bullet.Num = wep.TracerNum or 1  -- Use TracerNum from the second SWEP, default to 1
            bullet.Src = wep.Owner:GetShootPos()  -- Shooter's position
            bullet.Dir = wep.Owner:GetAimVector()  -- Shooter's aim direction
            bullet.Spread = Vector(0, 0, 0)  -- No spread for charged shot
            bullet.Tracer = 0
            bullet.TracerCol = wep.TracerCol or Color(255, 255, 0)  -- Tracer color (default to yellow)
            bullet.Force = adjustedDamage  -- Bullet force (same as damage here)
            bullet.HullSize = wep.HullSize or 0.5
            bullet.ChamberSize = wep.ChamberSize or 0
            bullet.Range = bullet.Range or 9999
    
            -- Shoot a tracer beam
            local ply = wep.Owner
            local startPos = wep:GetPos() + wep:OBBCenter()
            local tr = ply:GetEyeTrace()
            local endPos = tr.HitPos
            local beamData = EffectData()
            beamData:SetStart(startPos)
            beamData:SetOrigin(endPos)
            beamData:SetEntity(wep)
            util.Effect("ToolTracer", beamData)
            wep.Owner:FireBullets(bullet)
    
            -- Some basic recoil
            local ply = wep:GetOwner()
            if not IsValid(ply) then return end
            ply:SetViewPunchAngles(ply:GetViewPunchAngles() + Angle(-math.Rand(4, 10), math.Rand(-7, 7), 0))
    
            -- Shoot sound.
            wep:EmitSound("sops-v2/weapons/revolvers.wav")
            wep:SetNextPrimaryFire(CurTime() + 0.5) -- Cooldown
        end
    end
    if (fired && CLIENT) then
        -- Do a reload animation
        if (LocalPlayer() != wep:GetOwner()) then return end
        local a = wep:SelectAnimation("fire")
        wep:PlayAnimation(a, 1, true, 0, nil, nil, true)
        wep:SetPriorityAnim(CurTime() + wep:GetAnimKeyTime(a, true) * 1)
        if (wep.Sound) then
            wep.Sound:Stop()
            wep.Sound = false
            wep.AmmoDrained = 0
        end
    end
end

att.UBGL_Fire = function(wep, ubgl)
    if (wep:Clip2() <= 0) then
        if not wep.ChargingUnderbarrel then return end
    end
    -- Initialize charging
    if not wep.ChargingUnderbarrel then
        wep.ChargingUnderbarrel = true
        wep.ChargeStartTime = CurTime()
        wep.AmmoDrained = 0
    end

    -- Start the sound loop.
    if (not wep.Sound) then
        wep.Sound = wep.Sound or CreateSound( wep.Owner, "ambient/levels/citadel/field_loop1.wav" )
        wep.Sound:Play()
    end

    -- Slowly take ammo from the gun
    wep.ChargeStartTime = wep.ChargeStartTime or CurTime() -- Overall charge time
    wep.AmmoDrainTime = wep.AmmoDrainTime or CurTime() -- Ammo drain time
    if (SERVER && wep.AmmoDrainTime < CurTime() - 0.2) then
        wep.AmmoDrainTime = CurTime()
        if (wep:Clip2() > 0) then
            wep.AmmoDrained = wep.AmmoDrained + 1
        end
        wep:SetClip2(math.max(wep:Clip2() - 1, 0))
    end

    -- Check in 0.3 seconds if they've lifted mouse button.
    timer.Simple(0.3, Fire, wep)
    wep:SetNextPrimaryFire(CurTime() + 0.2)
end

att.UBGL_Reload = function(wep, ubgl)
    -- Stop any firing stuff.
    wep.ChargingUnderbarrel = false
    if (wep.Sound) then
        wep.Sound:Stop()
        wep.Sound = false
    end

    -- Check reload stats.
    if wep:Clip2() >= 25 then return end
    local ammoLeft = wep:GetOwner():GetAmmoCount("ar2")
    if ammoLeft <= 0 then return end

    -- Set animation / cooldown.
    local a = wep:SelectAnimation("reload") or self:SelectAnimation("draw")
    wep:PlayAnimation(a, wep:GetBuff_Mult("Mult_ReloadTime"), true, 0, nil, nil, true)
    wep:SetPriorityAnim(CurTime() + wep:GetAnimKeyTime(a, true) * wep:GetBuff_Mult("Mult_ReloadTime"))

    -- Set correct ammo.
    ammoLeft = ammoLeft + wep:Clip2()
    local clip = 25
    local load = math.Clamp(clip, 0, ammoLeft)
    wep:GetOwner():RemoveAmmo(load - wep:Clip2(), "ar2")
    wep:SetClip2(load)
    timer.Simple(0.5, function()
        if IsValid(wep) then wep.HasntFiredRecently = true end
    end)
end