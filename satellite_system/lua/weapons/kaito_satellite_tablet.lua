//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

AddCSLuaFile()


SWEP.PrintName          = "Satellite Link Tablet"
SWEP.Category = "[Kaito] Artillery System"
SWEP.Author             = "Kaito"

SWEP.Spawnable          = true
SWEP.AdminOnly          = true
SWEP.HoldType           = "camera"

SWEP.Primary.ClipSize   = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic  = false
SWEP.Primary.Ammo       = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.ViewModel = "models/tablet_uav/c_tablet_uav.mdl"
SWEP.WorldModel = "models/tablet_uav/w_tablet_uav.mdl"

SWEP.IconOverride = "materials/weapons/kaito/ksus_icon.png"

SWEP.MainUseTimeout = -1        // might want to not spam
SWEP.SecondaryTimeout = -1      // same.
SWEP.isSatelliteActive = false  // 

SWEP.artilleryTimeOut = 0

SWEP.SwayScale = 0.4 -- if textures bugs
SWEP.BobScale = 0.4
SWEP.SwayScale = 0.4

SWEP.IconOverride = "materials/weapons/kaito/ksus/slt.png"

SWEP.UseHands = true

function SWEP:PlayAnimation()
    -- print('Called') 
    local ply = self:GetOwner() 
    local vm = ply:GetViewModel() 
    print(vm)
    vm:SendViewModelMatchingSequence( vm:LookupSequence( "attack" ) ) 
end

function SWEP:Deploy()
    timer.Simple(0.6,function()
        local ply = self:GetOwner() 
        local vm = ply:GetViewModel() 
        vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )     
    end)

end


function SWEP:PrimaryAttack()

    if self.MainUseTimeout < CurTime() then
        if not IsFirstTimePredicted() then return end
        self.MainUseTimeout = CurTime() + 2 
        if SERVER then
            local cameraUseState = self.Owner:GetNWBool('ksus_plySatelCameraIsActive',NULL)
            
            if not cameraUseState or cameraUseState == NULL then
                net.Start('ksus.net.fromServer.toClient.openMainSatelliteVGUI')
                net.Send(self.Owner)                
            else -- here if Camera is Active
                net.Start('ksus.net.fromServer.toClient.openInCommandVGUI',false)
                net.Send(self.Owner)
            end

        end
        -- self.Owner:ChatPrint("Test.")
    end
end

SWEP.currentFOVIndent = 1


function SWEP:SecondaryAttack()
    if self.MainUseTimeout < CurTime() then
        if not IsFirstTimePredicted() then return end
        self.MainUseTimeout = CurTime() + 0.8
        local cameraUseState = self.Owner:GetNWBool('ksus_plySatelCameraIsActive',NULL)
            
        if not cameraUseState or cameraUseState == NULL then return end
        local fovTable = {
            [1] = 80,
            [2] = 60,
            [3] = 40,
            [4] = 20,
        }
        if SERVER then
            self.Owner:SendLua("surface.PlaySound('kaito/ksus/others/satellite_zoom.mp3')")
            self.Owner:SetFOV(fovTable[self.currentFOVIndent] or 90,0.8)
        end
        self.currentFOVIndent = self.currentFOVIndent + 1
        if self.currentFOVIndent > 4 then
            self.currentFOVIndent = 1
        end 
        -- self.Owner:ChatPrint("Test.")
    end
    
end

function SWEP:Reload()
    if self.MainUseTimeout < CurTime() then
        if not IsFirstTimePredicted() then return end
        self.MainUseTimeout = CurTime() + 1
        -- print('Called')
        -- local ply = self:GetOwner() 
        -- local vm = ply:GetViewModel() 
        -- vm:SendViewModelMatchingSequence( vm:LookupSequence( "attack" ) )   
        -- timer.Simple(4,function()
        --     vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )   
        --     timer.Simple(2.25,function()
        --         vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )   
        --     end)
        -- end)
    end
end