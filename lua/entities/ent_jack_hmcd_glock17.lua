--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_glock17.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_glock17"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_glock_p80.mdl"
ENT.DefaultAmmoAmt = 17
ENT.AmmoType = "Pistol"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "A_Suppressor",
		pos = {
			forward = 10.2,
			up = 2.3,
			right = 0
		},
		ang = {
			up = 90,
			forward = 180
		},
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	},
	["Laser"] = {
		bone = "A_Underbarrel",
		pos = {
			forward = 5,
			up = 0,
			right = -0.2
		},
		ang = {
			forward = 10
		},
		scale = .9,
		model = "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl"
	},
	["Walther_Mrs"] = {
		bone = "A_Underbarrel",
		pos = {
			forward = 5,
			up = 0,
			right = -0.2
		},
		ang = {
			forward = 10
		},
		scale = .9,
		model = "models/weapons/arc9/darsu_eft/mods/scope_all_walther_mrs.mdl"
	}
}

ENT.MuzzlePos = Vector(7, .2, 1)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(2, 1.5, 1.5)
ENT.BulletEjectDir = Vector(0, -1, 0)
ENT.ShellEffect = "eff_jack_hmcd_919"
ENT.Damage = 30