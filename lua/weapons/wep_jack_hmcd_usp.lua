--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_usp.lua
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
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_usp_match")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_usp_match"
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "H&K USP Match"
SWEP.Instructions = "This is a semi-automatic 18-round-capacity pistol firing 9x19mm rounds.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 19
SWEP.ENT = "ent_jack_hmcd_usp"
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_ins2/c_usp_match.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_usp_match.mdl"
--CustomColor=Color(50,50,50,255)
SWEP.HolsterSlot=2
SWEP.ShellType = ""
SWEP.vbwPistol = true
SWEP.vbwPos=Vector(7.5,0,3)
SWEP.DeathDroppable = false
SWEP.SuppressedPistol = false
SWEP.LaserPistol = false
SWEP.AttBone = "Weapon"
SWEP.UseHands = true

SWEP.TPIK = true

SWEP.TPIK_PosAngles = {
    ["ValveBiped.Bip01_R_Clavicle"] = Angle(0, -30, 0),
	["ValveBiped.Bip01_R_UpperArm"] = Angle(0, -30, 0),
	["ValveBiped.Bip01_Spine2"] = Angle(0, 25, 0),
	["ValveBiped.Bip01_Neck1"] = Angle(0, 20, 0),
}

SWEP.ReloadTime = 3.3
SWEP.ViewModelFlip = false
SWEP.Recoil = 0.2
SWEP.SprintPos = Vector(5, 3, -18)
SWEP.SprintAng = Angle(80, 0, 0)
SWEP.AimPos = Vector(-2, 0, 0.4)
SWEP.AmmoType="Pistol"
SWEP.AltAimPos = Vector(1.95, -3, .5)
SWEP.FireAnim = "base_fire" .. math.random(2, 3) .. ""
SWEP.IronFireAnim = "base_fire" .. math.random(2, 3) .. ""
SWEP.ReloadAnim = "base_reload_empty"
SWEP.TacticalReloadAnim = "base_reload"
SWEP.Category="HMCD: Union - Pistols"
SWEP.DrawAnim = "base_draw"
SWEP.DrawAnimEmpty = "empty_draw"
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
--SWEP.CloseFireSound="m9/m9_fp.wav"
SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.SuppressedFireSound = "m9/m9_suppressed_fp.wav"
SWEP.LastFireAnim = "base_firelast"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .04
SWEP.CarryWeight = 1200
SWEP.FuckedWorldModel = true
SWEP.LaserAngle = Angle(0, -90, -90)
SWEP.ShellEffect = "eff_jack_hmcd_919"
SWEP.ShellAttachment = 3
SWEP.MagEntity = "ent_jack_hmcd_glock17mag"

SWEP.MuzzlePos = {8.5, -5.1, 3.1}

SWEP.ReloadAdd = 1.3

SWEP.ReloadSounds = {
	{"weapons/usp_match/usp_match_magout.wav", 0.6, "EmptyOnly"},
	{"weapons/usp_match/usp_match_magin.wav", 1.8, "EmptyOnly"},
	{"weapons/usp_match/usp_match_maghit.wav", 2.7, "EmptyOnly"},
	{"weapons/usp_match/usp_match_boltrelease.wav", 3.6, "EmptyOnly"},
	{"weapons/usp_match/usp_match_magout.wav", 1, "FullOnly"},
	{"weapons/usp_match/usp_match_magin.wav", 1.6, "FullOnly"},
	{"weapons/usp_match/usp_match_maghit.wav", 1.75, "FullOnly"}
}

SWEP.DeployVolume = 60

SWEP.BulletDir = {400, 2.25, 1.5}

SWEP.SuicidePos = Vector(17, 0, -23)
SWEP.SuicideAng = Angle(90, 30, 90)
SWEP.SuicideSuppr = Vector(2, 0, -6.5)

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(15, 3, 0)
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "Slide",
			pos = {
				up = -2,
				forward = 0,
				right = 0
			},
			ang = {
				up = -90
			},
			model = "models/weapons/tfa_ins2/upgrades/usp_match/w_suppressor_pistol.mdl",
			num = HMCD_OSPREY
		},
		["Laser"] = {
			bone = "Weapon",
			pos = {
				up = -1,
				forward = 0.3,
				right = 6.5
			},
			ang = {
				up = -90
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
				up = -1.5,
				forward = 5
			},
			ang = {
				forward = 180,
				right = 10
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 5.5,
				up = -2,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/usp_match/w_suppressor_pistol.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 8.9,
				up = -3,
				right = 1
			},
			ang = {
				right = 170,
				up = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
		}
	}
}