--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_wep_base.lua

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
ENT.NextFire = 0

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "LaserEnabled")
end

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(self.CustomCollisionGroup or COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)

		if self.PhysicsBox then
			self:PhysicsInitBox(self.PhysicsBox[1], self.PhysicsBox[2])
		end

		if self.CollisionBounds then
			self:SetCollisionBounds(self.CollisionBounds[1], self.CollisionBounds[2])
		end

		if self.Bodygroups then
			for i, val in pairs(self.Bodygroups) do
				self:SetBodygroup(i, val)
			end
		end

		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(self.Mass or 20)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:Use(ply)
		self:PickUp(ply)
	end

	function ENT:PickUp(ply)
		if IsValid(self.Owner) then
			local wep = self.Owner:GetWeapon(self.SWEP)

			if self.Owner:Alive() and not (self.Owner.Otrub or self.Owner.Stunned) then
				return
			elseif IsValid(wep) then
				wep:Remove()
			end
		end

		local SWEP = self.SWEP

		if not self.RoundsInMag then
			self.RoundsInMag = self.DefaultAmmoAmt
		end

		if ply:HasWeapon(self.SWEP) then
			if self.RoundsInMag > 0 then
				ply:GiveAmmo(self.RoundsInMag, self.AmmoType, true)
				self.RoundsInMag = 0
				self:EmitSound("snd_jack_hmcd_ammotake.wav", 65, 80)
				ply:SelectWeapon(SWEP)
			else
				ply:PickupObject(self)
			end
		else
			ply:Give(self.SWEP)

			if self.Attachments then
				for attachment, info in pairs(self.Attachments) do
					ply:GetWeapon(self.SWEP):SetNWBool(attachment, self:GetNWBool(attachment))
				end
			end

			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(self.SWEP):SetClip1(self.RoundsInMag)
			ply:GetWeapon(self.SWEP):SetLaserEnabled(self:GetLaserEnabled())
			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end

	function ENT:PhysicsCollide(data, ent)
		if data.DeltaTime > .1 then
			self:EmitSound(self.ImpactSound, math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))

			if self.SecondSound then
				sound.Play(self.SecondSound, self:GetPos(), math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))
			end
		end
	end

	function ENT:Shoot()
		if not self.RoundsInMag then
			self.RoundsInMag = self.DefaultAmmoAmt
		end

		if not self.Reloading then
			if self.RoundsInMag > 0 then
				if self.NextFire < CurTime() then
					self.NextFire = CurTime() + weapons.Get(self.SWEP).TriggerDelay + weapons.Get(self.SWEP).CycleTime
					self.RoundsInMag = self.RoundsInMag - 1

					if IsValid(self.Owner:GetWeapon(self.SWEP)) then
						self.Owner:GetWeapon(self.SWEP):SetClip1(self.Owner:GetWeapon(self.SWEP):Clip1() - 1)
					end

					local pos, ang = self:GetPos(), self:GetAngles() + (self.AngleOffset or Angle(0, 0, 0))
					local muzzlePos = pos + ang:Forward() * self.MuzzlePos[1] + ang:Right() * self.MuzzlePos[2] + ang:Up() * self.MuzzlePos[3]
					local suppressed = self:GetNWBool("Suppressor")
					local bulletDir = ang:Forward() * self.BulletDir[1] + ang:Right() * self.BulletDir[2] + ang:Up() * self.BulletDir[3]
					if self.MuzzleEffect ~= "" then
						if suppressed then
							ParticleEffect(weapons.Get(self.SWEP).MuzzleEffectSuppressed, muzzlePos, bulletDir:Angle(), self)
						else
							ParticleEffect(weapons.Get(self.SWEP).MuzzleEffect, muzzlePos, bulletDir:Angle(), self)
						end
					end

					self:GetPhysicsObject():ApplyForceCenter(-bulletDir * weapons.Get(self.SWEP).Damage * weapons.Get(self.SWEP).NumProjectiles * 3)
					local Dist, Pitch = 100, weapons.Get(self.SWEP).ShotPitch * math.Rand(.9, 1.1)

					if suppressed and weapons.Get(self.SWEP).SuppressedFireSound then
						self:EmitSound(weapons.Get(self.SWEP).SuppressedFireSound)
					else
						self:EmitSound(weapons.Get(self.SWEP).CloseFireSound, 75, 100)
						self:EmitSound(weapons.Get(self.SWEP).FarFireSound, 75 * 2, 100)

						if self.ExtraFireSound then
							sound.Play(self.ExtraFireSound, self:GetShootPos() + VectorRand(), Dist - 5, 100)
						end
					end

					if self.Damage > 0 then
						local bullet = {}
						bullet.Num = self.NumProjectiles
						bullet.Src = muzzlePos
						bullet.Dir = bulletDir + VectorRand() * (1 - weapons.Get(self.SWEP).Accuracy)
						bullet.Spread = Vector(self.Spread, self.Spread, 0)
						bullet.Tracer = 0
						bullet.Force = self.Damage
						bullet.Damage = self.Damage
						self:FireBullets(bullet)

						if weapons.Get(self.SWEP).BulletEjectPos and weapons.Get(self.SWEP).ShellEffect ~= "" and IsValid(self.Owner) and self.Owner:Health() > 0 then
							local effectdata = EffectData()
							effectdata:SetEntity(self)
							effectdata:SetNormal(weapons.Get(self.SWEP).BulletEjectDir)
							effectdata:SetOrigin(pos + ang:Forward() * self.BulletEjectPos[1] + ang:Right() * self.BulletEjectPos[2] + ang:Up() * self.BulletEjectPos[3])

							if self.ShellDelay then
								timer.Simple(self.ShellDelay, function()
									if IsValid(self) then
										util.Effect(self.ShellEffect, effectdata)
									end
								end)
							else
								util.Effect(self.ShellEffect, effectdata)
							end

							if self.ShellEffect2 then
								if self.ShellDelay then
									timer.Simple(self.ShellDelay, function()
										if IsValid(self) then
											util.Effect(self.ShellEffect2, effectdata)
										end
									end)
								else
									util.Effect(self.ShellEffect2, effectdata)
								end
							end
						end
					end
				end
			else
				self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
			end
		end
	end

	function ENT:Think()
		if self.RoundsInMag == nil then
			self.RoundsInMag = self.DefaultAmmoAmt
		end
		if IsValid(self.Owner) and self.Owner:Alive() and not self.Owner.Otrub and self.OwnerAlive then
			local attacking = self.Owner:KeyDown(IN_ATTACK)
			self.Owner = nil
			if ((weapons.Get(self.SWEP).Primary.Automatic and self.RoundsInMag > 0) or IsChanged(attacking, "attacking", self)) and attacking then
				self:Shoot()
			end
		end

		self:NextThink(CurTime() + .01)

		return true
	end
