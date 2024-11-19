att.PrintName = "Beanbag Rounds"
att.Free = true
att.HideIfUnavailable = true
att.Icon = nil
att.AbbrevName = "Beanbag Rounds"
att.SortOrder = -2
att.Description = "Stun round."

att.Desc_Pros = {
    "Massive knockback"
}
att.Desc_Cons = {
    "No damage"
}
att.Desc_Neutrals = {
}

att.Slot = {"ShotgunBeanbag"}

att.AutoStats = true

att.Hook_BulletHit = function(wep, data)
    -- Return if invalid.
    if !data.tr.Entity then return end
    if data.tr.HitWorld then return end
    if !data.tr.Entity:IsPlayer() && !data.tr.Entity:IsNPC() then return end

    -- Do knockback here.
    local target = data.tr.Entity
    target:SetVelocity(target:GetVelocity() + ((data.tr.HitPos - data.tr.StartPos) * 500))

    -- Get rid of damage done by the actual weapon.
    data.damage = 0
end