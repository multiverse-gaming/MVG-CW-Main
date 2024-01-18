att.PrintName = "Firebug"
att.Icon = Material("interfaz/iconos/kraken/jedi juns sharpshooter/1833947853_761929952.png")
att.Description = "You're a Firebug, fire is everything to you."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "perk"

att.NotForNPC = true

att.Hook_BulletHit = function(wep, data)
    if CLIENT then return end

    local ent = data.tr.Entity

    ent:Ignite(5, 500)
    if ent:IsOnFire() then
        ent:SetHealth(ent:Health() - 2.5)
    end
end