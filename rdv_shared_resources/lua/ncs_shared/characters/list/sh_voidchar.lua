NCS_SHARED.AddCharacterSystem("voidchar", {
    GetCharacterID = function(P)    
        return tonumber(P:GetCharacterID())
    end,
    hooks = {
        ["VoidChar.CharacterDeleted"] = function(P, charObj)
            hook.Run("NCS_SHARED_CharacterDeleted", P, tonumber(charObj.id))
        end,
        ["VoidChar.CharacterSelected"] = function(P, charObj)
            local SLOT = tonumber(charObj.id)

            if not IsValid(P) then return end
            print("Yes")
    
            hook.Run("NCS_SHARED_CharacterLoaded", P, SLOT)
        end,
        ["VoidChar.CharacterSelected"] = function(P, NEW, OLD)
            print("Yes4")

            if OLD then
                print("Yes3")

                if NEW ~= OLD then
                    print("Yes2")

                    hook.Run("NCS_SHARED_CharacterChanged", P, tonumber(NEW.id), tonumber(OLD.id))
                end
            end

            hook.Run("NCS_SHARED_CharacterLoaded", P, NEW.id)
        end,
    }
})