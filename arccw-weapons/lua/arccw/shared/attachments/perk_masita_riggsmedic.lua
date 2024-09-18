att.PrintName = "Healing Bacta Launcher"
att.Free = true
att.HideIfUnavailable = true
att.AbbrevName = "Healing Bacta"
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = "Fire bacta capsules out of the underbarrel"

att.AutoStats = true
att.Desc_Pros = {
}
att.Slot = "RiggsBactaAlt"

att.UBGL = true
att.UBGL_PrintName = "Bacta Clouds"
att.UBGL_Automatic = false
att.UBGL_ClipSize = 4
att.UBGL_Ammo = "grenade"
att.UBGL_RPM = 100
att.UBGL_Recoil = 1
att.UBGL_Capacity = 4

local function Ammo(wep)
    return (wep:GetOwner():GetAmmoCount("grenade"))
end

att.Hook_ShouldNotSight = function(wep)
    if wep:GetInUBGL() then
        return true
    end
end

att.Hook_OnSelectUBGL = function(wep)
    wep:SetNextSecondaryFire(CurTime() + 0.2)
end

att.Hook_OnDeselectUBGL = function(wep)
    wep:SetNextPrimaryFire(CurTime() + 0.2)
end

att.UBGL_Fire = function(wep, ubgl)
    if wep:Clip2() <= 0 then return end

    -- Fire Bacta.
    local class = "bacta_granade_rc" --wep:GetBuff_Override("UBGL_Entity") or "bacta_granade_rc"
    local vel = 2000
    wep:FireRocket(class, vel)

    -- Reduce ammo, ply sound.
    wep:SetClip2(wep:Clip2() - 1)
    wep:EmitSound("masita/perks/combatheal_var_08.mp3", 40)
end

att.UBGL_Reload = function(wep, ubgl)
    -- Check reload stats.
    if wep:Clip2() >= 4 then return end
    local ammoLeft = Ammo(wep)
    if ammoLeft <= 0 then return end

    -- Set animation / cooldown.
    local a = wep:SelectAnimation("reload") or self:SelectAnimation("draw")
    wep:PlayAnimation(a, wep:GetBuff_Mult("Mult_ReloadTime"), true, 0, nil, nil, true)
    wep:SetPriorityAnim(CurTime() + wep:GetAnimKeyTime(a, true) * wep:GetBuff_Mult("Mult_ReloadTime"))

    -- Set correct ammo.
    ammoLeft = ammoLeft + wep:Clip2()
    local clip = 4
    local load = math.Clamp(clip, 0, ammoLeft)
    wep:GetOwner():RemoveAmmo(load - wep:Clip2(), "grenade")
    wep:SetClip2(load)
end