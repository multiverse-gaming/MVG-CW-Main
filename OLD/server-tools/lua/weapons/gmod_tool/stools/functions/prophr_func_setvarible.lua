function setVarible(_self, id, type, data)
    if CLIENT then
        if (type == 'int') then
            GetConVar(id):SetInt(data)
        else
            if (type == 'float') then
                GetConVar(id):SetFloat(data)
            end
        end
    end
    --
    --
    --
    if SERVER then
        -- Sett nettverks-data
        if (type == 'int') then
            _self:SetNWInt(id, data) 
        else
            if (type == 'float') then
                _self:SetNWFloat(id, data) 
            end
        end
    end
end
