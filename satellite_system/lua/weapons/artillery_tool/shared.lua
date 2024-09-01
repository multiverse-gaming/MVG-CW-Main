AddCSLuaFile()

SWEP.PrintName = "Artillery Tool"
SWEP.Base = "weapon_base"

SWEP.Category = "Kaito"
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/kaito/sw/w_macrobinoculars.mdl"
SWEP.HoldType = "camera"
SWEP.UseHands = true
SWEP.DrawAmmo = false 
SWEP.IconOverride = "materials/weapons/kaito/artillery/ArtilleryToolIcon.png"
SWEP.Slot = 4


local LastRld = -1
local sLastRld = -1
local firingMode = 0
local shellType = 1

local security = true 





function SpawnShellsAtRadius(origin, radius, n, d,sType)
    local isDistPlayed = GetConVar("kplayartdistantsound"):GetInt()
    local getTBI = GetConVar("kshellwaitingtime"):GetInt()
        if n <= 0 then
            return -- Ne rien faire si le nombre de shells est inférieur ou égal à zéro
        end
        local delay = d -- Délai en secondes entre chaque spawn
        local shellName = sType
        isDistPlayed = GetConVar("kplayartdistantsound"):GetInt()
        if string.find(shellName,'mortar') and isDistPlayed >= 1 then
            
            for i = 1, n do
                timer.Simple(delay * i, function()
                    net.Start("kaito_net_sound_new_mortar_basefire")
                        net.WriteString("placeholder")
                    net.Broadcast()
                end)
            end
            timer.Simple(getTBI, function()
                for i = 1, n do
                    local angle = math.random(0, 360) -- Angle aléatoire
                    local radianAngle = math.rad(angle) -- Convertir l'angle en radians
                    local offset = math.random(100, 800)
                    -- Calculer la position en fonction de l'angle et du rayon
                    local x = origin.x + (math.cos(radianAngle) * (radius - offset))
                    local y = origin.y + (math.sin(radianAngle) * (radius - offset))

                    -- Créer un vecteur pour la position potentielle de l'entité
                    local spawnPos = Vector(x, y, origin.z)

                    -- Utiliser util.TraceHull pour vérifier la géométrie du sol
                    local trace = util.TraceHull({
                        start = spawnPos,
                        endpos = spawnPos - Vector(0, 0, 1000), -- Descendre de 1000 unités pour vérifier la géométrie du sol
                        mins = Vector(-16, -16, 0), -- Ajustez ces valeurs selon les dimensions de votre entité
                        maxs = Vector(16, 16, 72), -- Ajustez ces valeurs selon les dimensions de votre entité
                        filter = function(ent)
                            if ent:GetClass() == "worldspawn" then
                                return true
                            end
                        end
                    })

                    if trace.Hit then
                        -- L'entité a touché le sol, nous pouvons créer l'entité à cette position
                        timer.Simple(delay * i, function()
                            local shell = ents.Create(shellName)
                            shell:SetPos(trace.HitPos)
                            shell:Spawn()
                        end)
                    end
                end
            end)
            return
        end

        for i = 1, n do
            local angle = math.random(0, 360) -- Angle aléatoire
            local radianAngle = math.rad(angle) -- Convertir l'angle en radians
            local offset = math.random(100, 800)
            -- Calculer la position en fonction de l'angle et du rayon
            local x = origin.x + (math.cos(radianAngle) * (radius - offset))
            local y = origin.y + (math.sin(radianAngle) * (radius - offset))

            -- Créer un vecteur pour la position potentielle de l'entité
            local spawnPos = Vector(x, y, origin.z)

            -- Utiliser util.TraceHull pour vérifier la géométrie du sol
            local trace = util.TraceHull({
                start = spawnPos,
                endpos = spawnPos - Vector(0, 0, 1000), -- Descendre de 1000 unités pour vérifier la géométrie du sol
                mins = Vector(-16, -16, 0), -- Ajustez ces valeurs selon les dimensions de votre entité
                maxs = Vector(16, 16, 72), -- Ajustez ces valeurs selon les dimensions de votre entité
                filter = function(ent)
                    if ent:GetClass() == "worldspawn" then
                        return true
                    end
                end
            })

            if trace.Hit then
                -- L'entité a touché le sol, nous pouvons créer l'entité à cette position
                timer.Simple(delay * i, function()
                    local shell = ents.Create(shellName)
                    shell:SetPos(trace.HitPos)
                    shell:Spawn()
                end)
            end
        end
