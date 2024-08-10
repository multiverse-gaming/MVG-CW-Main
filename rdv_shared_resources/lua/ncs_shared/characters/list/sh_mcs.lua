NCS_SHARED.AddCharacterSystem("mcs", {
    GetCharacterID = function(P)    
        return P:GetCharacter()
    end,
    hooks = {
        ["CharacterDeleted"] = function(P, SLOT)
            hook.Run("NCS_SHARED_CharacterDeleted", P, SLOT)
        end,
        ["PlayerLoadedCharacter"] = function(P, SLOT)
            hook.Run("NCS_SHARED_CharacterLoaded", P, SLOT)
        end,
        ["PrePlayerLoadedCharacter"] = function(P, NEW, OLD)
            if not OLD then return end
    
            if NEW ~= OLD then
                hook.Run("NCS_SHARED_CharacterChanged", P, NEW, OLD)
            end
        end,
    }
})