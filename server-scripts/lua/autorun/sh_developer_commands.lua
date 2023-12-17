if SERVER then return end




local function Commands()
    concommand.Add("dev.hook_viewer", function( ply, cmd, args )
        local size = #args

        if size == 2 then
            local tbl = hook.GetTable()[args[1]][args[2]]

            PrintTable(tbl)
        elseif size == 1 then
            local tbl = hook.GetTable()[args[1]]

            PrintTable(tbl)        
        elseif size == 0 then
            PrintTable(hook.GetTable())
        end

    end)

    concommand.Add("dev.print", function(ply, cmd, args)
        

        local concat = table.concat(args)
        print(concat)
        RunString(concat)
    
    end)


end

hook.Add("InitPostEntity", "Developer.AddCommands.Check", function()
    local getRank = LocalPlayer():GetUserGroup()

    if getRank == "superadmin" or getRank == "developer" or getRank == "activedeveloper" then
        Commands()
    end
end)