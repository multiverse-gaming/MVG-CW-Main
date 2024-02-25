if SAM_LOADED then return end

local sam, command, language = sam, sam.command, sam.language

-- if SERVER then
--     util.AddNetworkString("SAMFriendsCheck")
--     hook.Add("EntityTakeDamage", "DBanCode", function(target, dmginfo)
--         if dmginfo:GetAttacker():sam_get_nwvar("dban", false) == true then
--             dmginfo:ScaleDamage(0)
--         end
--     end)
--     local freeze_player = function(ply)
--         if SERVER then
--             ply:Lock()
--         end
--         ply:SetMoveType(MOVETYPE_NONE)
--         ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
--     end
-- end

-- local find_empty_pos -- https://github.com/FPtje/DarkRP/blob/b147d6fa32799136665a9fd52d35c2fe87cf7f78/gamemode/modules/base/sv_util.lua#L149
-- do
--     local is_empty = function(vector, ignore)
--         local point = util.PointContents(vector)
--         local a = point ~= CONTENTS_SOLID
--             and point ~= CONTENTS_MOVEABLE
--             and point ~= CONTENTS_LADDER
--             and point ~= CONTENTS_PLAYERCLIP
--             and point ~= CONTENTS_MONSTERCLIP
--         if not a then return false end

--         local ents_found = ents.FindInSphere(vector, 35)
--         for i = 1, #ents_found do
--             local v = ents_found[i]
--             if (v:IsNPC() or v:IsPlayer() or v:GetClass() == "prop_physics" or v.NotEmptyPos) and v ~= ignore then
--                 return false
--             end
--         end

--         return true
--     end

--     local distance, step, area = 600, 30, Vector(16, 16, 64)
--     local north_vec, east_vec, up_vec = Vector(0, 0, 0), Vector(0, 0, 0), Vector(0, 0, 0)

--     find_empty_pos = function(pos, ignore)
--         if is_empty(pos, ignore) and is_empty(pos + area, ignore) then
--             return pos
--         end

--         for j = step, distance, step do
--             for i = -1, 1, 2 do
--                 local k = j * i

--                 -- North/South
--                 north_vec.x = k
--                 if is_empty(pos + north_vec, ignore) and is_empty(pos + north_vec + area, ignore) then
--                     return pos + north_vec
--                 end

--                 -- East/West
--                 east_vec.y = k
--                 if is_empty(pos + east_vec, ignore) and is_empty(pos + east_vec + area, ignore) then
--                     return pos + east_vec
--                 end

--                 -- Up/Down
--                 up_vec.z = k
--                 if is_empty(pos + up_vec, ignore) and is_empty(pos + up_vec + area, ignore) then
--                     return pos + up_vec
--                 end
--             end
--         end

--         return pos
--     end
-- end

command.set_category("Extra")

-------------------------------------------------------------------------------
--   Set Run Speed	
---------------------------------------------------------------------------*/
-- command.new("setrunspeed")
--     :SetPermission("setrunspeed", "superadmin")

--     :AddArg("player")
--     :AddArg("number", { hint = "amount", optional = true, min = 100, max = 600, default = 280 })
--     :AddArg("number", { hint = "minutes", optional = true, default = 600, round = true })

--     :Help("Sets the Players Run Speed")

--     :OnExecute(function(ply, targets, amount, length)
--         for i = 1, #targets do
--             targets[i]:SetRunSpeed(amount)
--             timer.Create("SAM.RunSpeed." .. targets[i]:SteamID(), length * 60, 1, function()
--                 if IsValid(targets[i]) then
--                     for i = 1, #targets do
--                         targets[i]:SetRunSpeed(240)
--                     end
--                 end
--             end)
--         end

--         if sam.is_command_silent then return end

--         ply:sam_send_message("{A} set the Run Speed for {T} to {V}", {
--             A = ply, T = targets, V = amount
--         })
--     end)
--     :End()

-----------------------------------------------------------------------------
--    Set Walk Speed	
---------------------------------------------------------------------------*/
-- command.new("setwalkspeed")
--     :SetPermission("setwalkspeed", "superadmin")

--     :AddArg("player")
--     :AddArg("number", { hint = "amount", optional = true, min = 100, max = 600, default = 160 })
--     :AddArg("number", { hint = "seconds", optional = true, default = 600, round = true })

--     :Help("Sets the Players Walk Speed")

