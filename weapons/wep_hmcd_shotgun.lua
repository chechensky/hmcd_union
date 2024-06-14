--shotgun
SWEP.Base = "hmcd_weapon_base"
SWEP.PrintName = "BASE Remington 870"
SWEP.Instructions = "This is a typical civilian pump-action hunting shotgun. It has a 6-round magazine and fires 12-guage 2-3/4 inch cartridges. \n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."

SWEP.RecoilForce = {2, 2}

SWEP.InAirRecoilForce = {0.2, 0.0}

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_shot_m3juper90.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3juper90.mdl"
SWEP.AdminOnly = true
SWEP.CarryWeight = 3600
SWEP.Category="HMCD: Union - Shotguns"
SWEP.IronPos = Vector(-1.95, -1.5, 1.1)
SWEP.SprintAngle = Angle(-15, 45, -10)
SWEP.SprintPos = Vector(5, -5, -1.2)
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.Damage = 13
SWEP.DamageVar = 16
SWEP.Delay = 0.9
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
SWEP.CycleType = "manual"
SWEP.ReloadType = "individual"
SWEP.HoldAnim = "shotgun"
SWEP.HoldAimAnim = "ar2"
SWEP.PassiveHoldAnim = "passive"
SWEP.IndividualLoadSound = "snd_jack_shotguninsert.wav"
SWEP.CycleSound = "snd_jack_hmcd_shotpump.wav"
SWEP.FireSound = "snd_jack_hmcd_sht_close.wav"
SWEP.FarFireSound = "snd_jack_hmcd_sht_far.wav"
SWEP.IndividualLoadVACT = "insert"
SWEP.IndividualLoadStartVACT = "start_reload"
SWEP.IndividualLoadEndVACT = "after_reload"
SWEP.IndividualLoadSoundTime = 0.1
SWEP.EndOfLoadCycleSoundTime = 0.1

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "body",
			pos = {
				right = 2.7,
				forward = 1.03,
				up = 2.2
			},
			ang = {
				up = -90
			},
			scale = .5,
			model = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl",
			num = HMCD_SHOTGUNSUPP
		},
		["Laser"] = {
			bone = "body",
			pos = {
				right = 5.2,
				forward = 0.1,
				up = 1.7
			},
			ang = {
				up = -90
			},
			scale = .5,
			model = "models/cw2/attachments/anpeq15.mdl",
			num = HMCD_LASERBIG
		},
		["Sight"] = {
			bone = "body",
			pos = {
				right = 5,
				forward = 0,
				up = 1.7
			},
			ang = {
				up = 90
			},
			scale = .5,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				right = 20,
				forward = 0,
				up = 2.4
			},
			sightang = {
				up = -90
			},
			num = HMCD_KOBRA
		},
		["Sight2"] = {
			bone = "body",
			pos = {
				right = 4.5,
				forward = 0,
				up = 1.8
			},
			ang = {
				up = 90
			},
			scale = .5,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				right = 15,
				forward = 0,
				up = 2.53
			},
			sightang = {
				up = -90
			},
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "body",
			pos = {
				right = 6,
				forward = 0,
				up = 1.8
			},
			ang = {
				up = 90
			},
			scale = .5,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				right = 20,
				forward = 0,
				up = 2.53
			},
			sightang = {
				up = -90
			},
			num = HMCD_EOTECH
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
				right = 0
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 6.4,
				up = -6.3,
				right = 2.4
			},
			ang = {
				right = 0,
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 7.8,
				up = -6.3,
				right = 1.4
			},
			ang = {
				right = 0,
				forward = 180
			},
			model = "models/cw2/attachments/anpeq15.mdl"
		},
		["Sight"] = {
			pos = {
				forward = 7.8,
				up = -6.3,
				right = 0.9
			},
			ang = {
				right = 0,
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
		},
		["Sight2"] = {
			pos = {
				forward = 7.8,
				up = -6.3,
				right = 0.9
			},
			ang = {
				right = 0,
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
		},
		["Sight"] = {
			pos = {
				forward = 7.8,
				up = -6.3,
				right = 0.9
			},
			ang = {
				right = 0,
				forward = 180
			},
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		}
	}
}