--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_shotgun.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_shotgun"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_shot_m3juper90.mdl"
ENT.DefaultAmmoAmt = 6
ENT.AmmoType = "Buckshot"
ENT.ShellEffect = "eff_jack_hmcd_12gauge"
ENT.NumProjectiles = 8
ENT.TriggerDelay = .9
ENT.Damage = 15
ENT.MuzzlePos = Vector(28, 0, 4.8)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(9, 0, 4.8)
ENT.BulletEjectDir = Vector(0, -1, 0)
ENT.Spread = .0285
ENT.ShellDelay = .45
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 7.6,
			up = 6.1,
			right = -1.3
		},
		scale = .7,
		model = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl"
	},
	["Laser"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 9.5,
			up = 5.7,
			right = 0.25
		},
		ang = {
			up = 180
		},
		model = "models/cw2/attachments/anpeq15.mdl"
	},
	["Sight"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 9.5,
			up = 5.7,
			right = 0.1
		},
		model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
	},
	["Sight2"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 9,
			up = 6,
			right = 0.2
		},
		model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
	},
	["Sight3"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 9,
			up = 5.7,
			right = 0.1
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
	}
}