--     :OnExecute(function(ply, targets, amount, length)
--         for i = 1, #targets do
--             targets[i]:SetWalkSpeed(amount)
--             timer.Create("SAM.WalkSpeed." .. targets[i]:SteamID(), length, 1, function()
--                 if IsValid(targets[i]) then
--                     for i = 1, #targets do
--                         targets[i]:SetWalkSpeed(160)
--                     end
--                 end
--             end)
--         end

--         if sam.is_command_silent then return end
--         ply:sam_send_message("{A} set the Walk Speed for {T} to {V}", {
--             A = ply, T = targets, V = amount
--         })
--     end)
--     :End()

-----------------------------------------------------------------------------
--    Set Jump Power
---------------------------------------------------------------------------*/
-- command.new("setjumppower")
--     :SetPermission("setjumppower", "superadmin")

--     :AddArg("player")
--     :AddArg("number", { hint = "amount", optional = true, min = 100, max = 600, default = 200 })
--     :AddArg("number", { hint = "seconds", optional = true, default = 600, round = true })

--     :Help("Sets the Players Jump Power")

--     :OnExecute(function(ply, targets, amount, length)
--         for i = 1, #targets do
--             targets[i]:SetJumpPower(amount)
--             timer.Create("SAM.JumpPower." .. targets[i]:SteamID(), length, 1, function()
--                 if IsValid(targets[i]) then
--                     for i = 1, #targets do
--                         targets[i]:SetJumpPower(200)
--                     end
--                 end
--             end)
--         end

--         if sam.is_command_silent then return end
--         ply:sam_send_message("{A} set the Jump Power for {T} to {V}", {
--             A = ply, T = targets, V = amount
--         })
--     end)
--     :End()


-----------------------------------------------------------------------------
--    PlaySound		
---------------------------------------------------------------------------*/

-- command.new("playsound")
--     :SetPermission("playsound", "admin")

--     :AddArg("text", { hint = "sound" })

--     :Help("Plays a sound on all Clients")

--     :OnExecute(function(ply, text)
--         if not file.Exists("sound/" .. text, "GAME") then
--             sam.player.send_message(ply, "The sound " .. text .. " doesn't exist on the Server!")
--             return
--         end
--         BroadcastLua('surface.PlaySound("' .. text .. '")')
--         if sam.is_command_silent or ! ply:IsPlayer() then return end
--         ply:sam_send_message("{A} played '{V}' on all Players", {
--             A = ply, V = text
--         })
--     end)
--     :End()

-----------------------------------------------------------------------------
--    Steam Profile
---------------------------------------------------------------------------*/

-- command.new("steamprofile")
--     :SetPermission("steamprofile", "admin")

--     :AddArg("player", { optional = true })

--     :Help("Opens the Players Steam Profile")

--     :OnExecute(function(ply, targets)
--         for i = 1, #targets do
--             ply:SendLua("gui.OpenURL('http://steamcommunity.com/profiles/" .. targets[i]:SteamID64() .. "')")
--         end
--     end)
--     :End()

-----------------------------------------------------------------------------
--    Friends Check		
---------------------------------------------------------------------------*/
-- command.new("friends")
--     :SetPermission("friends", "admin")

--     :AddArg("player", { optional = true, single_target = true })

--     :OnExecute(function(ply, targets)
--         for i = 1, #targets do
--             net.Start("SAMFriendsCheck")
--             net.WriteEntity(ply)
--             net.Send(targets[i])
--         end
--     end)
--     :End()

-- if (CLIENT) then
--     local friendstab = {}

--     net.Receive("SAMFriendsCheck", function(len, ply)
--         local caller = net.ReadEntity()
--         for k, v in pairs(player.GetAll()) do
--             if v:GetFriendStatus() == "friend" then
--                 table.insert(friendstab, v:Nick())
--             end
--         end

--         net.Start("friends_check")
--         net.WriteEntity(caller)
--         net.WriteTable(friendstab)
--         net.SendToServer()

--         table.Empty(friendstab)
--     end)
-- end

-- if (SERVER) then
--     util.AddNetworkString("friends_check")

--     net.Receive("friends_check", function(len, ply)
--         local calling, tabl = net.ReadEntity(), net.ReadTable()
--         local tab = table.concat(tabl, ", ")

--         if (string.len(tab) == 0 and table.Count(tabl) == 0) then
--             calling:ChatPrint(ply:Nick() .. "(" .. ply:SteamID() .. ") is not Friends with anyone on the Server")
--         else
--             calling:ChatPrint(ply:Nick() .. "(" .. ply:SteamID() .. ") is Friends with " .. tab)
--         end
--     end)
-- end

-----------------------------------------------------------------------------
--    Disable Damage for Players		
---------------------------------------------------------------------------*/

