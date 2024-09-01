include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("kaito_net_sound_new_se",function()
    local entPos = net.ReadVector()
    local ply = LocalPlayer()
	local plypos = ply:GetPos()
	local distance = ply:GetPos():Distance(entPos)

    local soundTableClose = {
        "weapons/mortarimpactsmoke/mortarimpactsmoke50m_01.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke50m_02.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke50m_03.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke50m_01.mp3"

    }

    local soundTableMid = {
        "weapons/mortarimpactsmoke/mortarimpactsmoke100m_01.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke100m_02.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke100m_03.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke100m_04.mp3"
    }

    local soundTableFar = {
        "weapons/mortarimpactsmoke/mortarimpactsmoke250m_01.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke250m_02.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke250m_03.mp3",
        "weapons/mortarimpactsmoke/mortarimpactsmoke250m_04.mp3"
    }


    local soundTaken = math.Round((math.random(1, 4)), 0)

    if (distance < 4000) then
        surface.PlaySound(soundTableClose[soundTaken])
        timer.Simple(5, function()
            util.ScreenShake(Vector(0,0,0), 9, 5, 2, 9500)
        end)
    elseif (distance >= 4000 and distance < 10514) then
        surface.PlaySound(soundTableMid[soundTaken])
        timer.Simple(5, function()
            util.ScreenShake(Vector(0,0,0), 6, 4, 2, 4400)
        end)
    elseif (distance >= 10514 and distance < 900000) then
        surface.PlaySound(soundTableFar[soundTaken])
    end
    
end)