--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_mp5.lua
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
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_mp5a4")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_mp5a4"
SWEP.IconHeight = 2
SWEP.IconLength = 3
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "MP5A4"
SWEP.Instructions = "This is a 9x19mm Parabellum submachine gun, one of the most widely used submachine guns in the world. \n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 31
SWEP.ViewModel = "models/weapons/tfa_ins2/v_mp5a4.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_mp5a4.mdl"
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.Primary.Automatic = true
SWEP.Damage = 40
SWEP.ShellType = ""
SWEP.FuckedWorldModel = true
SWEP.SprintPos = Vector(5, 0, -3)
SWEP.SprintAng = Angle(-30, 30, -60)
SWEP.AimPos = Vector(-2.3, -1, 0.65)
SWEP.AltAimPos = Vector(2, -1, 0.75)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.ReloadTime = 4.75
SWEP.ReloadAdd = 2
SWEP.ReloadRate = .6
SWEP.ReloadAnim = "base_reloadempty"
SWEP.TacticalReloadAnim = "base_reload"
SWEP.FireAnim = "base_fire"
SWEP.IronFireAnim = "iron_fire"
SWEP.AmmoType = "Pistol"
SWEP.TriggerDelay = .075
SWEP.CycleTime = 0
SWEP.Recoil = .5
SWEP.Supersonic = true
SWEP.DrawAnim = "base_draw"
SWEP.Accuracy = .99
SWEP.Category="HMCD: Union - SMG"
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_mp5"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CloseFireSound = "smg_mac10/mac10_fire_01.wav"
SWEP.FarFireSound = "mp5k/mp5k_dist.wav"
SWEP.SuppressedFireSound = "mp5k/mp5k_suppressed_fp.wav"
SWEP.BarrelLength = 10
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(3,-7,-4)
SWEP.HolsterAng=Angle(160,5,180)
SWEP.CarryWeight = 3000
SWEP.NextFireTime = 0
SWEP.InsHands = true

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(30, 3, -2)
}

SWEP.SuicidePos = Vector(5, 7, -25)
SWEP.SuicideAng = Angle(110, 2, 90)
SWEP.SuicideSuppr = Vector(0, 4.5, -9.5)
SWEP.SuicideTime = 10
SWEP.SuicideType = "SMG"

SWEP.ReloadSounds = {
	{"weapons/tfa_ins2/mp5a4/mp5k_magout.wav", 1, "FullOnly"},
	{"weapons/tfa_ins2/mp5a4/mp5k_magin.wav", 3.35, "FullOnly"},
	{"weapons/tfa_ins2/mp5a4/mp5k_boltback.wav", .5, "EmptyOnly"},
	{"weapons/tfa_ins2/mp5a4/mp5k_boltlock.wav", .85, "EmptyOnly"},
	{"weapons/tfa_ins2/mp5a4/mp5k_magout.wav", 2.2, "EmptyOnly"},
	{"weapons/tfa_ins2/mp5a4/mp5k_magin.wav", 4.55, "EmptyOnly"},
	{"weapons/tfa_ins2/mp5a4/mp5k_boltrelease.wav", 5.75, "EmptyOnly"}
}

SWEP.MagEntity = "ent_jack_hmcd_mp5mag"
SWEP.MagDelay = 2.5

SWEP.MuzzlePos = {15, -6, 1}

SWEP.ShellAttachment = 3

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "Weapon",
			pos = {
				right = 12.25,
				forward = .2,
				up = .95
			},
			ang = {
				forward = 180
			},
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			num = HMCD_PISTOLSUPP
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = 0,
				forward = 5
			},
			ang = {
				forward = 180
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 25,
				up = -3.5,
				right = 2.27
			},
			ang = {
				up = 270,
				forward = -180,
				right = -90
			},
			model = "models/cw2/attachments/9mmsuppressor.mdl"
		}
	}
}