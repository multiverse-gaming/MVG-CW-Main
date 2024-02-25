-- Related to Event SetModel Command.
if SERVER then



    hook.Add("PlayerSpawn", "event_commands_mvg_keep_stuff", function(ply, transition)



        if ply:IsValid() and ply:GetNWString("EventModel") then

            local theplayer = ply



            timer.Simple(0, function()

                theplayer:SetModel(theplayer:GetNWString("EventModel", nil))

            end)



            timer.Simple(2, function()

                if theplayer:GetModel() != theplayer:GetNWString("EventModel", nil) then

                    theplayer:SetModel(theplayer:GetNWString("EventModel", nil))

                end

            end)



        end



    end)



    hook.Add("PlayerChangedTeam", "events_commands_mvg_remove_stuff_when_changing_job", function(ply, oldT, newT)



        if ply:IsValid() and ply:GetNWString("EventModel") then

            ply:SetNWString("EventModel", nil)

        end



    end)
end