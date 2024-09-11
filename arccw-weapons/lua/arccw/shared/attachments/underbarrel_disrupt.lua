att.PrintName = "Disrupt"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = "Fire rounds that make the enemy drop their binders."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "WPShot"

att.NotForNPC = true

att.UBGL = true
att.UBGL_PrintName = "Disruption Shot"
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
            wep:SetClip2(wep:Clip2() - 1)
            
            local ent = tr.Entity
            if (IsValid(ent) && ent:IsPlayer()) then
                local ED_Stun = EffectData()
                ED_Stun:SetOrigin( ent:GetPos() )
                ED_Stun:SetEntity( ent )
                ED_Stun:SetScale( 0.5 )
                util.Effect("SERV_passive_stun", ED_Stun, true, true)
                
                hook.Run("Cuffs_InstantUntieAllVictims", ent)
            end
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