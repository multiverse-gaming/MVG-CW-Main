att.PrintName = "Scandart"
att.Icon = nil
att.Description = "Fires a dart which highlights the hit target and any enemies within 512 units in red."
att.Desc_Pros = {}
att.Desc_Cons = {}
att.AutoStats = true
att.Slot = "cr2cscandart"

att.Override_ClipSize = 1
att.Mult_SpeedMult = 0.85
att.Override_Damage = 0
att.Override_ReloadTime = 3

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

hook.Add("EntityTakeDamage", "ScanDartHitEffect", function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if not IsValid(attacker) or not attacker:IsPlayer() then return end

    local weapon = attacker:GetActiveWeapon()
    if not IsValid(weapon) or weapon:GetClass() ~= "arccw_cr2c" then return end

    local hitPos = dmginfo:GetDamagePosition()
    if hitPos == vector_origin then
        local trace = attacker:GetEyeTrace()
        hitPos = trace.HitPos
    end

    if target:IsPlayer() or target:IsNPC() then
        AddESPEffect(target, Color(255, 0, 0))
    end
    AddESPInRadius(hitPos, 512, Color(255, 0, 0))
end)

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