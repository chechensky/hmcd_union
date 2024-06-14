--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_match.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Match Box"
ENT.SWEP = "wep_jack_hmcd_matchbox"
ENT.ImpactSound = "Wood.ImpactSoft"
ENT.Model = "models/weapons/gleb/matchhead.mdl"
ENT.Mass = 5

if SERVER then
	local igniteMass = {
		[MAT_PLASTIC] = 50,
		[MAT_FOLIAGE] = 50,
		[MAT_GRASS] = 5,
		[MAT_WOOD] = 5,
		[MAT_DIRT] = 5
	}

	function ENT:Initialize()
		self.Entity:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_BBOX)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		local mins, maxs = Vector(-.1, -.1, -1), Vector(.1, .1, 1)
		self:PhysicsInitBox(mins, maxs)
		self:SetCollisionBounds(mins, maxs)
		self:DrawShadow(true)
		self:SetModelScale(.19, 0)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(self.Mass)
			phys:Wake()
			phys:EnableMotion(true)
		end

		self:SetMaterial("models/rogue_cheney/cannon/cannon_match_burned")

		if self:GetNWBool("Lit") then
			local pos, ang = self:GetPos(), self:GetAngles()
			local heat = ents.Create("env_firesource")
			heat:SetPos(self:GetPos())
			heat:SetParent(self)
			heat:SetKeyValue("fireradius", 50)
			heat:SetKeyValue("firedamage", 50)
			heat:Spawn()
			heat:Input("Enable")
			self.Heat = heat
			local inf = ents.Create("prop_physics")
			inf:SetModel(self:GetModel())
			inf:SetPos(pos + ang:Up() - ang:Forward() * 0.63)
			inf:SetParent(heat)
			inf:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			inf:SetRenderMode(RENDERMODE_NONE)
			inf:SetColor(Color(0, 0, 0, 0))
			inf:SetHealth(10000)
			inf:Spawn()
			self.inf = inf
			ParticleEffectAttach("lighter_flame", PATTACH_POINT_FOLLOW, inf, 0)
		end
	end

	function ENT:Think()
		if self.LitTime then
			if self.LitTime + 40 < CurTime() or self:WaterLevel() > 0 then
				self:SetNWBool("Lit", false)
				self.LitTime = nil
				self.Heat:Remove()
			else
				for i, ent in pairs(ents.FindInSphere(self:GetPos(), 6)) do
					if ent ~= self and ent ~= self.inf and ent:Visible(self) then
						if ent.GasolineAmt or (igniteMass[ent:GetMaterialType()] and igniteMass[ent:GetMaterialType()] >= ent:GetPhysicsObject():GetMass()) then
							local dmg = DamageInfo()
							dmg:SetDamage(1)
							dmg:SetDamageType(DMG_BURN)
							dmg:SetAttacker(self.Owner)
							dmg:SetInflictor(self)
							ent:TakeDamageInfo(dmg)
						end
					end
				end
			end
		end
	end

	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
else
	function ENT:Draw()
		self:DrawModel()

		if self:GetNWBool("Lit") then
			local dlight = DynamicLight(self:EntIndex())

			if dlight then
				dlight.Pos = self:GetPos()
				dlight.r = 255
				dlight.g = 90
				dlight.b = 0
				dlight.brightness = 1
				dlight.Decay = 256
				dlight.Size = math.min(256, 100)
				dlight.DieTime = CurTime() + 1
			end
		end
	end
end