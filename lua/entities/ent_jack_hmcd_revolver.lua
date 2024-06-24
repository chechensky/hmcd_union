--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_revolver.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_revolver"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_pist_jeagle.mdl"
ENT.DefaultAmmoAmt = 6
ENT.AmmoType = "357"

ENT.Attachments = {
	["Suppressor"] = {
		bone = "ValveBiped.flash",
		pos = {
			forward = 17.1,
			up = 4.1,
			right = -1.7
		},
		ang = {
			forward = 90,
			up = 270
		},
		scale = .9,
		model = "models/cw2/attachments/9mmsuppressor.mdl"
	}
}

ENT.MuzzlePos = Vector(14, -.75, 4)
ENT.BulletEjectPos = Vector(7, -.75, 3.5)
ENT.BulletDir = Vector(1, 0, 0)
ENT.Damage = 40
ENT.TriggerDelay = .175