--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_mp5.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_mp5"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_mp5a4.mdl"
ENT.DefaultAmmoAmt = 30
ENT.AmmoType = "Pistol"
ENT.MuzzlePos = Vector(16.5, 0, 3.5)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(3.6, 0.5, 4.4)
ENT.BulletEjectDir = Vector(0, -1, 0)
ENT.Damage = 30
ENT.ShellEffect = "eff_jack_hmcd_919"
ENT.TriggerDelay = .06
ENT.Automatic = true

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ATTACH_Muzzle",
		pos = {
			forward = 20,
			up = 3.53,
			right = -1.25
		},
		ang = {
			forward = 90,
			up = -90
		},
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	}
}