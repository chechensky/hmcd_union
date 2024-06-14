--shotgun
SWEP.Base = "hmcd_weapon_base"
SWEP.PrintName = "BASE PX4"
SWEP.Instructions = "This is your trusty 9x19mm pistol. Use it as you see fit.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."

SWEP.RecoilForce = {2, 2}

SWEP.InAirRecoilForce = {0.2, 0.0}

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_px4.mdl"
SWEP.WorldModel = "models/weapons/w_matt_mattpx4v1.mdl"
SWEP.AdminOnly = true
SWEP.CarryWeight = 3600
SWEP.Category="HMCD: Union - Pistols"
SWEP.IronPos = Vector(-1.95, -1.5, 1.1)
SWEP.SprintAngle = Angle(-15, 45, -10)
SWEP.SprintPos = Vector(5, -5, -1.2)
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 13
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.Damage = 13
SWEP.DamageVar = 16
SWEP.Delay = 0.05
SWEP.Shots = 8
SWEP.Cone = 0.07
SWEP.AimCone = 0.005
SWEP.Spread = .0285
SWEP.AimAddMul = 40
SWEP.SprintAddMul = 30
SWEP.BarrelLength = 10
SWEP.AllowAdditionalShot = 0
SWEP.ReloadSpeedTime = 1
SWEP.DeploySpeedTime = 2.5
SWEP.RealDeploySpeedTime = 2.2
SWEP.IndividualLoadTime = 1.2
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.FireSound = "snd_jack_hmcd_sht_close.wav"
SWEP.FarFireSound = "snd_jack_hmcd_sht_far.wav"
SWEP.SuppressedFireSound = "toz_shotgun/toz_suppressed_fp.wav"
SWEP.TacticalReloadACT = ACT_VM_RELOAD
SWEP.IndividualLoadSoundTime = 0.1
SWEP.EndOfLoadCycleSoundTime = 0.1

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "slidey",
			pos = {
				up = -2.6,
				forward = -0.89,
				right = -16.76
			},
			reverseangle = true,
			ang = {
				up = 3,
				forward = -4,
				right = 60
			},
			scale = .7,
			model = "models/cw2/attachments/9mmsuppressor.mdl",
			num = HMCD_PISTOLSUPP
		},
		["Laser"] = {
			bone = "slidey",
			pos = {
				up = -2.6,
				forward = -1.58,
				right = -13.5
			},
			reverseangle = true,
			ang = {
				up = 90
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
				up = 1,
				forward = 0.5
			},
			ang = {
				forward = 180,
				right = 0,
				up = 90
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 12.6,
				up = -2.1,
				right = 1.5
			},
			ang = {
				right = 280,
				up = 84,
				forward = 102
			},
			scale = .9,
			model = "models/cw2/attachments/9mmsuppressor.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 8.9,
				up = -2.1,
				right = 1.6
			},
			ang = {
				right = 180,
				up = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
		}
	}
}