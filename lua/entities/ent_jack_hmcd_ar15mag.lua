--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ar15mag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "30-round AR-15 Magazine"
ENT.ImpactSound = "weapon_impact_soft1.wav"
ENT.Model = "models/kali/weapons/black_ops/magazines/30rd galil magazine.mdl"

ENT.Bodygroups = {1}

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end