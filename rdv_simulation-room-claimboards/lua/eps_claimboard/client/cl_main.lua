surface.CreateFont("EPS_ClaimBoard_ScreenTitle", {
    font = "Roboto",
    extended = false,
    size = 75,
    weight = 500,
    antialias = true
})

surface.CreateFont("EPS_ClaimBoard_ScreenBody", {
    font = "Roboto",
    extended = false,
    size = 50,
    weight = 500,
    antialias = true
})

surface.CreateFont("EPS_ClaimBoard_SimpleText", {
    font = "Roboto",
    extended = false,
    size = ScrW() * 0.02,
    weight = 500,
    antialias = true
})

hook.Add("Initialize", "EPSClaimboard_LoadFonts", function()
    XeninUI:CreateFont("XeninUI.EPSClaimboard.Label", ScrW() * 0.0075)
    XeninUI:CreateFont("XeninUI.EPSClaimboard.Confirm", ScrW() * 0.0075)
    XeninUI:CreateFont("XeninUI.EPSClaimboard.Button", ScrW() * 0.009)
    XeninUI:CreateFont("XeninUI.EPSClaimboard.Large", ScrW() * 0.02)
end)