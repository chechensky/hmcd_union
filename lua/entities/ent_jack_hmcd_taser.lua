--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_taser.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.SWEP = "wep_jack_hmcd_taser"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/defcon/taser/w_taser.mdl"
ENT.DefaultAmmoAmt = 1
ENT.AmmoType = "SniperPenetratedRound"
ENT.MuzzlePos = Vector(0.5, 6, 0)
ENT.BulletDir = Vector(0, 1, 0)
ENT.Damage = 0

if SERVER then
	ENT.Attachments = {
		["Laser"] = {}
	}
end

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
			self:GetPhysicsObject():ApplyForceCenter(-bulletDir * self.Damage * self.NumProjectiles * 3)
			local Dart = ents.Create("ent_jack_hmcd_arrow")
			Dart.HmcdSpawned = self.HmcdSpawned
			Dart.Owner = self.Owner
			local Ang = bulletDir:Angle()
			Ang:RotateAroundAxis(Ang:Right(), -270)
			Dart:SetAngles(Ang)
			Dart:SetPos(muzzlePos + bulletDir * 5 + Ang:Right() * 0.5)
			Dart.Fired = true
			Dart.InitialDir = bulletDir
			Dart.InitialVel = bulletDir * 10
			Dart.Poisoned = self.Owner.HMCD_AmmoPoisoned
			Dart.Damage = 1
			Dart.PenetrationPower = 1
			Dart.Model = "models/taser_grapl/taser_grapl.mdl"
			Dart.DropSpeed = .01
			Dart.Speed = 10

			Dart.CallbackFunc = function(dart, hitEnt)
				local owner = hitEnt
				dart:EmitSound("tazer.wav", 60, 100)

				if owner:IsPlayer() then
					local lifeID = owner.LifeID

					timer.Simple(.1, function()
						if IsValid(owner) and owner.LifeID == lifeID and not owner.Stunned then
							owner.Stunned = true
							owner:CreateFake()
						end
					end)
				end

				timer.Simple(8, function()
					if IsValid(hitEnt) then
						if IsValid(owner) and owner:IsPlayer() then
							owner.Stunned = false
						end
					end

					if IsValid(dart) then
						dart:StopSound("tazer.wav")
					end
				end)
			end

			self.Owner.HMCD_AmmoPoisoned = false
			Dart:Spawn()
			Dart:Activate()
			local Dart2 = ents.Create("ent_jack_hmcd_arrow")
			Dart2.HmcdSpawned = self.HmcdSpawned
			Dart2:SetPos(muzzlePos + bulletDir * 5 + Ang:Right() * -0.5)
			Dart2.Owner = self.Owner
			Dart2:SetAngles(Ang)
			Dart2.Fired = true
			Dart2.InitialDir = bulletDir
			Dart2.InitialVel = bulletDir * 10
			Dart2.Poisoned = self.Owner.HMCD_AmmoPoisoned
			self.Owner.HMCD_AmmoPoisoned = false
			Dart2.Damage = 1
			Dart2.PenetrationPower = 1
			Dart2.Model = "models/taser_grapl/taser_grapl.mdl"
			Dart2.DropSpeed = Dart.DropSpeed
			Dart2.Speed = Dart.Speed
			Dart2:Spawn()
			Dart2:Activate()
			self:EmitSound(self.CloseFireSound, 125)
		else
			self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
		end
	end
end