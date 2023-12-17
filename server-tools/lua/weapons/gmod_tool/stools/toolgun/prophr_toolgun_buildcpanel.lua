function TOOL.BuildCPanel(CPanel)
	CPanel:SetName("PropHr Tool - v4.02 (stable) | re-designed")
	--
	local svartFarge = Color( 000, 000, 000, 255 )
	local raudFarge = Color( 255, 000, 000, 255 )
	--
	local DComboBox = vgui.Create("DComboBox", CPanel)
	DComboBox:SetPos(14, 22)
	DComboBox:SetSize(200, 20)
	DComboBox:SetSortItems(false)
	DComboBox:SetValue("Stand. blood for NPC")
	DComboBox:AddChoice("No blood", DONT_BLEED)
	DComboBox:AddChoice("Yellow blood", BLOOD_COLOR_YELLOW)
	DComboBox:AddChoice("Green-Red blood", BLOOD_COLOR_GREEN)
	DComboBox:AddChoice("Normal blood (Red)", BLOOD_COLOR_RED)
	DComboBox:AddChoice("Stand. blood for NPC", -2)
	DComboBox:AddChoice("Mech blood (Sparks)", BLOOD_COLOR_MECH)
	DComboBox:AddChoice("Antilion blood (Yellow)", BLOOD_COLOR_ANTLION)
	DComboBox:AddChoice("Zombie blood (Green-Red)", BLOOD_COLOR_ZOMBIE)
	DComboBox:AddChoice("Antlion Worker blood (Bright-Green)", BLOOD_COLOR_ANTLION_WORKER)
	DComboBox.OnSelect = function(panel, index, value)
		net.Start("prophr_bloodColor")
		net.WriteInt(panel:GetOptionData(index), 3)
		net.SendToServer()
	end
	--
	CPanel:Help("")
	CPanel:Help("NOTICE: When duplicating, try and aim at the bottom of the prop, so you do not hit the hitbox(es)... The the duplication won't work then.")
	CPanel:Help("")
	--
	local farge_velger = vgui.Create("DRGBPicker", CPanel)
	farge_velger:SetPos(2, 22)
	farge_velger:SetSize(10, 53)

	function farge_velger:OnChange(_farge)
		prophr_healthbarcolor.r = _farge.r
		prophr_healthbarcolor.g = _farge.g
		prophr_healthbarcolor.b = _farge.b
	end
	--
	--
	function leggTilDCheckBox(
		bits,
		DCheckBox,
		tekst,
		tekstFarge,
		Var
	)
		DCheckBox:SetText(tekst)
		DCheckBox:SetTextColor(tekstFarge)
		DCheckBox:SetValue(GetConVar(Var):GetInt())
		DCheckBox:SetConVar(Var)
		--
		--
		function DCheckBox:OnChange(verdi)
			local v = verdi
			if (v) then v = 1 else v = 0 end
			--
			net.Start(Var)
			net.WriteInt(v, bits)
			net.SendToServer()
		end
		CPanel:AddItem(DCheckBox)
	end
	function leggTilDNumSlider(
		bits,
		DNumSlider,
		tekst,
		tekstFarge,
		Var,
		min,
		max,
		desimaler,
		typeNet
	)
		DNumSlider:SetText(tekst)
		DNumSlider:SetMin(min)
		DNumSlider:SetMax(max)
		DNumSlider:SetDecimals(desimaler)
		--
		DNumSlider:SetValue(GetConVar(Var):GetInt())
		DNumSlider:SetConVar(Var)
		--
		--
		function DNumSlider:OnValueChanged(nummer)
			if (typeNet == 'int') then
				--
				net.Start(Var)
					net.WriteInt(nummer, bits)
				net.SendToServer()
			else
				if (typeNet == 'float') then
					--
					net.Start(Var)
						net.WriteFloat(nummer)
					net.SendToServer()
				end
			end
		end
		CPanel:AddItem(DNumSlider)
	end
	--
	--
	local ps_panel = CPanel:Add("Performance settings:")
	--
	local DCheckBox0 = vgui.Create("DCheckBoxLabel", ps_panel)
	leggTilDCheckBox(
		3,
		DCheckBox0,
		"Optimized hitbox-system (prop)",
		Color(238, 238, 0, 255),
		"prophr_optimized_hitbox_system"
	)
	CPanel:ControlHelp("If checked, the prop is only going to have one hitbox in the center; instead of five total spread out on all sides of the prop. Good for NPC's that shoot – but zombies might want to be able to claw from all sides.")
	CPanel:Help("")
	--
	local hs_panel = CPanel:Add("Health settings:")
	--
	local NumSlider0 = vgui.Create("DNumSlider", hs_panel)
	leggTilDNumSlider(
		18,
		NumSlider0,
		"Health",
		svartFarge,
		"prophr_health",
		1,
		50000,
		0,
		"int"
	)
	--
	local DCheckBox1 = vgui.Create("DCheckBoxLabel", hs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox1,
		"New health on change",
		svartFarge,
		"prophr_new_health_onchange"
	)
	CPanel:ControlHelp("The prop will get a new max-health.")
	--
	local DCheckBox2 = vgui.Create("DCheckBoxLabel", hs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox2,
		"The prop will get a new max-health.",
		svartFarge,
		"prophr_new_healthLeft_onchange"
	)
	CPanel:ControlHelp("The health that is left, will change to the new max-health also.")
	--
	local DCheckBox3 = vgui.Create("DCheckBoxLabel", hs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox3,
		"Show health bars",
		raudFarge,
		"prophr_health_bar_active"
	)
	--
	local DCheckBox4 = vgui.Create("DCheckBoxLabel", hs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox4,
		"Show 'health left",
		svartFarge,
		"prophr_health_left_text_active"
	)
	CPanel:ControlHelp("You can select one, two or none of the sub-categories above, for a uniqe HUD-combo.")
	CPanel:Help("")
	--
	local hr_panel = CPanel:Add("Health reset:")
	--
	local NumSlider1 = vgui.Create("DNumSlider", hr_panel)
	leggTilDNumSlider(
		nil,
		NumSlider1,
		"Interval (in minutes)",
		svartFarge,
		"prophr_health_reset_timer_value",
		0.1,
		120,
		1,
		"float"
	)
	local NumSlider2 = vgui.Create("DNumSlider", hr_panel)
	leggTilDNumSlider(
		16,
		NumSlider2,
		"Interval amount",
		svartFarge,
		"prophr_health_reset_timer_interval_value",
		0,
		10000,
		0,
		"int"
	)

	local DCheckBox5 = vgui.Create("DCheckBoxLabel", hr_panel)
	leggTilDCheckBox(
		3,
		DCheckBox5,
		"Enable health reset",
		svartFarge,
		"prophr_health_reset_timer_checkbox"
	)
	CPanel:ControlHelp("Reset the health every x minutes. If interval amount == 0, then it will loop infinitely. Example: 0.1 min * 60 = 6 seconds.")
	--
	--
	local cs_panel = CPanel:Add("'Connection to the hostile NPC' settings:")

	local DCheckBox6 = vgui.Create("DCheckBoxLabel", cs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox6,
		"Fear the hostile NPC(s)",
		svartFarge,
		"prophr_fear_the_hostile_npc"
	)
	local DCheckBox7 = vgui.Create("DCheckBoxLabel", cs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox7,
		"Hate the hostile NPC(s)",
		svartFarge,
		"prophr_hate_the_hostile_npc"
	)
	CPanel:ControlHelp("If both are checked, the 'Fear setting' will be added.")
	CPanel:Help("")
	--
	local scs_panel = CPanel:Add("Single-connection settings:")

	local DCheckBox8 = vgui.Create("DCheckBoxLabel", scs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox8,
		"Single-con. with class",
		Color(255, 165, 0, 255), -- oransje
		"prophr_single_connection_with_class"
	)
	CPanel:ControlHelp("Choose wether (when holding 'E') to choose the entity nr.1's class-group to be hostile agains entity nr.2.")
	CPanel:ControlHelp("*NPC's with this property attached to themself, will not attack another NPC with this attached either.")
	CPanel:Help("")
	--
	local rs_panel = CPanel:Add("Relationship settings:")
	--
	local DCheckBox9 = vgui.Create("DCheckBoxLabel", rs_panel)
	leggTilDCheckBox(
		3,
		DCheckBox9,
		"NPC's can attack the prop/NPC",
		Color(26, 29, 223, 255), --blålilla
		"prophr_hostiles_attacks"
	)
	CPanel:ControlHelp("Affects every sub-category that is checked underneath.")
	CPanel:Help("")
	--
	--
	local NumSlider3 = vgui.Create("DNumSlider", rs_panel)
	leggTilDNumSlider(
		12,
		NumSlider3,
		"NPC-relationship:",
		svartFarge,
		"prophr_relationship_amount_npc",
		1,
		1000,
		0,
		"int"
	)
	CPanel:ControlHelp("The strength of the 'NPC to PROP/NPC'-relationship. Higher is more attractive. (default is '99'). *Doesn't seem to have much affect.")
	--
	--
	local psg_panel = CPanel:Add("Pre-set groups (standard):")
	
	local DCheckBox10 = vgui.Create("DCheckBoxLabel", psg_panel)
	leggTilDCheckBox(
		3,
		DCheckBox10,
		"Combines",
		svartFarge,
		"prophr_Combines_attacks"
	)
	local DCheckBox11 = vgui.Create("DCheckBoxLabel", psg_panel)
	leggTilDCheckBox(
		3,
		DCheckBox11,
		"Humans + Resistance",
		svartFarge,
		"prophr_HumansResistance_attacks"
	)
	local DCheckBox12 = vgui.Create("DCheckBoxLabel", psg_panel)
	leggTilDCheckBox(
		3,
		DCheckBox12,
		"Zombies",
		svartFarge,
		"prophr_Zombies_attacks"
	)
	local DCheckBox13 = vgui.Create("DCheckBoxLabel", psg_panel)
	leggTilDCheckBox(
		3,
		DCheckBox13,
		"Enemy Aliens",
		svartFarge,
		"prophr_EnemyAliens_attacks"
	)
	local DCheckBox14 = vgui.Create("DCheckBoxLabel", psg_panel)
	leggTilDCheckBox(
		3,
		DCheckBox14,
		"Every NPC",
		svartFarge,
		"prophr_EveryNPC_attacks"
	)
	CPanel:ControlHelp("Select one or more groups that will attack the prop directly. 'Every NPC setting' will overide everything.")
	CPanel:Help("")
	--
	--
	local os_panel = CPanel:Add("Other settings:")
	--
	local DCheckBox15 = vgui.Create("DCheckBoxLabel", os_panel)
	leggTilDCheckBox(
		3,
		DCheckBox15,
		"Disable thinking for NPC",
		svartFarge,
		"prophr_disable_thinking"
	)
	CPanel:ControlHelp("Makes the NPC stop thinking... just weird; but if your into that .")
	CPanel:Help("")
	--
	local d_panel = CPanel:Add("Debugging:")
	--
	local DCheckBox16 = vgui.Create("DCheckBoxLabel", d_panel)
	leggTilDCheckBox(
		3,
		DCheckBox16,
		"Print out in console",
		Color(147, 223, 75, 255), --grøn
		"prophr_print_out_relationships_in_console"
	)
	CPanel:ControlHelp("Hate = Hater. Motta = Receiver. (it is Norwegian)")
	--
	CPanel:Help("")
	CPanel:Help("This tool works for most props.")
	CPanel:ControlHelp("Made by: ravo Norway")
	CPanel:Help("")
	--
	DComboBox:MoveToFront()
	farge_velger:MoveToFront()

	DCheckBox0:MoveToFront()
	DCheckBox1:MoveToFront()
	DCheckBox2:MoveToFront()
	DCheckBox3:MoveToFront()
	DCheckBox4:MoveToFront()
	DCheckBox5:MoveToFront()
	DCheckBox6:MoveToFront()
	DCheckBox7:MoveToFront()
	DCheckBox8:MoveToFront()
	DCheckBox9:MoveToFront()
	DCheckBox10:MoveToFront()
	DCheckBox11:MoveToFront()
	DCheckBox12:MoveToFront()
	DCheckBox13:MoveToFront()
	DCheckBox14:MoveToFront()
	DCheckBox15:MoveToFront()
	DCheckBox16:MoveToFront()
end