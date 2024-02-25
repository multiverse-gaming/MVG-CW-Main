gameevent.Listen("player_spawn")

hook.Add("player_spawn", "give_ammo_for_people", function(data)

    local ply = Player(data.userid)

    if ply:GetNWBool("WasAsleep", false) == true then

        ply:SetNWBool("WasAsleep", false)

        -- Just dont do anything, shouldn't give ammo, should just say out of sleep now.

    else

        ply:GiveAmmo(10,"grenade")

        ply:GiveAmmo(400, "ar2")

    end





end)



-- I added a networkvar in sleep to ensure to not give extra ammo.







-- NEW FEATURE: Notifies if someone does kill or "explode"



















hook.Add( "CanPlayerSuicide", "NotifySuicide", function( ply )

    for i, v in ipairs( player.GetAll() ) do

        if v:HasPermission("see_admin_chat") then

            v:sam_send_message("[STAFF] {S Red} just used kill command, just a heads up.", {S = ply:GetName()} )

        end

    end

end )