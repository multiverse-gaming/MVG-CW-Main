AddCSLuaFile()

SWEP.Base = "mortar_constructor"
SWEP.PrintName = "Mortar Dark"
SWEP.Spawnable = true

SWEP.Author = "DolUnity"
SWEP.Purpose = "Placer un Mortier"
SWEP.Instructions = "Placer avec clique gauche \nRécupérer avec SHIFT+E"
SWEP.Category = "Kaito"
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.IconOverride = "materials/entities/mortarbaseblack.png"
function SWEP:OnSpawn(ent)
    ent:SetSkin(1)
end