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

local function CreateRecordTemperaturePanel(terminal)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Record Temperature")
    frame:SetSize(650, 250)
    frame:Center()
    frame:MakePopup()

    local temperatureDisplay = math.random(-3, 39)
    local currentTemperature = 0

    local buttonWidth = 60
    local buttonSpacing = 10
    local totalButtonWidth = 3 * buttonWidth + 2 * buttonSpacing

    local tempDisplayPanel = vgui.Create("DPanel", frame)
    tempDisplayPanel:SetSize(totalButtonWidth, 150)
    tempDisplayPanel:SetPos(400, 25)
    tempDisplayPanel.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 255, 255, 255))
        draw.SimpleText("Temperature: " .. temperatureDisplay, "DermaLarge", w / 2, h / 2, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local inputPanel = vgui.Create("DPanel", frame)
    inputPanel:SetSize(totalButtonWidth, 150)
    inputPanel:SetPos(50, 25)
    inputPanel.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 255, 255, 255))
        draw.SimpleText("Current Value: " .. currentTemperature, "DermaLarge", w / 2, h / 2, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local decrementButton = vgui.Create("DButton", frame)
    decrementButton:SetSize(buttonWidth, 30)
    decrementButton:SetPos(50, 200)
    decrementButton:SetText("-1")
    decrementButton.DoClick = function()
        currentTemperature = math.max(currentTemperature - 1, -3)
        inputPanel:InvalidateLayout(true)
    end

    local submitButton = vgui.Create("DButton", frame)
    submitButton:SetSize(buttonWidth, 30)
    submitButton:SetPos(50 + buttonWidth + buttonSpacing, 200)
    submitButton:SetText("Submit")
    submitButton.DoClick = function()
        if currentTemperature == temperatureDisplay then
            net.Start("CompleteTask")
            net.WriteEntity(terminal)
            net.SendToServer()
            frame:Close()
        else
            notification.AddLegacy("Temperature mismatch! Adjust the value.", NOTIFY_ERROR, 5)
        end
    end

    local incrementButton = vgui.Create("DButton", frame)
    incrementButton:SetSize(buttonWidth, 30)
    incrementButton:SetPos(50 + 2 * (buttonWidth + buttonSpacing), 200)
    incrementButton:SetText("+1")
    incrementButton.DoClick = function()
        currentTemperature = math.min(currentTemperature + 1, 39)
        inputPanel:InvalidateLayout(true)
    end
end

local function CreateClearAsteroidsPanel(terminal)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Clear Asteroids")
    frame:SetSize(800, 600)
    frame:Center()
    frame:MakePopup()

    local asteroidCount = 18
    local asteroids = {}
    local crosshairSize = 10
    local crosshair = vgui.Create("DPanel", frame)
    crosshair:SetSize(crosshairSize, crosshairSize)
    crosshair.Paint = function(self, w, h)
        surface.SetDrawColor(Color(255, 0, 0))
        surface.DrawLine(w / 2, 0, w / 2, h)
        surface.DrawLine(0, h / 2, w, h / 2)
    end

    local function CreateAsteroid()
        local asteroid = vgui.Create("DPanel", frame)
        local size = math.random(30, 50)
        asteroid:SetSize(size, size)
        asteroid:SetPos(frame:GetWide(), math.random(50, frame:GetTall() - size - 50))
        asteroid.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
        end
        asteroid.OnMousePressed = function()
            asteroid:Remove()
            table.RemoveByValue(asteroids, asteroid)
            asteroidCount = asteroidCount - 1
            if asteroidCount <= 0 then
                net.Start("CompleteTask")
                net.WriteEntity(terminal)
                net.SendToServer()
                frame:Close()
            end
        end
        table.insert(asteroids, asteroid)
    end

    local function UpdateAsteroids()
        for _, asteroid in ipairs(asteroids) do
            local x, y = asteroid:GetPos()
            asteroid:SetPos(x - 2, y)
            if x < -asteroid:GetWide() then
                asteroid:Remove()
                table.RemoveByValue(asteroids, asteroid)
                asteroidCount = asteroidCount - 1
            end
        end
    end

    local function DrawCounter()
        draw.SimpleText("Asteroids Remaining: " .. asteroidCount, "DermaLarge", frame:GetWide() / 2, frame:GetTall() - 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    timer.Create("AsteroidSpawner", 1, 0, function()
        if IsValid(frame) then
            CreateAsteroid()
        end
    end)

    hook.Add("Think", "AsteroidMovement", function()
        if IsValid(frame) then
            UpdateAsteroids()
            crosshair:SetPos(gui.MouseX() - crosshairSize / 2, gui.MouseY() - crosshairSize / 2)
            frame:InvalidateLayout(true)
        end
    end)

    function frame:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 150))
        DrawCounter()
    end
end

local function CreateUnlockManifoldsPanel(terminal)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Unlock Manifolds")
    frame:SetSize(400, 300)
    frame:Center()
    frame:MakePopup()

    local buttonOrder = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    local shuffledButtons = table.Copy(buttonOrder)
    table.Shuffle(shuffledButtons)

    local currentStep = 1
    local buttons = {}

    local function ResetProgress()
        currentStep = 1
        for _, btn in ipairs(buttons) do
            btn:SetEnabled(true)
            btn:SetColor(Color(255, 255, 255))
        end
    end

    local grid = vgui.Create("DPanel", frame)
    grid:SetSize(380, 260)
    grid:SetPos(10, 30)

    grid.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(60, 60, 60, 255))
    end

    local cols, rows = 5, 2
    local btnWidth, btnHeight = grid:GetWide() / cols, grid:GetTall() / rows

    for i, btnNumber in ipairs(shuffledButtons) do
        local btn = vgui.Create("DButton", grid)
        btn:SetSize(btnWidth - 10, btnHeight - 10)
        btn:SetPos(((i - 1) % cols) * btnWidth + 5, math.floor((i - 1) / cols) * btnHeight + 5)
        btn:SetText(btnNumber)
        btn:SetFont("DermaLarge")
        btn:SetColor(Color(255, 255, 255))
        btn.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(100, 100, 100))
            self:SetTextColor(self:GetColor())
        end

        btn.DoClick = function()
            if btnNumber == buttonOrder[currentStep] then
                btn:SetColor(Color(0, 255, 0))
                currentStep = currentStep + 1
                btn:SetEnabled(false)
                if currentStep > #buttonOrder then
                    net.Start("CompleteTask")
                    net.WriteEntity(terminal)
                    net.SendToServer()
                    frame:Close()
                end
            else
                btn:SetColor(Color(255, 0, 0))
                timer.Simple(1, function()
                    ResetProgress()
                end)
            end
        end

        table.insert(buttons, btn)
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
        elseif task == "Record Temperature" then
            CreateRecordTemperaturePanel(terminal)
        elseif task == "Clear Asteroids" then
            CreateClearAsteroidsPanel(terminal)
        elseif task == "UnlockManifolds" then
            CreateUnlockManifoldsPanel(terminal)
        else
            print("[TerminalSystem] Unknown task received.")
        end
    end
end)
