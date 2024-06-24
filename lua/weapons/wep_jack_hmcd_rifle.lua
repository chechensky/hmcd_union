--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_rifle.lua
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
	killicon.AddFont("wep_jack_hmcd_rifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_rifle")
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_rifle"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Mauser Kar98k"
SWEP.Instructions = "This is an old bolt-action hunting rifle with a scope with a five-round internal magazine, firing 7.92x57mm.\n\nLMB to fire.\nRMB to aim.\nRMB + E to use an alternative scope.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 5
SWEP.ViewModel = "models/weapons/gleb/c_kar98k_scope.mdl"
SWEP.WorldModel = "models/weapons/gleb/w_kar98k.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = true
SWEP.Damage = 48
SWEP.SprintPos = Vector(-7, 0, -2)
SWEP.SprintAng = Angle(-20, -30, 40)
--SWEP.AimPos=Vector(1.95,-3,.5)
SWEP.AimPos = Vector(2.2, -3, 1.75)
SWEP.AimAng = Angle(1, 0.5, 0)
SWEP.ReloadTime = 5.5
SWEP.ReloadRate = .75
SWEP.ReloadSound = "snd_jack_hmcd_boltreload.wav"
SWEP.CycleSound = "snd_jack_hmcd_boltcycle.wav"
SWEP.AmmoType = "AR2"
SWEP.TriggerDelay = .2
SWEP.CycleTime = 1.2
SWEP.Recoil = 1
SWEP.Category="HMCD: Union - Rifles"
SWEP.Supersonic = true
SWEP.SuppressedRifle = false
SWEP.Accuracy = .9999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_rifle"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true

SWEP.TPIK = true

SWEP.TPIK_PosAngles = {
	["ValveBiped.Bip01_L_Forearm"] = Angle(0,120,0),
	["ValveBiped.Bip01_L_Hand"] = Angle(0,0,0),
	["ValveBiped.Bip01_L_Finger0"] = Angle(0,0,0),
	["ValveBiped.Bip01_L_Finger1"] = Angle(0,-30,0),
	["ValveBiped.Bip01_L_Finger2"] = Angle(0,-30,0),
	["ValveBiped.Bip01_L_Finger3"] = Angle(0,-30,0)
}
SWEP.TPIK_PosVectors = {
}

SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
SWEP.CycleType = "manual"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "awm_draw"
SWEP.FireAnim = "awm_fire"
SWEP.ReloadAnim = "awm_reload"
SWEP.CloseFireSound = "kar98k/kar98k.wav"
--SWEP.FarFireSound="snd_jack_hmcd_snp_far.wav"
--SWEP.CloseFireSound="mosin/mosin_fp.wav"
SWEP.FarFireSound = "mosin/mosin_dist.wav"
SWEP.SuppressedFireSound = "mosin/mosin_suppressed_fp.wav"
SWEP.ShellType = ""
SWEP.Scoped = true
SWEP.DetachableScope = true
SWEP.ScopeFoV = 15
SWEP.ScopedSensitivity = .1
SWEP.BarrelLength = 18
SWEP.AimTime = 6.25
SWEP.World_MuzzleAttachmentName="muzzle_flash"
SWEP.BearTime = 9
SWEP.FuckedWorldModel = true
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle1"
SWEP.HolsterSlot = 1
SWEP.HipFireInaccuracy = .05
SWEP.HolsterPos=Vector(3.5,2,-4)
SWEP.HolsterAng=Angle(160,5,180)
SWEP.CarryWeight = 5000
SWEP.SuppressorPos = Vector(1.3, -22.5, 5)
SWEP.SuppressorAng = Angle(-10, -95, -10)
SWEP.SuppressorModel = "models/cw2/attachments/556suppressor.mdl"
SWEP.SuppressorSize = .9
SWEP.ShellDelay = .57
SWEP.ShellAttachment = 2
SWEP.ShellEffect = "eff_jack_hmcd_76239"
SWEP.MagDelay = 4.6
SWEP.MagEntity = "ent_jack_hmcd_mauserstripper"

SWEP.MuzzlePos = {38.7, -5.7, 2.1}

SWEP.NoBulletInChamber = true

SWEP.BulletDir = {1000, -1.5, -18}

SWEP.SuicidePos = Vector(-2, 12.5, -38)
SWEP.SuicideAng = Angle(110, 2, -90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"

SWEP.MuzzleInfo = {
	["Bone"] = "Ger_K98",
	["Offset"] = Vector(-30, 0, 5)
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "Ger_K98",
			pos = {
				right = 2.1,
				forward = -20,
				up = 1.5
			},
			reverseangle = true,
			ang = {
				up = -90,
				right = 90
			},
			scale = .7,
			model = "models/cw2/attachments/556suppressor.mdl",
			num = HMCD_RIFLESUPP
		},
		["Scope"] = {
			bone = "Ger_K98",
			pos = {
				right = -0.05,
				forward = -5,
				up = 3.35
			},
			reverseangle = true,
			ang = {
				up = 270,
				right = 0
			},
			scale = 1.1,
			model = "models/weapons/gleb/optic_scope_hmcd.mdl",
			num = HMCD_SCOPE,
			aimpos = Vector(2.2, -3, .6)
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = 1,
				forward = 0
			},
			ang = {
				forward = 180,
				right = 10
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 25,
				up = -6.3,
				right = -1.5
			},
			ang = {
				right = 80,
				forward = 90
			},
			scale = .9,
			model = "models/cw2/attachments/556suppressor.mdl"
		},
		["Scope"] = {
			pos = {
				forward = 7.3,
				up = -5,
				right = 1.25
			},
			scale = 1.45,
			ang = {
				right = 80,
				forward = 90,
				up = -90
			},
			model = "models/weapons/gleb/optic_scope_hmcd.mdl"
		}
	}
}