--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_ptrd.lua
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
	killicon.AddFont("wep_jack_hmcd_shotgun", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ptrd")
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_ptrd"
SWEP.IconLength = 4
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "PTRD-41"
SWEP.Instructions = "This is a single-shot anti-tank rifle using a 14.5×114 mm round.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement does not count."
SWEP.Primary.ClipSize = 1
SWEP.SlotPos = 2
SWEP.ViewModel = "models/gleb/c_ptrd.mdl"
SWEP.WorldModel = "models/gleb/w_ptrd.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 200
SWEP.SprintPos = Vector(10, -1, -1)
SWEP.SprintAng = Angle(-20, 70, -40)
SWEP.AimPos = Vector(-5.2, -1.5, 2.7)
SWEP.ReloadRate = .5
SWEP.BipodReloadRate = .59
SWEP.AmmoType = "AR2"
SWEP.AimTime = 5
SWEP.BearTime = 7
SWEP.TriggerDelay = .1
SWEP.CycleTime = .9
SWEP.Recoil = 20
SWEP.ReloadTime = 6
SWEP.Supersonic = false
SWEP.Accuracy = .99
SWEP.Category="HMCD: Union - Rifles"
SWEP.HipFireInaccuracy = .07
SWEP.CloseFireSound = "weapons/ptrd/ptrsfire.wav"
SWEP.SuppressedFireSound = "toz_shotgun/toz_suppressed_fp.wav"
SWEP.FarFireSound = "mosin/mosin_dist.wav"
SWEP.ENT = "ent_jack_hmcd_ptrd"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle2"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.MuzzleAttachment = "gbib"
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.DeathDroppable = false
SWEP.FireAnim = "fire"
SWEP.DrawAnim = "draw"
SWEP.DrawAnimEmpty = "draw_empty"
SWEP.UseHands = true
SWEP.CockAnimDelay = .25
SWEP.ShellType = ""
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.FuckedWorldModel = true
SWEP.World_MuzzleAttachmentName="1"
SWEP.ReloadType = "magazine"
SWEP.BarrelLength = 28
SWEP.HolsterSlot = 1
SWEP.CarryWeight = 8000
SWEP.ShellEffectReload = "eff_jack_hmcd_145"
SWEP.MagDelay = 1.8
SWEP.ShellAttachment = 1

SWEP.MuzzlePos = {75.7, -5.7, 2.1}

SWEP.BulletDir = {400, 2.5, -2}

SWEP.BipodUsable = true
SWEP.BipodPlaceAnim = "hand_to_bipod"
SWEP.BipodRemoveAnim = "bipod_to_hand"
SWEP.BipodPlaceAnimEmpty = "hand_to_bipod_empty"
SWEP.BipodRemoveAnimEmpty = "bipod_to_hand_empty"
SWEP.BipodFireAnim = "fire_bipod"
SWEP.ReloadAnim = "reload"
SWEP.BipodReloadAnim = "reload_bipod"
SWEP.NoBulletInChamber = true

SWEP.BipodDeploySound = {.8, "weapons/m249/handling/m249_bipoddeploy.wav"}

SWEP.BipodRemoveSound = {.8, "weapons/m249/handling/m249_bipodretract.wav"}

SWEP.BipodOffset = 12
SWEP.BipodAimOffset = Vector(0, 5.2, -2.6)
SWEP.ShellEffect = ""

SWEP.BipodReloadSounds = {
	{"weapons/ptrd/boltback.wav", 1.4, "Both"},
	{"weapons/ptrd/coveropen.wav", 1.6, "Both"},
	{"weapons/ptrd/clipin.wav", 4.45, "Both"},
	{"weapons/ptrd/coverclose.wav", 5.65, "Both"},
	{"weapons/ptrd/boltrelease.wav", 6.1, "Both"}
}

SWEP.ReloadSounds = {
	{"weapons/ptrd/boltback.wav", 1.4, "Both"},
	{"weapons/ptrd/coveropen.wav", 1.6, "Both"},
	{"weapons/ptrd/clipin.wav", 4.75, "Both"},
	{"weapons/ptrd/coverclose.wav", 5.45, "Both"},
	{"weapons/ptrd/boltrelease.wav", 5.95, "Both"}
}

SWEP.MuzzleInfo = {
	["Bone"] = "base",
	["Offset"] = Vector(0, -75, 8)
}

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = -1.5,
				forward = 4
			},
			ang = {
				forward = 180,
				right = 0
			}
		}
	}
}