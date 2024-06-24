--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_hatchet.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Hatchet"
ENT.SWEP = "wep_jack_hmcd_hatchet"
ENT.ImpactSound = "physics/metal/metal_solid_impact_soft1.wav"
ENT.MurdererLoot = true
ENT.Infectable = true
ENT.NoHolster = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/eu_homicide/w_hatchet.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(5)
			phys:Wake()
			phys:EnableMotion(true)
		end

		self.HitSomething = false
		self.Thinks = 0
		self.HitEntity = nil
		self.HitPos = vector_origin
		self.HatchetVelocity = vector_origin

		if not self.Thrown then
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end
	end

	function ENT:Think()
	end

	--
	local armorTypes = {"Bodyvest", "Helmet", "Mask"}

	function ENT:PhysicsCollide(data, phys)
		if data.HitEntity == self.Owner then return end

		if self.Thrown and not self.HitSomething then
			self.HitSomething = true

			if data.HitEntity:GetClass() == "func_breakable_surf" then
				data.HitEntity:Fire("break", "", 0)
			end

			local Tr2 = util.QuickTrace(self:GetPos() + self:GetAngles():Forward() * 4 + self:GetAngles():Right() * 4, self:GetAngles():Forward() * 500, {self})

			self:EmitSound(self.ImpactSound, 70, math.random(90, 110))
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			if Tr2.Entity ~= data.HitEntity then return end
			local Dmg, DmgAmt = DamageInfo(), math.random(20, 30)
			Dmg:SetDamage(DmgAmt)
			Dmg:SetDamageForce(data.OurOldVelocity)
			Dmg:SetDamagePosition(self:GetPos())
			Dmg:SetDamageType(DMG_SLASH)
			Dmg:SetAttacker(self.Owner)
			Dmg:SetInflictor(self)
			local hitgroup = 0

			if data.HitEntity:IsPlayer() then
				local smallestDist

				for i = 0, data.HitEntity:GetBoneCount() - 1 do
					local bonePos = data.HitEntity:GetBonePosition(i)
					local dist = Tr2.HitPos:DistToSqr(bonePos)

					if not smallestDist or dist < smallestDist then
						smallestDist = dist
						hitgroup = util.QuickTrace(bonePos, Vector()).HitGroup
					end
				end

				GAMEMODE:ScalePlayerDamage(data.HitEntity, hitgroup, Dmg)
			end

			for i, armorType in pairs(armorTypes) do
				if data.HitEntity:GetNWString(armorType) ~= "" and HMCD_ArmorProtection[armorType] and HMCD_ArmorProtection[armorType][hitgroup] then return end
			end

			data.HitEntity:TakeDamageInfo(Dmg)

			if data.HitEntity:IsPlayer() then
				GAMEMODE:ScalePlayerDamage(data.HitEntity, hitgroup, Dmg)
			end

			if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() or (data.HitEntity:GetClass() == "prop_ragdoll") then
				self:EmitSound("snd_jack_hmcd_axehit.wav", 75, math.random(110, 130))

				if data.HitEntity:IsPlayer() then
					if self.Poisoned then
						self.Poisoned = false
						HMCD_Poison(data.HitEntity, self.Owner, "Curare")
					end

					if self.Infected then
						if not data.HitEntity.ZombieBacteria then
							data.HitEntity.ZombieBacteria = {}
						end

						table.insert(data.HitEntity.ZombieBacteria, {45, CurTime() - 101})

						local sum = 0

						for i, tabl in pairs(data.HitEntity.ZombieBacteria) do
							sum = sum + tabl[1]
						end

						if sum >= data.HitEntity:Health() - (data.HitEntity.MaxBlood - data.HitEntity.BloodLevel) * 0.08 then
							GAMEMODE:Infect(data.HitEntity)
						end
					end
				end

				local edata = EffectData()
				edata:SetStart(self:GetPos())
				edata:SetOrigin(self:GetPos())
				edata:SetNormal(vector_up)
				edata:SetEntity(data.HitEntity)
				util.Effect("BloodImpact", edata, true, true)

				timer.Simple(.05, function()
					for i = 1, 2 do
						local BloodTr = util.QuickTrace(data.HitPos - data.OurOldVelocity:GetNormalized() * 10, data.OurOldVelocity:GetNormalized() * 50, {self})

						if BloodTr.Hit then
							util.Decal("Blood", BloodTr.HitPos + BloodTr.HitNormal, BloodTr.HitPos - BloodTr.HitNormal)
						end
					end
				end)
			else
				self:EmitSound("physics/metal/metal_solid_impact_hard1.wav", 75, math.random(90, 110))
			end
		else
			if data.DeltaTime > .2 then
				self:EmitSound(self.ImpactSound, 65, math.random(90, 110))
			end
		end
	end

	function ENT:PickUp(ply)
		if self.Thrown and not self.HitSomething then return end
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			if self.ContactPoisoned then
				if ply.Role == "Traitor" then
					ply:PrintMessage(HUD_PRINTTALK, "This is poisoned!")

					return
				else
					self.ContactPoisoned = false
					HMCD_Poison(ply, self.Poisoner, "VX")
				end
			end

			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Poisoned = self.Poisoned
			ply:GetWeapon(SWEP).Infected = self.Infected
			ply:SelectWeapon(SWEP)
			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end
elseif CLIENT then
	function ENT:Initialize()
	end
end
--