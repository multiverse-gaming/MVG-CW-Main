local hexagonSize = 50
local hexagons = {}
local hexagonColors = {}
local wiringColors = {Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255), Color(255, 255, 0)}
local leftPositions = {}
local rightPositions = {}
local connections = {}
local dragging = false
local currentDrag = nil
local swipePanel = nil
local startTime = 0
local swipeTime = 0
local minSwipeDuration = 0.0
local maxSwipeDuration = 2.0

local function DrawHexagon(x, y, size, color)
    local vertices = {}
    for i = 0, 5 do
        local angle = math.rad(60 * i)
        local px = x + size * math.cos(angle)
        local py = y + size * math.sin(angle)
        table.insert(vertices, { x = px, y = py })
    end

    surface.SetDrawColor(color)
    draw.NoTexture()
    surface.DrawPoly(vertices)
end

local function CreateHexagonPanel(task)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Prime Shields")
    frame:SetSize(400, 400)
    frame:Center()
    frame:MakePopup()

    hexagons = {
        {x = 150, y = 100},
        {x = 250, y = 100},
        {x = 100, y = 190},
        {x = 200, y = 190},
        {x = 300, y = 190},
        {x = 150, y = 280},
        {x = 250, y = 280}
    }

    hexagonColors = {}
    for i = 1, #hexagons do
        hexagonColors[i] = math.random(1, 2) == 1 and Color(255, 255, 255) or Color(255, 0, 0)
    end

    function frame:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
        for i, hexagon in ipairs(hexagons) do
            DrawHexagon(hexagon.x, hexagon.y, hexagonSize, hexagonColors[i])
        end
    end

    function frame:OnMousePressed(mouseCode)
        if mouseCode == MOUSE_LEFT then
            local mx, my = frame:ScreenToLocal(gui.MouseX(), gui.MouseY())
            for i, hexagon in ipairs(hexagons) do
                local hx, hy = hexagon.x, hexagon.y
                if math.sqrt((mx - hx)^2 + (my - hy)^2) < hexagonSize then
                    hexagonColors[i] = hexagonColors[i] == Color(255, 255, 255) and Color(255, 0, 0) or Color(255, 255, 255)

                    local allWhite = true
                    for _, color in ipairs(hexagonColors) do
                        if color ~= Color(255, 255, 255) then
                            allWhite = false
                            break
                        end
                    end

                    if allWhite then
                        net.Start("CompleteTask")
                        net.WriteEntity(task)
                        net.SendToServer()
                        frame:Close()
                    end
                    break
                end
            end
        end
    end
end

local function CreateWiringPanel(task)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Fix Wiring")
    frame:SetSize(600, 400)
    frame:Center()
    frame:MakePopup()

    leftPositions = {}
    rightPositions = {}
    connections = {}

    for i = 1, #wiringColors do
        leftPositions[i] = {x = 100, y = 50 + (i - 1) * 100, color = wiringColors[i]}
    end

    local shuffledColors = table.Copy(wiringColors)
    table.Shuffle(shuffledColors)
    for i = 1, #shuffledColors do
        rightPositions[i] = {x = 500, y = 50 + (i - 1) * 100, color = shuffledColors[i]}
    end

    function frame:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))

        for _, pos in ipairs(leftPositions) do
            surface.SetDrawColor(pos.color)
            surface.DrawCircle(pos.x, pos.y, 20, pos.color.r, pos.color.g, pos.color.b, 255)
        end

        for _, pos in ipairs(rightPositions) do
            surface.SetDrawColor(pos.color)
            surface.DrawCircle(pos.x, pos.y, 20, pos.color.r, pos.color.g, pos.color.b, 255)
        end

        for _, connection in ipairs(connections) do
            surface.SetDrawColor(connection.color)
            surface.DrawLine(connection.startX, connection.startY, connection.endX, connection.endY)
        end

        if dragging and currentDrag then
            local mx, my = frame:ScreenToLocal(gui.MouseX(), gui.MouseY())
            surface.SetDrawColor(currentDrag.color)
            surface.DrawLine(currentDrag.startX, currentDrag.startY, mx, my)
        end
    end

    function frame:OnMousePressed(mouseCode)
        if mouseCode == MOUSE_LEFT then
            local mx, my = frame:ScreenToLocal(gui.MouseX(), gui.MouseY())
            for i, pos in ipairs(leftPositions) do
                if math.sqrt((mx - pos.x)^2 + (my - pos.y)^2) < 20 then
                    dragging = true
                    currentDrag = {color = pos.color, startX = pos.x, startY = pos.y}
                    break
                end
            end
        elseif mouseCode == MOUSE_RIGHT then
            local mx, my = frame:ScreenToLocal(gui.MouseX(), gui.MouseY())
            for i, pos in ipairs(rightPositions) do
                if math.sqrt((mx - pos.x)^2 + (my - pos.y)^2) < 20 then
                    for j, connection in ipairs(connections) do
                        if connection.endX == pos.x and connection.endY == pos.y then
                            table.remove(connections, j)
                            break
                        end
                    end
                    break
                end
            end
        end
    end

    function frame:OnMouseReleased(mouseCode)
        if mouseCode == MOUSE_LEFT and dragging then
            local mx, my = frame:ScreenToLocal(gui.MouseX(), gui.MouseY())
            local connected = false
            for i, pos in ipairs(rightPositions) do
                if math.sqrt((mx - pos.x)^2 + (my - pos.y)^2) < 20 then
                    table.insert(connections, {color = currentDrag.color, startX = currentDrag.startX, startY = currentDrag.startY, endX = pos.x, endY = pos.y})
                    connected = true
                    break
                end
            end

            if not connected then
                dragging = false
                currentDrag = nil
            end

            if #connections == #wiringColors then
                local completed = true
                for i, connection in ipairs(connections) do
                    local matchingRightPos = nil
                    for j, rightPos in ipairs(rightPositions) do
                        if rightPos.x == connection.endX and rightPos.y == connection.endY then
                            matchingRightPos = rightPos
                            break
                        end
                    end
                    if matchingRightPos and matchingRightPos.color ~= connection.color then
                        completed = false
                        break
                    end
                end

                if completed then
                    net.Start("CompleteTask")
                    net.WriteEntity(task)
                    net.SendToServer()
                    frame:Close()
                end
            end

            dragging = false
            currentDrag = nil
        end
    end
