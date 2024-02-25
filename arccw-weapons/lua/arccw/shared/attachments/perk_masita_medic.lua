att.PrintName = "Healing Module"
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
att.UBGL_ClipSize = 5
att.UBGL_Ammo = "ar2"
att.UBGL_RPM = 100
att.UBGL_Recoil = 1
att.UBGL_Capacity = 5
-- Healing amount var located line 44

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
    //print(wep:Clip2())
    if wep:Clip2() >= 3 then return end

    if Ammo(wep) <= 0 then return end

    wep:EmitSound("w/rifles.wav", 100)


    local reserve = Ammo(wep)

    reserve = reserve + wep:Clip2()

    //local clip = 3

    local load = math.Clamp(3, 0, reserve)

    wep.Owner:SetAmmo(reserve - load, "pistol")

    wep:SetClip2(load)
end