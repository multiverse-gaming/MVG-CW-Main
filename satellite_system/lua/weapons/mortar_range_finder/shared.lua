AddCSLuaFile()

SWEP.PrintName = "Rangefinder"
SWEP.Base = "weapon_base"

SWEP.Author = "DolUnity"
SWEP.Purpose = "Récupérer la distance"
SWEP.Category = "[Kaito] Artillery System"
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/kaito/sw/w_macrobinoculars.mdl"
SWEP.HoldType = "camera"
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.IconOverride = "materials/entities/rangefindericon.png"
SWEP.Slot = 4

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClipSize = 0

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClipSize = 0

if (CLIENT) then
    SWEP.PreviewModel = ClientsideModel("models/dolunity/starwars/mortar.mdl")
    SWEP.PreviewModel:SetNoDraw(true)
    SWEP.PreviewModel:SetMaterial("models/wireframe")
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:Precache()
	util.PrecacheSound( "weapons/rangefinderzoomin.mp3" )
	util.PrecacheSound( "weapons/rangefinderzoomout.mp3" )
end

function SWEP:PrimaryAttack() end

function SWEP:SecondaryAttack()
    local pitcher = math.random( 90, 105 )
    local checkPlaySounds = GetConVar("mortar_play_rangefinder_sounds"):GetInt()
    if (not IsFirstTimePredicted()) then return end

    if (self.Zoom) then
        self.Owner:SetFOV(self.OldFOV, 0.5)
        self.Zoom = false
        if (checkPlaySounds != 0) then
            self.Weapon:EmitSound( "weapons/rangefinderzoomin.mp3", 35, pitcher, 1, CHAN_WEAPON )
        end     
    else
        self.Zoom = true
        self.OldFOV = self.Owner:GetFOV()
        self.Owner:SetFOV(20, 0.5)
        if (checkPlaySounds != 0) then
            self.Weapon:EmitSound( "weapons/rangefinderzoomout.mp3", 35, pitcher, 1, CHAN_WEAPON )
        end
        
    end
end

function SWEP:ShouldDrawViewModel()
    return false
end

function SWEP:AdjustMouseSensitivity()
    if (self.Owner:GetFOV() == 20) then
        return 0.05
    end
    return 1
end

function SWEP:Deploy()
    self:SetHoldType(self.HoldType)
end

local laserPointer = Material("Sprites/light_glow02_add_noz")
hook.Add("PostDrawTranslucentRenderables", "swmRangeFinderLaser", function()
    if (LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "mortar_range_finder" and not LocalPlayer():InVehicle()) then
        local trace = LocalPlayer():GetEyeTrace()
        render.SetMaterial(laserPointer)
        render.DrawQuadEasy(trace.HitPos + trace.HitNormal, trace.HitNormal, 32, 32, Color(255,0,0),0)
    end
end)

local rangeTable = Material("models/dolunity/starwars/mortar_scale.png")
local rangeOverlay = Material("hud/kaito/krangefinder/rangefinder.png")
hook.Add("HUDPaint", "swmRangeFinderDistanceHUD", function ()
    if (LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "mortar_range_finder" and not LocalPlayer():InVehicle()) then
        local trace = LocalPlayer():GetEyeTrace()
        local dist = LocalPlayer():GetPos():Distance(trace.HitPos)

        surface.SetFont("swmFont")
        surface.SetTextColor(75, 255, 255)
        local mText = math.Round(dist / 40, 1) .. "m"
        local mWidth, mHeight = surface.GetTextSize(mText)
        surface.SetTextPos((ScrW() - mWidth) / 2, ScrH() / 2 + ScrH() * 0.03)
        surface.DrawText(mText)

        local rText = math.Round(math.abs((LocalPlayer():GetAngles().y + 360) % 360 - 360),2)
        local rWidth, rHeight = surface.GetTextSize(rText)
        surface.SetTextPos((ScrW() - rWidth) / 2, ScrH() / 2 + ScrH() * 0.03 + rHeight * 1.1)
        surface.DrawText(rText .. "°")

        local drawOverlayCheck = GetConVar("draw_mortar_shud"):GetInt()
        
        if (drawOverlayCheck != 0) then
            DrawMaterialOverlay("effects/combine_binocoverlay", -0.06)
        end
        
        local drawRangefinderTable = GetConVar("draw_mortar_rangefinder_overlay"):GetInt() 

        if (drawRangefinderTable != 0) then
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(rangeOverlay)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end

       

        local drawROverlayCheck = GetConVar("draw_mortar_rangefinder_table"):GetInt() 

        if (drawROverlayCheck != 0) then
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(rangeTable)
            local height = ScrH() * 0.462
            local width = height * 0.6
            surface.DrawTexturedRect(ScrW() * 0.02, (ScrH() - height) / 2, width, height)
        end
        

        
        

    end
end)