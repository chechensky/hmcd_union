AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Walkie Talkie"
ENT.SWEP = "wep_jack_hmcd_walkietalkie"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/sirgibs/ragdoll/css/terror_arctic_radio.mdl"
ENT.Mass = 5

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(self.Mass)
			phys:Wake()
			phys:EnableMotion(true)
		end

		for i, ply in player.Iterator() do
			local wep = ply:GetWeapon(self.SWEP)

			if IsValid(wep) and wep:GetFrequency() == self.Frequency then
				local mic = ents.Create("env_microphone")
				mic:SetName("micro_" .. mic:EntIndex())
				mic:SetPos(ply:GetPos())
				mic:SetParent(ply)
				mic:SetKeyValue("target", mic:GetName())
				mic:SetKeyValue("speaker_dsp_preset", "59")
				mic:SetKeyValue("Sensitivity", "1")
				mic:SetKeyValue("MaxRange", "125")
				self:SetName("speaker_" .. self:EntIndex())
				mic:AddFlags(16)
				mic:Fire("SetSpeakerName", self:GetName())
				mic:Spawn()
				mic:Activate()
				mic:Fire("Disable")
				ply.Mics["Ents"][self:EntIndex()] = mic
				ply.Mics["Players"][self:EntIndex()] = self
			end
		end
	end

	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound(self.ImpactSound, 60, 100)

			if ply:HasWeapon(self.SWEP) then
				ply:PrintMessage(HUD_PRINTTALK, "You hide the additional walkie talkie.")
			end

			for i, playah in player.Iterator() do
				if playah.Mics and playah.Mics["Ents"][self:EntIndex()] then
					playah.Mics["Ents"][self:EntIndex()]:Remove()
					playah.Mics["Ents"][self:EntIndex()] = nil
					playah.Mics["Players"][self:EntIndex()] = nil
				end
			end

			self.Deleting = true
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned

			if self.Frequency then
				ply:GetWeapon(self.SWEP):SetFrequency(self.Frequency)
				ply:GetWeapon(self.SWEP).CurrentPos = self.CurrentPos
				ply:GetWeapon(self.SWEP).Disabled = self.Disabled
			end

			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end
end