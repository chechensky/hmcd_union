--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_sr25.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_sr25", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_sr25_eft")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_sr25_eft"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "SR-25"
SWEP.Instructions = "This is a designated marksman rifle/semi-automatic sniper rifle firing 7.62×51mm NATO caliber. \n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 20
SWEP.ViewModel = "models/weapons/v_sr25_eft.mdl"
SWEP.WorldModel = "models/weapons/w_sr25_ins2_eft.mdl"
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.InsHands = true
SWEP.Damage = 40
SWEP.Category="HMCD: Union - Rifles"
SWEP.SprintPos = Vector(10, 5, -2)
SWEP.SprintAng = Angle(0, 90, 0)
SWEP.AimPos = Vector(-1.8, -1, 1.25)
SWEP.AltAimPos = Vector(1.95, -3, .5)
SWEP.ReloadTime = 5
SWEP.ReloadAdd = 1
SWEP.ReloadRate = .75
-- SWEP.ReloadSound="snd_jack_hmcd_boltreload.wav"
-- SWEP.CycleSound="snd_jack_hmcd_boltcycle.wav"
SWEP.AmmoType = "AR2"
SWEP.Primary.Ammo = "AR2"
SWEP.TriggerDelay = .1
-- SWEP.CycleTime=1.2

SWEP.TPIK = true

SWEP.TPIK_PosAngles = {
    ["ValveBiped.Bip01_R_Upperarm"] = Angle(10, 0, 0),
	["ValveBiped.Bip01_R_Clavicle"] = Angle(0, -10, 0),
	["ValveBiped.Bip01_L_Clavicle"] = Angle(0, 10, 0),
	["ValveBiped.Bip01_L_Upperarm"] = Angle(30, 0, 0),
	["ValveBiped.Bip01_L_Finger0"] = Angle(0,-10,0)
}

SWEP.Recoil = 0.5
SWEP.Supersonic = true
SWEP.Accuracy = .9999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_sr25"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.SightRifle = false
SWEP.SightRifle2 = false
SWEP.SightRifle3 = false
SWEP.LaserRifle = false
SWEP.SuppressedRifle = true
SWEP.AttBone = "A_LaserFlashlight"
SWEP.LaserAngle = Angle(0, 0, 0)
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "base_draw"
SWEP.DrawAnimEmpty = "base_draw_empty"
SWEP.FireAnim = "base_fire"
SWEP.IronFireAnim = "iron_fire"
SWEP.LastFireAnim = "base_fire_last"
SWEP.LastIronFireAnim = "iron_fire_last"
SWEP.ReloadAnim = "base_reload_empty"
SWEP.TacticalReloadAnim = "base_reload"
-- SWEP.ReloadAnim="awm_reload"
--SWEP.CloseFireSound="rifle_sako85/sako_fire_01.wav"
--SWEP.FarFireSound="snd_jack_hmcd_snp_far.wav"
SWEP.SuppressedFireSound = "m14/m14_suppressed_fp.wav"
SWEP.CloseFireSound = "rifle_win1892/win1892_fire_01.wav"
SWEP.FarFireSound = "m4a1/m4a1_dist.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 19
SWEP.AimTime = 6.25
SWEP.BearTime = 9
SWEP.FuckedWorldModel = true
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle2"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .07
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(3.5,-8,-4)
SWEP.HolsterAng=Angle(160,5,180)
SWEP.CarryWeight = 5000
SWEP.ShellEffect = "eff_jack_hmcd_76251"
SWEP.ShellAttachment = 3
SWEP.MagEntity = "ent_jack_hmcd_sr25mag"

SWEP.MuzzlePos = {25.5, -5.1, -0.1}

SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.ScopeDotPosition = Vector(0,0,0)

SWEP.ViewModel_Laser = "muzzle"

SWEP.ReloadSounds = {
	{"weapons/tfa_ins2_sr25_eft/m14_magout.wav", .7, "Both"},
	{"weapons/tfa_ins2_sr25_eft/m14_magin.wav", 3.2, "Both"},
	{"weapons/tfa_ins2_sr25_eft/m16_hit.wav", 3.7, "Both"},
	{"weapons/tfa_ins2_sr25_eft/m14_boltrelease.wav", 4.9, "EmptyOnly"}
}

SWEP.BulletDir = {400, 2.5, -1.5}

