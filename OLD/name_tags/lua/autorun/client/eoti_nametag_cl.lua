EOTI_NameTag = EOTI_NameTag or {}
EOTI_NameTag.Draw = EOTI_NameTag.Draw or {}
EOTI_NameTag.Color = EOTI_NameTag.Color or {}
EOTI_NameTag.Target = EOTI_NameTag.Target or {}
EOTI_NameTag.NearbyPlayers = EOTI_NameTag.NearbyPlayers or {}
EOTI_HPBar = EOTI_HPBar or {}

if !(timer.Exists( 'eoti_nametag_editorrefresh')) then
    print('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x')
    print('NameTag+ CLIENT: Starting...')
end

timer.Create('eoti_nametag_editorrefresh',2,0,function()
    if !EOTI_NameTag.EditorRefresh then return end
    local temp = 'autorun/client/'
    AddCSLuaFile(temp.."Blank.lua")
    AddCSLuaFile(temp.."ColorBlocks.lua")
    AddCSLuaFile(temp.."Discrete.lua")
    AddCSLuaFile(temp.."Fantasy.lua")
    AddCSLuaFile(temp.."FlatDesign.lua")
    AddCSLuaFile(temp.."GrayAndBlack.lua")
    AddCSLuaFile(temp.."Khandi.lua")
    AddCSLuaFile(temp.."Space.lua")
    AddCSLuaFile(temp.."Tropical.lua")
    AddCSLuaFile(temp.."MyCustomMotif.lua")
    include( "autorun/client/eoti_nametag_cl.lua" )
end)
--------------------------------------------------------------

AddCSLuaFile( "eoti_nametag_config.lua" )
include( "eoti_nametag_config.lua" )

AddCSLuaFile( "hud/"..EOTI_NameTag.Motif )
include( "hud/"..EOTI_NameTag.Motif )

--------------------------------------------------------------

EOTI_NameTag.Draw.Scale = EOTI_NameTag.Draw.Scale/1000 or 0.1

if EOTI_NameTag.Enable and DarkRP then
    hook.Add("OnPlayerChangedTeam", "eoti_nametag_changejob", function(ply)
        if ply and EOTI_NameTag.Target.ent == ply and ply:IsPlayer() then
            if EOTI_NameTag.DrawHalo then hook.Add( "PreDrawHalos", "eoti_nametag_halo", function() end) end
            EOTI_NameTag.Target = {}
        end
    end )
    hook.Add("DarkRPVarChanged","eoti_nametag_levelup", function(ply,id,old,new)
        if (id == 'level' or id == 'lvl') and ply and EOTI_NameTag.Target.ent == ply and ply:IsPlayer() then
            if EOTI_NameTag.DrawHalo then hook.Add( "PreDrawHalos", "eoti_nametag_halo", function() end) end
            EOTI_NameTag.Target = {}
        end
    end)
    hook.Add("onPlayerChangedName","eoti_nametag_namechange",function(ply,old,new)
        if ply and EOTI_NameTag.Target.ent == ply and ply:IsPlayer() then
            if EOTI_NameTag.DrawHalo then hook.Add( "PreDrawHalos", "eoti_nametag_halo", function() end) end
            EOTI_NameTag.Target = {}
        end
    end)
