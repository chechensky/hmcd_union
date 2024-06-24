--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_cz75a.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_cz75a"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_cz75a.mdl"
ENT.DefaultAmmoAmt = 26
ENT.AmmoType = "Pistol"
ENT.MuzzlePos = Vector(7.4, 0, 2.3)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(1.1, 5.5, 4.5)
ENT.BulletEjectDir = Vector(0, -1, 0)
ENT.Damage = 30
ENT.ShellEffect = "eff_jack_hmcd_919"
ENT.Automatic = true

ENT.Bodygroups = {
	[0] = 1
}

ENT.TriggerDelay = .05

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 11.5,
			up = 3.45,
			right = 0
		},
		ang = {
			up = 90,
			forward = 180
		},
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	},
	["Laser"] = {
		bone = "ATTACH_Laser",
		pos = {
			forward = 3.6,
			up = 1.05,
			right = 0
		},
		scale = .7,
		model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
	}
}