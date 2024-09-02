att.PrintName = "Scan"
att.Icon = Material("interfaz/iconos/kraken/jedi guns saboteur/940267439_136247775.png")
att.Description = "Fire scan darts."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "WPShot"

att.NotForNPC = true

att.UBGL = true
att.UBGL_PrintName = "Scan Shot"
att.UBGL_Automatic = false
att.UBGL_ClipSize = 1
att.UBGL_Ammo = "ar2"
att.UBGL_RPM = 100
att.UBGL_Recoil = 1
att.UBGL_Capacity = 1

local function Ammo(wep)
    return wep.Owner:GetAmmoCount("ar2")
end

local function AddESPEffect(target, color)
    if not IsValid(target) then return end

    target:SetNWBool("ScanDartESP", true)
    target:SetNWVector("ScanDartESP_Color", color)

    timer.Simple(15, function()
        if IsValid(target) then
            target:SetNWBool("ScanDartESP", false)
        end
    end)
end

local function AddESPInRadius(pos, radius, color)
    local entities = ents.FindInSphere(pos, radius)
    for _, ent in ipairs(entities) do
        if ent:IsPlayer() or ent:IsNPC() then
            AddESPEffect(ent, color)
        end
    end
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
            AddESPInRadius(tr.HitPos, 512, Color(255, 0, 0))

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

hook.Add("PreDrawHalos", "ScanDartESP", function()
    for _, ply in pairs(player.GetAll()) do
        if ply:GetNWBool("ScanDartESP") then
            local color = ply:GetNWVector("ScanDartESP_Color", Vector(255, 0, 0))
            halo.Add({ply}, Color(color.x, color.y, color.z), 1, 1, 1, true, true)
        end
    end

    for _, npc in pairs(ents.FindByClass("npc_*")) do
        if npc:GetNWBool("ScanDartESP") then
            local color = npc:GetNWVector("ScanDartESP_Color", Vector(255, 0, 0))
            halo.Add({npc}, Color(color.x, color.y, color.z), 1, 1, 1, true, true)
        end
    end
end)