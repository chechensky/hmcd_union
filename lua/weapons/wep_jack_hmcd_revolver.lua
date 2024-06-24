--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_revolver.lua
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
	killicon.AddFont("wep_jack_hmcd_revolver", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_revolver")
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_revolver"
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Manurhin MR96"
SWEP.Instructions = "This is an inexpensive 6-round revolver firing .38-special.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 6
SWEP.ViewModel = "models/weapons/v_pist_jeagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_jeagle.mdl"
SWEP.FuckedWorldModel = true
SWEP.ViewModelFlip = false
SWEP.SuppressedPistol = false
SWEP.LaserPistol = false
SWEP.Damage = 25
SWEP.World_MuzzleAttachmentName="muzzle_flash"
SWEP.SprintPos = Vector(3, 0, -12)
SWEP.Category="HMCD: Union - Pistols"
SWEP.SprintAng = Angle(70, 0, 0)
SWEP.AimPos = Vector(-1.75, 0, .4)
SWEP.AltAimPos = Vector(-1.75, 0, .4)
SWEP.SuicidePos = Vector(5.75, -2, -17)
SWEP.SuicideAng = Angle(80, 20, 0)
SWEP.SuicideTime = 5
SWEP.SuicideSuppr = Vector(2, 0, -7.5)
SWEP.ReloadTime = 5
SWEP.ReloadRate = .5
SWEP.CloseFireSound = "hndg_sw686/revolver_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.CloseFireSound="m9/m9_fp.wav"
SWEP.SuppressedFireSound = "m9/m9_suppressed_fp.wav"
SWEP.ReloadSound = "snd_jack_hmcd_rvreload.wav"
SWEP.AmmoType = "357"
SWEP.TriggerDelay = .175
SWEP.CycleTime = .175
SWEP.Recoil = 1
SWEP.Supersonic = false
SWEP.Accuracy = .99
SWEP.ShotPitch = 90
SWEP.ENT = "ent_jack_hmcd_revolver"
SWEP.CommandDroppable = true
SWEP.Spawnable = true

SWEP.TPIK = true

SWEP.TPIK_PosAngles = {
    ["ValveBiped.Bip01_R_Forearm"] = Angle(0, 0, -30),
	["ValveBiped.Bip01_L_Forearm"] = Angle(0, 0, 0),
	["ValveBiped.Bip01_R_Hand"] = Angle(-5, 0, 0)
}

SWEP.CycleType = "revolving"
SWEP.ReloadType = "clip"
SWEP.MuzzleEffect = "pcf_jack_mf_spistol"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.ShellType = ""
SWEP.CustomColor = Color(50, 50, 50, 255)
SWEP.HolsterSlot=2
SWEP.HipFireInaccuracy = .05
SWEP.DeathDroppable = false
SWEP.CarryWeight = 1500
SWEP.ShellEffect = ""
SWEP.ShellEffectReload = "eff_jack_hmcd_38"
SWEP.ShellAttachment = 1
SWEP.MagDelay = 1.3

SWEP.MuzzlePos = {-0.9, 2, 7.8}

SWEP.NoBulletInChamber = true
SWEP.ReloadAdd = 0
SWEP.DangerLevel = 70

SWEP.BulletDir = {400, 1.7, -0.5}

SWEP.MuzzleInfo = {
	["Bone"] = "MR96",
	["Offset"] = Vector(20, 2, 0)
}

SWEP.DeployVolume = 60

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "MR96",
			pos = {
				right = 7.8,
				forward = -0.9,
				up = 2
			},
			ang = {
				up = 180,
				right = 90
			},
			scale = .7,
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			num = HMCD_PISTOLSUPP
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
				forward = 15.8,
				up = -4.9,
				right = 1.6
			},
			ang = {
				right = 280,
				up = 80,
				forward = 110
			},
			scale = .9,
			model = "models/cw2/attachments/9mmsuppressor.mdl"
		}
	}
}