command.new("dban")
    :SetPermission("dban", "admin")

    :AddArg("player", { allow_higher_target = false, single_target = true })
    :AddArg("text", { hint = "reason", optional = true, default = sam.language.get("default_reason") })
    :AddArg("number", { hint = "minutes", optional = true, default = 600, round = true })

    :Help("Disables the ability for the Player to Deal Damage")

    :OnExecute(function(ply, targets, reason, length)
        for i = 1, #targets do
            targets[i]:sam_set_nwvar("dban", true)
            timer.Create("SAM.DBan." .. targets[i]:SteamID(), length * 60, 1, function()
                if IsValid(targets[i]) then
                    targets[i]:sam_set_nwvar("dban", false)
                end
            end)
        end

        if sam.is_command_silent then return end

        ply:sam_send_message("{A} Disabled Damage for {T} for reason: {V}", {
            A = ply, T = targets, V = reason
        })
    end)
    :End()

command.new("undban")
    :SetPermission("undban", "admin")

    :AddArg("player", { allow_higher_target = false, single_target = true })

    :Help("Re-Enables the ability for the Player to Deal Damage")

    :OnExecute(function(ply, targets)
        for i = 1, #targets do
            targets[i]:sam_set_nwvar("dban", false)
            timer.Remove("SAM.DBan." .. ply:SteamID())
        end

        if sam.is_command_silent then return end

        ply:sam_send_message("{A} Re-Enabled Damage for {T}", {
            A = ply, T = targets
        })
    end)
    :End()

-----------------------------------------------------------------------------
--    Bring & Freeze	
---------------------------------------------------------------------------*/
command.new("fbring")
    :DisallowConsole()
    :SetPermission("fbring", "admin")

    :AddArg("player", { cant_target_self = true })

    :Help("Teleports the Player to you and Freezes them")

    :OnExecute(function(ply, targets)
        if not ply:Alive() then
            return ply:sam_send_message("dead")
        end

        if ply:InVehicle() then
            return ply:sam_send_message("leave_car")
        end

        if ply:sam_get_exclusive(ply) then
            return ply:sam_send_message(ply:sam_get_exclusive(ply))
        end

        local teleported = { admin = ply }
        local all = targets.input == "*"

        for i = 1, #targets do
            local target = targets[i]

            if target:sam_get_exclusive(ply) then
                if not all then
                    ply:sam_send_message(target:sam_get_exclusive(ply))
                end
                continue
            end

            if not target:Alive() then
                target:Spawn()
            end

            target.sam_tele_pos, target.sam_tele_ang = target:GetPos(), target:EyeAngles()

            target:ExitVehicle()
            target:SetVelocity(Vector(0, 0, 0))
            target:SetPos(find_empty_pos(ply:GetPos(), target))
            target:SetEyeAngles((ply:EyePos() - target:EyePos()):Angle())

            table.insert(teleported, target)

            timer.Simple(1, function()
                if SERVER then
                    target:Lock()
                end
                target:SetMoveType(MOVETYPE_NONE)
                target:SetCollisionGroup(COLLISION_GROUP_WORLD)
                target:sam_set_nwvar("frozen", true)
                target:sam_set_exclusive("frozen")
            end)
        end

        if #teleported > 0 then
            ply:sam_send_message("bring", {
                A = ply, T = teleported
            })
        end
    end)
    :End()

-----------------------------------------------------------------------------
--    Check if Banned	
---------------------------------------------------------------------------*/
command.new("checkban")     -- Finish
    :SetPermission("checkban", "admin")
    :AddArg("steamid")
    :Help("Checks if the SteamID is banned")

    :OnExecute(function(ply, promise)
        promise:done(function(data)
            local steamid, target = data[1], data[2]

            sam.player.is_banned(steamid, function(banned)
                if ! (banned) then
                    ply:sam_send_message("{T} isn't banned", {     --banned["reason"]
                        A = ply, T = steamid
                    })
                else
                    ply:sam_send_message(
                    "{T} was Banned for " ..
                    banned["reason"] .. " Unban Date: " .. os.date("%I:%M:%S - %d/%m/%Y", banned["unban_date"]), {
                        A = ply, T = steamid
                    })
                end
            end)
        end)
    end)
    :End()

-----------------------------------------------------------------------------
--    Mute & Gag
---------------------------------------------------------------------------*/
-- do
--     command.new("mg")
--         :SetPermission("mg", "admin")

--         :AddArg("player")
--         :AddArg("length", { optional = true, default = 0, min = 0 })
--         :AddArg("text", { hint = "reason", optional = true, default = sam.language.get("default_reason") })

--         :GetRestArgs()

--         :Help("Mutes and Gags Player")

