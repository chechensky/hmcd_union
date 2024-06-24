--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_mp7.lua
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
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_mp7")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_mp7"
SWEP.IconLength = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "HK MP7"
SWEP.Instructions = "This is a lightweight personal defense weapon firing 4.6x30mm. \n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 41
SWEP.ViewModel = "models/weapons/tfa_ins2/c_mp7.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_mp7.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.Damage = 30
SWEP.ShellType = ""
SWEP.FuckedWorldModel = true
SWEP.SprintPos = Vector(5, 4, -3)
SWEP.SprintAng = Angle(-30, 60, -30)
SWEP.AimPos = Vector(-2.8, -1.5, 0.8)
SWEP.AltAimPos = Vector(2, -1, 0.75)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.ReloadTime = 4.65
SWEP.ReloadRate = .6
SWEP.AttBone = "mp7_main"
SWEP.AmmoType = "Pistol"
SWEP.SightRifle = false
SWEP.SightRifle2 = false
SWEP.SightRifle3 = false
SWEP.SuppressedRifle = false
SWEP.LaserAngle = Angle(0, 0, 0)
SWEP.LaserRifle = false
SWEP.TriggerDelay = .0631
SWEP.Primary.Automatic = true
SWEP.CycleTime = 0
SWEP.Recoil = .4
SWEP.Supersonic = true
SWEP.Accuracy = .99
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_mp7"
SWEP.Category="HMCD: Union - SMG"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CloseFireSound = "smg_mac10/mac10_fire_01.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
--SWEP.CloseFireSound="mp5k/mp5k_fp.wav"
SWEP.FarFireSound = "mp5k/mp5k_dist.wav"
SWEP.SuppressedFireSound = "mp5k/mp5k_suppressed_fp.wav"
SWEP.BarrelLength = 6
SWEP.FireAnimRate = 1
SWEP.DrawAnim = "base_draw"
SWEP.FireAnim = "base_fire"
SWEP.IronFireAnim = "iron_fire"
SWEP.ReloadAnim = "base_reload_empty"
SWEP.TacticalReloadAnim = "base_reload"
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "crossbow"
SWEP.AimHoldType = "smg"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_spistol"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(2.3,-8,0)
SWEP.HolsterAng=Angle(160,10,180)
SWEP.CarryWeight = 2500
SWEP.NextFireTime = 0
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.ShellEffect = "eff_jack_hmcd_46"
SWEP.ShellAttachment = 1

SWEP.MuzzlePos = {15, -6, 1}

SWEP.AnimRandomiser = true
SWEP.ReloadAdd = 2.5

SWEP.ReloadSounds = {
	{"weapons/tfa_ins2/mp7/magout.wav", 1, "EmptyOnly"},
	{"weapons/tfa_ins2/mp7/magin.wav", 3.38, "EmptyOnly"},
	{"weapons/tfa_ins2/mp7/boltback.wav", 4.93, "EmptyOnly"},
	{"weapons/tfa_ins2/mp7/boltrelease.wav", 5.63, "EmptyOnly"},
	{"weapons/tfa_ins2/mp7/magout.wav", 1.3, "FullOnly"},
	{"weapons/tfa_ins2/mp7/magin.wav", 3.3, "FullOnly"}
}

SWEP.BulletDir = {400, 2.85, -1}

SWEP.SuicidePos = Vector(5, 7, -25)
SWEP.SuicideAng = Angle(110, 2, 90)
SWEP.SuicideSuppr = Vector(0, 4.5, -9.5)
SWEP.SuicideTime = 10
SWEP.SuicideType = "SMG"
SWEP.MagEntity = "ent_jack_hmcd_mp7mag"

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(12, 2, -1)
}

