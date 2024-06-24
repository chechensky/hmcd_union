--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_m249.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_m249"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_m249.mdl"
ENT.DefaultAmmoAmt = 200
ENT.AmmoType = "SMG1"
ENT.MuzzlePos = Vector(25.7, 0, 3.8)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(4, 0, 3.4)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.Damage = 90
ENT.ShellEffect = "eff_jack_hmcd_556"
ENT.ShellEffect2 = "eff_jack_hmcd_m249link"
ENT.TriggerDelay = .031
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"
ENT.Automatic = true

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 8,
			up = 6.7,
			right = 0
		},
		ang = {
			right = 180,
			up = -90
		},
		model = "models/cw2/attachments/556suppressor.mdl"
	},
	["Laser"] = {
		bone = "W_M249_LID",
		pos = {
			forward = 0.1,
			up = 0.5,
			right = -4
		},
		ang = {
			up = 90
		},
		scale = .9,
		model = "models/cw2/attachments/anpeq15.mdl"
	},
	["Sight"] = {
		bone = "W_M249_LID",
		pos = {
			forward = 0,
			up = 0.6,
			right = -5
		},
		ang = {
			up = -90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
	},
	["Sight2"] = {
		bone = "W_M249_LID",
		pos = {
			forward = 0,
			up = 0.6,
			right = -5
		},
		ang = {
			up = -90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
	},
	["Sight3"] = {
		bone = "W_M249_LID",
		pos = {
			forward = 0,
			up = 0.6,
			right = -5
		},
		ang = {
			up = -90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
	}
}