elseif CLIENT then
	function ENT:IsCarriedByLocalPlayer()
		return false
	end

	function ENT:Initialize()
		self.DrawnAttachments = {}
	end

	local spriteMat = Material("sprites/redglow1")

	function ENT:Draw()
		if self:GetNWBool("Laser") then
			local pos, ang = self:GetPos(), self:GetAngles()

			if self.AngleOffset then
				ang = ang + self.AngleOffset
			end

			local muzzlePos = pos + ang:Forward() * self.MuzzlePos[1] + ang:Right() * self.MuzzlePos[2] + ang:Up() * self.MuzzlePos[3]
			local bulletDir = ang:Forward() * self.BulletDir[1] + ang:Right() * self.BulletDir[2] + ang:Up() * self.BulletDir[3]
			render.SetMaterial(spriteMat)
			render.DrawSprite(util.QuickTrace(muzzlePos, bulletDir * 20000, self).HitPos, 3, 3, white)
		end

		self:DrawModel()

		--[[if self.MuzzlePos and false then
			local pos,ang=self:GetPos(),self:GetAngles()+(self.AngleOffset or angle_zero)
			local muzzlePos=pos+ang:Forward()*self.MuzzlePos[1]+ang:Right()*self.MuzzlePos[2]+ang:Up()*self.MuzzlePos[3]
			render.DrawWireframeSphere(muzzlePos,.2,64,64)
		end]]
		if self.Attachments then
			for attachment, info in pairs(self.Attachments) do
				if self:GetNWBool(attachment) then
					if not self.DrawnAttachments[attachment] then
						self.DrawnAttachments[attachment] = ClientsideModel(info.model)
						self.DrawnAttachments[attachment]:SetPos(self:GetPos())
						self.DrawnAttachments[attachment]:SetParent(self)
						self.DrawnAttachments[attachment]:SetNoDraw(true)

						if info.scale then
							self.DrawnAttachments[attachment]:SetModelScale(info.scale, 0)
						end

						if info.material then
							self.DrawnAttachments[attachment]:SetMaterial(info.material)
						end
					else
						local pos, ang = self:GetBonePosition(self:LookupBone(info.bone))
						self.DrawnAttachments[attachment]:SetRenderOrigin(pos + ang:Right() * info.pos.right + ang:Forward() * info.pos.forward + ang:Up() * info.pos.up)

						if info.ang then
							local angList = {
								["forward"] = ang:Forward(),
								["right"] = ang:Right(),
								["up"] = ang:Up()
							}

							for i, rot in pairs(info.ang) do
								ang:RotateAroundAxis(angList[i], rot)

								angList = {
									["forward"] = ang:Forward(),
									["right"] = ang:Right(),
									["up"] = ang:Up()
								}
							end
						end

						self.DrawnAttachments[attachment]:SetRenderAngles(ang)
						self.DrawnAttachments[attachment]:DrawModel()
					end
				else
					if self.DrawnAttachments[attachment] then
						self.DrawnAttachments[attachment] = nil
					end
				end
			end
		end
	end
end