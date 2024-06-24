--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_spas.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_spas"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_spas12_bri.mdl"
ENT.DefaultAmmoAmt = 8
ENT.AmmoType = "Buckshot"
ENT.ShellEffect = "eff_jack_hmcd_12gauge"
ENT.NumProjectiles = 8
ENT.TriggerDelay = .25
ENT.Damage = 15
ENT.MuzzlePos = Vector(28, -0.5, 1)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(4.5, 1, 1)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.Spread = .0285
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 6.6,
			up = 2.4,
			right = -1.7
		},
		scale = .7,
		model = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl"
	}
}