end




local firingType = {
    [1] = "artillery_he",
    [2] = "artillery_se",
    [3] = "mortar_bomb_shell",
    [4] = "mortar_smoke_shell",
    [5] = "mortar_fire_shell"
}


function SWEP:Initialize()
    self:SetHoldType("camera")
end


if (CLIENT) then
    SWEP.PreviewModel = ClientsideModel("models/dolunity/starwars/mortar.mdl")
    SWEP.PreviewModel:SetNoDraw(true)
    SWEP.PreviewModel:SetMaterial("models/wireframe")
end


function SWEP:Precache()
	util.PrecacheSound( "kaito/artillery/weapons/art_swep_security.mp3" )
    util.PrecacheSound( "kaito/artillery/weapons/art_swep_change_firingmode.mp3" )
    util.PrecacheSound( "kaito/artillery/weapons/art_swep_change_shell.mp3" )
    util.PrecacheSound( "kaito/artillery/weapons/art_swep_sendfiremission.mp3" )
    util.PrecacheSound( "kaito/artillery/weapons/art_swep_error.mp3" )
    
end


function SWEP:PrimaryAttack()

    

    if self.Owner:KeyDown(IN_SPEED) then
        if (shellType >= 5) then
            shellType = 1
        elseif shellType >=1 then
            shellType = shellType + 1
        end
        self.Weapon:EmitSound( "kaito/artillery/weapons/art_swep_change_shell.mp3", 35, pitcher, 1, CHAN_WEAPON )
        txtContent = "[Artillery Tool] Changed firing type to : "..firingType[shellType]
        if ( CLIENT ) then return end
        self.Owner:ChatPrint(txtContent) 
        return
    end

    self.Weapon:EmitSound( "kaito/artillery/weapons/art_swep_sendfiremission.mp3", 35, pitcher, 1, CHAN_WEAPON )

    if (security) then
        self.Weapon:EmitSound( "kaito/artillery/weapons/art_swep_error.mp3", 35, pitcher, 1, CHAN_WEAPON )
        if ( CLIENT ) then return end
        self.Owner:ChatPrint("[Artillery Tool] Security enabled, please use SHIFT (+run) and RIGHT-CLICK to disable.")
        return
    end

    local ply = self.Owner
    local trace = ply:GetEyeTrace()
    local impctPoint = trace.HitPos
    local firingPosition = ply:GetPos()
    

    if firingPosition:Distance(impctPoint) < 3700 then
        self.Weapon:EmitSound( "kaito/artillery/weapons/art_swep_error.mp3", 35, pitcher, 1, CHAN_WEAPON )
        if ( CLIENT ) then return end
        self.Owner:ChatPrint("[Artillery Tool] Firing mission too close.")
        return
    end

    if ( CLIENT ) then return end


    
    
    local isDistPlayed = GetConVar("kplayartdistantsound"):GetInt()
    local getTBI = GetConVar("kshellwaitingtime"):GetInt()
    local radialValue = GetConVar("k_art_radialstrike_value"):GetInt()
    local volleyValue = GetConVar("k_art_volleystrike_value"):GetInt()
    local shell = ents.Create(firingType[shellType])

    


    if (firingMode == 1) then
        if string.find(firingType[shellType],'mortar') and isDistPlayed >= 1 then
            net.Start("kaito_net_sound_new_mortar_basefire")
                net.WriteString("placeholder")
            net.Broadcast()
            timer.Simple(getTBI, function()
                shell:SetPos(impctPoint)
                shell:Spawn()  
            end)
            return
        end
        shell:SetPos(impctPoint)
        shell:Spawn()       
    elseif (firingMode == 2) then
        SpawnShellsAtRadius(impctPoint,1000,radialValue,1.8,firingType[shellType])
    else
        SpawnShellsAtRadius(impctPoint,1200,volleyValue,0.1,firingType[shellType])
    end

