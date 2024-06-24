--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_flashbang.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Grenade"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/weapons/w_m84.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
		end

		--self.Detonated=false
		--self.Armed=false
		--self.Rigged=false
		self.Grenade = true
	end

	function ENT:Use(ply)
	end

	--
	function ENT:Think()
		if self.Armed and (self.DetTime < CurTime()) then
			self:Detonate()
			self.Detonated = true
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:Arm()
		if self.Armed then return end
		self.Armed = true
		constraint.RemoveAll(self)

		if not self.SpawnedSpoon then
			sound.Play("weapons/m67/m67_spooneject.wav", self:GetPos(), 65, 100)
			local Spoon = ents.Create("prop_physics")
			Spoon.HmcdSpawned = self.HmcdSpawned
			Spoon:SetModel("models/codww2/equipment/mk,ii hand grenade spoon.mdl")
			Spoon:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			Spoon:SetPos(self:GetPos() + VectorRand())
			Spoon:SetAngles(self:GetAngles())
			Spoon:SetMaterial("models/shiny")
			Spoon:SetColor(Color(50, 40, 0))
			Spoon.Huy = false
			Spoon:Spawn()
			Spoon:Activate()
		end

		--Spoon:GetPhysicsObject():SetMaterial("metal_bouncy")
		--Spoon:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity()+VectorRand()*1)
		self.DetTime = CurTime() + 2

		if self.SpawnedSpoon and self.TimeLeft then
			self.DetTime = CurTime() + self.TimeLeft
		end

		if self.TimeLeft == nil and self.SpawnedSpoon ~= nil then
			self.DetTime = CurTime()
		end

		self:SetNWFloat("DetTime", self.DetTime - CurTime())
	end

	function ENT:Detonate()
		if self.Detonated then return end
		local Pos, Ground, Attacker = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 5), self:NearGround(), self.Owner
		ParticleEffect("ins_flashbang_explosion", Pos, vector_up:Angle())

		timer.Simple(.01, function()
			self:EmitSound("weapons/m84/m84_detonate_dist.wav", 140, 100)
		end)

		timer.Simple(.02, function()
			self:EmitSound("weapons/m84/m84_detonate.wav", 80, 100)
			self:Remove()
		end)

		for i, ply in ipairs(player.GetAll()) do
			if ply:Alive() then
				local ringMul, blindMul

				if ply:Visible(self) then
					blindMul = 1
					local TrueVec = (self:GetPos() - ply:GetPos()):GetNormalized()
					local LookVec = ply:GetAimVector()
					local DotProduct = LookVec:DotProduct(TrueVec)
					local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90
					blindMul = blindMul * 180 / ApproachAngle
					ringMul = 20
				else
					local dir = (self:GetPos() - ply:GetPos()):GetNormalized()

					local tr = util.QuickTrace(ply:GetShootPos(), self:GetPos() - ply:GetPos(), {ply, self})

					local MaxDist, SearchPos, SearchDist = 20, tr.HitPos, 5

					while SearchDist < MaxDist do
						SearchPos = SearchPos + dir * SearchDist
						local PeneTrace = util.QuickTrace(SearchPos, -dir * SearchDist)

						if not PeneTrace.StartSolid then
							break
						else
							SearchDist = SearchDist + 5
						end
					end

					ringMul = 20 - SearchDist
				end

				local dist = ply:GetPos():Distance(self:GetPos())

				if ringMul > 0 then
					ringMul = math.Round(math.Clamp(ringMul * math.Clamp(100 / dist, 0, 1), 0, 40))
				end

				if blindMul then
					blindMul = math.Round(math.Clamp(blindMul * math.Clamp(200 / dist, 0, 5), 0, 15))
				end
				--[[if ringMul > 0 or (blindMul and blindMul > 0) then
					net.Start("hmcd_blind")
					net.WriteEntity(ply)
					net.WriteInt(blindMul or 0, 5)
					net.WriteInt(ringMul, 7)
					net.Send(player.GetAll())
				end]]
			end
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .1 then
			self:EmitSound("Grenade.ImpactHard")
			self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity() * .9)
		end
	end

	function ENT:StartTouch(ply)
	end
	--
elseif CLIENT then
	function ENT:Initialize()
		self.TimerStarted = false
	end

	function ENT:Draw()
		self:DrawModel()
	end

	local lastknownpos

	function ENT:Think()
		local detTime

		if not self.TimerStarted then
			detTime = self:GetNWFloat("DetTime", -1)
		else
			lastknownpos = self:GetPos()
		end

		if detTime ~= -1 and not self.TimerStarted then
			self.TimerStarted = true

			timer.Simple(detTime, function()
				local dlight = DynamicLight(self:EntIndex())

				if dlight then
					dlight.pos = lastknownpos
					dlight.r = 255
					dlight.g = 255
					dlight.b = 255
					dlight.brightness = 10
					dlight.Decay = 1000
					dlight.Size = 384
					dlight.DieTime = CurTime() + 5
				end
			end)
		end
	end

	function ENT:OnRemove()
	end
end
--