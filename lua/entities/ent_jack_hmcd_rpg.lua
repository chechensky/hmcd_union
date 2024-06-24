--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_rpg.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_wep_base"
ENT.PrintName = "RPG-7"
ENT.SWEP = "wep_jack_hmcd_rpg"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/w_rpg.mdl"
ENT.DefaultAmmoAmt = 1
ENT.AmmoType = "RPG_Round"
ENT.MuzzlePos = Vector(13, 0, 2)
ENT.BulletDir = Vector(1, 0, 0)
ENT.Damage = 0

if SERVER then
	function ENT:PickUp(ply)
		if IsValid(self.Owner) then
			local wep = self.Owner:GetWeapon(self.SWEP)

			if self.Owner:Alive() and not (self.Owner.Otrub or self.Owner.Stunned) then
				return
			elseif IsValid(wep) then
				wep:Remove()
			end
		end

		local SWEP = self.SWEP

		if self:GetBodygroup(1) == 1 then
			self.RoundsInMag = 0
		end

		if self:GetBodygroup(1) == 0 then
			self.RoundsInMag = 1
		end

		if ply:HasWeapon(self.SWEP) then
			if self.RoundsInMag > 0 then
				ply:GiveAmmo(self.RoundsInMag, "RPG_Round", true)
				self:SetBodygroup(1, 1)
				self.RoundsInMag = 0
				self:EmitSound("snd_jack_hmcd_ammotake.wav", 65, 80)
				ply:SelectWeapon(SWEP)
			else
				ply:PickupObject(self)
			end
		else
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(self.SWEP):SetClip1(self.RoundsInMag)
			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end

	local rpgWarnings = {
		["combine"] = {
			["male"] = {"npc/combine_soldier/vo/displace.wav", "npc/combine_soldier/vo/displace2.wav", "npc/combine_soldier/vo/ripcordripcord.wav", "npc/metropolice/vo/shit.wav"}
		},
		["rebel"] = {
			["male"] = {"vo/npc/male01/getdown02.wav", "vo/npc/male01/headsup01.wav", "vo/npc/male01/headsup02.wav", "vo/npc/male01/incoming02.wav", "vo/npc/male01/runforyourlife01.wav", "vo/npc/male01/runforyourlife02.wav", "vo/npc/male01/runforyourlife03.wav", "vo/npc/male01/startle01.wav", "vo/npc/male01/strider_run.wav", "vo/npc/male01/uhoh.wav", "vo/npc/male01/watchout.wav", "vo/canals/male01/stn6_incoming.wav"},
			["female"] = {"vo/npc/female01/getdown02.wav", "vo/npc/female01/headsup01.wav", "vo/npc/female01/headsup02.wav", "vo/npc/female01/incoming02.wav", "vo/npc/female01/runforyourlife01.wav", "vo/npc/female01/runforyourlife02.wav", "vo/npc/female01/startle01.wav", "vo/npc/female01/strider_run.wav", "vo/npc/female01/uhoh.wav", "vo/npc/female01/watchout.wav"}
		}
	}

	rpgWarnings["npc_combine_s"] = rpgWarnings["combine"]
	rpgWarnings["npc_sniper"] = rpgWarnings["combine"]
	rpgWarnings["npc_citizen"] = rpgWarnings["rebel"]
	rpgWarnings["npc_metropolice"] = rpgWarnings["cp"]

	function ENT:Shoot()
		if self.NextFire < CurTime() then
			if not self.Reloading then
				if self.RoundsInMag > 0 then
					self.RoundsInMag = self.RoundsInMag - 1

					if IsValid(self.Owner:GetWeapon(self.SWEP)) then
						self.Owner:GetWeapon(self.SWEP):SetClip1(self.Owner:GetWeapon(self.SWEP):Clip1() - 1)
					end

					self.NextFire = CurTime() + .5
					local victims = player.GetAll()
					table.Add(victims, ents.FindByClass("npc_combine_s"))
					table.Add(victims, ents.FindByClass("npc_sniper"))
					table.Add(victims, ents.FindByClass("npc_citizen"))
					table.Add(victims, ents.FindByClass("npc_metropolice"))

					for i, ply in ipairs(victims) do
						local plyRole = ply.Role or ply:GetClass()

						if ply:Health() > 0 and ply ~= self.Owner and rpgWarnings[plyRole] and ply:Visible(self.Owner) and not (ply.Disposition and ply:Disposition(self.Owner) == D_LI) then
							local posnormal = (self.Owner:GetPos() - ply:GetPos()):GetNormalized()
							local aimvector = ply:GetAimVector()
							local DotProduct = aimvector:DotProduct(posnormal)
							local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90

							if ApproachAngle <= 60 then
								local Rand = table.Random(rpgWarnings[plyRole][ply.ModelSex])
								ply.tauntsound = Rand
								ply:EmitSound(Rand)
								local BeepTime = SoundDuration(Rand)
								ply.NextTaunt = CurTime() + BeepTime

								if string.find(ply:GetModel(), "combine") or string.find(ply:GetModel(), "police") then
									ply:EmitSound("npc/combine_soldier/vo/on" .. math.random(1, 4) .. ".wav")

									timer.Simple(BeepTime, function()
										if IsValid(ply) and ply:Health() > 0 then
											ply:EmitSound("npc/combine_soldier/vo/off" .. math.random(1, 6) .. ".wav")
										end
									end)
								end

								break
							end
						end
					end

					timer.Simple(.3, function()
						if IsValid(self) then
							local pos, ang = self:GetPos(), self:GetAngles() + (self.AngleOffset or Angle(0, 0, 0))
							local bulletDir = ang:Forward() * self.BulletDir[1] + ang:Right() * self.BulletDir[2] + ang:Up() * self.BulletDir[3]
							local muzzlePos = pos + ang:Forward() * self.MuzzlePos[1] + ang:Right() * self.MuzzlePos[2] + ang:Up() * self.MuzzlePos[3]
							local backblastEnts = ents.FindInCone(muzzlePos - bulletDir * 42, -bulletDir, 100, math.cos(math.rad(45)))

							local tr = util.QuickTrace(muzzlePos, bulletDir * -42, {self, self.Owner})

							if IsValid(tr.Entity) and not table.HasValue(backblastEnts, tr.Entity) then
								table.insert(backblastEnts, tr.Entity)
							end

							for i, ent in pairs(backblastEnts) do
								if ent ~= self.Owner:GetRagdollEntity() and ent ~= self and ent.Health and ent:Health() > 0 and self.Owner.fakeragdoll:Visible(ent) then
									local DamageAmt = 130
									local Dam = DamageInfo()
									Dam:SetAttacker(self.Owner)
									Dam:SetInflictor(self)
									Dam:SetDamage(DamageAmt)
									Dam:SetDamageForce(bulletDir * -100)

									if ent:IsPlayer() or ent:IsRagdoll() then
										Dam:SetDamageType(DMG_DROWNRECOVER)
									else
										Dam:SetDamageType(DMG_CLUB)
									end

									Dam:SetDamagePosition(ent:GetPos())
									ent:TakeDamageInfo(Dam)
								end
							end

							ParticleEffect("ins_weapon_rpg_backblast", muzzlePos + bulletDir * -42, -bulletDir:Angle())
							self:SetBodygroup(1, 1)
							self:GetPhysicsObject():ApplyForceCenter(VectorRand(-190,190))
							self.Owner:EmitSound(weapons.Get(self.SWEP).CloseFireSound)
							self.Owner:EmitSound(weapons.Get(self.SWEP).FarFireSound)
							self.Owner:SetLagCompensated(true)
							local Rocket = ents.Create("ent_ins2rpgrocket1")
							Rocket.HmcdSpawned = self.HmcdSpawned
							Rocket:SetPos(muzzlePos + bulletDir * 5)
							Rocket.Owner = self.Owner
							local Ang = bulletDir:Angle()
							Rocket:SetAngles(Ang)
							Rocket.Fired = true
							Rocket.InitialDir = bulletDir
							Rocket.InitialVel = bulletDir
							Rocket:Spawn()
							Rocket:Activate()
							Rocket:SetOwner(self.Owner)
							phys = Rocket:GetPhysicsObject()
							self.Owner:SetLagCompensated(false)
							local eyeAng = self.Owner:EyeAngles()
							local forward = eyeAng:Forward()

							if IsValid(phys) then
								Rocket:SetVelocity(forward * 2996)
							end
						end
					end)
				else
					self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
				end
			end
		end
	end
end