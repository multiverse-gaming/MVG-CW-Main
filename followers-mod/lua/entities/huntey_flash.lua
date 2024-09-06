
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Author			= "FiLzO"
ENT.Information		= ""
ENT.Category		= ""

ENT.Spawnable		= false
ENT.AdminOnly		= false

if(SERVER)then

function ENT:Initialize()
self:SetModel("models/weapons/w_pistol.mdl")
self:SetNoDraw(true)
self:DrawShadow(false)
self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

if self.A == nil then
self.A = 0
end
if self.B == nil then
self.B = 0
end
if self.C == nil then
self.C = 0
end

if self.AA == nil then
self.AA = 0
end
if self.BB == nil then
self.BB = 0
end
if self.CC == nil then
self.CC = 0
end

if self.AR == nil then
self.AR = 255
end
if self.BG == nil then
self.BG = 255
end
if self.CB == nil then
self.CB = 255
end

if self.FovA == nil then
self.FovA = 90
end
if self.DisA == nil then
self.DisA = 650
end

if self.FovB == nil then
self.FovB = 90
end
if self.DisB == nil then
self.DisB = 650
end

local realisticpos = self:GetPos() + self:GetForward() * self.A + self:GetUp() * self.B + self:GetRight() * self.C

if self.Model != nil then
self.cm = ents.Create("prop_dynamic")
self.cm:SetModel(self.Model)
self.cm:SetModelScale(self.ModelS)
self.cm:SetMaterial("")
self.cm:SetPos(realisticpos + self:GetForward() * self.ModelP)
self.cm:SetAngles(self:GetAngles() + Angle(self.AA,self.BB,self.CC))
self.cm:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
self.cm:SetParent(self)
self.cm:Spawn()
end

self.fa = ents.Create("env_projectedtexture")
self.fa:SetPos(realisticpos)
self.fa:SetAngles(self:GetAngles() + Angle(self.AA,self.BB,self.CC))
self.fa:SetKeyValue('lightcolor', ""..self.AR.." "..self.BG.." "..self.CB.."")
self.fa:SetKeyValue('lightfov', ""..self.FovA.."")
self.fa:SetKeyValue('farz', ""..self.DisA.."")
self.fa:SetKeyValue('nearz', "25")
self.fa:SetKeyValue('shadowquality', "0")
self.fa:Input("fbTexture", NULL, NULL, "effects/flashlight001")
self.fa:SetOwner(self.Owner)
self.fa:SetParent(self)
self.fa:Spawn()
self.fa:Activate()
self.fa:Fire("TurnOff", "", 0)
	
self.fb = ents.Create("point_spotlight")
self.fb:SetPos(realisticpos)
self.fb:SetAngles(self.fa:GetAngles())
self.fb:SetKeyValue("spawnflags", "1" + "2")
self.fb:SetKeyValue("spotlightwidth", ""..self.FovB.."")
self.fb:SetKeyValue("spotlightlength", ""..self.DisB.."")
self.fb:SetColor(Color(self.AR,self.BG,self.CB,255))
self.fb:SetOwner(self.Owner)
self.fb:SetParent(self)
self.fb:Spawn()
self.fb:Activate()
self.fb:Fire("LightOff", "", 0)

end
function ENT:OnRemove()
if IsValid (self.cm) then
SafeRemoveEntityDelayed(self.cm,0.5)
end
if IsValid (self.fb) then
self.fb:SetParent()
self.fb:Fire("LightOff")
self.fb:Fire("kill",self.fb,0.5)
end
end
end
