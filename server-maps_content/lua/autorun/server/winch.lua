--[[--------------------------
   Internal Configurations
----------------------------]]

local LG_Crane_Debug     = true					-- Activate debugger (true / false)
local LG_EntityName_1    = "train_char_grue1"	-- Entity 1
local LG_EntityName_2    = "phys_magnet_grue1"	-- Entity 2
local LG_EntityName_3    = "grutier_grue1"		-- Player
local LG_Key_Forward     = KEY_PAD_5			-- Key UP
local LG_Key_Backwards   = KEY_PAD_8			-- Key Down
local LG_Speed_Forward   = 100					-- Speed UP
local LG_Speed_Backwards = 100					-- Speed Down
local LG_Crane_Material  = "cable/cable"		-- Material
local LG_Crane_Width     = 2					-- Thickness Material
local LG_Controller_Min  = 8					-- Height rope min
local LG_Controller_Max  = 1536					-- Height rope max
local LG_Sound_VolStop   = 85					-- Volume stop engine (0 - 100)
local LG_Sound_Engine    = "vehicles/crane/crane_magnet_grab_loop.wav"	-- Sound rope engine ON
local LG_Sound_Stop      = "vehicles/crane/crane_magnet_release.wav"	-- Sound rope engine OFF

--[[--------------------------
     Internal Variables
----------------------------]]

local LG_Crane_Const = LG_Crane_Const or false
local LG_Crane_Rope  = LG_Crane_Rope  or false
local LG_Crane_Ctrl1 = LG_Crane_Ctrl1 or false
local LG_Crane_Ctrl2 = LG_Crane_Ctrl2 or {}
local LG_Entity_1, LG_Entity_2 = ents.FindByName(tostring(LG_EntityName_1))[1], ents.FindByName(tostring(LG_EntityName_2))[1]

--[[--------------------------
      Internal Functions
----------------------------]]

local function LG_WinchOn(pl, winch, dir)
	if not IsValid(winch) then return false end
	winch:SetDirection(dir)
	LG_Crane_Ctrl1.Sound_Engine:Play()
end
numpad.Register("LGCrane_WinchOn", LG_WinchOn)

local function LG_WinchOff(pl, winch)
	if not IsValid(winch) then return false end
	winch:SetDirection(0)
	LG_Crane_Ctrl1.Sound_Engine:Stop()
	LG_Crane_Ctrl1:EmitSound(tostring(LG_Sound_Stop), tonumber(LG_Sound_VolStop), 100, 1, CHAN_AUTO)
end
numpad.Register("LGCrane_WinchOff", LG_WinchOff)

local function LG_WinchToggle(pl, winch, dir)
	if not IsValid(winch) then return false end
	if winch:GetDirection() == dir then
		winch:SetDirection(0)
		LG_Crane_Ctrl1.Sound_Engine:Stop()
		LG_Crane_Ctrl1:EmitSound(tostring(LG_Sound_Stop), tonumber(LG_Sound_VolStop), 100, 1, CHAN_AUTO)
	else
		winch:SetDirection(dir)
		LG_Crane_Ctrl1.Sound_Engine:Play()
	end
end
numpad.Register("LGCrane_WinchToggle", LG_WinchToggle)

local function GMOD_CalcElasticConsts(Phys1, Phys2, Ent1, Ent2, iFixed)
	local minMass = 0

	if Ent1:IsWorld() then minMass = Phys2:GetMass()
	elseif Ent2:IsWorld() then minMass = Phys1:GetMass()
	else minMass = math.min(Phys1:GetMass(), Phys2:GetMass()) end

	local const = minMass * 100
	local damp  = const * 0.2

	if iFixed == 0 then
		const = minMass * 50
		damp  = const * 0.1
	end

	return const, damp
end

local function LG_Rope(Ent1, Ent2, Bone1, Bone2, LPos1, LPos2, width, material)
	if not constraint.CanConstrain(Ent1, Bone1) then return false end
	if not constraint.CanConstrain(Ent2, Bone2) then return false end

	local Phys1, Phys2 = Ent1:GetPhysicsObjectNum(Bone1), Ent2:GetPhysicsObjectNum(Bone2)
	local WPos1, WPos2 = Phys1:LocalToWorld(LPos1), Phys2:LocalToWorld(LPos2)

	if Phys1 == Phys2 then return false end

	local const, dampen    = GMOD_CalcElasticConsts(Phys1, Phys2, Ent1, Ent2, false)
	local Constraint, rope = constraint.Elastic(Ent1, Ent2, Bone1, Bone2, LPos1, LPos2, const, dampen, 0, material, width, true)

	if not Constraint then return nil, rope end

	local ctable = {
		Ent1     = Ent1,
		Ent2     = Ent2,
		Bone1    = Bone1,
		Bone2    = Bone2,
		LPos1    = LPos1,
		LPos2    = LPos2,
		width    = width,
		material = material
	}
	Constraint:SetTable(ctable)

	return Constraint, rope
