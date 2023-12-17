-- Fortifications Builder Tablet by Alydus







-- If you'd like to modify this, go ahead, but please leave appropriate credit.



-- Please do not reupload this code to the workshop, as it creates a multitude of problems - however, you can download it from the workshop and install it on your server to modify.







-- Thanks for the support with the addon.







AddCSLuaFile()















SWEP.PrintName = "Fortifications Tablet"



SWEP.Slot = 1



SWEP.SlotPos = 1



SWEP.DrawAmmo = false



SWEP.DrawCrosshair = false



SWEP.HoldType = "slam"



if CLIENT then



	surface.CreateFont("Alydus.FortificationsTablet.Title", {font = "Roboto Condensed", size = 70})



	surface.CreateFont("Alydus.FortificationsTablet.Subtitle", {font = "Roboto Condensed", size = 55})



	language.Add("Undone_Fortification", "Undone Fortification")



	language.Add("Cleanup_fortifications", "Fortifications")



	language.Add("Cleaned_fortifications", "Cleaned up all fortifications")



end







if SERVER then



	CreateConVar("sbox_maxfortifications", 10)



end







if CLIENT then



	infoConvarAmount = 10



end







cleanup.Register("fortifications")







SWEP.Author = "Alydus"



SWEP.Instructions = "A utility weapon that allows the user to build fortifications."



SWEP.Contact = ""



SWEP.Purpose = ""



SWEP.Spawnable = true



SWEP.AdminOnly = false



SWEP.Category = "MVG - Engineering Gear"







SWEP.Primary.ClipSize = -1



SWEP.Primary.DefaultClip = -1



SWEP.Primary.Automatic = false



SWEP.Primary.Ammo = "none"



SWEP.Primary.Delay = 3.5







SWEP.Secondary.ClipSize = -1



SWEP.Secondary.DefaultClip = -1



SWEP.Secondary.Automatic = false



SWEP.Secondary.Ammo = "none"



SWEP.Secondary.Delay = 3.5







SWEP.HoldType = "slam"



SWEP.ViewModelFOV = 65



SWEP.ViewModelFlip = false



SWEP.ViewModel = "models/weapons/v_bugbait.mdl"



SWEP.WorldModel = "models/nirrti/tablet/tablet_sfm.mdl"





SWEP.IronSightsPos = Vector(0,0,0)



SWEP.IronSightsAng = Vector(0, 0, 0)







SWEP.Fortifications = {



	{name = "Sandbags Corner 1", model = "models/props_fortifications/sandbags_corner1.mdl"},



	{name = "Sandbags Corner 1 Tall", model = "models/props_fortifications/sandbags_corner1_tall.mdl"},



	{name = "Sandbags Corner 2", model = "models/props_fortifications/sandbags_corner2.mdl"},



	{name = "Sandbags Corner 2 Tall", model = "models/props_fortifications/sandbags_corner2_tall.mdl"},



	{name = "Sandbags Corner 3", model = "models/props_fortifications/sandbags_corner3.mdl"},



	{name = "Sandbags Line 1", model = "models/props_fortifications/sandbags_line1.mdl"},



	{name = "Sandbags Line 1 Tall", model = "models/props_fortifications/sandbags_line1_tall.mdl"},



	{name = "Sandbags Line 2", model = "models/props_fortifications/sandbags_line2.mdl"},



	{name = "Sandbags Line 2 Tall", model = "models/props_fortifications/sandbags_line2_tall.mdl"},



	{name = "Sandbags Line 3", model = "models/props_fortifications/sandbags_line2b.mdl"},



	{name = "Concrete Wall", model = "models/props_fortifications/concrete_wall001_96_reference.mdl"},



	{name = "Concrete Barrier 1", model = "models/props_c17/concrete_barrier001a.mdl"},



	{name = "Concrete Barrier 2 Small", model = "models/props_fortifications/concrete_barrier001_96_reference.mdl"},



	{name = "Concrete Barrier 2 Large", model = "models/props_fortifications/concrete_barrier001_128_reference.mdl"},



	{name = "Concrete Barrier 3", model = "models/jbarnes/props/concrete barricade.mdl"},



	{name = "Small Fence", model = "models/props_c17/fence01b.mdl"},



	{name = "Medium Fence", model = "models/props_c17/fence01a.mdl"},



	{name = "Large Fence", model = "models/props_c17/fence03a.mdl"},



	{name = "Small Anti-Climb Fence", model = "models/props_wasteland/exterior_fence002b.mdl",},



	{name = "Medium Anti-Climb Fence", model = "models/props_wasteland/exterior_fence002c.mdl"},



	{name = "Large Anti-Climb Fence", model = "models/props_wasteland/exterior_fence002d.mdl"},



	{name = "Police Barricade Single", model = "models/props_street/police_barricade.mdl"},



	{name = "Police Barricade Triple", model = "models/props_street/police_barricade2.mdl"},



	{name = "Hesco Small", model = "models/static_afghan/prop_fortification_hesco_small.mdl"},



	{name = "Hesco Tall", model = "models/iraq/ir_hesco_basket_01.mdl"},



	{name = "Hesco Tall Leaning", model = "models/iraq/ir_hesco_basket_01b.mdl"}



}











