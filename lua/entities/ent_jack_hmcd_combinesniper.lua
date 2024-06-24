--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_combinesniper.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_combinesniper"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/w_models/combine_sniper_test.mdl"
ENT.DefaultAmmoAmt = 5
ENT.AmmoType = "Gravity"
ENT.MuzzlePos = Vector(31.25, 0, 1.25)
ENT.BulletDir = Vector(1, 0, 0)
ENT.Damage = 150
ENT.TriggerDelay = .25
ENT.MuzzleEffect = "new_ar2_muzzle"