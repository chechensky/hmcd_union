--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_remington.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_remington"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/smc/r870/w_remington_m870.mdl"
ENT.DefaultAmmoAmt = 6
ENT.AmmoType = "Hornet"
ENT.MuzzlePos = Vector(29.5, -0.4, 1.1)
ENT.BulletDir = Vector(1, 0, 0)
ENT.BulletEjectPos = Vector(6.5, 0, 1.1)
ENT.BulletEjectDir = Vector(0, 1, 0)
ENT.Damage = 6
ENT.ShellEffect = "eff_jack_hmcd_beanbag"
ENT.ShellDelay = .45
ENT.TriggerDelay = .9
ENT.MuzzleEffect = ""