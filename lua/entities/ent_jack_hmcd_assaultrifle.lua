--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_assaultrifle.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_assaultrifle"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_rif_m4a1.mdl"

ENT.Bodygroups = {
	[2] = 1,
	[8] = 2
}

ENT.DefaultAmmoAmt = 30
ENT.AmmoType = "SMG1"
ENT.MuzzlePos = Vector(15, 5, 10)
ENT.BulletDir = Vector(5, -1, 0)
ENT.BulletEjectPos = Vector(0, -5.1, 3.8)
ENT.BulletEjectDir = Vector(1, 0, 0)
ENT.Damage = 90
ENT.ShellEffect = "eff_jack_hmcd_556"
ENT.TriggerDelay = .1
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "sling_loop_front",
		pos = {
			forward = 0,
			up = 6.3,
			right = -5
		},
		ang = {
			forward = -180
		},
		scale = .9,
		model = "models/cw2/attachments/556suppressor.mdl"
	},
	["Laser"] = {
		bone = "sling_loop_front",
		pos = {
			forward = 0,
			up = 4.7,
			right = -12
		},
		ang = {
			up = -90
		},
		scale = .9,
		model = "models/cw2/attachments/anpeq15.mdl"
	},
	["Sight"] = {
		bone = "sling_loop_front",
		pos = {
			forward = 0,
			up = 4.7,
			right = -4
		},
		ang = {
			up = 90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
	},
	["Sight2"] = {
		bone = "sling_loop_front",
		pos = {
			forward = 0,
			up = 5,
			right = -4
		},
		ang = {
			up = 90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
	},
	["Sight3"] = {
		bone = "sling_loop_front",
		pos = {
			forward = 0,
			up = 5,
			right = -4
		},
		ang = {
			up = 90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
	}
}