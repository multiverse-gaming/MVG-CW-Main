SummeLibrary.Colors = {
    ["grey"] = Color(33, 33, 33),
    ["greyDark"] = Color(18, 18, 18),
    ["white"] = Color(221, 221, 2213),
    ["red"] = Color(255, 61, 61),
    ["green"] = Color(103, 255, 82),
    ["greenDark"] = Color(64, 173, 0),
    ["yellow"] = Color(255, 196, 0),
    ["orange"] = Color(255, 102, 0),
    ["blue"] = Color(0, 174, 255),
    ["cyan"] = Color(81, 243, 255),
}

function SummeLibrary:GetColor(name)
    return SummeLibrary.Colors[name] or SummeLibrary.Colors[1]
end

function SummeLibrary:RegisterColor(name, color)
    SummeLibrary.Colors[name] = color
end