if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/inventory/weapon_nam_akm")
end

SWEP.IconTexture = "vgui/inventory/weapon_nam_akm"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "AKM"
SWEP.Instructions = "This is a wooden/steel 7.62×39mm selective fire 30-round-capacity rifle, one of the most popular assault rifles in the world.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 31
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/btk/v_nam_akm.mdl"
SWEP.WorldModel = "models/pwb/weapons/w_akm.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 30
SWEP.Category="HMCD: Union - Rifles"
SWEP.Primary.Automatic = true
SWEP.ViewModelFOV = 80
SWEP.SprintPos = Vector(10, 0, -3)
SWEP.SprintAng = Angle(-20, 40, -50)
SWEP.AimPos = Vector(-1.63, -5, 0.475)
SWEP.AimAng = Angle(1.3, 0, 0)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.63, -4, 0.4)
SWEP.ReloadTime = 5
SWEP.ReloadRate = .6
SWEP.UseHands = true
SWEP.ReloadSound = ""
SWEP.AmmoType = "AR2"
SWEP.Primary.Ammo = "AR2"
SWEP.TriggerDelay = .1
SWEP.CycleTime = 0.035

SWEP.TPIK = false

SWEP.TPIK_PosAngles = {
    ["ValveBiped.Bip01_R_Upperarm"] = Angle(-5, 0, 0),
	["ValveBiped.Bip01_L_Upperarm"] = Angle(30, 0, 0),
	["ValveBiped.Bip01_L_Finger1"] = Angle(-60, 0, 0),
}

SWEP.TPIK_PosVectors = {
	["ValveBiped.Bip01_Spine2"] = Vector(3,0,0)
}

SWEP.ShootWait_Ragdoll = 0.2

SWEP.Recoil = .5
SWEP.AttBone = "Weapon"
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_akm"
SWEP.FuckedWorldModel = false
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "huy_draw"
SWEP.FireAnim = "base_fire"
SWEP.IronFireAnim = "iron_fire" .. math.random(1, 4) .. ""
SWEP.ReloadAnim = "base_reloadempty"
SWEP.TacticalReloadAnim = "base_reload"
--SWEP.TacticalReloadAnim="base_reload"
SWEP.CloseFireSound = "rifle_win1892/win1892_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_ar_far.wav"
SWEP.LaserAngle = Angle(270, 0, 0)

-- lasers

SWEP.LaserPos_Right = 0
SWEP.LaserPos_Forward = 0
SWEP.LaserPos_Up = 0
SWEP.LaserPos_RightCorrect = 0

--SWEP.CloseFireSound="ak74/ak74_fp.wav"
SWEP.FarFireSound = "ak74/ak74_dist.wav"
SWEP.SuppressedFireSound = "ak74/ak74_suppressed_fp.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 1
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle2"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(3,-7,-4)
SWEP.HolsterAng=Angle(160,10,180)
SWEP.CarryWeight = 4500
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.NextFireTime = 0
SWEP.ShellEffect = "eff_jack_hmcd_76239"
SWEP.ShellAttachment = 3
SWEP.MagEntity = "ent_jack_hmcd_akmmag"
SWEP.MagDelay = 1.9

SWEP.MuzzlePos = {30, -5.1, -3.1}

SWEP.InsHands = true
SWEP.ReloadAdd = 2

SWEP.ReloadSounds = {
	{"weapons/ak74/handling/ak74_magout.wav", 1.2, "Both"},
	{"weapons/ak74/handling/ak74_magin.wav", 3.6, "Both"},
	{"weapons/ak74/handling/ak74_boltback.wav", 5.5, "EmptyOnly"},
	{"weapons/ak74/handling/ak74_boltrelease.wav", 5.85, "EmptyOnly"}
}

SWEP.BulletDir = {400, 1.6, -10}

SWEP.SuicidePos = Vector(4, 7, -32)
SWEP.SuicideAng = Angle(100, 0, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"
SWEP.ProreloadMul = .5

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(30, 2, -2)
}
SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "Weapon",
			pos = {
				up = 0.5,
				forward = 0,
				right = 17.1
			},
			ang = {
				up = -90
			},
			scale = .7,
			model = "models/weapons/upgrades/a_suppressor_ak.mdl",
			num = HMCD_PBS
		},
		["Sight"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0,
				up = 2.75
			},
			ang = {
				up = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				up = 3.6,
				forward = 0;
				right = 15.6
			},
			sightang = {
				up = -90,
				right = 180
			},
			aimpos = Vector(-1.63, -4, -1.15),
			num = HMCD_KOBRA
		},
		["Sight2"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0,
				up = 2.75
			},
			ang = {
				up = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				up = 3.6,
				forward = 0;
				right = 15.6
			},
			sightang = {
				up = 90,
				right = 180
			},
			aimpos = Vector(-1.63, -4, -1.23),
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0,
				up = 2.75
			},
			ang = {
				up = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				up = 3.6,
				forward = 0;
				right = 15.6
			},
			sightang = {
				up = 90,
				right = 180
			},
			aimpos = Vector(-1.63, -4, -1.23),
			num = HMCD_EOTECH
		},
		["Rail"] = {
			bone = "Weapon",
			pos = {
				right = -2.5,
				forward = -0.25,
				up = 1
			},
			model = "models/wystan/attachments/akrailmount.mdl",
			material = "models/wystan/attachments/akrail/newscope"
		},
		["Laser"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = -0.1,
				up = 2.7
			},
			ang = {
				up = 90
			},
			model = "models/cw2/attachments/anpeq15.mdl",
			scale = .5,
			aimpos = Vector(-1.63, -4, -1.15),
			num = HMCD_LASERBIG
		},
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				forward = 4,
				up = 0
			},
			ang = {
				forward = 180,
				right = 10
			}
		},
		["Suppressor"] = {
			pos = {
				right = 1,
				forward = 30,
				up = -7.55
			},
			ang = {
				right = 170,
				up = 180,
				forward = 270
			},
			scale = .9,
			model = "models/weapons/upgrades/a_suppressor_ak.mdl"
		},
		["Rail"] = {
			pos = {
				forward = 7,
				up = -4.55,
				right = 0.8
			},
			ang = {
				right = -10,
				up = -90,
				forward = 180
			},
			model = "models/wystan/attachments/akrailmount.mdl",
			material = "models/wystan/attachments/akrail/newscope"
		},
		["Sight"] = {
			pos = {
				forward = 7.5,
				up = -6.35,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
		},
		["Sight2"] = {
			pos = {
				forward = 7.5,
				up = -6.5,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
		},
		["Sight3"] = {
			pos = {
				forward = 7.5,
				up = -6.5,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 7.75,
				up = -6.3,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180,
				up = 180
			},
			scale = .7,
			model = "models/cw2/attachments/anpeq15.mdl"
		}
	}
}