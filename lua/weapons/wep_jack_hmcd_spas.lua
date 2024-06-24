--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_spas.lua
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
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_spas12")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_spas12"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Spas-12"
SWEP.Instructions = "This is a combat shotgun firing 12-guage 2-3/4 inch cartridges.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability."
SWEP.Primary.ClipSize = 8
SWEP.ViewModel = "models/weapons/tfa_ins2/c_spas12_bri.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_spas12_bri.mdl"
SWEP.ViewModelFlip = false
SWEP.NoBulletInChamber = true
SWEP.Damage = 30
SWEP.UseHands = true
SWEP.FuckedWorldModel = true
SWEP.SprintPos = Vector(9, -1, -3)
SWEP.SprintAng = Angle(-20, 60, -40)
SWEP.AimPos = Vector(-2.6, 0.2, 0.85)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.902, -3.2, .13)
SWEP.ReloadTime = 4.25
SWEP.ReloadRate = .6
SWEP.ReloadSound = "snd_jack_shotguninsert.wav"
SWEP.AmmoType = "Buckshot"
SWEP.Category="HMCD: Union - Shotguns"
SWEP.SuppressedRifle = false
SWEP.TriggerDelay = .25
SWEP.CycleTime = .05
SWEP.Recoil = 1.3
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_spas"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.NumProjectiles = 8
SWEP.Spread = .0285
SWEP.ReloadType = "individual"
SWEP.DrawAnim = "base_draw"
SWEP.FireAnim = "base_fire_1"
SWEP.IronFireAnim = "base_fire_1"
SWEP.LastFireAnim = "base_firelast"
SWEP.LastIronFireAnim = "iron_fire_last"
SWEP.CloseFireSound = "shtg_remington870/remington_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_sht_far.wav"
--SWEP.CloseFireSound="toz_shotgun/toz_fp.wav"
SWEP.SuppressedFireSound = "toz_shotgun/toz_suppressed_fp.wav"
SWEP.FarFireSound = "toz_shotgun/toz_dist.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mshotgun"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(4,-3,5)
SWEP.HolsterAng=Angle(40,-190,180)
SWEP.FireAnimRate = 0.5
SWEP.CarryWeight = 4700
SWEP.ShellAttachment = 2
SWEP.ShellEffect = "eff_jack_hmcd_12gauge"

SWEP.MuzzlePos = {25.7, -6.5, 2.1}

SWEP.BulletDir = {400, 2.5, -1.5}

SWEP.SuicidePos = Vector(4, 11.75, -37.5)
SWEP.SuicideAng = Angle(110, 2, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"
SWEP.StallAnim = "base_reload_end"
SWEP.StallTime = .5
SWEP.LoadAnim = "base_reload_insert"
SWEP.LoadFinishAnim = "base_reload_end"
SWEP.StartReloadAnim = "base_reload_start"
SWEP.ReloadSoundDelay = .3
SWEP.InertiaScale = 0.5

SWEP.MuzzleInfo = {
	["Bone"] = "Weapon",
	["Offset"] = Vector(0, 20, 2)
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "Weapon",
			pos = {
				right = 2.7,
				forward = 1.4,
				up = 2
			},
			ang = {
				up = 90,
				forward = 180,
				right = -180
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl",
			num = HMCD_SHOTGUNSUPP
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = -3,
				forward = 6
			},
			ang = {
				forward = 180,
				right = 10
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 12,
				up = -6.5,
				right = 2.8
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl"
		}
	}
}