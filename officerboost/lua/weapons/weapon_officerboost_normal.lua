SWEP.Category = "Summe"

SWEP.PrintName = "Officer Boost (Normal)"

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
        

        OfficerBoost:CreateBoost(owner, "Normal")

        if OfficerBoost.Config["Normal"].GiveBack then
            timer.Create("Officer_Boost_N_" .. owner:SteamID64(),OfficerBoost.Config["Normal"].GiveBack, 1, function()
                owner:Give(class)
            end)
        end

        owner:StripWeapon(class)
    end
end

if SERVER then
    hook.Add("PlayerSpawn", "SummeIsTrolling.Spawn.Normal", function(ply)
        local owner = ply:SteamID64()
        if timer.Exists("Officer_Boost_N_" .. owner) then
            timer.Remove("Officer_Boost_N_" .. owner)
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