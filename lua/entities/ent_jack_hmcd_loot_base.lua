--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_loot_base.lua

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
ENT.Model = "models/weapons/w_pist_usp.mdl"

if SERVER then
	ENT.ImpactSound = "Drywall.ImpactHard"

	function ENT:Initialize()
		self.Entity:SetModel(self.Model)

		if self.Bodygroups then
			for i, val in pairs(self.Bodygroups) do
				self:SetBodygroup(i, val)
			end
		end

		if self.Material then
			self.Entity:SetMaterial(self.Material)
		end

		if self.Scale then
			self.Entity:SetModelScale(self.Scale, 0)
		end

		if self.Color then
			self.Entity:SetColor(self.Color)
		end

		if self.Skin then
			self.Entity:SetSkin(self.Skin)
		end

		if self.Sequence then
			self:SetSequence(self.Sequence)
		end

		if self.CollisionBounds then
			self:SetCollisionBounds(self.CollisionBounds[1], self.CollisionBounds[2])
		end

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(self.CollisionGroup or COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(self.Mass or 20)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:Use(ply)
		if self.ContactPoisoned then
			if ply.Role == "Traitor" then
				ply:PrintMessage(HUD_PRINTTALK, "This is poisoned!")

				return
			else
				self.ContactPoisoned = false
				HMCD_Poison(ply, self.Poisoner, "VX")
			end
		end

		local Constraints = constraint.GetTable(self)

		for i, constr in pairs(Constraints) do
			if (constr.Ent1:IsWorld() or constr.Ent2:IsWorld()) and not constr.Constraint.PickupAble then return end
		end

		if IsValid(self.Owner) and self.Owner:Alive() and not (self.Owner.Unconscious or #constraint.GetTable(self) == 0) then return end
		self.Touched = true
		self:PickUp(ply)
	end

	function ENT:Think()
		if self.GameSpawned and not self.Touched then
			if not self.Untouched then
				self.Untouched = 0
			end

			local Near, Pos, MaxDist = false, self:GetPos(), 500

			if GAMEMODE.SHTF then
				MaxDist = 1000
			end

			for key, found in pairs(team.GetPlayers(2)) do
				if found:Alive() and ((found:GetPos() - Pos):Length() < MaxDist) then
					Near = true
					break
				end
			end

			if Near then
				self.Untouched = 0
			else
				self.Untouched = self.Untouched + 1
			end

			if self.Untouched > 10 then
				self:Remove()

				return
			end
		end

		self:NextThink(CurTime() + 5)

		return true
	end

	function ENT:PhysicsCollide(data, ent)
		if data.DeltaTime > .1 then
			self:EmitSound(self.ImpactSound, math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))

			if self.SecondSound then
				sound.Play(self.SecondSound, self:GetPos(), math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))
			end

			self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity() * .9)
		end
	end
elseif CLIENT then
	function ENT:Initialize()
	end

	--
	function ENT:Draw()
		self:DrawModel()
	end
end