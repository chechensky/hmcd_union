--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ar2.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_ar2"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_irifle_h.mdl"
ENT.DefaultAmmoAmt = 30
ENT.AmmoType = "Gravity"
ENT.MuzzlePos = Vector(-14, 0.2, 4.8)
ENT.BulletDir = Vector(-1, 0, 0)
ENT.Damage = 80
ENT.TriggerDelay = .05
ENT.Automatic = true
ENT.MuzzleEffect = "new_ar2_muzzle"