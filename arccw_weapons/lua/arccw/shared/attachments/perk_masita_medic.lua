att.PrintName = "Healing Module"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = "Fire healing darts out of the DC17m underbarrel"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "PlankShot"

att.NotForNPC = true

att.UBGL = true
att.UBGL_PrintName = "Healing Darts"
att.UBGL_Automatic = true
att.UBGL_ClipSize = 3
att.UBGL_Ammo = "ar2"
att.UBGL_RPM = 100
att.UBGL_Recoil = 1
att.UBGL_Capacity = 3

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
            local ent = tr.Entity
            local dist = (tr.HitPos - tr.StartPos):Length() * ArcCW.HUToM
            local dmgmax = 0
            local dmgmin = 0
            local delta = dist / 5
            delta = math.Clamp(delta, 0, 1)
            local amt = Lerp(delta, dmgmax, dmgmin)

            local amount = 100 -- Healing amount, edit this value to increase or decrease.
            
            ent:SetHealth(math.min(ent:Health() + amount, ent:GetMaxHealth())) -- DON'T TOUCH THIS LINE, EDIT VALUE ABOVE | Dandy

            wep:SetClip2(wep:Clip2() - 1)
        end
    })

    wep:EmitSound("masita/perks/combatheal_var_08.mp3", 100)
end

att.UBGL_Reload = function(wep, ubgl)
    -- Check reload stats.
    if wep:Clip2() >= 3 then return end
    local ammoLeft = Ammo(wep)
    if ammoLeft <= 0 then return end

    -- Set animation / cooldown.
    local a = wep:SelectAnimation("reload") or self:SelectAnimation("draw")
    wep:PlayAnimation(a, wep:GetBuff_Mult("Mult_ReloadTime"), true, 0, nil, nil, true)
    wep:SetPriorityAnim(CurTime() + wep:GetAnimKeyTime(a, true) * wep:GetBuff_Mult("Mult_ReloadTime"))

    -- Set correct ammo.
    ammoLeft = ammoLeft + wep:Clip2()
    local clip = 3
    local load = math.Clamp(clip, 0, ammoLeft)
    wep:GetOwner():RemoveAmmo(load - wep:Clip2(), "ar2")
    wep:SetClip2(load)
end