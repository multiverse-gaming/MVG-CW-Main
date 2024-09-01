local P = mvp.package.Get()

mvp = mvp or {}
mvp.meta = mvp.meta or {}
mvp.meta.radialMenu = {}

mvp.meta.radialMenu.__proto = mvp.meta.radialMenu
mvp.meta.radialMenu.__proto.isRadialMenu = true
mvp.meta.radialMenu.__proto.options = {}

function mvp.meta.radialMenu:New()
    local o = table.Copy(self.__proto)

    setmetatable(o, self)
    o.__index = self

    return o
end

function mvp.meta.radialMenu:AddOption(title, description, icon, color, click)
    local option = mvp.meta.radialMenuOption:New()

    local overlayIcon = nil
    local isModel = false
    if (istable(icon)) then
        overlayIcon = icon[2]
        isModel = icon[3] or false
        entityLayoutFunc = icon[4] or nil

        icon = icon[1]
    end

    option:SetName(title)
    option:SetDescription(description)
    option:SetIcon(icon)
    option:SetOverlayIcon(overlayIcon)
    option:SetIsModel(isModel)
    option:SetEntLayoutFunc(entityLayoutFunc)
    option:SetColor(color)

    if (click) then
        option.Click = click
    end

    table.insert(self.options, option)

    return option
end

function mvp.meta.radialMenu:Open()
    if (#self.options <= 0) then
        mvp.q.LogError(nil, "Radial menu has no options")
        return
    end

    P.ShowRadialMenu(self.options)
end

mvp.meta.radialMenuOption = {}

mvp.meta.radialMenuOption.__proto = mvp.meta.radialMenuOption
mvp.meta.radialMenuOption.__proto.isRadialMenuOption = true

mvp.meta.radialMenuOption.__proto._name = "Option"
AccessorFunc(mvp.meta.radialMenuOption, "_name", "Name", FORCE_STRING)

mvp.meta.radialMenuOption.__proto._description = "Description"
AccessorFunc(mvp.meta.radialMenuOption, "_description", "Description", FORCE_STRING)

mvp.meta.radialMenuOption.__proto._icon = nil
AccessorFunc(mvp.meta.radialMenuOption, "_icon", "Icon")

mvp.meta.radialMenuOption.__proto._isModel = false
AccessorFunc(mvp.meta.radialMenuOption, "_isModel", "IsModel")

mvp.meta.radialMenuOption.__proto._entLayoutFunc = nil
AccessorFunc(mvp.meta.radialMenuOption, "_entLayoutFunc", "EntLayoutFunc")

mvp.meta.radialMenuOption.__proto._color = mvp.colors.Text
AccessorFunc(mvp.meta.radialMenuOption, "_color", "Color")

mvp.meta.radialMenuOption.__proto._overlayIcon = nil
AccessorFunc(mvp.meta.radialMenuOption, "_overlayIcon", "OverlayIcon")

function mvp.meta.radialMenuOption:New()
    local o = table.Copy(self.__proto)

    setmetatable(o, self)
    o.__index = self

    return o
end

function mvp.meta.radialMenuOption:Click()
    -- for override

    mvp.q.LogError(nil, "Radial menu option click not implemented")
end

function mvp.meta.radialMenuOption:AddSubOption(title, description, icon, color, click)
    if (self.subMenu) then
        return self.subMenu:AddOption(title, description, icon, color, click)
    end

    self.subMenu = mvp.meta.radialMenu:New()
    local option = self.subMenu:AddOption(title, description, icon, color, click)

    self.Click = function(opt)
        opt.subMenu:Open()
    end

    return option
end