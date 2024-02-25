-- Related to Give Event Weapon Command
if SERVER then
    
    hook.Add("PlayerSpawn", "event_commands_mvg_keep_primary", function(ply, transition)
    
    if ply:IsValid() and ply:GetNWString("EventPrimary") then

            local theplayer = ply



            timer.Simple(0, function()

                theplayer:Give(theplayer:GetNWString("EventPrimary", nil))

            end)
        end
    end)
    
    hook.Add("PlayerSpawn", "event_commands_mvg_keep_secondary", function(ply, transition)
    
    if ply:IsValid() and ply:GetNWString("EventSecondary") then

            local theplayer = ply



            timer.Simple(0, function()

                theplayer:Give(theplayer:GetNWString("EventSecondary", nil))

            end)
        end
    end)



    hook.Add("PlayerChangedTeam", "events_commands_mvg_remove_weapon_when_changing_job", function(ply, oldT, newT)



        if ply:IsValid() and ply:GetNWString("EventPrimary") then

            ply:SetNWString("EventPrimary", nil)

        end
        
        if ply:IsValid() and ply:GetNWString("EventSecondary") then

            ply:SetNWString("EventSecondary", nil)

        end



    end)


end