end

local function LG_Controller(ply, ent1, ent2, const, rope, fwd_bind, bwd_bind, fwd_speed, bwd_speed, toggle)
	local ConstTable     = const:GetTable()
	ConstTable.pl        = ply
	ConstTable.fwd_bind  = fwd_bind
	ConstTable.bwd_bind  = bwd_bind
	ConstTable.fwd_speed = fwd_speed
	ConstTable.bwd_speed = bwd_speed
	const:SetTable(ConstTable)

	local controller = ents.Create("gmod_winch_controller")
	controller:GetTable():SetConstraint(const)
	controller:GetTable():SetRope(rope)
	controller:Spawn()

	const:DeleteOnRemove(controller)
	ent1:DeleteOnRemove(controller)
	ent2:DeleteOnRemove(controller)

	local NumPadPlayer = {}

	if toggle then
		NumPadPlayer["NumPad1"] = numpad.OnDown(ply, fwd_bind, "LGCrane_WinchToggle", controller, 1)
		NumPadPlayer["NumPad2"] = numpad.OnDown(ply, bwd_bind, "LGCrane_WinchToggle", controller, -1)
	else
		NumPadPlayer["NumPad1"] = numpad.OnDown(ply, fwd_bind, "LGCrane_WinchOn", controller, 1)
		NumPadPlayer["NumPad2"] = numpad.OnUp(ply, fwd_bind, "LGCrane_WinchOff", controller)
		NumPadPlayer["NumPad3"] = numpad.OnDown(ply, bwd_bind, "LGCrane_WinchOn", controller, -1)
		NumPadPlayer["NumPad4"] = numpad.OnUp(ply, bwd_bind, "LGCrane_WinchOff", controller)
	end

	LG_Crane_Ctrl2 = NumPadPlayer

	return controller
end

hook.Add("EntityRemoved", "LGCrane_EntityRemoved", function(ent)
	if ent == LG_Crane_Ctrl1 then
		LG_Crane_Ctrl1.Sound_Engine:Stop()
		LG_Crane_Ctrl1:EmitSound(tostring(LG_Sound_Stop), tonumber(LG_Sound_VolStop), 100, 1, CHAN_AUTO)
	end
end)

--[[--------------------------
      Commander System
----------------------------]]

-- Rope
if not LG_Crane_Const and not LG_Crane_Rope then
	LG_Crane_Const, LG_Crane_Rope = LG_Rope(LG_Entity_1, LG_Entity_2, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), tonumber(LG_Crane_Width), tostring(LG_Crane_Material))
end

function LG_Crane_Allow()
	if LG_Crane_Debug then print("CRANE START") end
	local ply = ents.FindByName(tostring(LG_EntityName_3))[1]

	if IsValid(ply) and ply:IsPlayer() then
		if IsValid(LG_Entity_1) and IsValid(LG_Entity_2) then
			if not IsValid(LG_Crane_Ctrl1) then
				if LG_Crane_Debug then print("CRANE CONTROLLER ALLOWED") end
				LG_Crane_Ctrl1 = LG_Controller(ply, LG_Entity_1, LG_Entity_2, LG_Crane_Const, LG_Crane_Rope, LG_Key_Forward, LG_Key_Backwards, tonumber(LG_Speed_Forward), tonumber(LG_Speed_Backwards), false)
				LG_Crane_Ctrl1.min_length   = tonumber(LG_Controller_Min)
				LG_Crane_Ctrl1.max_length   = tonumber(LG_Controller_Max)
				LG_Crane_Ctrl1.Sound_Engine = CreateSound(LG_Crane_Ctrl1, tostring(LG_Sound_Engine))
				LG_Crane_Ctrl1.Sound_Engine:ChangeVolume(1)
				LG_Crane_Ctrl1.Sound_Engine:SetSoundLevel(85)
			end
		end
	end
end

function LG_Crane_Stop()
	if LG_Crane_Debug then print("CRANE STOP") end
	for k, v in pairs(LG_Crane_Ctrl2) do
		numpad.Remove(tonumber(v))
		LG_Crane_Ctrl2[k] = nil
	end

	if IsValid(LG_Crane_Ctrl1) then
		if LG_Crane_Debug then print("CRANE CONTROLLER REMOVED") end
		LG_Crane_Ctrl1.Sound_Engine:Stop()
		LG_Crane_Ctrl1:EmitSound(tostring(LG_Sound_Stop), tonumber(LG_Sound_VolStop), 100, 1, CHAN_AUTO)
		LG_Crane_Ctrl1:Remove()
		LG_Crane_Ctrl1 = false
	end
end