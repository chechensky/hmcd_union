--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_arrow.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Arrow"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.PenetrationPower = 20
ENT.Damage = 40

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model or "models/ml/arrow.mdl")

		if self.ModelScale then
			self:SetModelScale(self.ModelScale, 0)
		end

		self:PhysicsInit(SOLID_VPHYSICS)

		if self.Fired then
			self:SetMoveType(MOVETYPE_NONE)
		else
			self:SetMoveType(MOVETYPE_VPHYSICS)
		end

		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(CONTINUOUS_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(0.1)
			phys:EnableDrag(false)
		end

		hook.Add("Think", self, function()
			if self.Thought then
				hook.Remove("Think", self)
			elseif self.Fired and not (self.HitSomething and self.WallPass == nil) then
				self:ArrowThink()
			end
		end)

		self.CreationTime = CurTime()
		self.StartingPenetration = self.PenetrationPower
		self.StartPos = self:GetPos()
	end

	function ENT:Use(ply)
		if (self.Fired and not self.HitSomething) or self:GetModel() ~= "models/ml/arrow.mdl" then return end
		ply:GiveAmmo(1, "XBowBolt", true)
		sound.Play("snd_jack_hmcd_arrow.wav", self:GetPos(), 60, math.random(90, 110))

		if ply:HasWeapon("wep_jack_hmcd_bow") then
			ply:SelectWeapon("wep_jack_hmcd_bow")
		end

		local ent = self:GetParent()

		if not IsValid(ent) then
			local constr = constraint.GetTable(self)[1]

			if constr then
				ent = constr.Ent2
			end
		end

		if IsValid(ent) and (ent.fleshy or ent:IsPlayer() or ent:IsNPC()) then
			local owner = ent

			if owner:IsPlayer() then
				owner:ApplyPain(20)
			end

			owner:EmitSound("arrow_tear.wav")

			if not owner:IsNPC() then
				if not owner.Bleedout then
					owner.Bleedout = 0
				end

				owner.Bleedout = owner.Bleedout + 50
			end
		end

		self:Remove()
	end

	function ENT:ArrowThink()
		local dir = self.InitialDir * (self.Speed or 40)

		if not self.WallPass then
			local filters = {self, self.Owner}

			if CurTime() - self.CreationTime > 2 then
				filters = self
			end

			local tr = util.QuickTrace(self:GetPos(), dir, filters)

			if tr.Hit then
				self:FireBullets({
					Attacker = self.Owner,
					Damage = 0,
					Force = 1,
					Num = 1,
					Tracer = 0,
					TracerName = "",
					Dir = -tr.HitNormal,
					Spread = vector_origin,
					Src = tr.HitPos + tr.HitNormal
				})

				local AVec, IPos, SMul = tr.Normal, tr.HitPos, HMCD_SurfaceHardness[tr.MatType] or .5
				local MaxDist, SearchPos, SearchDist, Penetrated = (self.PenetrationPower / SMul) * .15, IPos, 5, false
				local setPoses = 0

				while (not Penetrated) and (SearchDist < MaxDist) do
					self.PenetrationPower = self.PenetrationPower - SMul * 5
					SearchPos = IPos + AVec * SearchDist
					local PeneTrace = util.QuickTrace(SearchPos, -AVec * SearchDist, filters)
					setPoses = setPoses + 1

					if (not PeneTrace.StartSolid) and PeneTrace.Hit and util.IsInWorld(PeneTrace.HitPos) then
						self:FireBullets({
							Attacker = self.Owner,
							Damage = 0,
							Force = 1,
							Num = 1,
							Tracer = 0,
							TracerName = "",
							Dir = -AVec,
							Spread = vector_origin,
							Src = SearchPos + AVec
						})

						Penetrated = true
					else
						SearchDist = SearchDist + 5
					end
				end

				self.WallPass = setPoses

				if IsValid(tr.Entity) then
					local Dmg = DamageInfo()
					Dmg:SetDamage(self.Damage)
					Dmg:SetDamageType(DMG_BULLET)
					Dmg:SetDamagePosition(tr.HitPos)
					Dmg:SetAttacker(self.Owner)
					Dmg:SetInflictor(self)
					Dmg:SetDamageForce(self:GetPhysicsObject():GetVelocity())
					local oldDmg = Dmg:GetDamage()

					if tr.Entity:IsRagdoll() or tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
						local infoList = {}
						local curVest, curHelmet, curMask = tr.Entity:GetNWString("Bodyvest"), tr.Entity:GetNWString("Helmet"), tr.Entity:GetNWString("Mask")

						local armorHit

						if #infoList > 0 then
							armorHit = true

							for i, info in pairs(infoList) do
								if info[3] then
									if istable(info[3][1]) then
										for i, inf in pairs(info[3]) do
											armorHit = HMCD_CheckArmor(tr.Entity, self.Owner:GetShootPos(), tr.HitPos, inf) and info[1] >= self.Damage * self.PenetrationPower / self.StartingPenetration
											if armorHit then break end
										end
									else
										armorHit = HMCD_CheckArmor(tr.Entity, self.Owner:GetShootPos(), tr.HitPos, info[3]) and info[1] >= self.Damage * self.PenetrationPower / self.StartingPenetration
									end
								else
									armorHit = info[1] >= self.Damage * self.PenetrationPower / self.StartingPenetration
								end

								if info["Holes"] and armorHit then
									for i, holeInfo in pairs(info["Holes"]) do
										local sex = tr.Entity.ModelSex or tr.Entity:GetSex()
										local pos, ang = tr.Entity:GetBonePosition(tr.Entity:LookupBone(holeInfo.bone))

										if holeInfo.posAdjust then
											pos = pos + ang:Right() * holeInfo.posAdjust[sex].Right + ang:Forward() * holeInfo.posAdjust[sex].Forward + ang:Up() * holeInfo.posAdjust[sex].Up
										end

										if holeInfo.rotate then
											local angs = {
												["Up"] = ang:Up(),
												["Right"] = ang:Right(),
												["Forward"] = ang:Forward()
											}

											for i, angInfo in pairs(holeInfo.rotate) do
												ang:RotateAroundAxis(angs[angInfo[1]], angInfo[2])

												angs = {
													["Up"] = ang:Up(),
													["Right"] = ang:Right(),
													["Forward"] = ang:Forward()
												}
											end
										end

										local localpos = WorldToLocal(tr.HitPos, Angle(), self.StartPos, Angle())
										local hit = util.IntersectRayWithOBB(self.StartPos, localpos, pos, ang, holeInfo.mins, holeInfo.maxs) ~= nil

										if hit then
											armorHit = false
										end
									end
								end
							end
						end

						if armorHit then
							self:Remove()

							return
						end

						Dmg:SetDamage(math.max(Dmg:GetDamage(), oldDmg / 1.5))

						if self.FleshyImpactSound and not (tr.Entity:IsRagdoll() and not tr.Entity.fleshy) then
							sound.Play(self.FleshyImpactSound, tr.HitPos, 70, 100)
						end
					end

					local owner = tr.Entity
					owner:TakeDamageInfo(Dmg)

					if not Penetrated then
						local ragEntity

						if tr.Entity.GetRagdollEntity then
							ragEntity = tr.Entity:GetRagdollEntity()
						end

						if not IsValid(ragEntity) then
							if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
								self:SetParent(tr.Entity)
								self:Fire("SetParentAttachmentMaintainOffset", "chest", 0.1)
								self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
								self.HitSomething = true
							else
								if tr.Entity:Health() == 0 or Dmg:GetDamage() < tr.Entity:Health() then
									if not IsValid(tr.Entity) or tr.PhysicsBone ~= 0 then
										self:SetPos(tr.HitPos)
										local constr = constraint.Weld(self, tr.Entity, 0, tr.PhysicsBone, 0, true, false)

										if constr then
											constr.PickupAble = true
										end
									else
										self:SetParent(tr.Entity)
									end

									self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
									self.HitSomething = true
								end
							end
						end

						if owner:IsPlayer() then
							local closestBone, minDist

							for i = 0, tr.Entity:GetBoneCount() - 1 do
								local dist = tr.HitPos:DistToSqr(tr.Entity:GetBonePosition(i))

								if not minDist or minDist > dist then
									minDist = dist
									closestBone = i
								end
							end

							local bonePos, boneAng = tr.Entity:GetBonePosition(closestBone)
							local pos, ang = WorldToLocal(tr.HitPos, self:GetAngles(), bonePos, boneAng)
						end
					end
				elseif not Penetrated then
					self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
					self.HitSomething = true
				end

				if self.CallbackFunc then
					self:CallbackFunc(tr.Entity)
				end
			end

			self:SetPos(tr.HitPos)
		else
			local add = math.Clamp(self.WallPass, 0, 40) * 5
			self:SetPos(self:GetPos() + self.InitialDir * add)
			self.WallPass = self.WallPass - add

			if self.WallPass <= 0 then
				self.WallPass = nil
			end
		end

		self.InitialDir = self.InitialDir - vector_up * (self.DropSpeed or 0.001)
		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Right(), (self.DropSpeed or 0.001) * -100)
		self:SetAngles(ang)
	end

	function ENT:Think()
		if not self.Thought then
			self.Thought = true
		end

		if self.Fired and not (self.HitSomething and self.WallPass == nil) then
			self:ArrowThink()
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:PhysicsCollide(data, physobj)
		if self.CollisionSound and data.DeltaTime > .15 then
			self:EmitSound(self.CollisionSound or "snd_jack_hmcd_arrow.wav", 60, math.random(90, 110))
		end
	end

	function ENT:StartTouch(ply)
	end
	--
elseif CLIENT then
	function ENT:Initialize()
	end

	--
	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--