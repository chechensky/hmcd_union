--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_smokebomb.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Rauchbombe"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.IsLoot = true

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel("models/props_junk/jlare.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:EnableMotion(true)
		end

		self.BurnoutTime = CurTime() + 30
		self.NextSmokeTime = CurTime() + .25
		self:SetDTBool(0, false)
		self.NextHide = CurTime() + 5

		for i, ply in player.Iterator() do
			if ply.NextCough and ply.NextCough < CurTime() then
				ply.NextCough = nil
			end
		end
	end

	function ENT:Use(ply)
		ply:PickupObject(self)
	end

	function ENT:Think()
		if self:WaterLevel() >= 3 then
			self.BurnoutTime = CurTime()

			return
		end

		if self.NextSmokeTime < CurTime() then
			self.NextSmokeTime = CurTime() + .5
			ParticleEffect("pcf_jack_smokebomb3", self:GetPos(), Angle(0, 0, 0), self)
		end

		if self.NextHide < CurTime() then
			self:SetDTBool(0, true)
		end

		self:EmitSound("snd_jack_hmcd_flare.wav", 65, math.random(95, 105))

		for i, ply in player.Iterator() do
			local watcher = ply

			if ply:Alive() and watcher:Visible(self) and watcher:GetPos():DistToSqr(self:GetPos()) < 40000 then
				if not ply.NextCough then
					ply.NextCough = CurTime() + math.random(4, 5)
				end

				if ply.NextCough < CurTime() then
					ply:Cough()
					ply.NextCough = CurTime() + math.random(4, 5)
				end
			end
		end

		self:NextThink(CurTime() + .15)

		if self.BurnoutTime < CurTime() then
			self:StopSound("snd_jack_hmcd_flare.wav")
			self.Think = nil
			self:SetNWBool("Burntout", true)
		end

		return true
	end
elseif CLIENT then
	local Glow = Material("sprites/mat_jack_basicglow")

	function ENT:Initialize()
	end

	--
	function ENT:Draw()
		if not self:GetNWBool("Burntout") then
			local Pos = self:GetPos()
			render.SetMaterial(Glow)
			render.DrawSprite(Pos, 50, 50, Color(255, math.random(150, 220), math.random(125, 150), 255))
		end

		self:DrawModel()
	end
end