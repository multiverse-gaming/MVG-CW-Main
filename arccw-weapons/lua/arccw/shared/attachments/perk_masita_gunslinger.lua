att.PrintName = "Gunslinger"
att.Icon = Material("interfaz/iconos/kraken/jedi guns dirty fighting/3726085931_3536543931.png")
att.Description = "You're a Gunslinger, an ace when it comes to Blaster Pistols. Your reload speed and accuracy will increase when using an pistol along other benefits."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "perk"

att.NotForNPC = true

att.Mult_AccuracyMOA = 0.25
att.Mult_HipDispersion = 0.5
att.Mult_RPM = 1.5
att.Mult_Penetration = 2
att.Mult_ReloadTime = 0.65

att.Hook_Compatible = function(wep)
    if (wep.Primary.Ammo ~= "ar2" and wep.Primary.Ammo ~= "357" and wep.Primary.Ammo ~= "pistol") then return false end
end