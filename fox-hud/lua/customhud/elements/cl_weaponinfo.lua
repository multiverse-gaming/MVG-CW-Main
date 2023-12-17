
local PANEL = {}



function PANEL:Init()

    self:SetSize(100, 100 )
    self:SetAlpha(248) --245
    self:SetPos(50,30)
    



end 

local marginPercOfMainBox = 0.02


function PANEL:Paint( width, height )

	
    if LocalPlayer():GetActiveWeapon() == NULL then return end
    local weapon = LocalPlayer():GetActiveWeapon():GetPrintName()

    if weapon == NULL then return end


    surface.SetFont( "DermaDefault" )
    surface.SetTextColor( 255, 255, 255 )
    surface.SetTextPos( 4, 3 ) -- 3,3
    surface.DrawText( weapon )

    surface.SetFont( "DermaDefault" )
    surface.SetTextColor( 255, 255, 255 )
    surface.SetTextPos( 4, 25 ) --    surface.SetTextPos( 3, 35 ) 


    -- This is put here to keep it ASAP.

    local Clip1 = LocalPlayer():GetActiveWeapon():Clip1()
    local MaxAmmo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
    local MaxClip1 =  LocalPlayer():GetActiveWeapon():GetMaxClip1() 
    
    if MaxClip1 == -1 then return end

    surface.DrawText( Clip1 .. " / " .. MaxClip1 .. " | " .. "Reserved: " .. MaxAmmo )




end



vgui.Register( "Fox.WeaponInfo", PANEL, "Panel" )

