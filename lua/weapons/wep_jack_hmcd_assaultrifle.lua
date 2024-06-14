if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_assaultrifle")
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_assaultrifle"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_jack_hmcd_firearm_base"
SWEP.PrintName = "AR-15"
SWEP.Instructions = "An absurdly powerful weapon, this aluminum/polymer 5.56x45mm semi-automatic home-assembled 30-round-capacity rifle is the quintessence of an armed American citizenry in the early 21st century.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 31
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/v_huy.mdl"
SWEP.WorldModel = "models/drgordon/weapons/ar-15/m4/colt_m4.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 25
SWEP.SprintPos = Vector(9, -1, -3)
SWEP.Category="HMCD: Union - Rifles"
SWEP.SprintAng = Angle(-20, 60, -40)
SWEP.AimPos = Vector(-1.902, -3.2, .13)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.902, -3.2, .13)
SWEP.ReloadTime = 3.75
SWEP.ReloadAdd = .5
SWEP.ReloadRate = .6
SWEP.ReloadSound = ""
SWEP.AmmoType = "SMG1"
SWEP.SuppressedRifle = false
SWEP.MultipleRIS = true
SWEP.TriggerDelay = .1
SWEP.CycleTime = 0
SWEP.Recoil = .5
SWEP.AttBone = "RAILS_LOW_001"
SWEP.LaserAngle = Angle(-179.65, -10, -0.7)
SWEP.Supersonic = true
SWEP.Accuracy = .99999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_assaultrifle"
SWEP.FuckedWorldModel = true
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "draw_unsil"
SWEP.FireAnim = "fire-1-unsil"
SWEP.ReloadAnim = "reload_unsil"
SWEP.World_MuzzleAttachmentName="muzzle_flash"
SWEP.TacticalReloadAnim = "reload2"
SWEP.CloseFireSound = "rifle_win1892/win1892_fire_01.wav"

-- lasers

SWEP.ViewModel_Laser = "1"
SWEP.LaserPos_Forward = 0
SWEP.LaserPos_Up = 0
SWEP.LaserPos_Right = 0
SWEP.LaserPos_RightCorrect = 0


--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_ar_far.wav"
--SWEP.CloseFireSound="m4a1/m4a1_fp.wav"
SWEP.SuppressedFireSound = "m4a1/m4a1_suppressed_fp.wav"
SWEP.FarFireSound = "m4a1/m4a1_dist.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 3
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle2"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(2,-9,-4)
SWEP.HolsterAng=Angle(160,100,180)
SWEP.CarryWeight = 4500
SWEP.ShellEffect = "eff_jack_hmcd_556"
SWEP.MagEntity = "ent_jack_hmcd_ar15mag"
SWEP.MagDelay = .7

SWEP.MuzzlePos = {25.5, -5.1, -0.1}

SWEP.ShellAttachment = 1

SWEP.ReloadSounds = {
	{"weapons/tfa_ins2/m4a1/m4a1_magout.wav", 0.7, "Both"},
	{"weapons/tfa_ins2/m4a1/m4a1_magin.wav", 2, "Both"},
	{"weapons/tfa_ins2/m4a1/m4a1_boltrelease.wav", 3, "EmptyOnly"}
}

SWEP.BulletDir = {400, 1.9, 0}

SWEP.SuicidePos = Vector(3, 6.75, -22)
SWEP.SuicideAng = Angle(110, 2, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"

SWEP.Attachables = {HMCD_RIFLESUPP, HMCD_LASERBIG, HMCD_KOBRA, HMCD_AIMPOINT, HMCD_EOTECH}

SWEP.MuzzleInfo = {
	["Bone"] = "m4_barrel",
	["Offset"] = Vector(30, 3, -1)
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "RAILS_LOW_001",
			pos = {
				right = 3.1,
				forward = 2.7,
				up = 0.1
			},
			ang = {
				up = -90,
				right = 90
			},
			model = "models/cw2/attachments/556suppressor.mdl",
			scale = .7,
			num = HMCD_RIFLESUPP
		},
		["Laser"] = {
			bone = "RAILS_LOW_001",
			pos = {
				right = 1.15,
				forward = 0.9,
				up = -0.85
			},
			ang = {
				up = 0,
				forward = 180
			},
			model = "models/cw2/attachments/anpeq15.mdl",
			scale = .65,
			num = HMCD_LASERBIG
		},
		["Sight"] = {
			bone = "RAILS_LOW_001",
			pos = {
				right = 1,
				forward = 4.5,
				up = -0.9
			},
			ang = {
				up = -180,
				forward = 180
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				right = 0.97,
				forward = -4,
				up = -1.9
			},
			sightang = {
				up = -180,
				forward = 180
			},
			num = 13
		},
		["Sight2"] = {
			bone = "RAILS_LOW_001",
			pos = {
				right = 1,
				forward = 4.5,
				up = -0.9
			},
			ang = {
				up = -180,
				forward = 180
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				right = 0.97,
				forward = -4,
				up = -1.9
			},
			sightang = {
				up = -180,
				forward = 180
			},
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "RAILS_LOW_001",
			pos = {
				right = 1,
				forward = 4.5,
				up = -0.9
			},
			ang = {
				up = -180,
				forward = 180
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				right = 0.97,
				forward = -4,
				up = -1.9
			},
			sightang = {
				up = -180,
				forward = 180
			},
			num = HMCD_EOTECH
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = -0.8,
				forward = 3
			},
			ang = {
				right = 180,
				up = 90
			},
			bodygroups = {
				[0] = 0,
				[2] = 1,
				[8] = 2
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 9.9,
				up = -7.15,
				right = 1
			},
			ang = {
				right = 270,
				up = 90,
				forward = 270
			},
			scale = .9,
			model = "models/cw2/attachments/556suppressor.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 12.9,
				up = -5.35,
				right = 1
			},
			ang = {
				right = 180
			},
			scale = .9,
			model = "models/cw2/attachments/anpeq15.mdl"
		},
		["Sight"] = {
			pos = {
				forward = 6.9,
				up = -5.35,
				right = 1
			},
			ang = {
				right = 180,
				up = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
		},
		["Sight2"] = {
			pos = {
				forward = 5.9,
				up = -5.7,
				right = 1
			},
			ang = {
				right = 180,
				up = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
		},
		["Sight3"] = {
			pos = {
				forward = 6.9,
				up = -5.7,
				right = 1
			},
			ang = {
				right = 180,
				up = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		}
	}
}