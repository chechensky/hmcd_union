--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_smallpistol.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
AddCSLuaFile()
SWEP.Spawnable = true
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Beretta PX4-Storm SubCompact"
SWEP.Instructions = "This is your trusty 9x19mm concealed-carry pistol with a lightweight low-capacity magazine. Use it to defend the lives of the innocent.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
--SWEP.CustomColor=Color(50,50,50,255)
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.CloseFireSound="m9/m9_fp.wav"
SWEP.ViewModel = "models/weapons/gleb/c_px4.mdl"
SWEP.WorldModel = "models/weapons/w_pist_px4.mdl"
SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.SuppressedFireSound = "m9/m9_suppressed_fp.wav"
SWEP.TacticalReloadAnim = "reload_charged"
SWEP.AttBone = "slidey"
SWEP.LaserOffset = Angle(0, 1.9, 0)
SWEP.LaserAngle = Angle(0, -93.8, 90)
SWEP.LaserReverse = true
SWEP.ENT = "ent_jack_hmcd_smallpistol"
SWEP.ShellType = ""
SWEP.Category="HMCD: Union - Pistols"
SWEP.CarryWeight = 1100
SWEP.HipFireInaccuracy = .04
SWEP.FuckedWorldModel = true
SWEP.UseHands = true
SWEP.AmmoType="Pistol"
SWEP.ReloadSound = ""
SWEP.MagEntity = "ent_jack_hmcd_px4mag"
SWEP.HolsterSlot=2
SWEP.World_MuzzleAttachmentName="muzzle_flash"
SWEP.DangerLevel = 70

SWEP.TPIK = true

SWEP.TPIK_PosAngles = {
    ["ValveBiped.Bip01_R_Forearm"] = Angle(5, -5, 0),
	["ValveBiped.Bip01_L_Forearm"] = Angle(0, 0, 0),
	["ValveBiped.Bip01_R_Hand"] = Angle(-5, 0, 0)
}

SWEP.ReloadSounds = {
	{"weapons/ins2/p80/m9_magout.wav", 0.7, "EmptyOnly"},
	{"weapons/ins2/p80/m9_magin.wav", 1.8, "EmptyOnly"},
	{"weapons/ins2/p80/m9_maghit.wav", 2.3, "EmptyOnly"},
	{"weapons/ins2/p80/m9_boltrelease.wav", 2.85, "EmptyOnly"},
	{"weapons/ins2/p80/m9_magout.wav", 0.6, "FullOnly"},
	{"weapons/ins2/p80/m9_magin.wav", 1.8, "FullOnly"},
	{"weapons/ins2/p80/m9_maghit.wav", 2.2, "FullOnly"}
}

SWEP.DeployVolume = 60

SWEP.BulletDir = {400, -2.25, 1.5}

SWEP.SuicidePos = Vector(-7, 4, -18)
SWEP.SuicideAng = Angle(100, -10, -90)
SWEP.SuicideSuppr = Vector(0, 0, -6.5)

SWEP.MuzzleInfo = {
	["Bone"] = "slidey",
	["Offset"] = Vector(0, -30, -3),
	["reverseangle"] = true
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "slidey",
			pos = {
				up = -3.075,
				forward = -1.2,
				right = -19.4
			},
			reverseangle = true,
			ang = {
				up = 3,
				forward = -4,
				right = 60
			},
			scale = .7,
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			num = HMCD_PISTOLSUPP
		},
		["Laser"] = {
			bone = "slidey",
			pos = {
				up = -3.3,
				forward = -1.9,
				right = -16
			},
			reverseangle = true,
			ang = {
				up = 90,
				right = -4
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl",
			num = HMCD_LASERSMALL
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = 1,
				forward = 0.5
			},
			ang = {
				{"forward", 180},
				{"right", 10},
				{"up", 0}
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 13.3,
				up = -4.1,
				right = 1.6
			},
			ang = {
				right = 270,
				up = 90,
				forward = 100
			},
			scale = .9,
			model = "models/cw2/attachments/9mmsuppressor.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 8.4,
				up = -2.1,
				right = 1.6
			},
			ang = {
				right = 180,
				up = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
		}
	}
}