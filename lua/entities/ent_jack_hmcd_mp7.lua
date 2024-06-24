--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_mp7.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_mp7"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_mp7.mdl"
ENT.DefaultAmmoAmt = 40
ENT.AmmoType = "HelicopterGun"
ENT.MuzzlePos = Vector(10.4, 0, 1.3)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(-1, 1.5, 1.3)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.Damage = 45
ENT.ShellEffect = "eff_jack_hmcd_46"
ENT.TriggerDelay = .031
ENT.Automatic = true

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 13,
			up = 1.3,
			right = -1.2
		},
		ang = {
			forward = 90,
			up = -90
		},
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	},
	["Laser"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 5,
			up = 1.2,
			right = -0.7
		},
		ang = {
			forward = 90
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
	},
	["Sight"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 0,
			up = 3.3,
			right = 0
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
	},
	["Sight2"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 0,
			up = 3.3,
			right = 0
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
	},
	["Sight3"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 0,
			up = 3.3,
			right = 0
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
	}
}