att.PrintName = "Internal Slugthrower"
att.Icon = Material("entities/acwatt_ubgl_aug_mk.png", "mips smooth")
att.Description = "Selectable shotgun equipped under the rifle's barrel. Double tap +ZOOM to equip/dequip."
att.Desc_Pros = {
	"+ Selectable Underbarrel Shotgun.",
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
	"info.toggleubgl"
}
att.Free = true
att.HideIfUnavailable = false
att.AutoStats = true
att.Slot = "tl50_ubgl"

att.SortOrder = 99

att.MountPositionOverride = 0

att.UBGL = true
att.UBGL_BaseAnims = true

att.UBGL_PrintName = "UB (BUCK)"
att.UBGL_Automatic = true
--att.UBGL_MuzzleEffect = "wpn_muzzleflash_dc17_red"
att.UBGL_ClipSize = 6
att.UBGL_Ammo = "ar2"
att.UBGL_RPM = 150
att.UBGL_Recoil = 0.5
att.UBGL_Capacity = 6
att.UBGL_Icon = Material("entities/acwatt_ubgl_aug_mk.png")

att.Reloading = false
att.ReloadingTimer = 0

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("ar2")
end

att.UBGL_Fire = function(wep, ubgl)
    wep.Owner:FireBullets({
        Src = wep.Owner:EyePos(),
        Num = 6,
        Damage = 25,
        Force = 0,
        Attacker = wep.Owner,
        Dir = wep.Owner:EyeAngles():Forward(),
		Spread = Vector(0.1, 0.1, 0),
        Callback = function(_, tr, dmg)
			dmg:SetDamage(25)
        end
    })
	wep:SetClip2(wep:Clip2() - 1)
    wep:EmitSound("dp23/dp23.wav", 100)
end

att.UBGL_Reload = function(wep, ubgl)
    -- Check reload stats.
    if wep:Clip2() >= 6 then return end
    local ammoLeft = Ammo(wep)
    if ammoLeft <= 0 then return end

    -- Set animation / cooldown.
    local a = wep:SelectAnimation("reload") or self:SelectAnimation("draw")
    wep:PlayAnimation(a, wep:GetBuff_Mult("Mult_ReloadTime"), true, 0, nil, nil, true)
    wep:SetPriorityAnim(CurTime() + wep:GetAnimKeyTime(a, true) * wep:GetBuff_Mult("Mult_ReloadTime"))

    -- Set correct ammo.
    ammoLeft = ammoLeft + wep:Clip2()
    local clip = 6
    local load = math.Clamp(clip, 0, ammoLeft)
    wep:GetOwner():RemoveAmmo(load - wep:Clip2(), "ar2")
    wep:SetClip2(load)
end