SWEP.FortificationsModelList = {}







for _, fortification in pairs(SWEP.Fortifications) do



	util.PrecacheModel(fortification["model"])



	table.insert(SWEP.FortificationsModelList, fortification["model"])



end















if CLIENT then



    util.PrecacheModel("models/nirrti/tablet/tablet_sfm.mdl")



end











if SERVER then



	hook.Add("KeyPress", "Alydus_KeyPress_HandleBuildTabletHologramFinished", function(ply, key)



		if not IsValid(ply.fortificationHologram) then return end



		if key == IN_USE and IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "alydus_fortificationbuildertablet" and ply:GetActiveWeapon().fortificationSelection and ply:GetEyeTrace().HitPos:Distance(ply:GetPos()) <= 250 then



			if not GAMEMODE.IsSandboxDerived or ply:GetCount("fortifications") < GetConVar("sbox_maxfortifications"):GetInt() then



				if (ply:GetEyeTrace().Entity and ply:GetEyeTrace().Entity:IsPlayer()) or ply:Crouching() or (IsValid(ply:GetEyeTrace().Entity) and table.HasValue(ply:GetActiveWeapon().FortificationsModelList, ply:GetEyeTrace().Entity:GetModel())) or hook.Call("Alydus.FortificationBuilderTablet.CanBuildFortification", ply) or (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "alydus_fortificationbuildertablet" and ply:GetActiveWeapon():GetNWBool("tabletBootup", false) == true) then



					ply:SendLua("surface.PlaySound(\"common/warning.wav\")")



				else



					local fortification = ents.Create("alydus_destructablefortification")



					fortification:SetAngles(Angle(0, ply:EyeAngles().y - 180, 0))



					fortification:SetPos(ply:GetEyeTrace().HitPos - ply:GetEyeTrace().HitNormal * ply.fortificationHologram:OBBMins().z)





					if alydusDestructableFortificationExtension then

						fortification:SetNWInt("fortificationHealth", GetConVar("alydus_defaultfortificationhealth"):GetInt())

					else

						fortification:SetModel(ply:GetActiveWeapon().Fortifications[ply:GetActiveWeapon().fortificationSelection]["model"])

					end



					fortification:Spawn()



					if alydusDestructableFortificationExtension then

						fortification:SetModel(ply:GetActiveWeapon().Fortifications[ply:GetActiveWeapon().fortificationSelection]["model"])

					end



					fortification.isPlayerPlacedFortification = ply



					fortification:SetMoveType(MOVETYPE_NONE)

					fortification:SetSolid(SOLID_VPHYSICS)





					if GAMEMODE.IsSandboxDerived then



						ply:AddCount("fortifications", fortification)



						ply:AddCleanup("fortifications", fortification)



					end







					fortification:EmitSound("physics/concrete/rock_impact_hard" .. math.random(1, 6) .. ".wav")





					undo.Create("Fortification")



						undo.AddEntity(fortification)



						undo.SetPlayer(ply)



					undo.Finish()



				end



			else



				if GAMEMODE.IsSandboxDerived then



					ply:LimitHit("fortifications")



				end



			end



		end



	end)



	hook.Add("PlayerSwitchWeapon", "Alydus_PlayerSwitchWeapon_FortificationBuilderTabletBootup", function(ply, oldWep, newWep)



		if newWep:GetClass() == "alydus_fortificationbuildertablet" and newWep:GetNWBool("tabletBootup", false) != true then



			newWep:SetNWBool("tabletBootup", true)



			newWep.fortificationSelection = newWep.fortificationSelection or 1



			ply:EmitSound("ambient/machines/thumper_startup1.wav")



			timer.Simple(2.5, function()



				if ply:GetNWBool("tabletBootup", false) == false and ply:HasWeapon("alydus_fortificationbuildertablet") then



					ply:EmitSound("npc/scanner/combat_scan4.wav")



					newWep:SetNWBool("tabletBootup", false)



				end



			end)



		elseif ply:HasWeapon("alydus_fortificationbuildertablet") and IsValid(oldWep) and oldWep:GetClass() == "alydus_fortificationbuildertablet" then



			ply:EmitSound("npc/roller/mine/combine_mine_deactivate1.wav")







			if ply.fortificationHologram != nil and IsValid(ply.fortificationHologram) then



				ply.fortificationHologram:Remove()



				ply.fortificationHologram = nil



			end



		end



	end)







