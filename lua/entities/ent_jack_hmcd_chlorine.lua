--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_chlorine.lua

--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName		= "Zyklon B"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.ImpactSound="physics/body/body_medium_impact_soft5.wav"
ENT.SecondSound="physics/metal/metal_canister_impact_hard3.wav"
ENT.NextSound=0
ENT.Looped=false
ENT.IsLoot=true
if(SERVER)then
	function ENT:Initialize()
		self.Entity:SetModel("models/props_junk/propanecanister001as.mdl")
		self.Entity:SetMaterial("models/props_junkhuy/propanecanister01a")
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetMass(75)
			phys:Wake()
			phys:EnableMotion(true)
		end
		self.Life=50
		self.DieTime=CurTime()+self.Life
		self.GasTime=CurTime()+5
		timer.Simple(100,function()
			if IsValid(self)then
				self:StopSound("steam_pipe_loop_02.wav")
			end
		end)
	end
	function ENT:Use(ply)
		--ply:PickupObject(self)
	end
	function ENT:Think()
		local Time,SelfPos=CurTime(),self:GetPos()+vector_up
		if(self.DieTime<Time)then return end
		if((self.DieTime+self.Life*2)<Time)then return end
		if(self.GasTime>Time)then return end
		if(self:WaterLevel()>=3)then return end
		if self.NextSound < CurTime() and self.Looped==false and not(self.PlaySound==false) then
			self.NextSound = CurTime() + SoundDuration("steam_pipe_loop_02.wav")
			self.Looped=true
			self:EmitSound("steam_pipe_loop_02.wav",60,100)
		end
		local Part=ents.Create("ent_jack_hmcd_chlorineparticle")
		Part:SetPos(SelfPos+self:GetAngles():Up()*10+self:GetAngles():Right()*-6+self:GetAngles():Forward()*-5)
		Part.HmcdSpawned=self.HmcdSpawned
		Part.Owner=self.Owner
		Part:Spawn()
		Part:Activate()
		Part:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity())
		self:NextThink(Time+math.Rand(.8,1.2))
		return true
	end
	function ENT:PhysicsCollide(data,ent)
		if(data.DeltaTime>.1)then
			self:EmitSound(self.ImpactSound,math.Clamp(data.Speed/3,20,65),math.random(100,120))
			if(self.SecondSound)then sound.Play(self.SecondSound,self:GetPos(),math.Clamp(data.Speed/3,20,65),math.random(100,120)) end
		end
	end
elseif(CLIENT)then
	function ENT:Initialize()
		--
	end
	function ENT:Draw()
		self:DrawModel()
	end
end