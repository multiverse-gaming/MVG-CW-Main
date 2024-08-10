NCS_SHARED.AddCharacterSystem("helix", {
    GetCharacterID = function(P)    
        return ( P:GetCharacter() and P:GetCharacter():GetID() )
    end,
    hooks = {
        ["CharacterDeleted"] = function(P, SLOT)
            hook.Run("NCS_SHARED_CharacterDeleted", P, SLOT)
        end,
        ["CharacterLoaded"] = function(CHAR)
            local P = CHAR:GetPlayer()

            if not IsValid(P) then return end
    
            hook.Run("NCS_SHARED_CharacterLoaded", P, CHAR:GetID())
        end,
        ["PrePlayerLoadedCharacter"] = function(P, NEW, OLD)
            if not OLD then return end
    
            if NEW ~= OLD then
                hook.Run("NCS_SHARED_CharacterChanged", P, NEW, OLD)
            end
        end,
    }
})