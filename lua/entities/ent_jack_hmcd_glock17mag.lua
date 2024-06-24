--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_glock17mag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "17-Round Glock-17 Magazine"
ENT.ImpactSound = "weapon_impact_soft3.wav"
ENT.Model = "models/sirgibs/kf2/glock18c_magazine_17.mdl"

ENT.Bodygroups = {
	[0] = 1
}

ENT.Mass = 5

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end