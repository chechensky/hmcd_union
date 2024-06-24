--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_sr25.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_sr25"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_sr25_ins2_eft.mdl"

ENT.PhysicsBox = {Vector(-15, -1, -5), Vector(30, 1, 5)}

ENT.CollisionBounds = {Vector(-15, -1, -5), Vector(30, 1, 5)}

ENT.DefaultAmmoAmt = 20
ENT.AmmoType = "AR2"
ENT.MuzzlePos = Vector(29, 0.05, 3.6)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(3.5, 0.8, 3.8)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.Damage = 115
ENT.ShellEffect = "eff_jack_hmcd_76251"
ENT.TriggerDelay = .2
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 2,
			up = 0,
			right = 0.4
		},
		ang = {
			right = -2,
			up = 5
		},
		model = "models/weapons/upgrades/w_sr25_silencer.mdl"
	},
	["Laser"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 17.5,
			up = 3.75,
			right = 1
		},
		ang = {
			forward = 90,
			up = 180
		},
		scale = .9,
		model = "models/cw2/attachments/anpeq15.mdl"
	},
	["Sight"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 2,
			up = 4.6,
			right = 0
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
	},
	["Sight2"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 2,
			up = 5,
			right = 0
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
	},
	["Sight3"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 5,
			up = 5,
			right = 0
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
	},
	["Romeo8T"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 3,
			up = 5,
			right = 0
		},
		ang = {
			forward = 0
		},
		model = "models/weapons/arc9/darsu_eft/mods/scope_all_sig_romeo_8t.mdl"
	}
}