--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_door.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Loot"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.IsLoot = true

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(self.Mass or 20)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end
else
	function ENT:Initialize()
		self:SetRenderBounds(self:GetCollisionBounds())
	end
end