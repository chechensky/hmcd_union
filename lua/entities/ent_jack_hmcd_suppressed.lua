--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_suppressed.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_suppressed"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_p99.mdl"
ENT.DefaultAmmoAmt = 10
ENT.AmmoType = "AlyxGun"
ENT.MuzzlePos = Vector(6, 0, 2.2)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(1.5, 0, 2.5)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.Damage = 10
ENT.ShellEffect = "eff_jack_hmcd_22"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "W_M9",
		pos = {
			forward = 0,
			up = 3.7,
			right = 7.9
		},
		ang = {
			forward = 180
		},
		scale = .9,
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	},
	["Laser"] = {
		bone = "W_M9",
		pos = {
			forward = 0,
			up = 1.2,
			right = 3.6
		},
		ang = {
			up = 270
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
	}
}