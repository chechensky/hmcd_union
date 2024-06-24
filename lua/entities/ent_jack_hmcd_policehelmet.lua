--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_policehelmet.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_eq_base"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.Model = "models/eu_homicide/helmet.mdl"
ENT.EquipmentNum = HMCD_POLHELMET
ENT.Armor = "RiotHelm"
ENT.ArmorType = "Helmet"

ENT.UseFunc = function(ent, ply)
	if ply.Role == "police" or ply.Role == "riotpolice" then
		if string.find(ply:GetModel(), "_2") then
			ply:SetBodygroup(1, 7)
		else
			ply:SetBodygroup(1, 5)
		end
	end
end