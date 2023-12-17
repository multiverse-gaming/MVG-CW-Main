SWEP.Category = "Summe"

SWEP.PrintName = "Battle Focus"

SWEP.Base = "tfa_gun_base"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 70
SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.HoldType = "none"

SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false

function SWEP:PreDrawViewModel()
    render.SetBlend(0)
end

function SWEP:PrimaryAttack()
    if SERVER then

        local class = self:GetClass()
        local owner = self:GetOwner()

        OfficerBoost:CreateBoost(owner, "BattleFocus")

        if OfficerBoost.Config["BattleFocus"].GiveBack then
            timer.Create("BattleFocus_LS_" .. owner:SteamID64(),OfficerBoost.Config["BattleFocus"].GiveBack, 1, function()
                owner:Give(class)
            end)
        end

        owner:StripWeapon(class)
    end
end

if SERVER then
    hook.Add("PlayerSpawn", "SummeIsTrolling.Spawn.BattleFocus", function(ply)
        local owner = ply:SteamID64()

        if timer.Exists("BattleFocus_LS_" .. owner) then
            timer.Remove("BattleFocus_LS_" .. owner)
        end
    end)
end

function SWEP:SecondaryAttack()
    
end

function SWEP:Reload()
end

function SWEP:ProcessFireMode()
end
function SWEP:IronSights()
end
function SWEP:DrawHUDAmmo()
	return false
end