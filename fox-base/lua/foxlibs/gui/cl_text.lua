--------------------------------------------------------------------------------------------------------------------
FoxLibs = FoxLibs or {}
FoxLibs.GUI = FoxLibs.GUI or {}
FoxLibs.GUI.Text = FoxLibs.GUI.Text or {}

FoxLibs.GUI.Text.Font = FoxLibs.GUI.Text.Font or {}

local internal = internal or {}
--------------------------------------------------------------------------------------------------------------------





function FoxLibs.GUI.Text:GetSizeOfText(text, font)

	local succ, err = pcall(function() 
		surface.SetFont( font )
	end)

	if not succ then
		Error("[FoxLibs][Text] Failed to get font.")
	else
		return surface.GetTextSize( text )
	end
end



--[[
	If priority is "h" or "w", will use that to determain height instead, if nil will try to find a suitable one for both.
]]
function FoxLibs.GUI.Text:CompileConditions(fontTbl, priority)
	local base_font_size_in_context = nil -- Is set in preliminary, the font size we will use to scale appropiatly.

	do -- Preliminary checks, and creates font.
		if fontTbl == nil or not istable(fontTbl) then 
			ErrorNoHalt("[FoxLibs][GUI][Text][CompileConditions] Failed to create temp font as input is invalid.")
			return false
		else
			fontTbl = FoxLibs.Table.Copy(fontTbl) -- Avoids table manipulation from outside the class.
		end
	
		if fontTbl.size == nil then
			if Debug_Fox then
				ErrorNoHalt("[FoxLibs][Text][CompileConditions] Automatically set font size to 13 as non-was provided..")
			end
			fontTbl.size = 13 -- We use this as default size.
		end

		if fontTbl.font == nil then
			ErrorNoHalt("[FoxLibs][Text][CompileConditions] Failed to create temp font as fontTbl input has no font type.")
			return false
		end
		
	
		surface.CreateFont( "FoxLibs.Text.Temp", fontTbl )

		base_font_size_in_context = fontTbl.size
	end


	local tblOfTextSizes = {}

	do -- Add values to tblOfTextSizes
		for i,v in pairs(internal.TblOfConditionsToReview) do
			-- This part isnt very signifcant only more for the "width" and base overall.
			tblOfTextSizes[i] = FoxLibs.GUI.Text:GetSizeOfText(v[3], "FoxLibs.Text.Temp")
		end
	end



end

function FoxLibs.GUI.Text:ClearConditions()
	internal.TblOfConditionsToReview = {}

	if Debug_Fox then
		print("[FoxLibs][Text] Cleared all conditions for creating font size test.")
	end
end

do -- intenral
	internal.TblOfConditionsToReview = {} -- Each element inside this must be of the format: {size_x, size_y, string of average format}



	--[[
		if priority is nil, will be "w" by default.

		
		Returns recommended font size.
	]]
	function internal.RecommendedFontSize(baseFontSize, wantedSize, curSize, priority)
		do -- Preliminary Checks
			
		end


	end
end


function FoxLibs.GUI.Text:AddCondition(text, size_x, size_y)
	do -- Preliminary checks
		if not isstring(text) then
			ErrorNoHalt("[FoxLibs][Text] text is not a string.")
			return false
		end

		if not isnumber(size_x) then
			ErrorNoHalt("[FoxLibs][Text] size_x is not a number.")
			return false
		end

		if not isnumber(size_y) then
			ErrorNoHalt("[FoxLibs][Text] size_y is not a number.")
			return false
		end
	end

	table.insert(internal.TblOfConditionsToReview, {size_x, size_y, text})

	return true
end













if true then return end


function FoxLibs.GUI:TextInit(element, allowDecimals, allowCommas)
	element.TextVal = nil
	if allowDecimals == true then
		element.allowDecimals = true -- MAYBE COUNT INSTEAD
	end

	if allowCommas == true then
		element.allowCommas = true -- MAYBE COUNT INSTEAD
	end

	element["text_" .. id] = true -- Hash? Is this fine?
	

end



-- Might be my way of seeing how much for the text to render?
--See also MarkupObject for limited width and markup support.





