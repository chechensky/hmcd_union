--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_combinesniper.lua
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
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_combinesniper")
end

SWEP.Base = "wep_jack_hmcd_firearm_base"
SWEP.PrintName = "OPSR"
SWEP.Instructions = "This is a semi-automatic sniper rifle firing dark energy plasma manufactured by the combine.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/combine_sniper_weapon.mdl"
SWEP.WorldModel = "models/w_models/combine_sniper_test.mdl"
SWEP.ViewModelFlip = false
SWEP.IconTexture = "vgui/wep_jack_hmcd_combinesniper"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.ViewModelFOV = 80
SWEP.UseHands = true
SWEP.Damage = 150
SWEP.SprintPos = Vector(10, -1, -3)
SWEP.SprintAng = Angle(-20, 30, -40)
SWEP.AimPos = Vector(-5.5, -13.2, 1)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.ReloadTime = 6
SWEP.ReloadRate = .5
SWEP.Scoped = true
SWEP.ScopedSensitivity = .05
SWEP.ScopeFoV = 15
SWEP.ReloadSound = ""
SWEP.AmmoType = "AR2"
SWEP.TriggerDelay = .25
SWEP.CycleTime = .05
SWEP.Recoil = 1
SWEP.Category="HMCD: Union - Sniper"
SWEP.AttBone = "RAILS_LOW_001"
SWEP.Angle1 = -179.65
SWEP.Angle2 = -10
SWEP.Angle3 = -0.7
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_combinesniper"
SWEP.FuckedWorldModel = true
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "draw"
SWEP.FireAnim = "fire"
SWEP.ReloadAnim = "reload"
--SWEP.CloseFireSound="rifle_win1892/win1892_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_ar_far.wav"
SWEP.CloseFireSound = "NPC_Sniper.FireBullet"
SWEP.FarFireSound = "mosin/mosin_dist.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 1
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.World_MuzzleAttachmentName="1"
SWEP.MuzzleEffect = "new_ar2_muzzle"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(2,-15,-2)
SWEP.HolsterAng=Angle(160,10,180)
SWEP.CarryWeight = 4500
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)

SWEP.MuzzlePos = {50.5, -10.1, 3.1}

SWEP.ShellEffect = ""
SWEP.NoBulletInChamber = true
SWEP.ReloadAdd = 0

SWEP.ReloadSounds = {
	{"weapons/combinesniper/mini14_magrelease.wav", 1.5, "Both"},
	{"weapons/combinesniper/mini14_magout.wav", 1.6, "Both"},
	{"weapons/combinesniper/mini14_magin.wav", 3.5, "Both"},
	{"weapons/combinesniper/mini14_boltback.wav", 4.8, "Both"},
	{"weapons/combinesniper/mini14_boltrelease.wav", 5.2, "Both"}
}

SWEP.BulletDir = {1000, 2.5, -1}

SWEP.SuicidePos = Vector(10, 24.75, -68.5)
SWEP.SuicideAng = Angle(110, 2, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"

SWEP.MuzzleInfo = {
	["Bone"] = "muzz",
	["Offset"] = Vector(30, 5, 0)
}

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1.5,
				up = -5,
				forward = 19.5
			},
			ang = {
				right = 180,
				up = 180
			}
		}
	}
}