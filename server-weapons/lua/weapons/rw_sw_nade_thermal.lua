SWEP.Base					= "tfa_ins2_nade_base"
SWEP.Category				= "TFA StarWars Reworked Explosif"
SWEP.Author					= "Gorka(Strasser) & ChanceSphere574"
SWEP.Type					= "Explode"
SWEP.PrintName				= "Thermal Grenade"
SWEP.Slot					= 5
SWEP.SlotPos				= 100
SWEP.DrawAmmo				= true
SWEP.DrawWeaponInfoBox		= false
SWEP.BounceWeaponIcon		= false
SWEP.DrawCrosshair			= false
SWEP.Weight					= 2
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType				= "grenade"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_ins2/v_f1.mdl"
SWEP.WorldModel				= "models/weapons/tfa_ins2/w_f1.mdl"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				=true
SWEP.UseHands				=true
SWEP.AdminSpawnable			=true


-- SET DAMAGE IN THE ENTITY ONE, rw_sw_ent_nade_damage, last parameter of util.BlastDamage
SWEP.Primary.Damage			=350
SWEP.Primary.RPM			=10
SWEP.Primary.ClipSize		=1
SWEP.Primary.DefaultClip	=1
SWEP.Primary.Automatic		=false
SWEP.DisableChambering		=true
SWEP.Primary.Ammo			="grenade"
SWEP.Primary.Round			=("rw_sw_ent_nade_thermal")
SWEP.Primary.Range 					= 1250
SWEP.Velocity				=950
SWEP.Velocity_Underhand		=400
SWEP.Delay					=0.23
SWEP.DelayCooked			=0.24
SWEP.Delay_Underhand		=0.245
SWEP.CookStartDelay			=1
SWEP.UnderhandEnabled		=true
SWEP.CookingEnabled			=true
SWEP.CookTimer				=3.2
SWEP.Primary.Force = 0
SWEP.Primary.Knockback = 0

SWEP.ViewModelBoneMods={
	["Spoon_F1"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
	["Weapon_F1"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
	["Pin_Pull"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
	["Pin_2_F1"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
	["Pin_F1"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
	--["Weapon"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
	--["Spoon"]={scale=Vector(0.009,0.009,0.009),pos=Vector(0,0,0),angle=Angle(0,0,0)},
}

SWEP.VElements={
	["n"]={type="Model",model="models/weapons/tfa_starwars/w_thermal.mdl",bone="Weapon_F1",rel="",pos=Vector(-0.7,0.2,01.1),angle=Angle(0,105,0),size=Vector(0.7,0.7,0.7),color=Color(255,255,255,255),surpresslightning=false,material="",skin=0,bodygroup={}},
}

SWEP.WElements={
	["n"]={type="Model",model="models/weapons/tfa_starwars/w_thermal.mdl",bone="ValveBiped.Bip01_R_Hand",rel="",pos=Vector(03,02,0),angle=Angle(0,180,180),size=Vector(0.9,0.9,0.9),color=Color(255,255,255,255),surpresslightning=false,material="",skin=0,bodygroup={}}
}

SWEP.ProceduralHoslterEnabled	=true
SWEP.ProceduralHolsterTime		=0.0
SWEP.ProceduralHolsterPos		=Vector(0,0,0)
SWEP.ProceduralHolsterAng		=Vector(0,0,0)

SWEP.Offset={
	Pos={
		Up=0,
		Right=1,
		Forward=3,
	},
	Ang={
		Up=-1,
		Right=-2,
		Forward=178
	},
	Scale=1
}

SWEP.InspectPos				=Vector(-03,0,03)
SWEP.InspectAng				=Vector(0,0,0)


SWEP.Sprint_Mode=TFA.Enum.LOCOMOTION_ANI
SWEP.SprintAnimation={
	["loop"]={
		["type"]=TFA.Enum.ANIMATION_SEQ,
		["value"]="sprint",
		["is_idle"]=true
	}
}