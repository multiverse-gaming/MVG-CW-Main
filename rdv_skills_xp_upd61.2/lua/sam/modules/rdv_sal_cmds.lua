sam.command.set_category("[NS] Addons")

sam.command.new("setlevel")
    :SetPermission("setlevel") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!
   
    :Help("(SAL) Set the Level of a player.")
   
    :AddArg("player", {
        optional = true, -- makes it target the player who is calling if there is no input, like !god (MAKE SURE TO MAKE IT THE ONLY ARGUMENT)
        single_target = true, -- only targets one player
        cant_target_self = false, -- disallow the player who is calling to target himself
        allow_higher_target = false, -- allow the player who is calling to target anyone, admin -> superadmin, useful for commands like !goto
    })

    :AddArg("number", {optional = false, default = 0})

    -- arrays https://www.lua.org/pil/11.1.html
    :OnExecute(function(calling_ply, targets, val)
        RDV.SAL.SetLevel(targets[1], val)
 
        sam.player.send_message(nil, "{A} has set the level of {T} to {V}.", {
            A = calling_ply, T = targets, V = val, V_2 = name, V_3 = length
        })
    end)
:End()

sam.command.new("givexp")
    :SetPermission("givexp") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!
   
    :Help("(SAL) Give XP to a player.")
   
    :AddArg("player", {
        optional = false, -- makes it target the player who is calling if there is no input, like !god (MAKE SURE TO MAKE IT THE ONLY ARGUMENT)
        single_target = true, -- only targets one player
        cant_target_self = false, -- disallow the player who is calling to target himself
        allow_higher_target = false, -- allow the player who is calling to target anyone, admin -> superadmin, useful for commands like !goto
    })

    :AddArg("number", {optional = false, default = 0})

    -- arrays https://www.lua.org/pil/11.1.html
    :OnExecute(function(calling_ply, targets, val)
        RDV.SAL.AddExperience(targets[1], val)

        sam.player.send_message(nil, "{A} has given {V} XP to {T}.", {
            A = calling_ply, T = targets, V = val, V_2 = name, V_3 = length
        })
    end)
:End()

sam.command.new("giveskillpoints")
    :SetPermission("giveskillpoints") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!
   
    :Help("(SAL) Give skillpoints to a player.")
   
    :AddArg("player", {
        optional = false, -- makes it target the player who is calling if there is no input, like !god (MAKE SURE TO MAKE IT THE ONLY ARGUMENT)
        single_target = true, -- only targets one player
        cant_target_self = false, -- disallow the player who is calling to target himself
        allow_higher_target = false, -- allow the player who is calling to target anyone, admin -> superadmin, useful for commands like !goto
    })

    :AddArg("number", {optional = false, default = 0})

    -- arrays https://www.lua.org/pil/11.1.html
    :OnExecute(function(calling_ply, targets, val)
        RDV.SAL.GivePoints(targets[1], val)

        sam.player.send_message(nil, "{A} has given {V} skillpoints to {T}.", {
            A = calling_ply, T = targets, V = val, V_2 = name, V_3 = length
        })
    end)
:End()