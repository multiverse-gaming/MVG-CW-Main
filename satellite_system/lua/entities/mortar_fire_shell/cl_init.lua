include("shared.lua")

local counter = 0

function shellShockEffect(t)
    local ply=LocalPlayer()    
    ply:SetDSP(24)
    counter=counter+1

    local deftable = {
        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 1,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }

    local coltab = {
        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 0,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }


        local baseSpeed = ply:GetWalkSpeed()
        local runSpeed = ply:GetRunSpeed()   
        surface.PlaySound("effects/shellshock_mortar/mortar_shell_shock.mp3")
        ply:SetWalkSpeed(80)
        ply:SetRunSpeed(90)
        hook.Add("RenderScreenspaceEffects", "ShellshockEffect", function()
            DrawColorModify( coltab )
            DrawMotionBlur(0.1, 0.8, 0.01)        
        end)
        timer.Simple(t, function()
            counter=counter-1
            if (counter < 1) then
                hook.Remove("RenderScreenspaceEffects", "ShellshockEffect")
                ply:SetDSP(1)
                ply:SetWalkSpeed(baseSpeed)
                ply:SetRunSpeed(runSpeed)               
            end

        end)
end

function ENT:Draw()
    self:DrawModel()
end

net.Receive("kaito_net_sound_new_in",function()
    local shouldShellshock = GetConVar("k_mortcl_enable_shelllshock"):GetInt()
    local entPos = net.ReadVector()
    local ply = LocalPlayer()
	local plypos = ply:GetPos()
	local distance = ply:GetPos():Distance(entPos)

    if (distance < 4000) then
        surface.PlaySound("weapons/mortarimpactflame.mp3")
        timer.Simple(5, function()
            if (shouldShellshock==1) then
                if (distance < 1640) or (1640 > distance) then
                    shellShockEffect(4)
                end  
            end
            util.ScreenShake(Vector(0,0,0), 9, 5, 2, 9500)
        end)
    elseif (distance >= 4000 and distance < 10514) then
        surface.PlaySound("weapons/mortarimpactflame100m.mp3")
        timer.Simple(5, function()
            util.ScreenShake(Vector(0,0,0), 6, 4, 2, 5500)
        end)
    elseif (distance >= 10514 and distance < 900000) then
        surface.PlaySound("weapons/mortarimpactflame400m.mp3")
    end

    
end)