--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_combinemine.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Combine Mine"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

if SERVER then
	local tracePoses = {vector_origin, Vector(10, 0, 0), Vector(-10, 0, 0), Vector(0, 10, 0), Vector(0, -10, 0)}

	function ENT:Initialize()
		self:SetModel("models/props_combine/combine_mine01.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		self.BoneAngles = {}
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
		end

		self.Sprite = ents.Create("env_sprite")
		self.Sprite:SetPos(self:GetPos() + self:GetAngles():Up() * 11)
		self.Sprite:SetParent(self)
		self.Sprite:SetKeyValue("model", "sprites/glow.vmt")
		self.Sprite:SetKeyValue("scale", .15)
		self.Sprite:SetKeyValue("rendermode", "5")
		self.Sprite:AddFlags(1)
		self.Sprite:Spawn()
		self:SetNWBool("StartingEnabled", self.Replacing and not self.Replacing:GetInternalVariable("StartDisarmed"))
		self.Sprite:SetKeyValue("rendercolor", "0 0 255")

		timer.Simple(5, function()
			if IsValid(self) then
				self:SetNWBool("StartingEnabled", false)
			end
		end)

		if self:GetNWBool("StartingEnabled") then
			self.NextGroundCheck = CurTime() + 1
		else
			self.NextGroundCheck = CurTime() + 2
		end

		self.Disabled = false

		if self.Replacing then
			self.Disabled = self.Replacing:GetInternalVariable("StartDisarmed")
		end

		hook.Add("GravGunOnPickedUp", self, function(ent, ply)
			if ent == self then
				self.GravHolding = true
				self.GoneOff = nil
				self.Disabled = false

				if self.TakeoffPreparing then
					self.TakeoffPreparing = nil
					self.Sprite:SetKeyValue("rendercolor", "0 0 255")
				end
			end
		end)

		hook.Add("GravGunOnDropped", self, function(ent, ply)
			if ent == self then
				self.GravHolding = nil
			end
		end)
	end

	function ENT:OnRemove()
		self.Armed = false
		self:StopSound("npc/roller/mine/combine_mine_active_loop1.wav")
	end

	function ENT:Think()
		if self.NextGroundCheck < CurTime() then
			if not (self.Armed or self.GravHolding or self.Disabled) then
				local hitWorld, hitSomething, hitTraces = false, false, {}

				for i, lpos in pairs(tracePoses) do
					local pos = self:LocalToWorld(lpos)
					local tr = util.QuickTrace(pos, self:GetAngles():Up() * -5, self)

					if tr.HitWorld then
						hitWorld = true

						table.insert(hitTraces, {lpos, tr.HitPos})
					end

					if tr.Hit then
						hitSomething = true
					end
				end

				if hitWorld then
					self.Armed = true
					self.LastEnableTime = CurTime()
					local ind = self:EntIndex()

					for i, ply in player.Iterator() do
						ply:SendLua("local ent=Entity(" .. ind .. ") if IsValid(ent) then ent:MoveLegs(1) end")
					end

					self.Sprite:SetKeyValue("rendercolor", "255 0 0")
					self.Sprite:SetKeyValue("renderamt", "0")
				elseif hitSomething then
					self.NextGroundCheck = CurTime() + 2
					self:EmitSound("npc/roller/mine/rmine_blip3.wav")
					local phys = self:GetPhysicsObject()
					phys:ApplyForceCenter(Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(.7, 1)) * 1500)
					phys:SetAngleVelocity(VectorRand() * 1000)
				else
					if math.abs(math.abs(self:GetAngles().r) - 180) < 10 then
						self:EmitSound("npc/roller/mine/rmine_blip3.wav")
						local phys = self:GetPhysicsObject()
						phys:ApplyForceCenter(Vector(0, 0, math.Rand(.7, 1)) * 1500)
						phys:SetAngleVelocity(Vector(.5, 0, 0) * 500)
					end

					self.NextGroundCheck = CurTime() + 2
				end

				for i, inf in pairs(hitTraces) do
					constraint.Weld(self, game.GetWorld(), 0, 0, 3000, false, false)
					break
				end
			end

			local parent = self:GetParent()

			if IsValid(parent) then
				local pos1 = self:GetPos()

				for i, ent in pairs(ents.GetAll()) do
					if ((ent:IsPlayer() and ent:Alive()) or (ent:IsNPC() and not NPC_RELATIONSHIPS["Combine"][ent:GetClass()])) and (ent:Visible(self) or (IsValid(ent.fakeragdoll) and ent.fakeragdoll:Visible(self))) then
						local pos2 = ent:GetPos()
						pos2.z = pos1.z

						if pos2:DistToSqr(pos1) < 40000 then
							local pos, vel = parent:GetAttachment(3).Pos, parent:GetVelocity()
							self:SetParent()
							self:SetPos(pos)
							self:SetVelocity(vel)
						end
					end
				end
			end
		end

		if self.Armed then
			if #constraint.GetTable(self) == 0 then
				self:EmitSound("npc/roller/blade_in.wav")
				self:StopSound("npc/roller/mine/combine_mine_active_loop1.wav")
				self.Armed = false
				self.Alarmed = false
				self.Sprite:SetKeyValue("rendercolor", "0 0 255")
				self.Sprite:SetKeyValue("renderamt", "255")
				local ind = self:EntIndex()

				for j, ply in player.Iterator() do
					ply:SendLua("local ent=Entity(" .. ind .. ") if IsValid(ent) then ent:MoveLegs(-1) end")
				end
			else
				local foundEnt = false

				for i, ent in pairs(ents.FindInSphere(self:GetPos(), 240)) do
					if ((ent:IsPlayer() and ent:Alive()) or (ent:IsNPC() and not NPC_RELATIONSHIPS["Combine"][ent:GetClass()])) and (ent:Visible(self) or (IsValid(ent.fakeragdoll) and ent.fakeragdoll:Visible(self))) then
						foundEnt = true

						if not self.Alarmed then
							self.Alarmed = true
							self:EmitSound("npc/roller/mine/combine_mine_deploy1.wav")
							self:EmitSound("npc/roller/mine/combine_mine_active_loop1.wav")
							self.Sprite:SetKeyValue("renderamt", "255")
						end

						if ent:GetPos():DistToSqr(self:GetPos()) <= 10000 and CurTime() - self.LastEnableTime > .5 then
							self.Alarmed = false
							self.TakeoffPreparing = true
							self.NextGroundCheck = CurTime() + 3
							self:EmitSound("npc/roller/blade_in.wav")
							local ind = self:EntIndex()

							for j, ply in player.Iterator() do
								ply:SendLua("local ent=Entity(" .. ind .. ") if IsValid(ent) then ent:MoveLegs(-1) end")
							end

							constraint.RemoveAll(self)
							self.Armed = false
							self:StopSound("npc/roller/mine/combine_mine_active_loop1.wav")
							local lastPos = ent:GetPos()

							timer.Simple(1, function()
								if IsValid(self) and not self.GravHolding then
									if IsValid(ent) then
										lastPos = ent:GetPos()
									end

									local phys = self:GetPhysicsObject()
									local length = (ent:GetPos() - self:GetPos()):Length()
									phys:ApplyForceCenter((ent:GetPos() - self:GetPos()) * 10 + vector_up * math.max(200, length) * 10)
									phys:SetAngleVelocity(VectorRand() * 500)

									timer.Simple(.3, function()
										if IsValid(self) and not self.GravHolding then
											self.GoneOff = true
										end
									end)
								end
							end)
						end
					end
				end

				if self.Alarmed and not foundEnt then
					self.Alarmed = nil
					self:StopSound("npc/roller/mine/combine_mine_active_loop1.wav")
					self:EmitSound("npc/roller/mine/combine_mine_deactivate1.wav")
					self.Sprite:SetKeyValue("renderamt", "0")
				end
			end
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:Use(ply)
	end

	--
	function ENT:NearGround()
		return util.QuickTrace(self:GetPos() + vector_up * 10, -vector_up * 50, {self}).Hit
	end

	function ENT:Detonate()
		if self.Detonated then return end
		self.Detonated = true
		local Pos, Ground, Attacker = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 5), self:NearGround(), self.Owner

		if not IsValid(Attacker) then
			Attacker = game.GetWorld()
		end

		if Ground then
			ParticleEffect("pcf_jack_groundsplode_small3", Pos, vector_up:Angle())
		else
			ParticleEffect("pcf_jack_airsplode_small3", Pos, VectorRand():Angle())
		end

		local Foom = EffectData()
		Foom:SetOrigin(Pos)

		for key, ent in pairs(ents.FindInSphere(Pos, 75)) do
			if (ent ~= self) and (ent:GetClass() == "func_breakable") and ent:CanSee(Pos) then
				ent:Fire("break", "", 0)
			elseif (ent ~= self) and (ent:GetClass() == "func_physbox") then
				constraint.RemoveAll(ent)
			elseif (ent ~= self) and HMCD_IsDoor(ent) and not ent:GetNoDraw() and ent:CanSee(Pos) then
				HMCD_BlastThatDoor(ent, (ent:GetPos() - self:GetPos()):GetNormalized() * 750)
			end
		end

		util.Effect("explosion", Foom, true, true)
		local Flash = EffectData()
		Flash:SetOrigin(Pos)
		Flash:SetScale(2)
		util.Effect("eff_jack_hmcd_dlight", Flash, true, true)

		timer.Simple(.01, function()
			self:EmitSound("snd_jack_hmcd_explosion_debris.mp3", 85, math.random(90, 110))
			self:EmitSound("m67/m67_detonate_far_dist_0" .. math.random(1, 3) .. ".wav", 140, 100)
			self:EmitSound("snd_jack_hmcd_debris.mp3", 85, math.random(90, 110))

			for i = 0, 10 do
				local Tr = util.QuickTrace(Pos, VectorRand() * math.random(10, 150), {self})

				if Tr.Hit then
					util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
				end
			end
		end)

		timer.Simple(.02, function()
			--self:EmitSound("m67/m67_detonate_0"..math.random(1,3)..".wav",Pos,80,100)
			self:EmitSound("m67/m67_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
			self:EmitSound("m67/m67_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
		end)

		timer.Simple(.04, function()
			local shake = ents.Create("env_shake")
			shake.HmcdSpawned = self.HmcdSpawned
			shake:SetPos(Pos)
			shake:SetKeyValue("amplitude", tostring(100))
			shake:SetKeyValue("radius", tostring(200))
			shake:SetKeyValue("duration", tostring(1))
			shake:SetKeyValue("frequency", tostring(200))
			shake:SetKeyValue("spawnflags", bit.bor(4, 8, 16))
			shake:Spawn()
			shake:Activate()
			shake:Fire("StartShake", "", 0)
			SafeRemoveEntityDelayed(shake, 2) -- don't clutter up the world
			local shake2 = ents.Create("env_shake")
			shake2.HmcdSpawned = self.HmcdSpawned
			shake2:SetPos(Pos)
			shake2:SetKeyValue("amplitude", tostring(100))
			shake2:SetKeyValue("radius", tostring(400))
			shake2:SetKeyValue("duration", tostring(1))
			shake2:SetKeyValue("frequency", tostring(200))
			shake2:SetKeyValue("spawnflags", bit.bor(4))
			shake2:Spawn()
			shake2:Activate()
			shake2:Fire("StartShake", "", 0)
			SafeRemoveEntityDelayed(shake2, 2) -- don't clutter up the world
			util.BlastDamage(self, Attacker, Pos, 150, 50)
		end)

		timer.Simple(.05, function()
			local Shrap = DamageInfo()
			Shrap:SetAttacker(Attacker)

			if IsValid(self) then
				Shrap:SetInflictor(self)
			else
				Shrap:SetInflictor(game.GetWorld())
			end

			Shrap:SetDamageType(DMG_BUCKSHOT)
			Shrap:SetDamage(55)
			util.BlastDamageInfo(Shrap, Pos, 600)

			for i = 1, 120 do
				local bullet = {}
				bullet.Num = 1
				bullet.Src = Pos
				bullet.Dir = VectorRand()
				bullet.Spread = 0
				bullet.Tracer = 0
				bullet.Force = .6
				bullet.Damage = 80
				bullet.AmmoType = "Buckshot"
				self:FireBullets(bullet)
			end

			SafeRemoveEntity(self)
		end)

		timer.Simple(.1, function()
			for key, rag in pairs(ents.FindInSphere(Pos, 750)) do
				if (rag:GetClass() == "prop_ragdoll") or rag:IsPlayer() then
					for i = 1, 20 do
						local Tr = util.TraceLine({
							start = Pos,
							endpos = rag:GetPos() + VectorRand() * 50
						})

						if Tr.Hit and (Tr.Entity == rag) then
							util.Decal("Blood", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
						end
					end
				end
			end
		end)
	end

	function ENT:PhysicsCollide(data, physobj)
		if (data.DeltaTime > .1) and data.Speed > 60 then
			self:EmitSound("SolidMetal.ImpactSoft", math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))
		end

		if (data.Speed > 400 and not (self.Armed or self.GravHolding or self.FallImmune)) or self.GoneOff then
			self:Detonate()
		end

		if self.FallImmune then
			self.FallImmune = false
			self.Disabled = false
		end
	end

	function ENT:StartTouch(ply)
	end
	--
else
	function ENT:MoveLegs(dir)
		hook.Add("Think", self, function()
			for i = 1, self:GetBoneCount() - 1 do
				if i % 2 == 1 then
					self:ManipulateBoneAngles(i, self:GetManipulateBoneAngles(i) - Angle(0, 0, 7) * dir)
				else
					self:ManipulateBoneAngles(i, self:GetManipulateBoneAngles(i) - Angle(0, -6, 0) * dir)
				end
			end

			local man = self:GetManipulateBoneAngles(1)

			if (man.r <= 0 and dir == 1) or (man.r >= 70 and dir == -1) then
				if dir == 1 then
					if self:GetNWBool("StartingEnabled") then
						self:SetNWBool("StartingEnabled", false)
					else
						self:EmitSound("npc/roller/blade_cut.wav")

						for i = 1, self:GetBoneCount() - 1 do
							if i % 2 == 0 then
								local pos, ang = self:GetBonePosition(i)
								local stab = {}
								stab.Attacker = game.GetWorld()
								stab.Damage = 1
								stab.Dir = -vector_up
								stab.Src = pos
								self:FireBullets(stab)
							end
						end
					end
				end

				hook.Remove("Think", self)
			end
		end)
	end

	function ENT:Initialize()
		for i = 1, self:GetBoneCount() - 1 do
			if i % 2 == 1 then
				self:ManipulateBoneAngles(i, Angle(0, 0, 70))
			else
				self:ManipulateBoneAngles(i, Angle(0, -60, 0))
			end
		end
	end
end