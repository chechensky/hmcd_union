--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_fakepistol.lua

--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.PrintName		= "Fake Pistol"
ENT.SWEP="wep_jack_hmcd_fakepistol"
ENT.ImpactSound="physics/metal/weapon_impact_soft3.wav"
ENT.Model="models/weapons/w_matt_mattpx4v1.mdl"
ENT.AmmoType="fake"
ENT.DefaultAmmoAmt=10
ENT.Damage=0
ENT.MuzzlePos=Vector(0.4,9.5,4)
ENT.BulletDir=Vector(0,1,0)
ENT.AngleOffset=Angle(3,0,10)