--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_pistol.lua
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
	killicon.AddFont("wep_jack_hmcd_pistol", "HL2MPTypeDeath", "1", Color(255, 0, 0))
end

SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Beretta PX4-Storm SubCompact"
SWEP.Instructions = "This is your trusty 9x19mm pistol. Use it as you see fit.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 14
SWEP.ENT = "ent_jack_hmcd_pistol"
--CustomColor=Color(50,50,50,255)
SWEP.HolsterSlot = 2
SWEP.ShellType = ""
SWEP.DeathDroppable = false
SWEP.AttBone = "slidey"
SWEP.LaserOffset = Angle(0, 1.9, 0)
SWEP.LaserReverse = true
SWEP.ViewModelFlip = true
SWEP.UseHands = true
SWEP.Category="HMCD: Union - Pistols"
SWEP.TacticalReloadAnim = "reload_charged"
SWEP.SuicidePos = Vector(-7, 4, -18)
SWEP.SuicideAng = Angle(100, -10, -90)
SWEP.SuicideTime = 7
SWEP.SuicideSuppr = Vector(0, 0, -6.5)
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
--SWEP.CloseFireSound="m9/m9_fp.wav"

SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.SuppressedFireSound = "m9/m9_suppressed_fp.wav"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .04
SWEP.CarryWeight = 1200
SWEP.FuckedWorldModel = true
SWEP.ReloadSound = ""
SWEP.MagEntity = "ent_jack_hmcd_px4mag"
SWEP.ReloadAdd = .7

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
				{"up", 90}
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 12.6,
				up = -2.1,
				right = 1.5
			},
			ang = {
				right = 280,
				up = 84,
				forward = 102
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