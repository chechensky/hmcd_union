SWEP.Base = "hmcd_weapon_base"
SWEP.PrintName = "BASE AKM"
SWEP.Instructions = "This is a typical civilian pump-action hunting shotgun. It has a 6-round magazine and fires 12-guage 2-3/4 inch cartridges. \n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."

SWEP.RecoilForce = {2, 2}

SWEP.InAirRecoilForce = {0.2, 0.0}

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/btk/v_nam_akm.mdl"
SWEP.WorldModel = "models/btk/w_nam_akm.mdl"
SWEP.AdminOnly = true
SWEP.CarryWeight = 3600
SWEP.Category="HMCD: Union - Rifles"
SWEP.IronPos = Vector(-1.95, -1.5, 1.1)
SWEP.SprintAngle = Angle(-15, 45, -10)
SWEP.SprintPos = Vector(5, -5, -1.2)
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.ClipSize = 30
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
			bone = "Weapon",
			pos = {
				up = 0.5,
				forward = 0,
				right = 17.1
			},
			ang = {
				up = -90
			},
			scale = .7,
			model = "models/weapons/upgrades/a_suppressor_ak.mdl",
			num = HMCD_PBS
		},
		["Sight"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0,
				up = 2.75
			},
			ang = {
				up = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				up = 3.6,
				forward = 0;
				right = 15.6
			},
			sightang = {
				up = 90,
				right = 180
			},
			num = HMCD_KOBRA
		},
		["Sight2"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0,
				up = 2.75
			},
			ang = {
				up = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				up = 3.6,
				forward = 0;
				right = 15.6
			},
			sightang = {
				up = 90,
				right = 180
			},
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0,
				up = 2.75
			},
			ang = {
				up = -90
			},
			scale = .8,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				up = 3.6,
				forward = 0;
				right = 15.6
			},
			sightang = {
				up = 90,
				right = 180
			},
			num = HMCD_EOTECH
		},
		["Rail"] = {
			bone = "Weapon",
			pos = {
				right = -2.5,
				forward = -0.25,
				up = 1
			},
			model = "models/wystan/attachments/akrailmount.mdl",
			material = "models/wystan/attachments/akrail/newscope"
		},
		["Laser"] = {
			bone = "Weapon",
			pos = {
				right = -2,
				forward = 0.1,
				up = 2.7
			},
			ang = {
				up = -90
			},
			model = "models/cw2/attachments/anpeq15.mdl",
			scale = .5,
			num = HMCD_LASERBIG
		},
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				forward = 4,
				up = 1
			},
			ang = {
				forward = 180,
				right = 0
			}
		},
		["Suppressor"] = {
			pos = {
				right = 1,
				forward = 30,
				up = -7.55
			},
			ang = {
				right = 180,
				up = 180,
				forward = 270
			},
			scale = .9,
			model = "models/weapons/upgrades/a_suppressor_ak.mdl"
		},
		["Rail"] = {
			pos = {
				forward = 7,
				up = -4.55,
				right = 0.8
			},
			ang = {
				right = -10,
				up = -90,
				forward = 180
			},
			model = "models/wystan/attachments/akrailmount.mdl",
			material = "models/wystan/attachments/akrail/newscope"
		},
		["Sight"] = {
			pos = {
				forward = 7.5,
				up = -6.35,
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
				forward = 7.5,
				up = -6.5,
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
				forward = 7.5,
				up = -6.5,
				right = 1
			},
			ang = {
				right = -10,
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 7.5,
				up = -6.3,
				right = 1.25
			},
			ang = {
				right = -10,
				forward = 180
			},
			model = "models/cw2/attachments/anpeq15.mdl"
		}
	}
}