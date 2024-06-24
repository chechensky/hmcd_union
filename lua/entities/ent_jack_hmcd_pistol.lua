--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_pistol.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_pistol"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_matt_mattpx4v1.mdl"
ENT.DefaultAmmoAmt = 13
ENT.AmmoType = "Pistol"
ENT.MuzzlePos = Vector(0.4, 9.5, 4)
ENT.BulletDir = Vector(0, 1, 0)
ENT.AngleOffset = Angle(3, 0, 10)
ENT.BulletEjectPos = Vector(1.1, 5.5, 4.5)
ENT.BulletEjectDir = Vector(-1, 0, 0)
ENT.Damage = 30
ENT.ShellEffect = "eff_jack_hmcd_919"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "flash",
		pos = {
			forward = 0.5,
			up = 3,
			right = 12.8
		},
		ang = {
			forward = 190
		},
		scale = .9,
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	},
	["Laser"] = {
		bone = "flash",
		pos = {
			forward = 0.5,
			up = 1.7,
			right = 8.4
		},
		ang = {
			forward = 10,
			up = 270
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
	}
}