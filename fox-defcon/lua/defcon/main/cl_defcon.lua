Fox = Fox or {}
Fox.Defon = Fox.Defcon or {}

local internal = internal or {}

--[[
    SH_Init will call this, don't call this.
]]
function Fox.Defcon:CL_Init(cfgData)
    Fox.Defcon:CreateListenEvent()

    
    internal:SetUpPrefix(cfgData)




end


--[[
    Can request defcon from server for HUD.
]]
function Fox.Defcon:GetDefcon()

    



    CustomHUD_Fox.Loaded.C.Defcon.Val = 
end



do -- internal


    --[[
        Input: newData (table)
        Output: The prefix data.
        WID: It uses newData of config to determain what the prefix for Defcon command will be in chat.
    ]]
    function internal:SetUpPrefix(newData)

        if newData == false or newData.Prefix == nil or (not isstring(newData.Prefix)) then
            internal.Prefix = "/"
        else
            internal.Prefix = newData.Prefix
        end
    end


    --[[
        INPUT: Nothing
        OUTPUT: Nothing
        WID: It creates an event that when player chats, checks if it is changing the defcon. If it does then it will call the server to say
            it has.
    ]]
    function internal:CreateListenEvent()
        hook.Add("OnPlayerChat", "Fox.Defcon.ListenForCommand", function(ply, text)
            local text = string.lower(text)
            local strStart, strEnd = string.find(text, internal.Prefix .. "defcon")

            if isnumber(strStart) then
                for i,v in pairs(Fox.Defcon.TableOfDefcons) do
                    local argument = string.find(text, v, strEnd + 1)

                    if isnumber(argument) then
                        -- TOOD: Call server saying new command.
                        return false
                    end

                end

            end

        end)
    end
    

end