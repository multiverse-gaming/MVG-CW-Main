AddCSLuaFile()

ENT.PrintName = "Squad Shield"
ENT.Category = "MVG"
ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Model = "models/hunter/tubes/tube1x1x1.mdl"
ENT.RenderGroup = RENDERGROUP_OTHER
ENT.Spawnable = true

function ENT:SetupDataTables()

    self:NetworkVar("Float", 0, "TimeCreated")

end

function ENT:Initialize()

    self:SetTimeCreated(CurTime())

    if CLIENT then
        self = ents.CreateClientProp()

        local light = DynamicLight(self:EntIndex())

        if light then

            light.pos = self:GetPos()
            light.r = 63
            light.g = 73
            light.b = 255
            light.brightness = 2
            light.Decay = 0
            light.Size = 256
            light.DieTime = CurTime() + 30

        end

    else

        self.BulletShield = ents.Create("prop_dynamic")
        self.BulletShield:SetModel("models/stein/squadshield.mdl")
        self.BulletShield:SetMaterial("stein/shield1")
        self.BulletShield:SetParent(self)
        self.BulletShield:SetPos(self:GetPos() - Vector(0, 0, 2))
        self.BulletShield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
        self.BulletShield:SetSolid(SOLID_BSP)
        self.BulletShield:AddEffects(EF_NOSHADOW)
        self.BulletShield:Activate()
        self.BulletShield.donottouchwithphysgun = true

        self.BulletShieldSecond = ents.Create("prop_dynamic")
        self.BulletShieldSecond:SetModel("models/stein/squadshield.mdl")
        self.BulletShieldSecond:SetMaterial("stein/shield1")
        self.BulletShieldSecond:SetParent(self)
        self.BulletShieldSecond:SetPos(self:GetPos() - Vector(0, 0, 2))
        self.BulletShieldSecond:SetAngles(self:GetAngles() + Angle(180, 0, 0))
        self.BulletShieldSecond:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
        self.BulletShieldSecond:SetSolid(SOLID_BSP)
        self.BulletShieldSecond:AddEffects(EF_NOSHADOW)
        self.BulletShieldSecond:Activate()
        self.BulletShield.donottouchwithphysgun = true

        self.SoundLoop = CreateSound(self, "ambient/levels/citadel/field_loop2.wav")
        self.SoundLoop:SetSoundLevel(80)

        self:ActivateShield()
    end
end

if SERVER then

    function ENT:ActivateShield()
        self.SoundLoop:PlayEx(0.32, 64)
        self:EmitSound("ambient/machines/thumper_hit.wav", 80, 64, 0.64)
        self:EmitSound("npc/scanner/scanner_siren1.wav", 80, 88, 0.64)
        self:EmitSound("ambient/levels/citadel/pod_open1.wav", 80, 100, 0.64)

        timer.Simple(30, function()
            if !IsValid(self) then return end
            self:DeactivateShield()
            constraint.RemoveConstraints(self, "Weld")
            constraint.RemoveConstraints(self.BulletShield, "Weld")
            constraint.RemoveConstraints(self.BulletShieldSecond, "Weld")
            self:Remove()
        end)
    end

    function ENT:DeactivateShield()

        self.SoundLoop:Stop()
        self:EmitSound("ambient/levels/canals/headcrab_canister_open1.wav", 80, 120, 0.64)
        self:EmitSound("ambient/levels/citadel/pod_close1.wav", 80, 100, 0.64)

    end
    
    function ENT:OnRemove()
        self:DeactivateShield()
    end

end