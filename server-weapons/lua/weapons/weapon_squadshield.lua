AddCSLuaFile()

SWEP.PrintName = "Squad Shield"
SWEP.Category = "MVG"
SWEP.Author = "Stein"
SWEP.Instructions = [[
    Press left click to deploy the shield.
]]

SWEP.Base = "weapon_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false 
SWEP.HoldType = "normal"
SWEP.Slot = 2
SWEP.SlotPos = 101

SWEP.ViewModelFOV = 74
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = ""
SWEP.UseHands = true 

SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = false 

SWEP.Primary.Damage = 0
SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false 
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 60

SWEP.Secondary.Damage = 0
SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
    
    if CLIENT then
        
        local function DrawRect(col, x, y, w, h)

            surface.SetDrawColor(col.r, col.g, col.b, col.a)
            surface.DrawRect(x, y, w, h)
    
        end
    
        local screenwidth, screenheight = ScrW(), ScrH()
        local backgroundwidth, barheight = 256, 48
        local col_back = Color(50, 50, 50, 200)
        local col_bar = Color(230, 230, 230, 255)

        hook.Add("HUDPaint", "squad_shield_weapon_countdown", function()
        
            if LocalPlayer():HasWeapon("weapon_squadshield") then
                
                weaponId = LocalPlayer():GetWeapon("weapon_squadshield")

                local difference = weaponId:GetNextPrimaryFire() - CurTime()
    
                if difference <= 0 then

                    local text = "Ready"

                    surface.SetFont("DermaLarge")
                    surface.SetTextColor(0, 255, 0)
                    surface.SetTextPos((ScrW() - surface.GetTextSize(text))/ 2, ScrH() - 40)
                    surface.DrawText(text)

                elseif difference > 0 and difference <= 60 then

                    local text = math.Round(difference)

                    surface.SetFont("DermaLarge")
                    surface.SetTextColor(255, 255, 255)
                    surface.SetTextPos((ScrW() - surface.GetTextSize(text))/ 2, ScrH() - 40)
                    surface.DrawText(math.Round(difference))
    
                end
    
            end
        
        end)    
                    
    end

end

function SWEP:PrimaryAttack()

    if not IsFirstTimePredicted() then return end

    if CLIENT then return end

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    local tr = util.TraceLine ({

        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() - Vector(0, 0, 1024), 
        filter = self:GetOwner()

    })

    if tr.Hit then

        local squadshield = ents.Create("squadshield")

        squadshield:SetPos(tr.HitPos + Vector(0, 0, 2))
        squadshield:AddEffects(EF_NOSHADOW)
        squadshield:Spawn()

    else

        self:SetNextPrimaryFire(CurTime())

    end

end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end