function FoxLibs.GUI:CreateTextFontSizeTable(font, textTable, ReCalculate)
	if FoxLibs.GUI.Text.Font[font] == nil then
		FoxLibs.GUI.Text.Font[font] = {}
	end

	for i, v in pairs (textTable) do
		if v ~= "" and (FoxLibs.GUI.Text.Font[font] ~= nil or ReCalculate) then 
			local width, height  = FoxLibs.GUI:GetSizeOfText(v, font)
			FoxLibs.GUI.Text.Font[font] = {x = width, y = height}
		end
	end

end

-- Dont calculate too much, use checker for difference in health on update etc if needs to rerun this.


-- To update font just set it to nil again.


-- TODO: SHOULD I MOVE THIS?
local units = {"", "K", "M", "B", "T"}
local charactersUsed = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", ","}

--TODO: Create calculate new size method. 
function FoxLibs.GUI:ConvertNumber(element, font, newValue)
	if FoxLibs.GUI.Text.Font == nil then -- TODO: REMOVE IN END SOMEWHERE ELSE?
		FoxLibs.GUI:CreateTextFontSizeTable(font, units)
		FoxLibs.GUI:CreateTextFontSizeTable(font, charactersUsed)
	end

	--[[
	for i, v in pairs (element.FontSizes) do
		print(i .. " | " .. v.x .. " " .. v.y)
	end
	print("======")
	]]


	-- Realistically minimum it should be is 3 characters.

	--[[
	local n = math.floor(math.log(value, 1000))
	local m = value / math.pow(1000, n);
	local unit = units[n]
	]]

	local n_oldValue = math.floor(math.log(element.Val, 1000))
	local n_newValue = math.floor(math.log(newValue, 1000))
	local lastConvertedValue = element.TextVal or ""

	if n_oldValue == n_newValue then

		local test = FoxLibs.GUI:GetUnitAtEndMultiplier(lastConvertedValue)
		--print(test)

		-- Set new value!
	else
		--print("WOAH DIFFERENCE!")
	end

	--[[
	local n = math.floor(math.log(value, 1000))

	print(value)
	print(n)
	print(m)




	print(unit)
	]]
	--[[
	local width = FoxLibs.GUI:GetWidthOfText(element, newValue)
	print(width)
	]]

	-- PUT MARKUP TO TEST TO MAKE SURE ITS RIGHT!
	-- Dont calculate too much, use checker for difference in health on update etc if needs to rerun this.


end


-- Example: 5 numbers, 2 decimal places, 1 comma etc.
-- Settings to allow commas
-- element.commas (ADD TO PANEL:INIT | TODO)


--[[
    This function calculates the combinates of numbers, commas and decimal allowed in both cases etc.
    For example: 1,000,000 < width of panel then its fine etc.
]]
function FoxLibs.GUI:CalculateCharactersNumAllowed(element, useCommas, decimalPlacesAllowed) -- decimalPlacesAllowed used when can't use normal HP amount.
    if element.CharactersUseTable == nil then
        element.CharactersUseTable = {
            numbers = 0,
            commas = 0,
            decimalAllow = true
        }

        -- IMPORTANT TODO : REMEMBER CENTER TEXT EXISTS SO CONSIDER THAT THE STARTING POINT. 
    end

    if useCommas == true then
        -- 100

        -- 1,100
        -- 1.1K

        -- 101,120
        -- 101.12K -- 2 DP
        -- 101.1K -- 1 DP

        -- 11,100,000
        -- 11.1M

        -- TODO: MAKE SURE AM STARTING THIS OFF RIGHT THINK OF SCENARIOS OF ALL FORMATS

    else

    end
end

function FoxLibs.GUI:GetWidthOfText(element, value)
	local value = string.Split(value, "")
	local width = 0
	
	for i, v in pairs (value) do
		local currentElementValue_X = element.FontSizes[v].x
		width = width + currentElementValue_X
	end

	return width
	
end

function FoxLibs.GUI:GetUnitAtEndMultiplier(value)
	local endingValue = string.Right(value, 1)
	local multiplyierLevel

	if table.HasValue(units, endingValue) and endingValue ~= "" then

		for i ,v in pairs (units) do
			if v == endingValue then
				break
			else
				multiplyierLevel = multiplyierLevel + 1
			end
		end

	else
		multiplyierLevel = 0
	end

	return multiplyierLevel
end
