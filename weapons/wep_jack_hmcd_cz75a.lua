--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_cz75a.lua
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
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_cz75")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_cz75"
SWEP.Base = "wep_jack_hmcd_firearm_base"
SWEP.PrintName = "CZ75"
SWEP.Instructions = "This is a light weight, automatic pistol firing 9x19mm rounds. \n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 27
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/tfa_ins2/c_cz75a.mdl"
SWEP.WorldModel = "models/pwb/weapons/w_cz75.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.Damage = 20
SWEP.FuckedWorldModel = true


SWEP.Primary.Automatic = true
SWEP.SprintPos = Vector(5, 3, -17)
SWEP.SprintAng = Angle(80, 0, 0)
SWEP.AimPos = Vector(-2, -1, 0)
SWEP.AimAng = Angle(.7, 0, 0)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.ReloadTime = 4
SWEP.ReloadRate = .6
SWEP.AttBone = "Weapon"
SWEP.AmmoType = "Pistol"
SWEP.LaserOffset = Angle(-0.5, -0.1, 0)
SWEP.FireAnimRate = 2
SWEP.TriggerDelay = .05
SWEP.CycleTime = .05
SWEP.Recoil = .4
SWEP.Supersonic = true
SWEP.Accuracy = .99
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_cz75a"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.Category="HMCD: Union - Pistols"
--SWEP.CloseFireSound="smg_mac10/mac10_fire_01.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.SuppressedFireSound = "m9/m9_suppressed_fp.wav"
SWEP.BarrelLength = 6
SWEP.DrawAnim = "base_draw"
SWEP.EmptyDrawAnim = "empty_draw"
SWEP.FireAnim = "base_fire" .. math.random(2, 3) .. ""
SWEP.IronFireAnim = "iron_fire_" .. math.random(1, 3) .. ""
SWEP.TacticalReloadAnim = "base_reload"
SWEP.LastFireAnim = "base_firelast"
SWEP.LastIronFireAnim = "iron_firelast"
SWEP.ReloadAnim = "base_reload_empty"
SWEP.AimTime = 6
SWEP.BearTime = 3
SWEP.HipHoldType = "revolver"
SWEP.AimHoldType = "revolver"
SWEP.DownHoldType = "normal"
SWEP.MuzzleEffect = "pcf_jack_mf_spistol"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=2
SWEP.HolsterPos=Vector(2.3,-8,0)
SWEP.HolsterAng=Angle(160,10,180)
SWEP.CarryWeight = 1300
SWEP.NextFireTime = 0
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.MagDelay = 1
SWEP.ReloadAdd = 0.5
SWEP.ShellEffect = "eff_jack_hmcd_919"
SWEP.MagEntity = "ent_jack_hmcd_glock17mag"

SWEP.MuzzlePos = {10, -5, 0}

SWEP.ShellAttachment = 3
SWEP.ShellType = ""

SWEP.ReloadSounds = {
	{"weapons/usp_match/usp_match_magout.wav", 0.6, "EmptyOnly"},
	{"weapons/usp_match/usp_match_magin.wav", 1.8, "EmptyOnly"},
	{"weapons/usp_match/usp_match_maghit.wav", 2.7, "EmptyOnly"},
	{"weapons/usp_match/usp_match_boltrelease.wav", 3.6, "EmptyOnly"},
	{"weapons/usp_match/usp_match_magout.wav", 1.4, "FullOnly"},
	{"weapons/usp_match/usp_match_magin.wav", 2, "FullOnly"},
	{"weapons/usp_match/usp_match_maghit.wav", 2.15, "FullOnly"}
}

SWEP.DeployVolume = 60

SWEP.BulletDir = {40, 2.25, 1.5}

SWEP.Bodygroups = {
	[1] = 1
}

SWEP.SuicidePos = Vector(17, 0, -23)
SWEP.SuicideAng = Angle(90, 30, 90)
SWEP.SuicideSuppr = Vector(2, 0, -8.5)

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(15, 2, 0)
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "A_Suppressor",
			pos = {
				right = -5.2,
				forward = -0.01,
				up = -1.25
			},
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			num = HMCD_PISTOLSUPP
		},
		["Laser"] = {
			bone = "Weapon",
			pos = {
				right = 3,
				forward = 0.25,
				up = -0.2
			},
			ang = {
				up = 90,
				forward = 180,
				right = 180
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl",
			num = HMCD_LASERSMALL
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 0,
				up = 3,
				forward = 14
			},
			ang = {
				forward = 180,
				right = 10
			},
			bodygroups = {
				[0] = 1
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 14.2,
				up = -3.8,
				right = 1
			},
			ang = {
				right = 100,
				up = 90,
				forward = 290
			},
			model = "models/cw2/attachments/9mmsuppressor.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 8,
				up = -3.7,
				right = 1.3
			},
			ang = {
				right = -10,
				forward = 185
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
		}
	}
}