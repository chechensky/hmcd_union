--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_zipline.lua

--]]
ENT.Type = "anim"
ENT.PrintName = "Grappling Hook"
-- This was imported from BFS2114
ENT.Author = "Jackarunda"
ENT.Category = ""
ENT.Information = "BLOOIE-SCHLANG"
ENT.Spawnable = false
ENT.AdminSpawnable = false
AddCSLuaFile()

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel("models/props_junk/cardboard_box004a.mdl")
		self.Entity:SetMaterial("models/hands/hands_color")
		self.Entity:SetColor(Color(0, 0, 0, 0))
		self.Entity:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		self.Entity:DrawShadow(false)
		self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		--self.Entity:UseTriggerBounds(true,24)
		local phys = self.Entity:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
			--phys:EnableGravity(false)
		end

		self.Locked = false
		self.Stopped = false
		self.Entity:SetUseType(SIMPLE_USE)
		self:SetModelScale(1, 0)
	end

	function ENT:PhysicsCollide(data, physobj)
	end

	--
	function ENT:StartTouch(activator)
	end

	--
	function ENT:OnTakeDamage(dmginfo)
		self.Entity:TakePhysicsDamage(dmginfo)
	end

	function ENT:Think()
	end

	--
	function ENT:LockToSurface(ent)
	end

	--
	function ENT:OnRemove()
	end

	--aw fuck you
	function ENT:Use(activator)
		if GAMEMODE.ZOMBIE and activator.Murderer then return end

		if not IsValid(self.Rope) and activator:IsPlayer() then
			self.Locked = false
			constraint.RemoveAll(self)
			--[[if not(activator:HasWeapon("wep_jack_hmcd_zipline"))then
				activator:Give("wep_jack_hmcd_zipline")
				activator:GetWeapon("wep_jack_hmcd_zipline").HmcdSpawned=self.HmcdSpawned
				activator:SelectWeapon("wep_jack_hmcd_zipline")
				self:Remove()
			end]]
		end
	end
elseif CLIENT then
	function ENT:Initialize()
	end

	--hurr
	function ENT:Draw()
	end

	-- self.Entity:DrawModel()
	function ENT:OnRemove()
	end
end
--fuck you kid you're a dick