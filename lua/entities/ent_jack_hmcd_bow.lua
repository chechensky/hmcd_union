--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_bow.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.PrintName = "Bow"
ENT.SWEP = "wep_jack_hmcd_bow"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_snij_awp.mdl"
ENT.AmmoType = "XBowBolt"
ENT.MuzzlePos = Vector(23, -0.35, 4.3)
ENT.BulletDir = Vector(1, 0, 0)
ENT.Damage = 60

ENT.Attachments = {
	["BowSight"] = {
		bone = "ValveBiped.weapon_bone",
		pos = {
			forward = 0.2,
			up = 10.3,
			right = -3
		},
		ang = {
			forward = 180,
			right = -90
		},
		scale = .7,
		model = "models/bowsight/hunter_sights.mdl"
	}
}

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel("models/weapons/w_snij_awp.mdl")
		self:SetNWBool("BowSight", true)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(20)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:PickUp(ply)
		if IsValid(self.Owner) then
			local wep = self.Owner:GetWeapon(self.SWEP)

			if self.Owner:Alive() and not (self.Owner.Unconscious or self.Owner.Stunned) then
				return
			elseif IsValid(wep) then
				wep:Remove()
			end
		end

		local SWEP = self.SWEP

		if ply:HasWeapon(self.SWEP) then
			ply:PickupObject(self)
		else
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned

			if self.GameSpawned then
				ply:GiveAmmo(1, "XBowBolt", true)
			end

			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end

	function ENT:Shoot()
		if self.NextFire < CurTime() and IsValid(self.Owner) and self.Owner:GetAmmoCount(self.AmmoType) > 0 then
			self.NextFire = CurTime() + self.TriggerDelay
			self.RoundsInMag = self.RoundsInMag - 1

			if IsValid(self.Owner:GetWeapon(self.SWEP)) then
				self.Owner:RemoveAmmo(1, self.AmmoType)
			end

			if self.Owner:GetAmmoCount(self.AmmoType) > 0 then
				self:EmitSound("snd_jack_hmcd_bowload.wav", 55, 100)
			end

			local pos, ang = self:GetPos(), self:GetAngles() + (self.AngleOffset or Angle(0, 0, 0))
			local bulletDir = ang:Forward() * self.BulletDir[1] + ang:Right() * self.BulletDir[2] + ang:Up() * self.BulletDir[3]
			local muzzlePos = pos + ang:Forward() * self.MuzzlePos[1] + ang:Right() * self.MuzzlePos[2] + ang:Up() * self.MuzzlePos[3]
			self:GetPhysicsObject():ApplyForceCenter(-bulletDir * self.Damage * self.NumProjectiles * 3)
			local Arrow = ents.Create("ent_jack_hmcd_arrow")
			Arrow.CollisionSound = "snd_jack_hmcd_arrow.wav"
			Arrow.HmcdSpawned = self.HmcdSpawned
			Arrow:SetPos(muzzlePos + bulletDir * 5)
			Arrow.Owner = self.Owner
			local Ang = bulletDir:Angle()
			Ang:RotateAroundAxis(Ang:Right(), -90)
			Arrow:SetAngles(Ang)
			Arrow.Fired = true
			Arrow.InitialDir = bulletDir
			Arrow.InitialVel = bulletDir * 10
			Arrow.Poisoned = self.Owner.HMCD_AmmoPoisoned
			self.Owner.HMCD_AmmoPoisoned = false
			Arrow:Spawn()
			Arrow:Activate()
			self:EmitSound("snd_jack_hmcd_bowshoot.wav", 60)
		end
	end
end