--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_makarych.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_makarych"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_pm.mdl"
ENT.DefaultAmmoAmt = 8
ENT.AmmoType = "9mmRound"
ENT.MuzzlePos = Vector(4.5, 0, 2.1)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(0.75, 0, 2.2)
ENT.BulletEjectDir = Vector(0, -1, 0)
ENT.Damage = 4
ENT.ShellEffect = "eff_jack_hmcd_919"
ENT.MuzzleEffect = ""

ENT.Attachments = {
	["Magazine"] = {
		bone = "W_PIS_MAGAZINE",
		pos = {
			forward = -14.65,
			up = 3.35,
			right = -2.5
		},
		model = "models/weapons/tfa_ins2/upgrades/a_magazine_pm_8_phys.mdl"
	}
}