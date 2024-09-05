att.PrintName = "Scan-Self"
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = "Fire scan darts - only reveal their positions to yourself."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ScanShot"

att.NotForNPC = true
att.Free = true
att.HideIfUnavailable = false

att.UBGL = true
att.UBGL_PrintName = "Scan Shot Self"
att.UBGL_Automatic = false
att.UBGL_ClipSize = 1
att.UBGL_Ammo = "ar2"
att.UBGL_RPM = 100
att.UBGL_Recoil = 1
att.UBGL_Capacity = 1

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("ar2")
end

att.UBGL_Fire = function(wep, ubgl)
    wep.Owner:FireBullets({
        Src = wep.Owner:EyePos(),
        Num = 1,
        Damage = 0,
        Force = 0,
        Attacker = wep.Owner,
        Dir = wep.Owner:EyeAngles():Forward(),
        Callback = function(_, tr, dmg)
            if (!SERVER) then return end
            net.Start("arccw_scandart")
                net.WriteVector(tr.HitPos)
                net.WriteInt(255, 16)
            net.Send(wep.Owner) -- Send to the owner.

            wep:SetClip2(wep:Clip2() - 1)
        end
    })

    wep:EmitSound("masita/perks/combatheal_var_08.mp3", 100)
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
    wep:GetOwner():RemoveAmmo(load - wep:Clip2(), "ar2")
    wep:SetClip2(load)
end