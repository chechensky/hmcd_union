AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName		= "Aimpoint CompM2 Sight"
ENT.ImpactSound="physics/metal/weapon_impact_soft3.wav"
ENT.Model="models/weapons/tfa_ins2/upgrades/phy_optic_aimpoint.mdl"
ENT.EquipmentNum=HMCD_AIMPOINT
ENT.Category = "HMCD: Union - Attachments"
ENT.Spawnable = true
if(SERVER)then
	function ENT:Initialize()
		self.Entity:SetModel(self.Model)
		if self.Material then self.Entity:SetMaterial(self.Material) end
		if self.Color then self.Entity:SetColor(self.Color) end
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			local mass=self.Mass or 15
			phys:SetMass(mass)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end
	function ENT:Use(ply)
		if not(ply.Equipment) then ply.Equipment={} end
		if(not(ply.Equipment[self.PrintName]))then
			ply.Equipment[HMCD_EquipmentNames[self.EquipmentNum]]=true
			net.Start("hmcd_equipment")
			net.WriteInt(self.EquipmentNum,6)
			net.WriteBit(true)
			net.Send(ply)
			if self.Armor then
				ply:SetNWString(self.ArmorType,self.Armor)
				sound.Play("snd_jack_hmcd_disguise.wav",ply:GetPos(),65,80)
			else
				self:EmitSound(self.ImpactSound,65,100)
			end
			self:Remove()
		end
	end
elseif(CLIENT)then
	--
end