--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_mauserstripper.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Mauser Kar98k Stripper"
ENT.ImpactSound = "weapon_impact_soft3.wav"
ENT.Model = "models/red orchestra 2/germans/weapons/c96 stripper.mdl"

ENT.Bodygroups = {1}

ENT.Mass = 3

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end