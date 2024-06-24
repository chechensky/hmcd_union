--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_present.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Gift Box"
ENT.Model = "models/items/cs_gift.mdl"

if SERVER then
	function ENT:PickUp(ply)
		if math.random(1, 100) ~= 1 then
			local edata = EffectData()
			edata:SetStart(self:GetPos())
			edata:SetOrigin(self:GetPos())
			edata:SetNormal(self:GetPos():GetNormalized())
			edata:SetEntity(self)
			edata:SetRadius(10)
			util.Effect("balloon_pop", edata, true, true)
			GAMEMODE:SpawnLoot(self:GetPos(), false, true)
			self:Remove()
			ply:AddMerit(1)
		else
			self.IEDAttacker = ply
			self:ExplodeIED()
		end
	end
end