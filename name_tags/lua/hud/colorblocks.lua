-- Display Settings
EOTI_NameTag.Draw.Scale = 100 -- How large is the name tag.
EOTI_NameTag.Draw.Border = 0 -- Spacing between boxes.
EOTI_NameTag.Draw.Corner = 0 -- Rounded corners on boxes.
EOTI_NameTag.Draw.PadWide = 4 -- Horizontal spacing around the text inside the box.
EOTI_NameTag.Draw.PadTall = 3 -- Vertical spacing around the text inside the box.

-- Display Black Outline Around Text
EOTI_NameTag.Draw.OutlineName = 0
EOTI_NameTag.Draw.OutlineHealth = 0
EOTI_NameTag.Draw.OutlineArmor = 0
EOTI_NameTag.Draw.OutlineTag = 0
EOTI_NameTag.Draw.OutlineInfo = 0

-- Display Text Colors
EOTI_NameTag.Color.Name = Color(245,245,245)
EOTI_NameTag.Color.Health = Color(245,245,245)
EOTI_NameTag.Color.Armor = Color(245,245,245)
EOTI_NameTag.Color.Tag = Color(245,245,245)
EOTI_NameTag.Color.Info = Color(245,245,245)

-- Display Container Colors
-- Setting one of these 6 colors will skip rendering that box's background, avoid using Color(0,0,0,0)
EOTI_NameTag.Color.Background = Color(0,0,0)
EOTI_NameTag.Color.ForegroundName = Color(218,93,39)
EOTI_NameTag.Color.ForegroundHealth = Color(174,8,44)
EOTI_NameTag.Color.ForegroundArmor = Color(35,113,185)
EOTI_NameTag.Color.ForegroundTag = Color(92,44,142)
EOTI_NameTag.Color.ForegroundInfo = Color(0,130,112)

-- Fonts: Name
surface.CreateFont( "EOTI_NameTag_Name", {
    font = "Montserrat-Bold",
    size = 22,
    weight = 400,
    antialias = true,
})

-- Fonts: Health
surface.CreateFont( "EOTI_NameTag_Health", {
    font = "Coolvetica",
    size = 32,
    weight = 400,
    antialias = true,
})

-- Fonts: Armor
surface.CreateFont( "EOTI_NameTag_Armor", {
    font = "Coolvetica",
    size = 32,
    weight = 400,
    antialias = true,
})

-- Fonts: Level Tag
surface.CreateFont( "EOTI_NameTag_Tag", {
    font = "Coolvetica",
    size = 32,
    weight = 400,
    antialias = true,
})

-- Fonts: Job Info
surface.CreateFont( "EOTI_NameTag_Info", {
    font = "Montserrat-Bold",
    size = 22,
    weight = 400,
    antialias = true,
})

-- How to install your own font (GMOD does not adequately explain this to users)

-- 1) Put 'example2.ttf' file in 'addons/eoti_nametag/resource/fonts/'
-- 2) Add resource.AddFile('resource/fonts/example2.tff') to 'addons/eoti_nametag/lua/autorun/server/eoti_nametag_sv.lua' or to your autorun/server/ file.
-- 3) Open the font and look at the name bar at the top of the window, use this, NOT the file name. This is not explained ever.
-- 4) Put font = "Example 2 Bold", or whatever is in the window name, not the file name.