end











function CheckAngleOfNormal(ply)



	local tr = nil



	if SERVER then



		tr = util.TraceLine( util.GetPlayerTrace( ply ) ).HitNormal



	elseif CLIENT then



		tr = util.TraceLine( util.GetPlayerTrace( LocalPlayer() ) ).HitNormal



	else



		-- IDEK LOL, doubt it



	end







	local abs_x = math.abs(tr[1])



	local abs_y = math.abs(tr[2])



	local nor_z = tr[3]







	if abs_x > 0.7 or abs_y > 0.7 or nor_z < -0.7 then



		return false



	else



		return true



	end







end







function SWEP:Think()



	if SERVER then



		ply = self.Owner



		if !ply:HasWeapon("alydus_fortificationbuildertablet") then return end



		local wep = ply:GetActiveWeapon()



		local ang = ply:GetAngles()



		local tr = ply:GetEyeTrace()







		if CheckAngleOfNormal(ply) and IsValid(ply) and ply:Alive() and ply:HasWeapon("alydus_fortificationbuildertablet") and IsValid(wep) and wep:GetClass() == "alydus_fortificationbuildertablet" and wep:GetNWBool("tabletBootup", false) == false and wep.fortificationSelection != nil then



			if not IsValid(ply.fortificationHologram) then



				ply.fortificationHologram = ents.Create("prop_physics")



				if IsValid(ply.fortificationHologram) then



					ply.fortificationHologram:SetAngles(Angle(0, ply:EyeAngles().y - 180, 0))



					ply.fortificationHologram:SetPos(tr.HitPos - tr.HitNormal * ply.fortificationHologram:OBBMins().z)



					ply.fortificationHologram:SetColor(Color(46, 204, 113, 150))



					ply.fortificationHologram:SetModel(wep.Fortifications[wep.fortificationSelection]["model"])



					ply.fortificationHologram:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)



					ply.fortificationHologram:SetRenderMode(RENDERMODE_TRANSALPHA)



					ply.fortificationHologram:Spawn()



					ply.fortificationHologram:SetNWString("alydusFortificationHologramName", wep.Fortifications[wep.fortificationSelection]["name"])



					ply.fortificationHologram:EmitSound("physics/concrete/rock_impact_hard1.wav")



				else



					ply.fortificationHologram = nil



				end



			elseif IsValid(ply.fortificationHologram) then



				if ply:Crouching() or (IsValid(tr.Entity) and table.HasValue(wep.FortificationsModelList, tr.Entity:GetModel())) then



					ply.fortificationHologram:SetColor(Color(255, 255, 255, 0))



				else



					if ply.fortificationHologram:GetModel() != wep.Fortifications[wep.fortificationSelection]["model"] then



						ply.fortificationHologram:SetModel(wep.Fortifications[wep.fortificationSelection]["model"])



						ply.fortificationHologram:SetNWString("alydusFortificationHologramName", wep.Fortifications[wep.fortificationSelection]["name"])



					end



					ply.fortificationHologram:SetPos(tr.HitPos - tr.HitNormal * ply.fortificationHologram:OBBMins().z)



					ply.fortificationHologram:SetAngles(Angle(0, ply:EyeAngles().y - 180, 0))



					if tr.HitPos:Distance(ply:GetPos()) >= 250 then



						ply.fortificationHologram:SetColor(Color(255, 255, 255, 0))



					elseif ply.fortificationHologram:GetColor().a == 0 then



						ply.fortificationHologram:SetColor(Color(46, 204, 113, 150))



					end



				end



			end



		elseif ply.fortificationHologram != nil and IsValid(ply.fortificationHologram) then



			ply.fortificationHologram:Remove()



			ply.fortificationHologram = nil



		end



	end



