local OBJ = RDV.LIBRARY.RegisterCharacter("helix")

function OBJ:GetCharacterID(p)
    if not p:GetCharacter() then
        return
    end

    return p:GetCharacter():GetID()
end

function OBJ:OnCharacterLoaded(CALLBACK)
    RDV.LIBRARY.AddCharacterHook("CharacterLoaded", function(char, slot)
        local player = char:GetPlayer()

        if not IsValid(player) then
            return
        end

        local slot = char:GetID()

        CALLBACK(player, slot)
    end)
end

function OBJ:OnCharacterDeleted(CALLBACK)
    RDV.LIBRARY.AddCharacterHook("CharacterDeleted", function(player, char)
        CALLBACK(player, char)
    end)
end

function OBJ:OnCharacterChanged(CALLBACK)
    RDV.LIBRARY.AddCharacterHook("PrePlayerLoadedCharacter", function(client, new, old)
        if not old then
            return
        end

        if new ~= old then
            CALLBACK(client, new:GetID(), old:GetID())
        end
    end)
end