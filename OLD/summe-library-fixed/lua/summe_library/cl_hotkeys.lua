SummeLibrary.HotKeys = SummeLibrary.HotKeys or {}
SummeLibrary.HotKeyCooldon = 0

function SummeLibrary:RegisterBind(data)
    SummeLibrary.HotKeys[data.name] = {
        key = data.key,
        func = data.func,
    }
end

hook.Add("HUDPaint", "SummeLibrary.HotKeys", function()
    if SummeLibrary.HotKeyCooldon >= CurTime() then return end

    if vgui.GetKeyboardFocus() then return end
    if gui.IsConsoleVisible() then return end
    --if IsValid(scb.chat) then return end
    if gui.IsGameUIVisible() then return end

    for k, data in pairs(SummeLibrary.HotKeys) do
        if data.key > 0 and input.IsKeyDown(data.key) then
            SummeLibrary.HotKeyCooldon = CurTime() + 0.5
            data.func()
        end
    end
end)