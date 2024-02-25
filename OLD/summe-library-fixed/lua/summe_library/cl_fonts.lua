function SummeLibrary:CreateFont(name, size)
    local tbl = {
		font = "Roboto",
		size = size + 2,
		weight = 500,
		extended = true
	}

    surface.CreateFont(name, tbl)
end