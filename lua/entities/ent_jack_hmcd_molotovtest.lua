--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_molotovtest.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Molotov"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.IsLoot = true
ENT.SWEP = "wep_jack_hmcd_molotovtest"

local explosionParticles = {"ins_molotov_smoke", "ins_molotov_flame_b", "ins_molotov_flamewave", "ins_molotov_burst_b", "ins_molotov_burst_glass", "ins_molotov_trailers", "ins_molotov_burst_flame", "ins_molotov_burst", "ins_molotov_trails", "ins_molotov_flash"}

local Flammables = {
	[MAT_ANTLION] = true,
	[MAT_BLOODYFLESH] = true,
	[MAT_EGGSHELL] = true,
	[MAT_FLESH] = true,
	[MAT_ALIENFLESH] = true,
	[MAT_PLASTIC] = true,
	[MAT_FOLIAGE] = true,
	[MAT_COMPUTER] = true,
	[MAT_GRASS] = true,
	[MAT_WOOD] = true,
	[MAT_DIRT] = true
}

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/weapons/w_molotov.mdl")
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

		timer.Simple(.1, function()
			if self.Ignited then
				ParticleEffectAttach("molotov_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
			end
		end)

		self.Detonated = false
		self.Ignited = false
		self.SpawnTime = CurTime()
		self.Radius = 200
	end

	function ENT:PickUp(ply)
		if self.Armed then return end
		if self.Ignited then return end
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound("GlassBottle.ImpactHard", 60, 90)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end

	function ENT:CanPassThrough(ent)
		return string.find(ent:GetClass(), "prop_") or ent:IsPlayer() or string.find(ent:GetClass(), "ent") or string.find(ent:GetClass(), "npc") or HMCD_ExplosiveType(ent) == 3
	end

	function ENT:IgniteEntities()
		for key, ent in pairs(ents.FindInSphere(self:GetPos(), self.Radius)) do
			local Tr = util.QuickTrace(self:GetPos(), ent:GetPos() - self:GetPos(), {self, ent})

			local Diffz = self:GetPos().z - ent:GetPos().z

			if self:Visible(ent) and self:CanBeIgnited(ent) and math.abs(Diffz) < 20 then
				local mass

				if ent:GetPhysicsObject() then
					mass = ent:GetPhysicsObject():GetMass()
				else
					mass = 100
				end

				self:ModifiedIgnite(ent, math.random(mass * 0.15, mass * 0.2))
			end
		end
	end

	function ENT:ModifiedIgnite(ent, ignitetime, isRDM)
		local curIgniteTime = 0

		if IsValid(ent.CurrentFire) then
			curIgniteTime = ent.CurrentFire:GetInternalVariable("lifetime") - CurTime()
		end

		ent:Ignite(curIgniteTime + ignitetime)

		if isRDM then
			local owner = ent

			if owner:IsPlayer() and IsValid(self.Owner) then
				owner.LastIgniter = self.Owner
			end
		end
	end

	function ENT:CanBeIgnited(ent)
		return Flammables[ent:GetMaterialType()] or (ent:IsPlayer() and ent:Alive()) or HMCD_ExplosiveType(ent) == 3 or ent:IsNPC() or ent.GasolineAmt
	end

	function ENT:Think()
		if self.Detonated then
			--[[if not(self.ReadyToDelete) then
				local Gas=ents.Create("ent_jack_hmcd_carbon")
				Gas:SetPos(self:GetPos())
				Gas.HmcdSpawned=self.HmcdSpawned
				Gas.Owner=self.Owner
				Gas:Spawn()
				Gas:Activate()
				Gas:GetPhysicsObject():SetVelocity(Vector(math.random(100,150),math.random(100,150),math.random(200,300)))
			end]]
			for key, ent in pairs(ents.FindInSphere(self:GetPos(), self.Radius)) do
				local Diffz = self:GetPos().z - ent:GetPos().z

				if self:Visible(ent) and math.abs(Diffz) < 20 and self:CanBeIgnited(ent) and not self.ReadyToDelete then
					local mass

					if ent:GetPhysicsObject() then
						mass = ent:GetPhysicsObject():GetMass()
					else
						mass = 100
					end

					if math.random(1, 10) == 1 then
						self:ModifiedIgnite(ent, math.random(mass * 0.15, mass * 0.2), CurTime() - self.SpawnTime < 10)
					end

					local attacker = self.Owner

					if not IsValid(attacker) then
						attacker = game.GetWorld()
					end

					local Dmg = DamageInfo()

					if CurTime() - self.SpawnTime >= 10 then
						Dmg:SetAttacker(game.GetWorld())

						if IsValid(attacker) then
							local owner = ent

							if owner:IsPlayer() then
								owner.LastAttacker = attacker
								owner.LastAttackerName = attacker.BystanderName
							end
						end
					else
						Dmg:SetAttacker(attacker)
					end

					Dmg:SetInflictor(self)
					Dmg:SetDamageType(DMG_BURN)
					Dmg:SetDamagePosition(self:GetPos())
					Dmg:SetDamageForce(vector_origin)
					Dmg:SetDamage(3)
					ent:TakeDamageInfo(Dmg)
				end
			end

			if self.ReadyToDelete then
				self:Remove()
			end

			if self.Crispiness < 1 and self.Detonated then
				self:StopSound("weapons/molotov/molotov_burn.wav")
				sound.Play("weapons/molotov/molotov_burn_extinguish.wav", self:GetPos(), 75, 100)
				self:Remove()
			end
		end

		self:NextThink(CurTime() + .75)

		return true
	end

	function ENT:Detonate()
		if self:WaterLevel() >= 3 then
			self.Armed = false
			self.Ignited = false
			self:Extinguish()
			local effectdata = EffectData()
			effectdata:SetEntity(self)
			util.Effect("ParticleEffectStop", effectdata)

			return
		end

		if self.Detonated then return end
		self.Detonated = true

		local hitpos = util.QuickTrace(self:GetPos() + vector_up, -vector_up * 500, {self}).HitPos

		local Pos, Attacker = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 5), self.Owner
		self:IgniteEntities()
		self:EmitSound("weapons/molotov/molotov_burn.wav")
		self:Extinguish()
		self.Crispiness = 225
		self:SetMaterial("models/hands/hands_color")
		self:SetPos(hitpos)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		timer.Simple(31, function()
			self.ReadyToDelete = true
		end)

		local effectdata = EffectData()
		effectdata:SetAngles(self:GetAngles())
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self)
		util.Effect("eff_jack_hmcd_fancyfire", effectdata)
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .1 then
			self:EmitSound("GlassBottle.ImpactHard")
			self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity() * .9)

			if self.Ignited then
				self:Detonate()
			end
		end
	end

	function ENT:Light()
		if self:WaterLevel() >= 3 then return end
		self.Ignited = true
		self:SetDTBool(0, true)
	end

	function ENT:StartTouch(ply)
	end
	--
end