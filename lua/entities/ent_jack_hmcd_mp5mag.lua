--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_mp5mag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "30-Round MP5 Magazine"
ENT.ImpactSound = "weapon_impact_soft1.wav"
ENT.Model = "models/bshields/drgordon/weapons/h&k/h&k_mp5a3_30_round_9x19mm_magazine.mdl"

ENT.Bodygroups = {
	[1] = 1
}

if SERVER then
	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
end