
--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_crossbow.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_crossbow"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_crossbow.mdl"
ENT.DefaultAmmoAmt = 1
ENT.AmmoType = "Thumper"
ENT.MuzzlePos = Vector(28, -2.1, 3.65)
ENT.BulletDir = Vector(1, 0, 0)

function ENT:Shoot()
	if not self.Reloading then
		if self.RoundsInMag > 0 then
			self.RoundsInMag = self.RoundsInMag - 1

			if IsValid(self.Owner:GetWeapon(self.SWEP)) then
				self.Owner:GetWeapon(self.SWEP):SetClip1(self.Owner:GetWeapon(self.SWEP):Clip1() - 1)
			end

			local pos, ang = self:GetPos(), self:GetAngles() + (self.AngleOffset or Angle(0, 0, 0))
			local bulletDir = ang:Forward() * self.BulletDir[1] + ang:Right() * self.BulletDir[2] + ang:Up() * self.BulletDir[3]
			local muzzlePos = pos + ang:Forward() * self.MuzzlePos[1] + ang:Right() * self.MuzzlePos[2] + ang:Up() * self.MuzzlePos[3]
			self:GetPhysicsObject():ApplyForceCenter(VectorRand(-80,80))
			local Bolt = ents.Create("ent_jack_hmcd_arrow")
			Bolt.Model = "models/crossbow_bolt.mdl"
			Bolt.FleshyImpactSound = "weapons/crossbow/bolt_skewer1.wav"
			Bolt.Damage = 160
			Bolt.PenetrationPower = 70
			Bolt.HmcdSpawned = self.HmcdSpawned
			Bolt:SetPos(muzzlePos + bulletDir * 5)
			Bolt.Owner = self.Owner
			local Ang = bulletDir:Angle()
			Ang:RotateAroundAxis(Ang:Right(), -180)
			Bolt:SetAngles(Ang)
			Bolt.Fired = true
			Bolt.InitialDir = bulletDir
			Bolt.InitialVel = bulletDir * 10
			Bolt.Poisoned = self.Owner.HMCD_AmmoPoisoned
			self.Owner.HMCD_AmmoPoisoned = false
			Bolt:Spawn()
			Bolt:Activate()
			self:EmitSound(self.CloseFireSound, 125)
		else
			self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
		end
	end
end