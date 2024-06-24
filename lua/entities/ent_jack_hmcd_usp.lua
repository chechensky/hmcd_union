--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_usp.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_usp"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_usp_match.mdl"
ENT.DefaultAmmoAmt = 18
ENT.AmmoType = "Pistol"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 0,
			up = 0,
			right = 0
		},
		model = "models/weapons/tfa_ins2/upgrades/usp_match/w_suppressor_pistol.mdl"
	},
	["Laser"] = {
		bone = "ATTACH_Laser",
		pos = {
			forward = 4.5,
			up = 0.7,
			right = 0.3
		},
		model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
	}
}

ENT.MuzzlePos = Vector(7, .2, 2.4)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(2, 1.5, 1.5)
ENT.BulletEjectDir = Vector(0, -1, 0)
ENT.ShellEffect = "eff_jack_hmcd_919"
ENT.Damage = 30