--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_px4mag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "13-round PX4 Magazine"
ENT.ImpactSound = "weapon_impact_soft" .. math.random(1, 3) .. ".wav"
ENT.Model = "models/joshzemlinsky/weapons/sof3_beretta_px4_mag.mdl"

ENT.Bodygroups = {1}

ENT.Mass = 5

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end