end
if EOTI_NameTag.Enable then
    function EOTI_NameTag.getLevel(target)
        target = target or LocalPlayer():GetEyeTrace().Entity
        local meta = FindMetaTable( "Player" )
        EOTI_NameTag.Target.level =
            DarkRP and ( target:getDarkRPVar('level') or target:getDarkRPVar('lvl') ) or --vrondakis or sf leveling system
            levelup != nil and levelup.getLevel(target) or -- neth's levelup
            meta.MetaBaseClass['GetNetVar'] != nil and target:EL_playerLevel() or nil --elevel or nil
        return EOTI_NameTag.Target.level
    end

    function EOTI_NameTag.getDarkRPJob(target)
        if !DarkRP then return nil end
        local meta = (target or LocalPlayer():GetEyeTrace().Entity):getJobTable()
        EOTI_NameTag.Target.job = istable(meta) and meta.name or nil
        return EOTI_NameTag.Target.job
    end

    function EOTI_NameTag.hasDarkRPGunLicense(target)
        if !DarkRP then return nil end
        target = target or LocalPlayer():GetEyeTrace().Entity
        return target:getDarkRPVar('HasGunlicense')
    end

    function EOTI_NameTag.isDarkRPWanted(target)
        if !DarkRP then return nil end
        target = target or LocalPlayer():GetEyeTrace().Entity
        return target:getDarkRPVar('wanted')
    end

    function EOTI_NameTag.isTTTDetective(target)
        target = target or LocalPlayer():GetEyeTrace().Entity
        return ROLE_DETECTIVE != nil and target:IsDetective() or nil
    end

    function EOTI_NameTag.areBothTTTTraitors(target)
        target = target or LocalPlayer():GetEyeTrace().Entity
        return ROLE_DETECTIVE != nil and (LocalPlayer()):IsTraitor() and target:IsTraitor() or nil
    end

    function EOTI_NameTag.TargetIsInPlayerGroup(group, target)
        target = target or LocalPlayer():GetEyeTrace().Entity
        if group == nil or group == {} or !(target:IsPlayer()) then return end
        group = istable(group) and group or {group}

        for k, vip in pairs( group ) do
            if target:GetNWString("usergroup") == vip       --FAdmin Default Admin Mod Installed with DarkRP
            or target:GetUserGroup() == vip                 --ULX Admin Mod check for "donator"
            or target:GetNWString("EV_UserGroup") == vip    --Evolve Admin Mod Syntax
            then
                return true
            end
        end
        return false
    end

    function EOTI_NameTag.generateText(hp,armor)
        -----------------------------------------------------------------------------------------------------------------------------------------------
        surface.SetFont("EOTI_NameTag_Name")

        if EOTI_NameTag.Target.name then
            EOTI_NameTag.Target.textWideName, EOTI_NameTag.Target.textTallName = surface.GetTextSize( EOTI_NameTag.Target.name )
        end

        surface.SetFont("EOTI_NameTag_Info")

        if EOTI_NameTag.Target.info then
            EOTI_NameTag.Target.textWideInfo, EOTI_NameTag.Target.textTallInfo = surface.GetTextSize( EOTI_NameTag.Target.info )
        end

        if EOTI_NameTag.Target.misc then
            EOTI_NameTag.Target.textWideMisc, EOTI_NameTag.Target.textTallMisc = surface.GetTextSize( EOTI_NameTag.Target.misc )
        end
        -----------------------------------------------------------------------------------------------------------------------------------------------

        surface.SetFont("EOTI_NameTag_Health")

        if hp then
            EOTI_NameTag.Target.textWideHealth, EOTI_NameTag.Target.textTallHealth = surface.GetTextSize( hp )
        end

        surface.SetFont("EOTI_NameTag_Armor")

        if armor then
            EOTI_NameTag.Target.textWideArmor, EOTI_NameTag.Target.textTallArmor = surface.GetTextSize( armor )
        end

        surface.SetFont("EOTI_NameTag_Tag")

        if EOTI_NameTag.Target.tag then
            EOTI_NameTag.Target.textWideTag, EOTI_NameTag.Target.textTallTag = surface.GetTextSize( EOTI_NameTag.Target.tag )
        end

        local rhp = (EOTI_NameTag.Target.textWideHealth or 0) > 0 and (EOTI_NameTag.Target.textWideHealth + EOTI_NameTag.Draw.PadWide*2) or 0
        local rarmor = (EOTI_NameTag.Target.textWideArmor or 0) > 0 and (EOTI_NameTag.Target.textWideArmor + EOTI_NameTag.Draw.PadWide*2) or 0
        local ricon = (EOTI_NameTag.Target.textWideTag or 0) > 0 and (EOTI_NameTag.Target.textWideTag + EOTI_NameTag.Draw.PadWide*2) or 0
        local rname = (EOTI_NameTag.Target.textWideName or 0) > 0 and (EOTI_NameTag.Target.textWideName + EOTI_NameTag.Draw.PadWide*2) or 0
        local rinfo = (EOTI_NameTag.Target.textWideInfo or 0) > 0 and (EOTI_NameTag.Target.textWideInfo + EOTI_NameTag.Draw.PadWide*2) or 0
        local rmisc = (EOTI_NameTag.Target.textWideMisc or 0) > 0 and (EOTI_NameTag.Target.textWideMisc + EOTI_NameTag.Draw.PadWide*2) or 0
        local count = (EOTI_NameTag.Target.textWideHealth and 1 or 0)+(EOTI_NameTag.Target.textWideArmor and 1 or 0)+(EOTI_NameTag.Target.textWideTag and 1 or 0)
        count = EOTI_NameTag.Draw.Border*(math.Clamp(count-1,0,3))

        EOTI_NameTag.Target.textWidest = math.max( rname, rinfo, rmisc, (rhp + rarmor + rinfo + count) )
    end

    function EOTI_NameTag.drawHUD(target,hp,armor,dist,isply,isnpc,isveh,isprop)
        if !EOTI_NameTag.Target.textWidest then return end
        if TEAM_PROPS and TEAM_HUNTERS and (LocalPlayer()):Team() != target:Team() then return end

        local Pos = target:GetPos()
        local Ang = Angle( 0, LocalPlayer():EyeAngles()[2], 0 )
        Ang:RotateAroundAxis(Ang:Forward(), 90)
        local TextAng = Ang
        TextAng:RotateAroundAxis(TextAng:Right(), 90)

        local textX = -EOTI_NameTag.Target.textWidest/2
        local textY = EOTI_NameTag.ShowProp and !(isply or isnpc) and target:OBBMaxs().z+100 or -EOTI_NameTag.TargetYOffset

        local textW, textH, infoY

        if EOTI_NameTag.DrawHalo then
            hook.Add( "PreDrawHalos", "eoti_nametag_halo", function()
                halo.Add( {target}, EOTI_NameTag.HaloColor, EOTI_NameTag.HaloSize, EOTI_NameTag.HaloSize, EOTI_NameTag.HaloIntensity )
            end)
        end

        cam.Start3D2D(Pos + Ang:Right() * -50, TextAng, EOTI_NameTag.Draw.Scale*math.Clamp(dist/100,1,dist))
            local bHeight = (EOTI_NameTag.Target.name and EOTI_NameTag.Target.textTallName+EOTI_NameTag.Draw.PadTall*2 or 0) + ((hp or armor or EOTI_NameTag.Target.tag) and (EOTI_NameTag.Target.textTallHealth or EOTI_NameTag.Target.textTallTag or EOTI_NameTag.Target.textTallArmor)+EOTI_NameTag.Draw.PadTall*2 or 0) + (EOTI_NameTag.Target.info and EOTI_NameTag.Target.textTallInfo+EOTI_NameTag.Draw.PadTall*2 or 0) + (EOTI_NameTag.Target.misc and EOTI_NameTag.Target.textTallInfo+EOTI_NameTag.Draw.PadTall*2 or 0)
            local count = (EOTI_NameTag.Target.name and 1 or 0)+((hp or armor or EOTI_NameTag.Target.tag) and 1 or 0)+(EOTI_NameTag.Target.info and 1 or 0)+(EOTI_NameTag.Target.misc and 1 or 0)
            bHeight = bHeight + EOTI_NameTag.Draw.Border*(math.Clamp(count-1,0,3))

            count = ((hp and 1 or 0)+(armor and 1 or 0)+(EOTI_NameTag.Target.tag and 1 or 0))
            local rwidth = (hp and EOTI_NameTag.Target.textWideHealth or 0)+(armor and EOTI_NameTag.Target.textWideArmor or 0)+(EOTI_NameTag.Target.tag and EOTI_NameTag.Target.textWideTag or 0)+(EOTI_NameTag.Draw.PadWide*2)*count+EOTI_NameTag.Draw.Border*(math.Clamp(count-1,0,3))
            EOTI_NameTag.Target.textWidest = rwidth > EOTI_NameTag.Target.textWidest and rwidth or EOTI_NameTag.Target.textWidest  -- makes the info and name bar wider if its thinner than the row
            rwidth = rwidth < EOTI_NameTag.Target.textWidest and (EOTI_NameTag.Target.textWidest-rwidth)/count or 0 -- adds padding to hp, armor, and icon when name or info is wider than the 3 tags

            if EOTI_NameTag.Color.Background then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, textY, EOTI_NameTag.Target.textWidest, bHeight, EOTI_NameTag.Color.Background) end

            if EOTI_NameTag.Target.name then
                textH = EOTI_NameTag.Target.textTallName + EOTI_NameTag.Draw.PadTall*2
                if EOTI_NameTag.Color.ForegroundName then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, textY, EOTI_NameTag.Target.textWidest, textH, EOTI_NameTag.Color.ForegroundName) end
                textY = textY+EOTI_NameTag.Target.textTallName/2 + EOTI_NameTag.Draw.PadTall
                draw.SimpleTextOutlined( EOTI_NameTag.Target.name, "EOTI_NameTag_Name", 0, textY, EOTI_NameTag.Color.Name, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineName, Color(0,0,0) )
            end
            if EOTI_NameTag.Target.info then
                textH = EOTI_NameTag.Target.textTallInfo + EOTI_NameTag.Draw.PadTall*2
                textY = textY or 0

                infoY = textY+EOTI_NameTag.Target.textTallName/2 + EOTI_NameTag.Draw.Border*2 + (EOTI_NameTag.Target.textTallHealth or EOTI_NameTag.Target.textTallArmor or EOTI_NameTag.Target.textTallTag) + EOTI_NameTag.Draw.PadTall*3 -- fix texttallname
                if EOTI_NameTag.Color.ForegroundInfo then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, infoY, EOTI_NameTag.Target.textWidest, textH, EOTI_NameTag.Color.ForegroundInfo) end

                infoY = infoY+EOTI_NameTag.Target.textTallInfo/2 + EOTI_NameTag.Draw.PadTall
                draw.SimpleTextOutlined( EOTI_NameTag.Target.info, "EOTI_NameTag_Info", 0, infoY, EOTI_NameTag.Color.Info, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineInfo, Color(0,0,0) )
            end
            if EOTI_NameTag.Target.misc then
                textH = EOTI_NameTag.Target.textTallMisc + EOTI_NameTag.Draw.PadTall*2
                textY = textY or 0

                infoY = infoY and infoY+EOTI_NameTag.Target.textTallMisc/2+EOTI_NameTag.Draw.PadTall+EOTI_NameTag.Draw.Border or textY+EOTI_NameTag.Target.textTallName/2 + EOTI_NameTag.Draw.Border*2 + EOTI_NameTag.Target.textTallHealth + EOTI_NameTag.Draw.PadTall*3 -- fix texttallname
                if EOTI_NameTag.Color.ForegroundInfo then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, infoY, EOTI_NameTag.Target.textWidest, textH, EOTI_NameTag.Color.ForegroundInfo) end

                infoY = infoY+EOTI_NameTag.Target.textTallInfo/2 + EOTI_NameTag.Draw.PadTall
                draw.SimpleTextOutlined( EOTI_NameTag.Target.misc, "EOTI_NameTag_Info", 0, infoY, EOTI_NameTag.Color.Info, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineInfo, Color(0,0,0) )
            end
            textY = EOTI_NameTag.Target.name and textY+EOTI_NameTag.Target.textTallName/2 + EOTI_NameTag.Draw.PadTall + EOTI_NameTag.Draw.Border or textY
            if hp then
                textW = EOTI_NameTag.Target.textWideHealth+EOTI_NameTag.Draw.PadWide*2+rwidth
                textH = EOTI_NameTag.Target.textTallHealth+EOTI_NameTag.Draw.PadTall*2
                if EOTI_NameTag.Color.ForegroundHealth then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, textY, textW, textH, EOTI_NameTag.Color.ForegroundHealth) end
                draw.SimpleTextOutlined( hp, "EOTI_NameTag_Health", textX+textW/2, textY+textH/2, EOTI_NameTag.Color.Health, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineHealth, Color(0,0,0) )
                textX = textX+textW+EOTI_NameTag.Draw.Border
            end
            if armor then
                textW = EOTI_NameTag.Target.textWideArmor+EOTI_NameTag.Draw.PadWide*2+rwidth
                textH = EOTI_NameTag.Target.textTallArmor+EOTI_NameTag.Draw.PadTall*2
                if EOTI_NameTag.Color.ForegroundArmor then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, textY, textW, textH, EOTI_NameTag.Color.ForegroundArmor) end
                draw.SimpleTextOutlined( armor, "EOTI_NameTag_Armor", textX+textW/2, textY+textH/2, EOTI_NameTag.Color.Armor, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineArmor, Color(0,0,0) )
                textX = textX+textW+EOTI_NameTag.Draw.Border
            end
            if EOTI_NameTag.Target.tag then
                textW = EOTI_NameTag.Target.textWideTag+EOTI_NameTag.Draw.PadWide*2+rwidth
                textH = EOTI_NameTag.Target.textTallTag+EOTI_NameTag.Draw.PadTall*2
                if EOTI_NameTag.Color.ForegroundTag then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, textY, textW, textH, EOTI_NameTag.Color.ForegroundTag) end
                draw.SimpleTextOutlined( EOTI_NameTag.Target.tag, "EOTI_NameTag_Tag", textX+textW/2, textY+textH/2, EOTI_NameTag.Color.Tag, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineTag, Color(0,0,0) )
            end
        cam.End3D2D()
    end

    function EOTI_NameTag.drawNames(target,dist)
        if #EOTI_NameTag.NearbyPlayers > 0 then

            for _, ply in pairs(EOTI_NameTag.NearbyPlayers) do
                if ply:IsValid() and LocalPlayer():IsLineOfSightClear(ply) and !(ply:GetNWBool( "CloakPlayerCloaked", nil )) and (target != ply or dist > EOTI_NameTag.Distance) then --StealthCamo
                    local Pos = ply:GetPos()
                    local Ang = Angle( 0, LocalPlayer():EyeAngles()[2], 0 )
                    Ang:RotateAroundAxis(Ang:Forward(), 90)
                    local TextAng = Ang
                    TextAng:RotateAroundAxis(TextAng:Right(), 90)

                    local dist = (LocalPlayer():GetPos()):Distance(ply:GetPos())

                    local name = ply:Name()
                    surface.SetFont("EOTI_NameTag_Name")
                    local nameW, nameH = surface.GetTextSize( name )
                    nameW = EOTI_HPBar.BarWidth < nameW and (nameW + EOTI_NameTag.Draw.PadWide*2) or EOTI_HPBar.BarWidth
                    nameH = nameH + EOTI_NameTag.Draw.PadTall*2
                    local textX = -nameW/2

                    local scale = EOTI_NameTag.Draw.Scale*math.Clamp(dist/100,1,dist)
                    local textY = -EOTI_HPBar.YOffset-100+100*scale*3

                    cam.Start3D2D(Pos + Ang:Right() * -50, TextAng, scale)
                        if EOTI_NameTag.Color.ForegroundName then draw.RoundedBox(0, textX, textY, nameW, nameH, EOTI_NameTag.Color.ForegroundName) end
                        textY = textY+nameH/2
                        draw.SimpleTextOutlined( name, "EOTI_NameTag_Name", 0, textY, EOTI_NameTag.Color.Name, TEXT_ALIGN_CENTER, 1, EOTI_NameTag.Draw.OutlineName, Color(0,0,0) )

                        textY = textY+nameH/2

                        local hp = ply:Health() or 100
                        hp = math.Clamp(hp,0,hp)
                        local maxhp = ply:GetMaxHealth() or 100
                        maxhp = hp and maxhp < hp and hp or maxhp

                        draw.RoundedBox(0, textX, textY, nameW/maxhp*hp, EOTI_HPBar.BarHeight, Color(255,0,0))

                        local armor = ply:Armor() or 0
                        local maxar = 100 > armor and 100 or armor

                        if armor > 0 then draw.RoundedBox(EOTI_NameTag.Draw.Corner, textX, textY+EOTI_HPBar.BarHeight, nameW/maxar*armor, EOTI_HPBar.BarHeight, Color(0,0,255)) end
                    cam.End3D2D()
                end
            end
        end
    end