end







if CLIENT then



	hook.Add("PostDrawTranslucentRenderables","Alydus_PostDrawOpaqueRenderables_EntityDisplays", function()

		local ply = LocalPlayer()



		-- Selected Fortification Display

		if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "alydus_fortificationbuildertablet" and ply:Alive() and not ply:Crouching() then

			for _, v in pairs(ents.GetAll()) do

				if IsValid(v) and v:GetPos():Distance(LocalPlayer():GetPos()) <= 250 then

					if v:GetClass() == "prop_physics" and v:GetNWString("alydusFortificationHologramName", false) != false and not (ply:GetEyeTrace().Entity and (ply:GetEyeTrace().Entity:GetClass() == "prop_physics" or ply:GetEyeTrace().Entity:GetClass() == "alydus_destructablefortification")) then

						local offset = Vector(0, 0, 50)

						local ang = LocalPlayer():EyeAngles()

						local pos = v:GetPos() + offset + ang:Up()



						ang:RotateAroundAxis(ang:Forward(), 90)

						ang:RotateAroundAxis(ang:Right(), 90)



						local fade = math.abs(math.sin(CurTime() * 3))



						cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.10)

							draw.DrawText("Fortification Selection", "Alydus.FortificationsTablet.Title", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER)

							draw.DrawText(v:GetNWString("alydusFortificationHologramName", "Unknown Fortification"), "Alydus.FortificationsTablet.Subtitle", 0, 60, Color(150, 150, 150), TEXT_ALIGN_CENTER)

						cam.End3D2D()

					elseif v:GetClass() == "alydus_destructablefortification" and v:GetNWInt("fortificationHealth", false) != false then

						local offset = Vector(0, 0, 65)

						local ang = LocalPlayer():EyeAngles()

						local pos = v:GetPos() + offset + ang:Up()



						ang:RotateAroundAxis(ang:Forward(), 90)

						ang:RotateAroundAxis(ang:Right(), 90)



						local fade = math.abs(math.sin(CurTime() * 3))



						cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.10)

							draw.DrawText(math.Round(v:GetNWInt("fortificationHealth", 0)) .. " health remaining", "Alydus.FortificationsTablet.Subtitle", 0, 60, Color(255, 255, 255), TEXT_ALIGN_CENTER)

						cam.End3D2D()

					end

				end

			end

		end

	end)

end











function SWEP:PrimaryAttack()







	if SERVER then



		local ply = self:GetOwner()



		if IsValid(ply) and ply:Alive() and IsValid(ply.fortificationHologram) and self.fortificationSelection != nil and not ply:Crouching() then



			if ply:GetEyeTrace().HitPos:Distance(ply:GetPos()) >= 250 then



				ply:SendLua("surface.PlaySound(\"common/warning.wav\")")



				return



			end



			if self.Fortifications[self.fortificationSelection + 1] then



				self.fortificationSelection = self.fortificationSelection + 1



			else



				self.fortificationSelection = 1



			end



			ply.fortificationHologram:EmitSound("physics/concrete/rock_impact_hard1.wav")



		end



	end



end







function SWEP:SecondaryAttack()



	if SERVER then



		local ply = self:GetOwner()



		if IsValid(ply) and ply:Alive() and IsValid(ply.fortificationHologram) and self.fortificationSelection != nil and not ply:Crouching() then



			if ply:GetEyeTrace().HitPos:Distance(ply:GetPos()) >= 250 then



				ply:SendLua("surface.PlaySound(\"common/warning.wav\")")



				return



			end



			if self.Fortifications[self.fortificationSelection - 1] then



				self.fortificationSelection = self.fortificationSelection - 1



			else



				self.fortificationSelection = table.Count(self.Fortifications)



			end



			ply.fortificationHologram:EmitSound("physics/concrete/rock_impact_hard3.wav")



		end



	end



end







function SWEP:Reload()



	if SERVER then



		local ply = self:GetOwner()



		if not self.Owner:KeyPressed(IN_RELOAD) then



			return



		end



		if IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "alydus_fortificationbuildertablet" and ply:GetActiveWeapon().fortificationSelection then



			if ply:GetEyeTrace().Entity.isPlayerPlacedFortification == ply then



				ply:GetEyeTrace().Entity:EmitSound("physics/concrete/rock_impact_hard" .. math.random(1, 6) .. ".wav")



				ply:GetEyeTrace().Entity:Remove()



			end



		end



		return



	end



end















