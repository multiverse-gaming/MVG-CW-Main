local P = mvp.package.Get()

-- Helper functions
local function drawCircle(x, y, r, step, cache)
    local positions = {}
    for i = 0, 360, step do
        table.insert(positions, {
            x = x + math.cos(math.rad(i)) * r,
            y = y + math.sin(math.rad(i)) * r
        })
    end
    return (cache and positions) or surface.DrawPoly(positions)
end
local function drawSubSection(cx, cy, radius, thickness, startang, endang, roughness, cache)
    local triarc = {}
    -- local deg2rad = math.pi / 180
    -- Define step
    local roughness = math.max(roughness or 1, 1)
    local step = roughness
    -- Correct start/end ang
    local startang, endang = startang or 0, endang or 0
    if startang > endang then step = math.abs(step) * -1 end
    -- Create the inner circle's points.
    local inner = {}
    local r = radius - thickness
    for deg = startang, endang, step do
        local rad = math.rad(deg)
        -- local rad = deg2rad * deg
        local ox, oy = cx + (math.cos(rad) * r), cy + (-math.sin(rad) * r)
        table.insert(inner, {
            x = ox,
            y = oy,
            u = (ox - cx) / radius + .5,
            v = (oy - cy) / radius + .5,
        })
    end

    -- Create the outer circle's points.
    local outer = {}
    for deg = startang, endang, step do
        local rad = math.rad(deg)
        -- local rad = deg2rad * deg
        local ox, oy = cx + (math.cos(rad) * radius), cy + (-math.sin(rad) * radius)
        table.insert(outer, {
            x = ox,
            y = oy,
            u = (ox - cx) / radius + .5,
            v = (oy - cy) / radius + .5,
        })
    end

    -- Triangulize the points.
    for tri = 1, #inner * 2 do -- twice as many triangles as there are degrees.
        local p1, p2, p3
        p1 = outer[math.floor(tri / 2) + 1]
        p3 = inner[math.floor((tri + 1) / 2) + 1]
        if tri % 2 == 0 then --if the number is even use outer.
            p2 = outer[math.floor((tri + 1) / 2)]
        else
            p2 = inner[math.floor((tri + 1) / 2)]
        end

        table.insert(triarc, {p1, p2, p3})
    end

    if cache then
        return triarc
    else
        for k, v in pairs(triarc) do
            surface.DrawPoly(v)
        end
    end
end
local w, h = ScrW, ScrH

local LMBIcon = Material("mvp/radialmenu/lmb.png", "mips smooth")
local RMBIcon = Material("mvp/radialmenu/rmb.png", "mips smooth")

