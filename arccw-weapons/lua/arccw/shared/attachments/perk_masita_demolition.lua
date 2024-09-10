att.PrintName = "Demolition expert"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("interfaz/iconos/kraken/sith snip marksmanship/1630896351_777900936.png")
att.Description = "You're a Demolition's expert. You can load an extra rounds for that one last punch."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "perk"

att.NotForNPC = true

att.Add_ClipSize = 5
att.Hook_Compatible = function(wep)
    if (wep.Primary.Ammo ~= "RPG_Round" and wep.Primary.Ammo ~= "SMG1_Grenade") then return false end
end