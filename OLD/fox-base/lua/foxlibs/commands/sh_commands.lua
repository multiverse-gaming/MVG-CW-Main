FoxLibs = FoxLibs or {}
FoxLibs.Commands = FoxLibs.Commands or {}




function FoxLibs.Commands:UpdatePrefix(prefix)
    do -- Verification of input.
        if not isstring(prefix) then
            print("[FoxLibs][Commands][UpdatePrefix] Failed to change prefix as it's not string.")
            return false
        end
    end

end

--[[
    Input: name of command.




    Args type:
        -> Specific case.
        -> 
]]
function FoxLibs.Commands:CreateCommand(name, args)
    do -- Verification of input.
        if not isstring(name) then
            print("[FoxLibs][Commands] Invalid input for name, must be string, input type right now: " .. type(name))
            return false
        end
        if not isstring(args) then
            print("[FoxLibs][Commands] Invalid input for args, must be table, input type right now: " .. type(args))
            return false
        end
        do -- Check all args in table are string.
            for i,v in pairs(args) do
                if not isstring(v) then
                    print("[FoxLibs][Commands] Invalid input for args VALUES, must be string for all, input type right now: " .. type(v))
                    return false
                end
            end
        end
    end



end