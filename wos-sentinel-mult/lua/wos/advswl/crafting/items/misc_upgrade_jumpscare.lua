local ITEM = {} 
ITEM.Rarity = 100

ITEM.Name = "Jumpscare"

ITEM.Description = "Jumpscare people. Only works near halloween."

ITEM.Type = WOSTYPE.MISC2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = true

ITEM.Model = "models/chip/chip.mdl"

ITEM.OnEquip = function( wep )
    local currentMonth = tonumber(os.date("%m"))  -- Get current month as a number
    local currentDay = tonumber(os.date("%d"))    -- Get current day as a number
    local currentYear = tonumber(os.date("%Y"))   -- Get current year as a number
        
    -- Define Halloween date (October 31)
    local halloweenMonth = 10
    local halloweenDay = 31

    -- Create os.time values for comparison
    local currentDate = os.time({year = currentYear, month = currentMonth, day = currentDay})
    local halloweenDate = os.time({year = currentYear, month = halloweenMonth, day = halloweenDay})

    -- 10 days in seconds (10 days * 24 hours * 60 minutes * 60 seconds)
    local tenDaysInSeconds = 10 * 24 * 60 * 60

    -- Check if we're within 10 days before or after Halloween
    if math.abs(currentDate - halloweenDate) <= tenDaysInSeconds then
        wep:AddForcePower( "Jumpscare" )
    end
end

wOS:RegisterItem( ITEM )