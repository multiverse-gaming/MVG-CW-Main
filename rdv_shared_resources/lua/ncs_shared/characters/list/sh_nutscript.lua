NCS_SHARED.AddCharacterSystem("nutscript", {
    GetCharacterID = function(P)    
        return ( P:getChar() and P:getChar():getID() )
    end,
    hooks = {
        ["OnCharacterDelete"] = function(P, SLOT)
            hook.Run("NCS_SHARED_CharacterDeleted", P, SLOT)
        end,
        ["PlayerLoadedChar"] = function(P, NEW, OLD)
            hook.Run("NCS_SHARED_CharacterLoaded", client, NEW:getID())

            if not OLD then return end
    
            if NEW ~= OLD then
                hook.Run("NCS_SHARED_CharacterChanged", client, NEW:getID(), OLD:getID())
            end
        end,
    }
})