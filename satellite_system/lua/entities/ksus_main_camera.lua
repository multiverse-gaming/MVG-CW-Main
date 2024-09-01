//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

AddCSLuaFile()

ENT.PrintName   =   "Satellite Camera"
ENT.Author      =   "Kaito"
ENT.Category    =   "Kaito"
ENT.Type        =   "anim"
ENT.Base        =   "base_anim"


ENT.Spawnable = false
ENT.AdminOnly = false

ENT.nextTraceTime = 0
ENT.traceInterval = 1

function ENT:SpawnFunction(ply, tr, ClassName)

    local ent = ents.Create(ClassName)
    ent:SetPos(tr.HitPos + tr.HitNormal * 25)
    ent:Spawn()
    ent:Activate()
    ent:SetOwner(ply)

    return ent
end

function ENT:Initialize()
    if (CLIENT) then return end

    self:SetModel("models/dav0r/camera.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_FLY)
    self:SetSolid(SOLID_NONE)
    self:GetPhysicsObject():EnableGravity(false)
    self:DrawShadow(false)
    self:SetMaterial('Models/effects/vol_light001')
    self.nextTraceTime = 0
    self.traceInterval = 1 -- Intervalle de 1 seconde

end

function ENT:Think()

    self:SetNWVector("KaitoSatCameraPos", self:GetPos())

    -- Vérifie si une seconde s'est écoulée depuis le dernier tracé
    if CurTime() >= self.nextTraceTime then
        -- Met à jour le temps pour la prochaine vérification
        self.nextTraceTime = CurTime() + self.traceInterval

        local startPos = self:GetPos()
        local startAng = self:GetAngles()

        local trace = util.TraceLine({
            start = startPos,
            endpos = startPos + (startAng:Forward() * 99999999), -- Ajustez la distance si nécessaire
            filter = self
        })

        local hitpos = trace.HitPos 
        local entities = ents.FindInSphere(hitpos, 250)

        -- Met à jour le NWBool pour indiquer s'il y a une entité ou non
        local entityFound = #entities > 0
        -- if entityFound then
        --     print('Entity Found')
        -- end
        
        self:SetNWBool("ksus_entityInRadiusFound_satelliteCam", entityFound)
        self:SetNWVector('ksus_hitposFromSatCam',hitpos)
    end

    self:NextThink(CurTime()) -- Pour que le Think continue d'être appelé
    return true
end



function ENT:CameraControl( ply )
    local minHeight = 4200 -- Remplacez cette valeur par la hauteur minimale désirée
    local currentPos = self:GetPos()

    -- print(currentPos.z)

    local function heightCorrection()
        if currentPos.z < minHeight then
            self:SetVelocity( Vector(0,0,100) )
        end
    end
    
    if not IsValid(ply) then return end 

    if ply:KeyDown( IN_FORWARD ) then 
        self:SetVelocity( Vector(10,0,0) )
        heightCorrection()
    elseif ply:KeyDown(IN_BACK) then
        self:SetVelocity( Vector(-10,0,0) )
        heightCorrection()
    elseif ply:KeyDown(IN_MOVELEFT) then
        self:SetVelocity( Vector(0,10,0) )
        heightCorrection()
    elseif ply:KeyDown(IN_MOVERIGHT) then
        self:SetVelocity( Vector(0,-10,0) )
        heightCorrection()
    elseif ply:KeyDown(IN_SPEED) then
        self:SetVelocity( Vector(0,0,20) )
        heightCorrection()
    elseif ply:KeyDown(IN_DUCK) then
        self:SetVelocity( Vector(0,0,-30) )
        heightCorrection()
    else 
        self:SetVelocity( -self:GetVelocity()/10 ) 
        heightCorrection()
    end
end


local waypointTimeControl = -1


function ENT:SpawnWaypoint(ply,name)
    -- print('Called'..ply:Nick()..' '..name)
    if waypointTimeControl < CurTime() then
        if not IsValid(ply) or not ply:Alive() then return end

        local startPos = self:GetPos()
        local startAng = self:GetAngles()

        local trace = util.TraceLine({
            start = startPos,
            endpos = startPos + (startAng:Forward() * 99999999), -- Ajustez la distance si nécessaire
            filter = self
        })

        local hitpos = trace.HitPos 
        local alreadyPoint = false 

		for k,v in ipairs(ents.FindInSphere(hitpos,320)) do
			if v:GetClass() == "waypoint_marker" then
				if (v:GetWPOwner() == ply) or (ply:IsAdmin()) then
					net.Start("kaito_waypoints_sounds")
						net.WriteString("remove")
					net.Send(ply)
					v:Remove()
				else
					ply:ChatPrint("That waypoint is not owned by you! It is owned by "..v:GetWPOwner():GetName())
					net.Start("kaito_waypoints_sounds")
						net.WriteString("fail")
					net.Send(ply)
					
				end
				alreadyPoint = true
			else
				alreadyPoint = false
			end
        end 


        if alreadyPoint then
            return
        elseif (trace.Hit) then
            if alreadyPoint then return end
            local ent = ents.Create("waypoint_marker") 
            if not IsValid(ent) then return end

            ent:SetPos(trace.HitPos)
            ent:SetAngles(trace.HitNormal:Angle()) -- Alignez l'entité avec la normal du point de collision
            ent:Spawn()
            ent:Activate()
			net.Start("kaito_waypoints_sounds")
				net.WriteString("add")
			net.Send(ply)
            ent:SetWaypointName(name)
        end

        waypointTimeControl = CurTime() + 2

    end

end

function ENT:RemoveWaypoint(ply)
    if waypointTimeControl < CurTime() then

        local startPos = self:GetPos()
        local startAng = self:GetAngles()

        local trace = util.TraceLine({
            start = startPos,
            endpos = startPos + (startAng:Forward() * 99999999), -- Ajustez la distance si nécessaire
            filter = self
        })

        local hitpos = trace.HitPos 

        waypointTimeControl = CurTime() + 2

		for k,v in ipairs(ents.FindInSphere(hitpos,320)) do
			if v:GetClass() == "waypoint_marker" then
				if (v:GetWPOwner() == ply) or (ply:IsAdmin()) then
					net.Start("kaito_waypoints_sounds")
						net.WriteString("remove")
					net.Send(ply)
					v:Remove()
				else
					ply:ChatPrint("That waypoint is not owned by you! It is owned by "..v:GetWPOwner():GetName())
					net.Start("kaito_waypoints_sounds")
						net.WriteString("fail")
					net.Send(ply)
					
				end
			end
        end 
    end
end