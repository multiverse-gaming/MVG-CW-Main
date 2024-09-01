local P = mvp.meta.package:New()

P:SetIcon(Material("mvp/radialmenu/package_icon.png", "smooth"))
P:SetName("Radial Menus")
P:SetVersion("1.0.2")
P:SetDescription("Enables developers to create radial menus for their needs.")
P:SetAuthor("Kot")

P:AddFolder("languages")
P:AddFolder("ui")
P:AddFile("cl_radialmenu.meta.lua")
P:AddFile("cl_credits.lua")

mvp.package.Register(P)