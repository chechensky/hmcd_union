--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_grapl.lua

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
		self.Entity:SetMaterial("models/shiny")
		self.Entity:SetColor(Color(10, 10, 10, 255))
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:PhysicsInitBox(Vector(-4, -4, -4), Vector(4, 4, 4))
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		self.Entity:DrawShadow(true)
		self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
		self.Entity:UseTriggerBounds(true, 24)
		local phys = self.Entity:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(20)
			phys:SetMaterial("concrete")
			phys:SetDragCoefficient(0)
		end

		self.Stillness = 0
		self.Locked = false
		self.Stopped = false
		self.Entity:SetUseType(SIMPLE_USE)
		self:SetNWBool("Impacted", false)
		self:SetModelScale(1, 0)
	end

	function ENT:PhysicsCollide(data, physobj)
		if (data.Speed > 20) and (data.DeltaTime > .15) then
			self:SetNWBool("Impacted", true)

			if data.Speed > 300 then
				sound.Play("snds_jack_hmcd_grapple/hard.wav", self:GetPos(), 70, math.random(90, 110))
			else
				sound.Play("snds_jack_hmcd_grapple/soft.wav", self:GetPos(), 65, math.random(90, 110))
			end
		end
	end

	function ENT:StartTouch(activator)
	end

	--
	function ENT:OnTakeDamage(dmginfo)
		self.Entity:TakePhysicsDamage(dmginfo)
	end

	function ENT:PhysicsUpdate()
		if (self:GetCollisionGroup() == COLLISION_GROUP_NONE) and self:GetVelocity():LengthSqr() < 1 then
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		elseif (self:GetCollisionGroup() == COLLISION_GROUP_WEAPON) and self:GetVelocity():LengthSqr() >= 1 then
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
		end
	end

	function ENT:Think()
		if not self.Locked then
			if self.Rope and IsValid(self.Rope) and not self.Stopped then
				local Tr = util.TraceLine({
					start = self:GetPos(),
					endpos = self.Rope:GetPos(),
					filter = {self, self.Rope, self.Rope.Owner}
				})

				if Tr.Hit then
					self.Stopped = true
					self.Rope:PullTaut()
					--self:GetPhysicsObject():SetVelocity(self.Rope.Owner:GetVelocity()-self:GetPhysicsObject():GetVelocity()*.1)
				end
			end

			local Vel, Ent = self:GetRelativeVelocity()

			if Vel <= 1 then
				self.Stillness = self.Stillness + 1

				if self.Stillness >= 7 then
					self.Locked = true
					self:LockToSurface(Ent)
				end
			else
				self.Stillness = 0
			end

			self:NextThink(CurTime() + .25)

			return true
		end
	end

	function ENT:LockToSurface(ent)
		local constr = constraint.Weld(self, ent, 0, 0, 0, true, false)
		constr.PickupAble = true
		sound.Play("snds_jack_hmcd_grapple/lock.wav", self:GetPos(), 75, 100)
	end

	function ENT:OnRemove()
	end

	--aw fuck you
	function ENT:Use(activator)
		if GAMEMODE.ZOMBIE and activator.Murderer then return end

		if not IsValid(self.Rope) and activator:IsPlayer() then
			self.Stillness = 0
			self.Locked = false
			constraint.RemoveAll(self)

			if not activator:HasWeapon("wep_jack_hmcd_grapl") then
				activator:Give("wep_jack_hmcd_grapl")
				activator:GetWeapon("wep_jack_hmcd_grapl").HmcdSpawned = self.HmcdSpawned
				activator:SelectWeapon("wep_jack_hmcd_grapl")
				self:Remove()
			end
		end
	end

	function ENT:GetRelativeVelocity()
		local SelfPos = self:GetPos()

		for i = 1, 50 do
			local TrDat = {
				start = SelfPos,
				endpos = SelfPos + VectorRand() * 30,
				filter = {self}
			}

			local Tr = util.TraceLine(TrDat)

			if Tr.Hit and not Tr.HitSky then
				if IsValid(Tr.Entity:GetPhysicsObject()) then return (self:GetPhysicsObject():GetVelocity() - Tr.Entity:GetPhysicsObject():GetVelocity()):Length(), Tr.Entity end
			end
		end

		return 100, nil
	end
elseif CLIENT then
	function ENT:Initialize()
	end

	--hurr
	function ENT:Draw()
		if self.DatWorldModel then
			local Vel, Ang = self:GetVelocity(), self:GetAngles()

			if Vel:Length() > 200 then
				Ang = Vel:Angle()

				if self:GetNWBool("Impacted") then
					Ang:RotateAroundAxis(Ang:Right(), 90)
				else
					Ang:RotateAroundAxis(Ang:Right(), -90)
				end
			end

			self.DatWorldModel:SetRenderOrigin(self:GetPos())
			self.DatWorldModel:SetRenderAngles(Ang)
			self.DatWorldModel:DrawModel()
		else
			self.DatWorldModel = ClientsideModel("models/weapons/c_models/c_grappling_hook/c_grappling_hook.mdl")
			self.DatWorldModel:SetMaterial("models/shiny")
			self.DatWorldModel:SetColor(Color(10, 10, 10, 255))
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
		end
		-- self.Entity:DrawModel()
	end

	function ENT:OnRemove()
	end
end
--fuck you kid you're a dick