/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile()
include("sh_zpn_config_main.lua")
AddCSLuaFile("sh_zpn_config_main.lua")
TOOL.Category = "Zeros PumpkinNight"
TOOL.Name = "#PumpkinSpawner"
TOOL.Command = nil

if (CLIENT) then
	language.Add("tool.zpn_pumpkinspawner.name", "Custom Pumpkin SpawnTool")
	language.Add("tool.zpn_pumpkinspawner.desc", "LeftClick: Creates a Pumpkin Spawnpoint. \nRightClick: Removes a Pumpkin Spawnpoint.")
	language.Add("tool.zpn_pumpkinspawner.0", "LeftClick: Creates a Pumpkin Spawnpoint.")
end

function TOOL:LeftClick(trace)
	local trEnt = trace.Entity
	if trEnt:IsPlayer() then return false end
	if (CLIENT) then return end
	if zclib.Player.IsAdmin(self:GetOwner()) == false then return end

	if trEnt:IsWorld() then
		if trace.Hit and trace.HitPos and zclib.util.InDistance(trace.HitPos, self:GetOwner():GetPos(), 1000) then
			zclib.Notify(self:GetOwner(), "Pumpkin Spawn added!", 0)
			zpn.PumpkinSpawner.AddPos(trace.HitPos)
			zpn.PumpkinSpawner.ShowAll(self:GetOwner())
		end

		return true
	else
		return false
	end
end

function TOOL:RightClick(trace)
	if (trace.Entity:IsPlayer()) then return false end
	if (CLIENT) then return end
	if zclib.Player.IsAdmin(self:GetOwner()) == false then return end
	if trace.Hit and trace.HitPos then
		if zclib.util.InDistance(trace.HitPos, self:GetOwner():GetPos(), 1000) then
			zclib.Notify(self:GetOwner(), "Pumpkin Spawn removed!", 0)
			zpn.PumpkinSpawner.RemoveSpawnPos(trace.HitPos, self:GetOwner())
		end

		return true
	else
		return false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

function TOOL:Deploy()
	if SERVER and zclib.Player.IsAdmin(self:GetOwner()) then
		zpn.PumpkinSpawner.ShowAll(self:GetOwner())
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function TOOL:Holster()
	if SERVER and zclib.Player.IsAdmin(self:GetOwner()) then
		zpn.PumpkinSpawner.HideAll(self:GetOwner())
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

function TOOL.BuildCPanel(CPanel)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

	zclib.Settings.OptionPanel("Pumpkin spawns",nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
		[1] = {
			name = "Save",
			class = "DButton",
			cmd = "zpn_save_pumpkinspawns"
		},
		[2] = {
			name = "Remove",
			class = "DButton",
			cmd = "zpn_remove_pumpkinspawns"
		}
	})
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73