function SWEP:Initialize()



	self:SetHoldType("slam")







	if CLIENT then



		wrenchMat = Material("alydus/icons/wrench.png")



		nextMat = Material("alydus/icons/next.png")



		lastMat = Material("alydus/icons/last.png")







		shieldMat = Material("alydus/icons/shield.png")



		refreshMat = Material("alydus/icons/refresh.png")







		toolsMat = Material("alydus/icons/tools.png")







		useBind = input.LookupBinding("+use") or "E"



		reloadBind = input.LookupBinding("+reload") or "R"



		if !IsValid(tabletWeapon) then



            tabletWeapon = ClientsideModel("models/nirrti/tablet/tablet_sfm.mdl")



            tabletWeapon:SetNoDraw( true )



        end



	end



end











function SWEP:PostDrawViewModel(vm, wep, ply)



	vm:SetMaterial("Models/effects/vol_light001")



	if IsValid(vm) and CLIENT and IsValid(tabletWeapon) then







		local boneid = vm:LookupBone( "ValveBiped.Bip01_R_Hand" )







        if not boneid then return end







        local matrix = vm:GetBoneMatrix( boneid )







        if not matrix then return end















        local newpos, newang = LocalToWorld( Vector( 0, -5, 3 ), Angle(55, 94, 271), matrix:GetTranslation(), matrix:GetAngles() )







        tabletWeapon:SetPos( newpos )



        tabletWeapon:SetAngles( newang )



        tabletWeapon:SetupBones()



        tabletWeapon:DrawModel()







		--newang:RotateAroundAxis(newang:Right(), -90)







		cam.Start3D2D(newpos + newang:Up() * 3 + newang:Right() * -2 + newang:Forward() * -1, Angle(0, ply:EyeAngles().y, newang.z) + Angle(182, 90, 160), 0.01)



			surface.SetDrawColor(255, 255, 255, 255)



			if self:GetNWBool("tabletBootup", false) == false then



				draw.SimpleText("Fortification Builder", "Alydus.FortificationsTablet.Title", 15, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)







				surface.SetMaterial(nextMat)



				surface.DrawTexturedRect(230, 42, 40, 40)



				surface.SetMaterial(lastMat)



				surface.DrawTexturedRect(-235, 38, 40, 40)







				draw.SimpleText("LMB: Last | RMB: Next", "Alydus.FortificationsTablet.Subtitle", 15, 60, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)







				surface.SetMaterial(wrenchMat)



				surface.DrawTexturedRect(-215, 98, 40, 40)







				draw.SimpleText("    [" .. string.upper(useBind) .. "]: Build | [" .. string.upper(reloadBind) .. "]: Remove", "Alydus.FortificationsTablet.Subtitle", 15, 120, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)











				surface.SetMaterial(shieldMat)



				surface.DrawTexturedRect(-237, 160, 40, 40)







				draw.SimpleText("      " ..(infoConvarAmount-ply:GetCount("fortifications")) .. " Fortifications Available", "Alydus.FortificationsTablet.Subtitle", 15, 180, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)



			else



				draw.SimpleText("Fortification Builder", "Alydus.FortificationsTablet.Title", 15, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)



				surface.SetMaterial(refreshMat)



				surface.DrawTexturedRect(-130, 70, 40, 40)







				draw.SimpleText("    Booting up...", "Alydus.FortificationsTablet.Subtitle", 15, 90, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)



			end



		cam.End3D2D()



	end







end











function SWEP:DrawWorldModel()



	local _Owner = self:GetOwner()







	if (IsValid(_Owner)) then



		-- Specify a good position



		local offsetVec = Vector(5, -2.7, -3.4)



		local offsetAng = Angle(180, 90, 0)







		local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand



		if !boneid then return end







		local matrix = _Owner:GetBoneMatrix(boneid)



		if !matrix then return end







		local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())







		tabletWeapon:SetPos(newPos)



		tabletWeapon:SetAngles(newAng)







		tabletWeapon:SetupBones()



	else



		tabletWeapon:SetPos(self:GetPos())



		tabletWeapon:SetAngles(self:GetAngles())



	end







	tabletWeapon:DrawModel()



end













function SWEP:Holster(wep)
	if SERVER then
		return true
	end

	if IsValid(wep) and wep.Owner == LocalPlayer() and IsValid(self) then

		LocalPlayer():GetViewModel():SetMaterial("")

	end

	return true



end







function SWEP:OnRemove()



	self:Holster()



end
