--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_rifle.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_rifle"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/gleb/w_kar98k.mdl"
ENT.DefaultAmmoAmt = 5
ENT.AmmoType = "AR2"
ENT.TriggerDelay = 1.2
ENT.ShellDelay = .57
ENT.ShellEffect = "eff_jack_hmcd_76239"
ENT.Damage = 115
ENT.MuzzlePos = Vector(42, -0.2, 2.9)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(10, -0.2, 2.9)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 29.8,
			up = 2.8,
			right = -2.3
		},
		ang = {
			forward = 90,
			up = 90
		},
		scale = .7,
		model = "models/cw2/attachments/556suppressor.mdl"
	},
	["Scope"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 8.25,
			up = 4.5,
			right = -0.25
		},
		ang = {
			forward = 0,
			up = 90
		},
		scale = 1.4,
		model = "models/weapons/gleb/optic_scope_hmcd.mdl"
	}
}