end

local function CreateSwipeCardPanel(terminal)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Swipe Card")
    frame:SetSize(600, 200)
    frame:Center()
    frame:MakePopup()

    local card = vgui.Create("DPanel", frame)
    card:SetSize(100, 150)
    card:SetPos(50, 25)
    card.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 255, 255, 255))
        draw.SimpleText("CARD", "DermaLarge", w / 2, h / 2, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local startX = card.x
    local isDragging = false
    local targetX = frame:GetWide() - card:GetWide() - 50

    card.OnMousePressed = function()
        isDragging = true
    end

    card.OnMouseReleased = function()
        isDragging = false
        if card.x >= targetX then
            net.Start("CompleteTask")
            net.WriteEntity(terminal)
            net.SendToServer()
            frame:Close()
        else
            card:SetPos(startX, 25)
        end
    end

    card.Think = function()
        if isDragging then
            local x, y = frame:CursorPos()
            card:SetPos(math.Clamp(x - card:GetWide() / 2, startX, targetX), 25)
        end
    end
end

local function CreateCleanFilterPanel(terminal)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Clean Filter")
    frame:SetSize(800, 600)
    frame:Center()
    frame:MakePopup()

    local exitHole = vgui.Create("DPanel", frame)
    exitHole:SetSize(50, 150)
    exitHole:SetPos(50, 275)
    exitHole.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 255))
        draw.RoundedBox(0, 5, 5, w - 10, h - 10, Color(169, 169, 169, 255))
    end

    local objects = {}
    local velocities = {}

    for i = 1, 6 do
        local obj = vgui.Create("DPanel", frame)
        obj:SetSize(50, 50)
        obj:SetPos(600, math.random(50, 550))
        obj:SetBackgroundColor(Color(math.random(100, 255), math.random(100, 255), math.random(100, 255), 255))
        table.insert(objects, obj)

        local velocity = { x = math.random(-2, 2), y = math.random(-2, 2) }
        table.insert(velocities, velocity)

        local isDragging = false

        obj.OnMousePressed = function()
            isDragging = true
        end

        obj.OnMouseReleased = function()
            isDragging = false
            local objX, objY = obj:GetPos()
            local holeX, holeY = exitHole:GetPos()

            if objX < holeX + exitHole:GetWide() and objY > holeY and objY < holeY + exitHole:GetTall() then
                obj:Remove()
                table.RemoveByValue(objects, obj)

                if #objects == 0 then
                    net.Start("CompleteTask")
                    net.WriteEntity(terminal)
                    net.SendToServer()
                    frame:Close()
                end
            end
        end

        obj.Think = function()
            if isDragging then
                local x, y = frame:CursorPos()
                obj:SetPos(x - obj:GetWide() / 2, y - obj:GetTall() / 2)
            else
                local x, y = obj:GetPos()
                local vx, vy = velocities[i].x, velocities[i].y

                x = x + vx
                y = y + vy

                if x < 0 or x + obj:GetWide() > frame:GetWide() then
                    velocities[i].x = -vx
                end

                if y < 0 or y + obj:GetTall() > frame:GetTall() then
                    velocities[i].y = -vy
                end

                obj:SetPos(x, y)
            end
        end
    end
end

net.Receive("TerminalTask", function()
    local terminal = net.ReadEntity()
    local task = net.ReadString()
    if IsValid(terminal) then
        if task == "Fix Wiring" then
            CreateWiringPanel(terminal)
        elseif task == "Prime Shields" then
            CreateHexagonPanel(terminal)
        elseif task == "Swipe Card" then
            CreateSwipeCardPanel(terminal)
        elseif task == "Clean Filter" then
            CreateCleanFilterPanel(terminal)
        else
            print("[TerminalSystem] Unknown task received.")
        end
    end
end)
