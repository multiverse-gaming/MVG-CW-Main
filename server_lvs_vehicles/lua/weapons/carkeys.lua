SWEP.PrintName = "Vehicle Keys"
SWEP.Category = "Durians Weapons"
SWEP.Spawnable = true

SWEP.Author = "Durian"
SWEP.Instructions = ""

SWEP.Slot = 1 
SWEP.SlotPos = 127 
SWEP.DrawAmmo = false 

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModelFOV = 70
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/Hl2/c_fists.mdl"
SWEP.WorldModel = ""


function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsLocked")
end

function SWEP:PrimaryAttack()
    if CLIENT then return end

    local ply = self.Owner
    local ent = ply:GetEyeTrace().Entity

    if not IsValid(ent) then return false end
    if not ent.LVS and not ent.LFS then return end

    local vehOwner = ent:GetNWEntity("owner")
    
    if vehOwner == NULL then
        vehOwner = ply
        ent:SetNWEntity("owner", ply)
    end

    if vehOwner:UniqueID() == ply:UniqueID() then
        if self:GetIsLocked() then
            ply:PrintMessage( HUD_PRINTCENTER, "Vehicle Already Locked" )
        else
            ent:Lock()
            self:SetIsLocked(true)
            ply:PrintMessage( HUD_PRINTCENTER, "Vehicle Locked" )
        end
    else
        ply:PrintMessage( HUD_PRINTCENTER , "Vehicle Not Yours")
    end
end

function SWEP:SecondaryAttack()
    if CLIENT then return end

    local ply = self.Owner
    local ent = ply:GetEyeTrace().Entity

    if not IsValid(ent) then return false end
    if not ent.LVS and not ent.LFS then return end

    local vehOwner = ent:GetNWEntity("owner")
    
    if vehOwner == NULL then
        vehOwner = ply
        ent:SetNWEntity("owner", ply)
    end

    if vehOwner:UniqueID() == ply:UniqueID() then
        if not self:GetIsLocked() then
            ply:PrintMessage( HUD_PRINTCENTER, "Vehicle Already Unlocked" )
        else
            ent:UnLock()
            self:SetIsLocked(false)
            ply:PrintMessage( HUD_PRINTCENTER, "Vehicle Unlocked" )
        end
    else
        ply:PrintMessage( HUD_PRINTCENTER , "Vehicle Not Yours")
        
    end
end

tkccooldown = 0.25


local lastReloadTime = 0

function SWEP:Reload()
    if (os.time() - lastReloadTime) > tkccooldown then
        if CLIENT then return end

        local ply = self.Owner
        local ent = ply:GetEyeTrace().Entity

        if not IsValid(ent) then return false end
        if not ent.LVS and not ent.LFS then return end

        local vehOwner = ent:GetNWEntity("owner")

        if vehOwner == NULL then
            local vehOwner = ply
            ent:SetNWEntity("owner", ply)
            ply:PrintMessage( HUD_PRINTCENTER, "This Now Your Vehicle")
            ent:SetNWEntity("owner", ply)
        elseif vehOwner:UniqueID() == ply:UniqueID() then
            ply:PrintMessage( HUD_PRINTCENTER , "This is No Longer Your Vehicle")
            ent:SetNWEntity("owner", NULL)
        else
            ply:PrintMessage(HUD_PRINTCENTER , "This Vehicle is Already Owned")
        end
        lastReloadTime = os.time()
    end
end