--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_bloodyblobs.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Bloody Blobs"

if SERVER then
	local randomModels = {
		{
			"models/cliffs/rocks_large01.mdl", 0.5, {Vector(-30, -40, 0), Vector(25, 40, 30)}
		},
		{
			"models/cliffs/rockcluster01.mdl", 0.1, {Vector(-30, -40, 0), Vector(25, 30, 20)}
		},
		{
			"models/cliffs/rocks_medium01.mdl", 0.5, {Vector(-30, -40, 0), Vector(25, 30, 20)}
		},
		{
			"models/cliffs/rockcluster02.mdl", 0.25, {Vector(-45, -25, 0), Vector(35, 25, 30)}
		},
		{
			"models/cliffs/rocks_large02.mdl", 0.5, {Vector(-30, -30, 0), Vector(30, 45, 30)}
		}
	}

	function ENT:Initialize()
		local rand = table.Random(randomModels)
		self.Entity:SetModel(rand[1])
		self:PhysicsInitBox(rand[3][1], rand[3][2])
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial("flesh")
			phys:EnableMotion(false)
		end

		self:SetMaterial("models/flesh")
		self:SetHealth(100)
		self:SetMaxHealth(100)
		self:ManipulateBoneScale(0, Vector(rand[2], rand[2], rand[2]))
		self:SetTrigger(true)
	end

	function ENT:StartTouch(ply)
		local phys = ply:GetPhysicsObject()

		if not ply:IsNPC() and IsValid(phys) and phys:GetMass() >= 85 then
			timer.Simple(0.1, function()
				if IsValid(self) then
					self:Explode()
				end
			end)
		end
	end

	function ENT:Explode()
		local effData = EffectData()
		effData:SetOrigin(self:GetPos())
		effData:SetNormal(Vector(0, 0, 1))
		effData:SetScale(6)
		effData:SetFlags(3)
		effData:SetColor(0)
		effData:SetEntity(self)
		util.Effect("bloodspray", effData)

		for i = 1, 20 do
			effData:SetNormal(VectorRand())
			effData:SetOrigin(self:GetPos() + self:GetAngles():Up() * 20)
			util.Effect("eff_jack_hmcd_blobgib", effData)
		end

		util.Decal("Blood", self:GetPos() + VectorRand() * 55, self:GetPos() - vector_up * 500, self)
		self:EmitSound("physics/flesh/flesh_bloody_break.wav", 70)

		for i, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
			if ent:IsPlayer() and ent:Alive() then
				local watchingEnt = ent

				if IsValid(ent.fakeragdoll) then
					watchingEnt = ent.fakeragdoll
				end

				if watchingEnt:Visible(self) and (ent.Bleedout > 0 or ent:GetNWString("Mask") ~= "Gas Mask") then
					if ent.Bleedout > 0 then
						ent:AddBacteria(45, CurTime())
					end

					if ent:GetNWString("Mask") ~= "Gas Mask" and GAMEMODE.ZombieMutations["Air"] then
						ent:AddBacteria(45, CurTime() - 101)
					end
				end
			end
		end

		if GAMEMODE.ZombieMutations["Air"] then
			for x = -0.5, 0.5, 0.5 do
				for y = -0.5, 0.5, 0.5 do
					for z = -0.5, 0.5, 0.5 do
						local vec = Vector(x, y, z)

						table.insert(GAMEMODE.ZombieGas, {self:GetPos() + Vector(0, 0, 30) + vec * math.Rand(10, 15), CurTime(), vec * 130 + Vector(0, 0, 10)})
					end
				end
			end
		end

		self:Remove()
	end

	function ENT:OnTakeDamage(dmginfo)
		self:Explode()
	end

	function ENT:Think()
		if GAMEMODE.ZombieMutations["Air"] and GAMEMODE.ZombieMutations["Air"] > 2 then
			for x = -0.5, 0.5, 0.5 do
				for y = -0.5, 0.5, 0.5 do
					local vec = Vector(x, y, 0)

					table.insert(GAMEMODE.ZombieGas, {self:GetPos() + Vector(0, 0, 30) + vec * math.Rand(10, 15), CurTime(), vec * 130 + Vector(0, 0, 10)})
				end
			end
		end

		self:NextThink(CurTime() + 10)

		return true
	end
end