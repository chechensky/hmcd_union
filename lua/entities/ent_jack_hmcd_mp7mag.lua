--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_mp7mag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "40-Round MP7 Magazine"
ENT.ImpactSound = "weapon_impact_soft1.wav"
ENT.Model = "models/eu_homicide/mp7_magazine.mdl"

ENT.Bodygroups = {
	[0] = 1
}

ENT.Color = Color(0, 0, 0, 255)

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end