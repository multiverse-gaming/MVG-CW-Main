att.PrintName = "Incendiary Grenade Launcher"
att.Free = false
att.HideIfUnavailable = true
att.AbbrevName = "Incendiary Launcher"
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = "Fire incendiary grenades out of the underbarrel"

att.AutoStats = true
att.Desc_Pros = {
}
att.Slot = "tl50_ubgl"

att.UBGL = true
att.UBGL_PrintName = "Incendiaries"
att.UBGL_Automatic = false
att.UBGL_ClipSize = 1
att.UBGL_Ammo = "grenade"
att.UBGL_RPM = 100
att.UBGL_Recoil = 1
att.UBGL_Capacity = 1

local function Ammo(wep)
    return (wep:GetOwner():GetAmmoCount("grenade"))
end

att.Hook_ShouldNotSight = function(wep)
    if wep:GetInUBGL() then
        return true
    end
end

att.Hook_OnSelectUBGL = function(wep)
    wep:SetClip2(math.max(math.min(wep:Clip2(), 1), 0))
    wep:SetNextSecondaryFire(CurTime() + 0.2)
end

att.Hook_OnDeselectUBGL = function(wep)
    wep:SetNextPrimaryFire(CurTime() + 0.2)
end

att.UBGL_Fire = function(wep, ubgl)
    if wep:Clip2() <= 0 then return end

    -- Fire Bacta.
    local class = "arccw_thr_incendiary_small" --wep:GetBuff_Override("UBGL_Entity") or "bacta_granade_rc"
    local vel = 2000
    wep:FireRocket(class, vel)

    -- Reduce ammo, ply sound.
    wep:SetClip2(wep:Clip2() - 1)
    wep:EmitSound("dp23/dp23.wav", 100)
end

att.UBGL_Reload = function(wep, ubgl)
    -- Check reload stats.
    if wep:Clip2() >= 1 then return end
    local ammoLeft = Ammo(wep)
    if ammoLeft <= 0 then return end

    -- Set animation / cooldown.
    local a = wep:SelectAnimation("reload") or self:SelectAnimation("draw")
    wep:PlayAnimation(a, wep:GetBuff_Mult("Mult_ReloadTime"), true, 0, nil, nil, true)
    wep:SetPriorityAnim(CurTime() + wep:GetAnimKeyTime(a, true) * wep:GetBuff_Mult("Mult_ReloadTime"))

    -- Set correct ammo.
    ammoLeft = ammoLeft + wep:Clip2()
    local clip = 1
    local load = math.Clamp(clip, 0, ammoLeft)
    wep:GetOwner():RemoveAmmo(load - wep:Clip2(), "grenade")
    wep:SetClip2(load)
end