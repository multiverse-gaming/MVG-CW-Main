-- Related to Set HP Command
if SERVER then
    
    hook.Add("PlayerSpawn", "event_commands_mvg_keep_hp", function(ply, transition)
    
    if ply:IsValid() and ply:GetNWString("EventHealth") then

       -- MsgC (Color (17,236,116,255),"[Event Health] ",Color(255,255,255), ply, Color(0,255,255), ply:GetNWString("EventHealth"),Color(255,255,255), type(ply:GetNWString("EventHealth")) ,Color(255,255,255), "\n" )

        if ply:GetNWString("EventHealth") == "Remove" then return end

            local theplayer = ply
            timer.Simple(0, function()

                theplayer:SetHealth(theplayer:GetNWString("EventHealth")) --, nil
                
                theplayer:SetMaxHealth(theplayer:GetNWString("EventHealth")) --, nil

            end)
        end
    end)



    hook.Add("PlayerChangedTeam", "events_commands_mvg_remove_hp_when_changing_job", function(ply, oldT, newT)

       -- MsgC (Color (17,236,116,255),"[Event Health Remove] ",Color(255,255,255), ply ,Color(255,255,255),"\n")

        if ply:IsValid() and ply:GetNWString("EventHealth") then
          --  MsgC (Color (17,236,116,255),"[Event Health Test] ",Color(255,255,255), ply ,Color(255,255,255), "\n")

            ply:SetNWString("EventHealth", "Remove")

        end

    end)


end