end

function SWEP:SecondaryAttack()

    if self.Owner:KeyDown(IN_SPEED) then
        self.Weapon:EmitSound( "kaito/artillery/weapons/art_swep_security.mp3", 35, pitcher, 1, CHAN_WEAPON )
        if ( CLIENT ) then return end
        if security then
            self.Owner:ChatPrint("Disabled security.")
            security = false 
        else
            self.Owner:ChatPrint("Enabled security")
            security = true
        end
        return
    end

    local pitcher = math.random( 90, 105 )
    local checkPlaySounds = GetConVar("mortar_play_rangefinder_sounds"):GetInt()
    if (not IsFirstTimePredicted()) then return end

    if (self.Zoom) then
        self.Owner:SetFOV(self.OldFOV, 0.5)
        self.Zoom = false
        if (checkPlaySounds != 0) then
            self.Weapon:EmitSound( "weapons/rangefinderzoomin.mp3", 35, pitcher, 1, CHAN_WEAPON )
        end     
    else
        self.Zoom = true
        self.OldFOV = self.Owner:GetFOV()
        self.Owner:SetFOV(20, 0.5)
        if (checkPlaySounds != 0) then
            self.Weapon:EmitSound( "weapons/rangefinderzoomout.mp3", 35, pitcher, 1, CHAN_WEAPON )
        end
        
    end



end

function SWEP:Reload()
    if LastRld < CurTime() then
        self.Weapon:EmitSound( "kaito/artillery/weapons/art_swep_change_firingmode.mp3", 35, pitcher, 1, CHAN_WEAPON )
        LastRld = CurTime() + 0.5
        if ( CLIENT ) then return end

        local ply = self.Owner
        firingMode = firingMode+1
        if (firingMode > 3) then
            firingMode=1
            ply:ChatPrint("[Artillery Tool] Mode : Single")
        elseif (firingMode == 3) then
            ply:ChatPrint("[Artillery Tool] Mode : Volley Strike")
        elseif (firingMode == 2) then
            ply:ChatPrint("[Artillery Tool] Mode : Radial Strike")
        end
        
    end
end


function SWEP:ShouldDrawViewModel()
    return false
end

function SWEP:AdjustMouseSensitivity()
    if (self.Owner:GetFOV() == 20) then
        return 0.05
    end
    return 1
end

function SWEP:Deploy()
    self:SetHoldType(self.HoldType)
end

local laserPointer = Material("Sprites/light_glow02_add_noz")
hook.Add("PostDrawTranslucentRenderables", "mortarRangeFinder", function()
    if (LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "artillery_tool" and not LocalPlayer():InVehicle()) then
        local trace = LocalPlayer():GetEyeTrace()
        render.SetMaterial(laserPointer)
        render.DrawQuadEasy(trace.HitPos + trace.HitNormal, trace.HitNormal, 32, 32, Color(255,255,0),0)
    end
end)

hook.Add("HUDPaint", "kaitoDrawBaseBinosHud", function ()
    if (LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "artillery_tool" and not LocalPlayer():InVehicle()) then
        local check = true 
        local drawOverlayCheck = GetConVar("k_artcl_enable_binobasehud"):GetInt()
        local drawScifiCheck = GetConVar("k_artcl_enable_binoscifihud"):GetInt()
        local drawMaterial = Material("weapons/kaito/artillery/macrobinoculars.png")


        if (drawScifiCheck != 0) then
            DrawMaterialOverlay("effects/combine_binocoverlay", -0.06)
        end

        if (drawOverlayCheck != 0) then
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(drawMaterial)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end

    end
end)