function P.ShowRadialMenu(sections)
    if (not sections) or (#sections == 0) then 
        return mvp.q.LogError("Radial Menu", "Tried to create a radial menu with no sections")
    end

    local scale = h() / 900
    local calculated = 325 * scale
    local rad = calculated * 0.4

    local sectionSize = 360 / #sections

    local originW, originH = w() * .5, h() * .5

    if (IsValid(P.activeRadialMenu)) then
        P.activeRadialMenu:Remove()
    end

    local radialMenu = vgui.Create("DButton")
    radialMenu:SetSize(w(), h())
    radialMenu:SetPos(0, 0)
    radialMenu:MakePopup()
    radialMenu:SetCursor("hand")

    radialMenu.selectedArea = 0
    radialMenu.selectedText = ""

    function radialMenu:Think()
        if (sections[self.selectedArea + 1]) then 
            self.selectedOption = sections[self.selectedArea + 1]
        end

        self:CalculateIconsPosition()
    end

    function radialMenu:CalculateIconsPosition()
        self.icons = {}
        for k, v in pairs(sections) do
            local ang = (k - 1) * sectionSize
            local radians = math.rad(ang)

            local iconType = "icon"

            if (v._isModel) then
                iconType = "model"
            elseif (v._icon == nil or (type(v._icon) == "IMaterial" and v._icon:IsError())) then
                iconType = "text" 
            end

            local iconSize = 64 * scale -- assume "icon" size
            local iconSizeMult = 1
            local isSectionSelected = self.selectedArea and self.selectedArea == k - 1

            if (iconType == "model") then
                iconSize = 64 * scale
            elseif (iconType == "text") then
                iconSize = 64 * scale
            end

            if (isSectionSelected) then
                iconSizeMult = 1.2
            end

            local r = calculated - rad * .5
            local s, c = math.sin(radians) * r, math.cos(radians) * r
            local x, y = originW - iconSize * .5 + s, originH - iconSize * .5 - c

            self.icons[k] = {
                x = x,
                y = y,
                s = s,
                c = c,
                size = iconSize,
                sizeMult = iconSizeMult,
                entityLayoutFunc = v._entLayoutFunc,
                type = iconType
            }
        end
    end

    -- prepare panels for "model" icons
    radialMenu:CalculateIconsPosition()
    for k, v in pairs(radialMenu.icons) do
        if (v.type == "model") then
            local modelPanel = vgui.Create("DModelPanel", radialMenu)
            modelPanel:SetSize(v.size, v.size)
            modelPanel:SetPos(v.x, v.y)
            modelPanel:SetModel(sections[k]._icon)
            modelPanel:SetMouseInputEnabled(false)
            -- modelPanel:SetFOV(30)

            modelPanel.LayoutEntity = function(self, ent)
                if (self:GetParent().selectedArea == k - 1) then
                    ent:SetAngles(Angle(0, RealTime() * 100, 0))
                else
                    ent:SetAngles(Angle(0, 180, 0))
                end

                local headBone = ent:LookupBone("ValveBiped.Bip01_Head1")

                if (headBone) then
                    local headPos = ent:GetBonePosition(headBone)
                    modelPanel:SetCamPos(headPos - Vector(23, 23, 0))
                    modelPanel:SetLookAt(headPos - Vector(0, 0, 10))
                end

                if (v.entityLayoutFunc) then
                    v.entityLayoutFunc(ent)
                end
            end
        end
    end

    function radialMenu:DrawRadialMenu(w, h)
        local cursorAng = 360 - (math.deg(math.atan2(gui.MouseX() - originW, gui.MouseY() - originH)) + 180)
        local selectedArea = math.abs(cursorAng + sectionSize * .5) / sectionSize
        selectedArea = math.floor(selectedArea)

        if (selectedArea >= #sections) then
            selectedArea = 0
        end
        self.selectedArea = selectedArea

        self.cursorColor = mvp.utils.LerpColor(FrameTime() * 5, self.cursorColor or mvp.colors.Accent, self.selectedOption._color or mvp.colors.Accent)

        local selectedAng = selectedArea * sectionSize
        local outerArcScale = 4

        draw.NoTexture()

        surface.SetDrawColor(self.selectedOption._color or mvp.colors.Accent)
        drawSubSection(originW, originH, calculated + outerArcScale, outerArcScale, 90 - selectedAng - sectionSize * .5, 90 - selectedAng + sectionSize * .5, 1, false)

        surface.SetDrawColor(ColorAlpha(mvp.colors.Background, 60))
        drawSubSection(originW, originH, calculated, rad, 90 - selectedAng - sectionSize * .5, 90 - selectedAng + sectionSize * .5, 1, false)

        surface.SetDrawColor(ColorAlpha(mvp.colors.Background, 100))
        drawCircle(originW, originH, calculated - rad, 1, false)
        drawCircle(originW, originH, calculated, 1, false)

        for k, v in pairs(self.icons) do
            local iconType = v.type

            if (iconType == "model") then
                continue
            end
            local sectionDetails = sections[k]

            local x, y = v.x, v.y
            local iconSize = v.size
            local iconSizeMult = v.sizeMult

            draw.NoTexture()

            if (iconType == "icon") then
                surface.SetDrawColor(mvp.colors.Text)
                surface.SetMaterial(sectionDetails._icon)
                surface.DrawTexturedRect(x, y, iconSize, iconSize)
            else -- text
                local s, c = v.s, v.c
                draw.SimpleText(sectionDetails._name, mvp.q.Font(22 * iconSizeMult, 700), originW + s, originH - c, mvp.colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            if (sectionDetails._overlayIcon) then
                surface.SetDrawColor(mvp.colors.Text)
                surface.SetMaterial(sectionDetails._overlayIcon)
                surface.DrawTexturedRect(x, y, iconSize * .75, iconSize * .75)
            end
        end

        draw.NoTexture()
        surface.SetDrawColor(self.cursorColor)

        local innerArcScale = 6
        drawSubSection(originW, originH, calculated - rad + innerArcScale * 2, innerArcScale, -cursorAng + 90 - sectionSize * .5, -cursorAng + 90 + sectionSize * .5, 1, false)
    end

    function radialMenu:Paint(w, h)
        self:DrawRadialMenu(w, h)

        if (not self.selectedOption) then
            draw.SimpleText(mvp.q.Lang("radialmenu.select_option"), mvp.q.Font(24, 700), originW, originH, mvp.colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            return true
        end

        local selectedOption = self.selectedOption
        local textOffset = 0

        local originW, originH = w * .5, h * .5 - 35

        if (not selectedOption._isModel and selectedOption._icon and not selectedOption._icon:IsError()) then
            local iconSize = 64 * scale * 1.5

            surface.SetDrawColor(mvp.colors.Text)
            surface.SetMaterial(selectedOption._icon)
            surface.DrawTexturedRect(originW - iconSize * .5, originH - iconSize * .5, iconSize, iconSize)

            textOffset = iconSize * .5 + 20
        end

        if (selectedOption._description) then
            textOffset = textOffset == 0 and 15 or textOffset
            draw.SimpleText(selectedOption._description, mvp.q.Font(24, 500), originW, originH + textOffset, mvp.colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end

        draw.SimpleText(selectedOption._name, mvp.q.Font(32, 700), originW, originH - textOffset, mvp.colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        local mouseButtonIconSize = 32
        
        surface.SetDrawColor(mvp.colors.Text)
        surface.SetMaterial(LMBIcon)
        surface.DrawTexturedRect(originW - 50 - mouseButtonIconSize * .5, originH + 50 - mouseButtonIconSize * .5 + textOffset, mouseButtonIconSize, mouseButtonIconSize)

        draw.SimpleText(mvp.q.LangFallback("radialmenu.select", "Select"), mvp.q.Font(24, 600), originW - 50, originH + 50 + textOffset + mouseButtonIconSize, mvp.colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        surface.SetMaterial(RMBIcon)
        surface.DrawTexturedRect(originW + 50 - mouseButtonIconSize * .5, originH + 50 - mouseButtonIconSize * .5 + textOffset, mouseButtonIconSize, mouseButtonIconSize)

        draw.SimpleText(mvp.q.LangFallback("radialmenu.cancel", "Cancel"), mvp.q.Font(24, 600), originW + 50, originH + 50 + textOffset + mouseButtonIconSize, mvp.colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        return true
    end

    function radialMenu:DoClick()
        if (not self.selectedOption) then return end

        self.selectedOption:Click()
        self:Remove()
    end

    function radialMenu:DoRightClick()
        self:Remove()
    end

    P.activeRadialMenu = radialMenu
end