SWEP.MultipleRIS = true

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "mp7_main",
			pos = {
				right = 0.8,
				forward = 14.5,
				up = 0
			},
			ang = {
				up = -90,
				right = 90
			},
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			num = HMCD_PISTOLSUPP
		},
		["Laser"] = {
			bone = "mp7_main",
			pos = {
				right = -0.2,
				forward = 6.48,
				up = -0.9
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl",
			num = HMCD_LASERSMALL
		},
		["Sight"] = {
			bone = "mp7_main",
			pos = {
				right = -2.5,
				forward = 0.5,
				up = 0.05
			},
			ang = {
				up = 90,
				forward = -90,
				right = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				right = -3.6,
				forward = 9,
				up = 0.1
			},
			sightang = {
				forward = -90
			},
			aimpos = Vector(-2.8, -2, 0.35),
			num = HMCD_KOBRA
		},
		["Sight2"] = {
			bone = "mp7_main",
			pos = {
				right = -2.6,
				forward = 1,
				up = 0
			},
			ang = {
				up = 90,
				forward = -90,
				right = -90
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				right = -3.63,
				forward = 13,
				up = 0
			},
			sightang = {
				forward = 90,
				right = 180
			},
			aimpos = Vector(-2.8, -2, 0.3),
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "mp7_main",
			pos = {
				right = -2.6,
				forward = 1,
				up = 0
			},
			ang = {
				up = 90,
				forward = -90,
				right = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				right = -3.63,
				forward = 13,
				up = 0
			},
			sightang = {
				forward = 90,
				right = 180
			},
			aimpos = Vector(-2.8, -2, 0.2),
			num = HMCD_EOTECH
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = -2.5,
				forward = 6
			},
			ang = {
				forward = 180,
				right = 10
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 18.8,
				up = -4.9,
				right = 0.98
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
				forward = 11,
				up = -4.6,
				right = 1.7
			},
			ang = {
				right = -10,
				forward = 270
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
		},
		["Sight"] = {
			pos = {
				forward = 6,
				up = -5.8,
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
				forward = 6,
				up = -6,
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
				forward = 6,
				up = -6,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		}
	}
}

SWEP.NPCAnims = {
	[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1,
	[ACT_RELOAD] = ACT_RELOAD_SMG1,
	[ACT_IDLE] = ACT_IDLE_SMG1,
	[ACT_IDLE_ANGRY] = ACT_RANGE_ATTACK_SMG1,
	[ACT_WALK] = ACT_WALK_RIFLE,
	[ACT_IDLE_RELAXED] = ACT_IDLE_RELAXED,
	[ACT_IDLE_STIMULATED] = ACT_IDLE_STIMULATED,
	[ACT_IDLE_AGITATED] = ACT_IDLE_ANGRY_SMG1,
	[ACT_WALK_RELAXED] = ACT_WALK_RELAXED,
	[ACT_WALK_STIMULATED] = ACT_WALK_STIMULATED,
	[ACT_WALK_AGITATED] = ACT_WALK_AIM_RIFLE,
	[ACT_RUN_RELAXED] = ACT_RUN_RELAXED,
	[ACT_RUN_STIMULATED] = ACT_RUN_STIMULATED,
	[ACT_RUN_AGITATED] = ACT_RUN_AIM_RIFLE,
	[ACT_IDLE_AIM_RELAXED] = ACT_IDLE_RELAXED,
	[ACT_IDLE_AIM_STIMULATED] = ACT_IDLE_AIM_STIMULATED,
	[ACT_IDLE_AIM_AGITATED] = ACT_IDLE_ANGRY_SMG1,
	[ACT_WALK_AIM_RELAXED] = ACT_WALK_RELAXED,
	[ACT_WALK_AIM_STIMULATED] = ACT_WALK_AIM_STIMULATED,
	[ACT_WALK_AIM_AGITATED] = ACT_WALK_AIM_RIFLE,
	[ACT_RUN_AIM_RELAXED] = ACT_RUN_RELAXED,
	[ACT_RUN_AIM_STIMULATED] = ACT_RUN_AIM_STIMULATED,
	[ACT_RUN_AIM_AGITATED] = ACT_RUN_AIM_RIFLE,
	[ACT_WALK_AIM] = ACT_WALK_AIM_RIFLE,
	[ACT_WALK_CROUCH] = ACT_WALK_CROUCH,
	[ACT_WALK_CROUCH_AIM] = ACT_WALK_CROUCH_AIM,
	[ACT_RUN] = ACT_RUN_RIFLE,
	[ACT_RUN_AIM] = ACT_RUN_AIM_RIFLE,
	[ACT_RUN_CROUCH] = ACT_RUN_CROUCH,
	[ACT_RUN_CROUCH_AIM] = ACT_RUN_CROUCH_AIM,
	[ACT_GESTURE_RANGE_ATTACK1] = ACT_GESTURE_RANGE_ATTACK_SMG1,
	[ACT_RANGE_AIM_LOW] = ACT_RANGE_AIM_SMG1_LOW,
	[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1,
	[ACT_RELOAD_LOW] = ACT_RELOAD,
	[ACT_GESTURE_RELOAD] = ACT_GESTURE_RELOAD,
	[ACT_MELEE_ATTACK1] = ACT_MELEE_ATTACK1
}