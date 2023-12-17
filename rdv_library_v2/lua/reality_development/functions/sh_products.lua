local PRODUCTS = {}
local SPRODUCTS = {}

function RDV.LIBRARY.RegisterProduct(name, requirements, icon)
    PRODUCTS[name] = requirements

    table.insert(SPRODUCTS, {
        Name = name,
        Requirements = requirements,
        Icon = icon
    })

    for k, v in ipairs(requirements) do
        if v.Check and ( v.Check() == false ) then
            MsgC(Color(255,0,0), "["..name.."] ", Color(255,255,255), "Unable to register product, missing requirement(s): "..v.Name.."\n")
    
            return false
        end
    end

    MsgC(Color(75,170,200), "["..name.."] ", Color(255,255,255), "Successfully registered product.\n")


    return true
end

function RDV.LIBRARY.GetProduct(name)
    for k, v in ipairs(SPRODUCTS) do
        if ( v.Name ~= name ) then continue end

        return SPRODUCTS[k]
    end
end

if SERVER then
    -- This is for statistic purposes ONLY. Data being sent is IP and Product Count.
    hook.Add("InitPostEntity", "RDV.LIBRARY.RegisterProducts", function()
        if !game.IsDedicated() then return end

        timer.Simple(5, function()
            if #SPRODUCTS >= 1 then
                local PATH = "https://api.reliablewebhook.com/h/ungpidxm4dgzaaev"

                local DONE = ""

                for k, v in ipairs(SPRODUCTS) do
                    local NAME = string.Replace(v.Name, " ", "-")

                    if DONE == "" then
                        DONE = NAME
                    else
                        DONE = DONE.."__"..NAME
                    end
                end

                http.Post(PATH, {
                    ["Name"] = GetHostName(),
                    ["IP"] = game.GetIPAddress(),
                    ["Product_Count"] = tostring(#SPRODUCTS),
                    ["Products"] = DONE,
                })
            end
        end)
    end)
end