end

if EOTI_NameTag.Enable then
    timer.Create('eoti_nametag_distance',0.1,0,function()
        EOTI_NameTag.NearbyPlayers = {}
        local me = LocalPlayer()
        local propHuntMe = TEAM_PROPS and TEAM_HUNTERS and me:Team() or nil
        local players = EOTI_HPBar.ShowBots and EOTI_HPBar.ShowPlayers and player.GetAll() or EOTI_HPBar.ShowPlayers and player.GetHumans() or player.GetBots()
        for _, ply in pairs( players ) do
            local propHuntTarget = propHuntMe and ply:Team() == propHuntMe or nil
            EOTI_NameTag.NearbyPlayers[#EOTI_NameTag.NearbyPlayers+1] = ply != me and propHuntTarget and (LocalPlayer():GetPos()):Distance(ply:GetPos()) < EOTI_HPBar.Distance and ply or nil
            if #EOTI_NameTag.NearbyPlayers >= EOTI_HPBar.Max then return end
        end
    end)

	hook.Add( "PostDrawTranslucentRenderables", "eoti_nametag_draw", function()
		cam.IgnoreZ(true)

            local target = LocalPlayer():GetEyeTrace().Entity
            local valid = target:IsValid()
            local dist = valid and (LocalPlayer():GetPos()):Distance(target:GetPos())

            if valid then

                local isnpc = EOTI_NameTag.ShowNPC and target:IsNPC()
                local isply = EOTI_NameTag.ShowPlayer and target:IsPlayer()
                local isveh = EOTI_NameTag.ShowVehicle and target:IsValid() and target:IsVehicle()
                local isprop = EOTI_NameTag.ShowProp and target:GetClass() == 'prop_physics'

                EOTI_NameTag.showHUD = target:GetClass() == 'prop_door_rotating' -- Change this

                if (isply or isnpc or isveh or isprop) then
                    local tgthp = target:Health()
                    tgthp = EOTI_NameTag.ShowHealth and (isply or isnpc or ( (isprop or isveh) and tgthp > 0 )) and tgthp or nil
                    local armor = EOTI_NameTag.ShowArmor and isply and target:Armor() or nil

                    if DarkRP and isply and target:getDarkRPVar('wanted') or dist < EOTI_NameTag.Distance and !(target:GetNWBool( "CloakPlayerCloaked", nil )) then

                        if target != EOTI_NameTag.Target.ent then
                            EOTI_NameTag.Target = {}
                            EOTI_NameTag.Target.ent = target

                            if isply then
                                -- get target's name
                                EOTI_NameTag.Target.name = EOTI_NameTag.ShowName and target:Name() or nil

                                -- if this exists
                                EOTI_NameTag.Target.info = EOTI_NameTag.overrideInfoBar(LocalPlayer(),target,isply,isnpc,isveh,isprop)

                                -- adds extra bar
                                EOTI_NameTag.Target.misc = EOTI_NameTag.addExtraInfoBar(LocalPlayer(),target,isply,isnpc,isveh,isprop)
                            elseif isnpc then
                                -- get target's name
                                local cname = target:GetClass()
                                EOTI_NameTag.Target.name = EOTI_NameTag.ShowNPCName and (EOTI_NameTag.CustomNames[cname] or cname) or nil
                            elseif isveh or isprop then
                                local cname = target:GetClass()
                                EOTI_NameTag.Target.name = EOTI_NameTag.ShowVehicleName and target:IsVehicle() and (EOTI_NameTag.CustomNames[cname] or cname) or nil
                            end
                            -- if this exists
                            EOTI_NameTag.Target.tag = EOTI_NameTag.overrideTag(LocalPlayer(),target,isply,isnpc,isveh,isprop)

                            -- generate text for this particular motif
                            EOTI_NameTag.generateText(tgthp,armor)
                        end
                        EOTI_NameTag.drawHUD(target,tgthp,armor,dist,isply,isnpc,isveh,isprop)
                    end
                else
                    if EOTI_NameTag.DrawHalo then hook.Add( "PreDrawHalos", "eoti_nametag_halo", function() end) end
                    EOTI_NameTag.Target = {}
                end
            else
                if EOTI_NameTag.DrawHalo then hook.Add( "PreDrawHalos", "eoti_nametag_halo", function() end) end
                EOTI_NameTag.Target = {}
            end
            EOTI_NameTag.drawNames(target,dist)
        cam.IgnoreZ(false)
    end)

	hook.Add( "HUDPaint", "eoti_paint_TargetID", function()
		if EOTI_NameTag.HideNameTag then
            if DarkRP then DarkRP.GAMEMODE.Config.globalshow = false end
            hook.Add("HUDShouldDraw", "HideEntityDisplayHUD", function(name)
                if name == "DarkRP_EntityDisplay" then return EOTI_NameTag.showHUD end
            end)
            function GAMEMODE:HUDDrawTargetID()
                return false
            end
        end
	end)
end

if timer.Exists( 'eoti_nametag_editorrefresh') then
    print("NameTag+ CLIENT: Refreshing Script (If you see this repeatedly then EOTI_NameTag.AutoRefreshed is set to true in 'eoti_nametag/lua/eoti_nametag_config.lua')")
else
    print('NameTag+ CLIENT: Finished Loading.')
    print('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x')
end
