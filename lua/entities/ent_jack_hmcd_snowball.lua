--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_snowball.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.SWEP = "wep_jack_hmcd_snowball"
ENT.Model = "models/zerochain/props_christmas/snowballswep/zck_w_snowballswep.mdl"
ENT.Mass = 1
ENT.ImpactSound = "player/footsteps/snow6.wav"

if SERVER then
	function ENT:PickUp(ply)
		if self.Armed then return end
		if GAMEMODE.ZOMBIE and ply.Murderer then return end
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound("weapons/snowball/zck_snowball_pickup01.wav")
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end

	function ENT:PhysicsCollide(data, phys)
		if self.Thrown then
			self.Thrown = false
			self:EmitSound("weapons/snowball/snowball_impact0" .. math.random(1, 2) .. ".wav")
			local effData = EffectData()
			effData:SetOrigin(data.HitPos)
			util.Effect("eff_jack_hmcd_poof", effData)
			SafeRemoveEntityDelayed(self, 0.1)
		elseif data.DeltaTime > .1 then
			self:EmitSound(self.ImpactSound, math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))
			self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity() * .9)
		end
	end

	function ENT:Throw()
		self.Armed = true
	end

	function ENT:StartTouch(ply)
	end
	--
elseif CLIENT then
	function ENT:Initialize()
	end

	--
	function ENT:Draw()
		self:DrawModel()
	end

	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--