include("shared.lua")
include("eps_claimboard/config.lua")
AddCSLuaFile()

function ENT:Draw()
    self:DrawModel()
    local pos = self:LocalToWorld(Vector(-23, 0, 90))
    local ang = self:LocalToWorldAngles(Angle(0, 0, 90))
    cam.Start3D2D(pos, ang, 0.1)
    draw.RoundedBox(0, 0, 0, 510, 745, Color(0, 0, 0))
    draw.RoundedBox(0, 0, 0, 510, 100, Color(144, 0, 255))

    if self:GetClaimBoardClaimed() then
        draw.SimpleText(EPS_ShortenString(self:GetClaimBoardTitle(), 13), "EPS_ClaimBoard_ScreenTitle", 510 / 2, 50, Color(255, 255, 255), 1, 1)
        draw.SimpleText("Claimed By", "EPS_ClaimBoard_ScreenBody", 510 / 2, 250, Color(255, 255, 255, 255), 1, 1)
        draw.SimpleText(EPS_ShortenString(self:GetClaimBoardBat(), 13), "EPS_ClaimBoard_ScreenTitle", 510 / 2, 315, Color(255, 255, 255, 255), 1, 1)
        draw.SimpleText("Status:", "EPS_ClaimBoard_ScreenBody", 510 / 2, 400, Color(255, 255, 255, 255), 1, 1)

        if self:GetClaimBoardOpen() then
            draw.SimpleText("Open To All", "EPS_ClaimBoard_ScreenTitle", 510 / 2, 460, Color(0, 255, 0, 255), 1, 1)
        else
            draw.SimpleText("Closed", "EPS_ClaimBoard_ScreenTitle", 510 / 2, 460, Color(255, 0, 0, 255), 1, 1)
            draw.SimpleText("AOS On Entry", "EPS_ClaimBoard_ScreenBody", 510 / 2, 520, Color(255, 0, 0, 255), 1, 1)
        end
    else
        draw.SimpleText("Unclaimed", "EPS_ClaimBoard_ScreenTitle", 510 / 2, 50, Color(255, 255, 255), 1, 1)
    end

    cam.End3D2D()
end