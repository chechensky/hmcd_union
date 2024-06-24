--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ptrd.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_ptrd"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/gleb/w_ptrd.mdl"
ENT.DefaultAmmoAmt = 1
ENT.AmmoType = "CombineCannon"
ENT.MuzzlePos = Vector(74.25, 0, 3.8)
ENT.BulletEjectPos = Vector(7, 0, 3.7)
ENT.BulletDir = Vector(1, 0, 0)
ENT.Damage = 600
ENT.TriggerDelay = 1
ENT.MuzzleEffect = "pcf_jack_mf_mrifle1"