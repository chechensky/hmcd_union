--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_poisoncanister.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Zyklon B"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.IsLoot = true

if SERVER then
	local function DebugPos(pos)
		local Sp = EffectData()
		Sp:SetOrigin(pos)
		util.Effect("WaterSplash", Sp, true, true)
	end

	function ENT:Initialize()
		self.Entity:SetModel("models/jordfood/jtun.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(10)
			phys:Wake()
			phys:EnableMotion(true)
		end

		self.Life = 100
		self.DieTime = CurTime() + self.Life
		self.GasTime = CurTime() + 5
		self.NextVisibilityCheck = 0
	end

	function ENT:Use(ply)
		ply:PickupObject(self)
	end

	function ENT:Think()
		local Time, SelfPos = CurTime(), self:GetPos() + vector_up

		if self.NextVisibilityCheck < Time then
			self.NextVisibilityCheck = Time + .4

			for i, ply in ipairs(player.GetAll()) do
				if not (ply == self.Owner or ply.NotifiedAboutCyanide) then
					for i, ent in ipairs(ents.FindInCone(ply:EyePos(), ply:GetAimVector(), 1000, math.cos(math.rad(75)))) do
						if ent == self then
							ply.NotifiedAboutCyanide = true
							break
						end
					end
				end
			end
		end

		if self.DieTime < Time then return end
		if (self.DieTime + self.Life * 2) < Time then return end
		if self.GasTime > Time then return end
		if self:WaterLevel() > 0 then return end
		local Part = ents.Create("ent_jack_hmcd_gasparticle")
		Part:SetPos(SelfPos)
		Part.HmcdSpawned = self.HmcdSpawned
		Part.Owner = self.Owner
		Part:Spawn()
		Part:Activate()
		Part:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity())
		--[[
		for i=1,2 do
			local Spread=1-((self.DieTime-Time)/self.Life)
			Spread=1 -- edbug
			-- turn 1 --
			local To1=self:RandVec(SelfPos,Spread)
			local Tr1,Fr1=util.TraceLine({start=SelfPos,endpos=To1,filter={self}}),To1
			if(Tr1.Hit)then Fr1=Tr1.HitPos+Tr1.HitNormal*10;Spread=Spread*1.5 end
			-- turn 2 --
			self:Burst(Fr1,Spread)
			local To2=self:RandVec(Fr1,Spread)
			local Tr2,Fr2=util.TraceLine({start=Fr1,endpos=To2,filter={self}}),To2
			if(Tr2.Hit)then Fr2=Tr2.HitPos+Tr2.HitNormal*10;Spread=Spread*1.5 end
			-- turn 3 --
			self:Burst(Fr2,Spread)
			local To3=self:RandVec(Fr2,Spread)
			local Tr3,Fr3=util.TraceLine({start=Fr2,endpos=To3,filter={self}}),To3
			if(Tr3.Hit)then Fr3=Tr3.HitPos+Tr3.HitNormal*10;Spread=Spread*1.5 end
			-- turn 4 --
			self:Burst(Fr3,Spread)
			local To4=self:RandVec(Fr3,Spread)
			local Tr4,Fr4=util.TraceLine({start=Fr3,endpos=To4,filter={self}}),To4
			if(Tr4.Hit)then Fr4=Tr4.HitPos+Tr4.HitNormal*10;Spread=Spread*1.5 end
			-- final --
			self:Burst(Fr4,Spread)
		end
		--]]
		self:NextThink(Time + math.Rand(.8, 1.2))

		return true
	end

	--[[
	function ENT:RandVec(pos,spread)
		local Vec=VectorRand()*math.Rand(1,50*spread)
		Vec.x=Vec.x*1.5
		Vec.y=Vec.y*1.5
		return pos+Vec
	end
	function ENT:Burst(pos,spread)
		DebugPos(pos)
		local Tr,Chance=util.TraceLine({start=pos,endpos=self:GetPos()+vector_up,filter={self}}),15
		if(Tr.Hit)then Chance=3 end
		if not(math.random(1,Chance)==3)then return end
		for key,playa in pairs(ents.FindInSphere(pos,200*spread))do
			if((playa:IsPlayer())and(playa:Team()==2)and(playa:Alive()))then
				local Tr=util.TraceLine({start=pos,endpos=playa:GetShootPos(),filter={self,playa}})
				if not(Tr.Hit)then HMCD_Poison(playa,self.Owner,true) end --playa:TakeDamage(1,nil,nil)
			end
		end
	end
	--]]
	function ENT:PhysicsCollide(data, ent)
		if data.DeltaTime > .1 then
			sound.Play("physics/metal/soda_can_impact_soft" .. math.random(2, 3) .. ".wav", self:GetPos(), 55, math.random(90, 110))
		end
	end
elseif CLIENT then
	function ENT:Initialize()
	end

	--
	function ENT:Draw()
		self:DrawModel()
	end
end