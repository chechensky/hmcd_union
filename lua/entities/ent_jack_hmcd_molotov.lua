--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_molotov.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.SWEP = "wep_jack_hmcd_molotov"
ENT.Model = "models/w_models/weapons/w_eq_molotov.mdl"
ENT.Mass = 5

if SERVER then
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

	function ENT:Think()
	end

	--
	function ENT:NearGround()
		return util.QuickTrace(self:GetPos() + vector_up * 10, -vector_up * 50, {self}).Hit
	end

	function ENT:Detonate()
		if self:WaterLevel() >= 3 then
			self.Armed = false
			self:Extinguish()

			return
		end

		if self.Detonated then return end
		self.Detonated = true
		local Pos, Ground, Attacker = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 5), self:NearGround(), self.Owner
		ParticleEffect("pcf_jack_incendiary_air_sm2", Pos, VectorRand():Angle())
		--local Foom=EffectData()
		--Foom:SetOrigin(Pos)
		--util.Effect("explosion",Foom,true,true)
		local Flash = EffectData()
		Flash:SetOrigin(Pos)
		Flash:SetScale(2)
		util.Effect("eff_jack_hmcd_dlight", Flash, true, true)

		timer.Simple(.01, function()
			for i = 0, 10 do
				local Tr = util.QuickTrace(Pos, VectorRand() * math.random(10, 150), {self})

				if Tr.Hit then
					util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
				end
			end
		end)

		timer.Simple(.02, function()
			self:EmitSound("snd_jack_firebomb.wav", 80, 100)

			for i = 1, 10 do
				sound.Play("GlassBottle.Break", Pos, 80 + i, 100)
			end
		end)

		timer.Simple(.03, function()
			local Fire = ents.Create("ent_jack_hmcd_fire")
			Fire.HmcdSpawned = self.HmcdSpawned
			Fire.Initiator = Attacker
			Fire.Power = 3
			Fire:SetPos(Pos)
			Fire:Spawn()
			Fire:Activate()
		end)

		timer.Simple(.04, function()
			SafeRemoveEntity(self)
		end)
	end

	function ENT:ModifiedIgnite(ent, ignitetime)
		local curIgniteTime = 0

		if IsValid(ent.CurrentFire) then
			curIgniteTime = ent.CurrentFire:GetInternalVariable("lifetime") - CurTime()
		end

		ent:Ignite(curIgniteTime + ignitetime)
		local owner = ent

		if owner:IsPlayer() and IsValid(self.Owner) then
			owner.LastIgniter = self.Owner
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .1 then
			self:EmitSound("GlassBottle.ImpactHard")
			self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity() * .9)

			if self.Ignited then
				self:ModifiedIgnite(data.HitEntity, 100)
				self:Detonate()
			end
		end
	end

	function ENT:Light()
		if self:WaterLevel() >= 3 then return end
		self.Ignited = true
		self:ModifiedIgnite(self, 25)
		self:SetDTBool(0, true)
	end

	function ENT:StartTouch(ply)
	end
	--
end