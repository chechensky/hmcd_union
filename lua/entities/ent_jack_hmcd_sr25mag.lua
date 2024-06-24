--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_sr25mag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "10-round SR-25 Magazine"
ENT.ImpactSound = "weapon_impact_soft" .. math.random(1, 3) .. ".wav"
ENT.Model = "models/kali/weapons/10rd m14 magazine.mdl"

ENT.Bodygroups = {1}

ENT.Mass = 5

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end