SWEP.SuicidePos = Vector(4, 11, -32.5)
SWEP.SuicideAng = Angle(110, 2, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"
SWEP.SuicideSuppr = Vector(3, 2, -6.5)
SWEP.MultipleRIS = true

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(30, 1, -2)
}

if CLIENT then
	function SWEP:AdjustMouseSensitivity()
		if self:GetNWBool("Scope1", false) and self.AimPerc > 55 then
			return 0.3
		end
	end
end

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "A_Suppressor",
			pos = {
				right = 19,
				forward = -2.5,
				up = -3.75
			},
			ang = {
				up = 93,
				forward = 30
			},
			model = "models/weapons/upgrades/w_sr25_silencer.mdl",
			num = HMCD_RIFLESUPP
		},
		["Laser"] = {
			bone = "A_LaserFlashlight",
			pos = {
				right = 0,
				forward = 4,
				up = 0.5
			},
			ang = {
				forward = 90,
				up = 180
			},
			scale = .7,
			model = "models/cw2/attachments/anpeq15.mdl",
			num = HMCD_LASERBIG
		},
		["Sight"] = {
			bone = "A_Optic",
			pos = {
				right = -0.65,
				forward = 0,
				up = 0
			},
			ang = {
				up = 90,
				right = 90
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				right = 0.3,
				forward = 0,
				up = 20
			},
			sightang = {
				up = -90,
				forward = 180,
				right = 90
			},
			aimpos = Vector(-1.8, -3, .5),
			num = HMCD_KOBRA
		},
		["Sight2"] = {
			bone = "A_Optic",
			pos = {
				right = -0.5,
				forward = 0,
				up = 0
			},
			ang = {
				up = 90,
				right = 90
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				right = 0.5,
				forward = 0,
				up = 20
			},
			sightang = {
				up = -90,
				forward = 180,
				right = 90
			},
			aimpos = Vector(-1.8, -3, .275),
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "A_Optic",
			pos = {
				right = -0.65,
				forward = 0,
				up = 0
			},
			ang = {
				up = 90,
				right = 90
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				right = 0.4,
				forward = 0,
				up = 20
			},
			sightang = {
				up = -90,
				forward = 180,
				right = 90
			},
			aimpos = Vector(-1.8, -3, .425),
			num = HMCD_EOTECH
		},
		["TSRS02"] = {
			bone = "A_Optic",
			pos = {
				right = -0.65,
				forward = 0,
				up = 0
			},
			ang = {
				up = 90,
				right = 90
			},
			scale = .7,
			model = "models/weapons/arc9/darsu_eft/mods/scope_all_trijicon_srs_02.mdl",
			sightpos = {
				right = 0.4,
				forward = 0,
				up = 20
			},
			sightang = {
				up = -90,
				forward = 180,
				right = 90
			},
			aimpos = Vector(-1.8, -3, .425),
			thermal = true,
			num = 9
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1.25,
				up = -1,
				forward = 5
			},
			ang = {
				forward = 180
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 6,
				up = -8.5,
				right = 0
			},
			ang = {
				up = 5,
				forward = 20
			},
			model = "models/weapons/upgrades/w_sr25_silencer.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 22.5,
				up = -4.6,
				right = 0.25
			},
			ang = {
				forward = -90,
				up = 180
			},
			scale = .7,
			model = "models/cw2/attachments/anpeq15.mdl"
		},
		["Sight"] = {
			pos = {
				forward = 7.8,
				up = -5.8,
				right = 1
			},
			ang = {
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
		},
		["Sight2"] = {
			pos = {
				forward = 7.8,
				up = -6,
				right = 1.3
			},
			ang = {
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
		},
		["Sight3"] = {
			pos = {
				forward = 7.8,
				up = -6,
				right = 1.1
			},
			ang = {
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		},
		["Romeo8T"] = {
			pos = {
				forward = 7.8,
				up = -6,
				right = 1.56
			},
			ang = {
				forward = 180
			},
			model = "models/weapons/arc9/darsu_eft/mods/scope_all_sig_romeo_8t.mdl"
		},
		["Scope1"] = {
			pos = {
				forward = 7.8,
				up = -6,
				right = 1.1
			},
			ang = {
				forward = 180
			},
			model = "models/weapons/arc9/darsu_eft/mods/scope_nightforce_atacr.mdl"
		}
	}
}