AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local function ToggleRelay()
	net.Start("RDV.COMMUNICATIONS.RelayToggled")
	
		if RDV.COMMUNICATIONS.RelayEnabled then
			net.WriteUInt(0, 1)
		else
			net.WriteUInt(1, 1)
		end

	net.Broadcast()

	RDV.COMMUNICATIONS.RelayEnabled = !RDV.COMMUNICATIONS.RelayEnabled
end

function ENT:Initialize()
    self:SetModel(RDV.LIBRARY.GetConfigOption("COMMS_conModel"))
    self:SetUseType(SIMPLE_USE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)

    if RDV.LIBRARY.GetConfigOption("COMMS_conHealthEn") then
        local HP = RDV.LIBRARY.GetConfigOption("COMMS_conHealth")

        self:SetHealth(HP)
        self:SetMaxHealth(HP)
    end

    self.SoundDelay = 0

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

local function SendNotification(ply, msg)
    local COL = RDV.LIBRARY.GetConfigOption("COMMS_prefixColor")
    local PRE = RDV.LIBRARY.GetConfigOption("COMMS_prefix")
	
    RDV.LIBRARY.AddText(ply, COL, "["..PRE.."] ", Color(255,255,255), msg)
end

function ENT:Use(activator)
    if RDV.LIBRARY.GetConfigOption("COMMS_conHealthEn") and self:Health() <= 0 then
        SendNotification(activator, RDV.LIBRARY.GetLang(nil, "COMMS_commsRelayDamaged"))
        return
    end

    ToggleRelay()
end

function ENT:OnTakeDamage(dmginfo)
    if !RDV or !RDV.COMMUNICATIONS then return end

    if self:Health() <= 0 then
        return
    end

    local NH = math.Clamp( ( self:Health() - dmginfo:GetDamage() ), 0, self:GetMaxHealth() )

    self:SetHealth(NH)

    if NH <= 0 then
        if RDV.COMMUNICATIONS.RelayEnabled then
            ToggleRelay()
        end
    end
end

function ENT:Think()
    if !RDV or !RDV.COMMUNICATIONS then return end

    if !RDV.COMMUNICATIONS.RelayEnabled then
        if RDV.LIBRARY.GetConfigOption("COMMS_conHealthEn") and self:Health() <= 0 then
            self:Ignite(1, 30)
        else
            self:Extinguish()
        end

        return
    end

    if RDV.LIBRARY.GetConfigOption("COMMS_conSounds") then
        if self.SoundDelay and self.SoundDelay > CurTime() then
            return
        end

        local SOUNDS = {        
            "rdv/communications/sw_rc_ambradio_01.ogg",
            "rdv/communications/sw_rc_ambradio_02.ogg",
            "rdv/communications/sw_rc_ambradio_03.ogg",
            "rdv/communications/sw_rc_ambradio_04.ogg",
            "rdv/communications/sw_rc_ambradio_05.ogg"
        }

        if !SOUNDS then
            return
        end

        local LEN = #SOUNDS

        local PLAY = SOUNDS[math.random(1, LEN)]

        self:EmitSound(PLAY)

        self.SoundDelay = CurTime() + math.random(10, 17)
    end
end