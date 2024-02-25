local OBJ = RDV.LIBRARY.RegisterCharacter("mcs")

function OBJ:GetCharacterID(p)
    return p:GetCharacter()
end

function OBJ:OnCharacterLoaded(CALLBACK)
    RDV.LIBRARY.AddCharacterHook("PlayerLoadedCharacter", function(player, slot)
        CALLBACK(player, slot)
    end)
end

function OBJ:OnCharacterDeleted(CALLBACK)
    RDV.LIBRARY.AddCharacterHook("CharacterDeleted", function(player, slot)
        CALLBACK(player, slot)
    end)
end

function OBJ:OnCharacterChanged(CALLBACK)
    RDV.LIBRARY.AddCharacterHook("PrePlayerLoadedCharacter", function(client, new, old)
        if not old then
            return
        end
        
        if new ~= old then
            CALLBACK(client, new, old)
        end
    end)
end