--         :OnExecute(function(ply, targets, length, reason)
--             local current_time = SysTime()

--             for i = 1, #targets do
--                 local target = targets[i]
--                 target:sam_set_pdata("unmute_time", length ~= 0 and (current_time + length * 60) or 0)

--                 target.sam_gagged = true
--                 if length ~= 0 then
--                     timer.Create("SAM.UnGag" .. target:SteamID64(), length * 60, 1, function()
--                         RunConsoleCommand("sam", "ungag", "#" .. target:EntIndex())
--                     end)
--                 end
--             end
--             ply:sam_send_message("{A} Muted and Gagged {T} for {V} Reason: {V_2}", {
--                 A = ply, T = targets, V = sam.format_length(length), V_2 = reason
--             })
--         end)
--         :End()
-- end

-----------------------------------------------------------------------------
--    Warn & Ban		
---------------------------------------------------------------------------*/
-- command.new("wban")
--     :SetPermission("wban", "admin")

--     :AddArg("player", { single_target = true })
--     :AddArg("length", { optional = true, default = 0 })
--     :AddArg("text", { hint = "reason", optional = true, default = sam.language.get("default_reason") })

--     :GetRestArgs()

--     :Help("Bans and Warns the Player")

--     :OnExecute(function(ply, targets, length, reason)
--         local target = targets[1]
--         if ply:GetBanLimit() ~= 0 then
--             if length == 0 then
--                 length = ply:GetBanLimit()
--             else
--                 length = math.Clamp(length, 1, ply:GetBanLimit())
--             end
--         end
--         AWarn:CreateWarningID(target:SteamID64(), ply:SteamID64(), reason)
--         target:sam_ban(length, reason, ply:SteamID())

--         ply:sam_send_message("ban", {
--             A = ply, T = target:Name(), V = sam.format_length(length), V_2 = reason
--         })
--     end)
--     :End()

-----------------------------------------------------------------------------
--    Job Ban		
---------------------------------------------------------------------------*/
command.new("jobban")
    :SetPermission("jobban", "admin")

    :AddArg("player", { single_target = true })
    :AddArg("text", { hint = "job" })
    :AddArg("number", { hint = "minutes", optional = true, default = 60, round = true })
    :AddArg("text", { hint = "reason", optional = true, default = sam.language.get("default_reason") })

    :Help("Bans the Player from a Certain Job for set amount of time. (Jobcode!)")

    :OnExecute(function(ply, targets, job, length, reason)
        for i = 1, #targets do
            local jobName = string.lower(job)
            local jobID
            for _, job in pairs(RPExtraTeams) do
                if (string.lower(job["name"]) == jobName) then
                    jobID = job["team"] or nil
                end
            end
            if (jobID) then
                targets[i]:teamBan(jobID, length * 60)
            end
        end

        if sam.is_command_silent then return end
        ply:sam_send_message(
        "{A} banned {T} from the " .. tostring(job) .. " Job for " .. length .. " Minutes for Reason: " .. reason, {
            A = ply, T = targets
        })
    end)
    :End()

-----------------------------------------------------------------------------
--    Job UnBan		
---------------------------------------------------------------------------*/
command.new("jobunban")
    :SetPermission("jobunban", "admin")

    :AddArg("player", { single_target = true })
    :AddArg("text", { hint = "job" })

    :Help("Bans the Player from a Certain Job for set amount of time")

    :OnExecute(function(ply, targets, job)
        for i = 1, #targets do
            local jobName = string.lower(job)
            local jobID
            for _, job in pairs(RPExtraTeams) do
                if (string.lower(job["name"]) == jobName) then
                    jobID = job["team"] or nil
                end
            end
            if (jobID) then
                targets[i]:teamUnBan(jobID)
            end
        end

        if sam.is_command_silent then return end
        ply:sam_send_message("{A} unbanned {T} from the " .. tostring(job) .. " Job", {
            A = ply, T = targets
        })
    end)
    :End()


-----------------------------------------------------------------------------
--    Strip non-default weapons	[STRONG WORK IN PROGRESS]
---------------------------------------------------------------------------*/


command.new("stripw")
    :SetPermission("stripw", "admin")
    :AddArg("player")
    :AddArg("text", { hint = "weapon(s)" })
    :Help("Strip specific weapons from player(s). WIP")

    :OnExecute(function(ply, targets, weapon)
        for i = 1, #targets do
            targets[i]:StripWeapon(weapon)
        end

        -- local targetNames = table.concat(targets, ", ") -- Convert the table to a comma-separated string
        -- local targetWeapons = table.concat(weapons, ", ") -- Convert the table to a comma-separated string

        sam.player.send_message(nil, "{A} stripped {V} from {T}.", {
            A = ply, V = weapon, T = targets -- Use the string representation of targets
        })
    end)
:End()