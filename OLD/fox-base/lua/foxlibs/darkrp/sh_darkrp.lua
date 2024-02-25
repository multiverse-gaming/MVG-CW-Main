FoxLibs = FoxLibs or {}
FoxLibs.DarkRP = FoxLibs.DarkRP or {}

--[[
    WID:
        Input: jobName | The name of the job in strin format.

        Output: 
        1) Does job exist (bool)
        2) Job category name.
]]
function FoxLibs.DarkRP:JobExists(jobName)
    local jobTable = DarkRP.getCategories()["jobs"]

    for key, value in pairs(jobTable) do

        if value["members"] ~= nil and istable(value["members"]) then
            for i,v in pairs(value["members"]) do
                if istable(v) and isstring(v["name"]) and v["name"] == jobName then
                    return true, value["name"]
                end
            end

        end
    end

    return false

end

function FoxLibs.DarkRP:GetJobCategory(jobName)
    local exists, nameCat = FoxLibs.DarkRP:JobExists(jobName)

    if exists then
        return nameCat
    else
        if Debug_Fox then
            print("[FoxLibs][DarkRP] Couldn't find job in a category, job probably doesn't exist.")
        end
        return false
    end


end


--[[
    WID:
        Input: name
        Output: Job info (table) (A COPY OF IT NOT DIRECT OUTPUT)

        NOTE: It will double check with FoxLibs.DarkRP:JobExists(jobName) it's valid.
]]
function FoxLibs.DarkRP:GetJobInfo(jobName)
    if FoxLibs.DarkRP:JobExists(jobName) then
        local catName = FoxLibs.DarkRP:GetJobCategory(jobName)

        if catName ~= false then
            local jobTable = DarkRP.getCategories()["jobs"]

            for i, v in pairs(jobTable) do
                if v["name"] == catName then
                    for k, t in pairs(v["members"]) do
                        if t["name"] == jobName then
                            return FoxLibs.Table.Copy(t)
                        end
                    end
                end
            end
        end
    else
        return nil
    end
end
