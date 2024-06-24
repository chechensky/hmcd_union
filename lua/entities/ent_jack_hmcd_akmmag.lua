--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_akmmag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "30-round AKM Magazine"
ENT.ImpactSound = "weapon_impact_soft3.wav"
ENT.Model = "models/btk/nam_akmmag.mdl"

ENT.Bodygroups = {1}

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end