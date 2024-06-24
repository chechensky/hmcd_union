--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_makarych.lua
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
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_pm")
	killicon.AddFont("wep_jack_hmcd_pistol", "HL2MPTypeDeath", "1", Color(255, 0, 0))
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_pm"
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "IJ-79-9T"
SWEP.Category = "HMCD: Union - Pistols"
SWEP.Instructions = "This is a non-lethal gas pistol with the ability to fire ammunition with rubber bullets.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet."
SWEP.Primary.ClipSize = 9
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/tfa_ins2/c_pm.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_pm.mdl"
SWEP.ENT = "ent_jack_hmcd_makarych"
SWEP.HolsterSlot=2
SWEP.Damage = 4
SWEP.ShellType = ""
SWEP.DeathDroppable = false
SWEP.UseHands = true
SWEP.Category="HMCD: Union - Pistols"
SWEP.ViewModelFlip = false
SWEP.SprintPos = Vector(4, 0, -15)
SWEP.SprintAng = Angle(80, 0, 0)
--SWEP.SprintPos=Vector(0,20,0)
--SWEP.SprintAng=Angle(-90,90,0)
SWEP.AimPos = Vector(-2.15, 0, 0.5)
SWEP.FireAnim = "base_fire" .. math.random(2, 3) .. ""
SWEP.IronFireAnim = "iron_fire_" .. math.random(1, 3) .. ""
SWEP.LastIronFireAnim = "iron_fire_last"
SWEP.LastFireAnim = "base_firelast"
SWEP.DrawAnimEmpty = "empty_draw"
SWEP.DrawAnim = "base_draw"
SWEP.ReloadAnim = "base_reload_empty"
SWEP.TacticalReloadAnim = "base_reload"
--SWEP.CloseFireSound="m9/m9_fp.wav"
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.HipFireInaccuracy = .04
SWEP.CarryWeight = 1200
SWEP.FuckedWorldModel = true
SWEP.ReloadSound = ""
SWEP.AmmoType = "Pistol"
SWEP.MagEntity = "ent_jack_hmcd_makarychmag"
SWEP.ReloadTime = 4.2
SWEP.MagDelay = 1.5
SWEP.ReloadAdd = .7
SWEP.Traumatic = true
SWEP.FireAnimRate = 0.75
SWEP.ShellAttachment = 3
SWEP.MuzzleEffect = ""

SWEP.ReloadSounds = {
	{"weapons/tfa_ins2/pm/handling/makarov_magrelease.wav", 1.1, "Both"},
	{"weapons/tfa_ins2/pm/handling/makarov_magout.wav", 1.3, "Both"},
	{"weapons/tfa_ins2/pm/handling/makarov_magin.wav", 3.1, "Both"},
	{"weapons/tfa_ins2/pm/handling/makarov_maghit.wav", 3.3, "Both"},
	{"weapons/tfa_ins2/pm/handling/makarov_boltrelease.wav", 3.6, "EmptyOnly"}
}

SWEP.BulletDir = {400, 2, -1}

SWEP.Attachments = {
	["Owner"] = {
		["Magazine"] = {
			bone = "Bullet_1",
			pos = {
				right = -14,
				forward = 2.5,
				up = 1.5
			},
			ang = {
				up = -90
			},
			model = "models/weapons/tfa_ins2/upgrades/a_magazine_pm_8_phys.mdl"
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = -1,
				forward = 5
			},
			ang = {
				forward = 180,
				right = 10
			}
		},
		["Magazine"] = {
			model = "models/weapons/tfa_ins2/upgrades/a_magazine_pm_8_phys.mdl",
			pos = {
				forward = -10,
				up = -1.75,
				right = 3.5
			},
			ang = {
				right = 170,
				up = 180
			}
		}
	}
}