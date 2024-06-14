if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.Category = "NPC_WEAPONS"
SWEP.Author = ""
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.GrenadeTimer = false
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_bugbait.mdl"
SWEP.RunAwayTimer = false
SWEP.StealthTimer = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.BaseCombineHoldType = false
SWEP.Slash = 1
SWEP.IsCombine = false
SWEP.CooldownTimer = false
SWEP.ShowWorldModel = false
SWEP.easterEgg = false

function SWEP:Deploy()
	if self:GetOwner():IsPlayer() and self.easterEgg == false then
		self.easterEgg = true
		PrintMessage(HUD_PRINTCENTER, "Wait, you're not supposed to have those... but I'll still reward your creativity. Have fun!")
		self:GetOwner():ConCommand("play ba_misc/ultraegg.wav")
	end
end

function SWEP:Infect(playah)
	if not playah.Infected then
		local LifeID = playah.LifeID
		playah.Infected = true
		playah.InfectionStarted = false

		if not timer.Exists(tostring(playah) .. "InfectionTimer") then
			timer.Create(tostring(playah) .. "InfectionTimer", math.random(45, 60), 1, function()
				net.Start("hmcd_infected")
				net.WriteEntity(playah)
				net.WriteBit(playah.Infected)
				net.WriteBit(playah.InfectionStarted)
				net.Send(playah)

				timer.Simple(128, function()
					if IsValid(playah) and playah:Alive() then
						if playah.LifeID == LifeID then
							if playah.fake then
								playah:KillSilent()
								playah.fake = false
							else
								playah:Kill()
							end
						end
					end
				end)
			end)
		end
	else
		if timer.Exists(tostring(playah) .. "InfectionTimer") then
			timer.Adjust(tostring(playah) .. "InfectionTimer", timer.TimeLeft(tostring(playah) .. "InfectionTimer") / 1.5, nil, nil)
		end
	end
end

local MaterialTable = {
	[67] = {"MetalVent.ImpactHard", 200},
	[77] = {"MetalVent.ImpactHard", 200},
	[87] = {"Wood_Panel.ImpactHard", 100}
}

function SWEP:PrimaryAttack()
	if not self:IsValid() or not self:GetOwner():IsValid() then return end
	pos = self:GetOwner():GetShootPos()
	ang = self:GetOwner():GetAimVector()
	damagedice = math.Rand(0.9, 1.10)
	primdamage = math.random(12, 18)
	pain = primdamage * damagedice

	if SERVER and IsValid(self:GetOwner()) then
		local slash = {}
		slash.start = pos
		slash.endpos = pos + (ang * 70)
		slash.filter = self:GetOwner()
		slash.mins = Vector(-5, -5, -20)
		slash.maxs = Vector(5, 5, 5)
		local slashtrace = util.TraceHull(slash)

		if slashtrace.Hit then
			targ = slashtrace.Entity

			if targ:IsPlayer() or targ:IsNPC() then
				if targ.ZombieBA == true then return end
				paininfo = DamageInfo()
				paininfo:SetDamage(pain)
				paininfo:SetDamageType(DMG_SLASH)
				paininfo:SetAttacker(self:GetOwner())
				paininfo:SetInflictor(self.Weapon)
				local RandomForce = math.random(1000, 20000)
				paininfo:SetDamageForce(slashtrace.Normal * RandomForce)

				if targ:IsPlayer() then
					targ:ViewPunch(Angle(-10, math.random(-20, 20), math.random(-5, 5)))
				end

				if self:GetOwner().HitInLArm == true and self:GetOwner().HitInRArm == true then
					paininfo:ScaleDamage(.1)
				elseif self:GetOwner().HitInLArm == true or self:GetOwner().HitInRArm == true then
					paininfo:ScaleDamage(.5)
				end

				if targ.IsGrabbed == true then
					paininfo:ScaleDamage(.5)
				end

				timer.Simple(3, function()
					targ.IsGrabbed = nil
				end)

				if math.random() * 100 > 30 and targ:GetPos():Distance(self:GetOwner():GetPos()) <= 65 and targ.IsGrabbed == nil and self:GetOwner().IsGrabbing == nil then
					--local grabPos = self:GetOwner():LocalToWorld(Vector(30,0,0))
					local grabPos = targ:GetPos()

					if targ:IsPlayer() then
						targ:ViewPunch(Angle(10, 0, 0))
					elseif targ:IsNPC() then
						targ:FearSound()
					end

					targ:EmitSound("InfectedGrab.BA")
					targ.IsGrabbed = true
					self:GetOwner().IsGrabbing = true

					timer.Simple(2, function()
						if IsValid(self) then
							self:GetOwner().IsGrabbing = nil
						end
					end)

					timer.Simple(3, function()
						targ.IsGrabbed = nil
					end)

					timer.Create("BAGrab", 0.001, 150, function()
						if IsValid(self) and self:GetOwner():IsValid() and IsValid(targ) and targ.IsGrabbed == true and self:GetOwner():GetPos():Distance(targ:GetPos()) < 80 then
							targ:SetPos(grabPos)
						else
							timer.Stop("BAGrab")
							targ.IsGrabbed = nil

							if IsValid(self) then
								self:GetOwner().IsGrabbing = nil
							end
						end
					end)

					timer.Start("BAGrab")
				else
					local blood = targ:GetBloodColor()
					local fleshimpact = EffectData()
					fleshimpact:SetEntity(self.Weapon)
					fleshimpact:SetOrigin(slashtrace.HitPos)
					fleshimpact:SetNormal(slashtrace.HitPos)

					if blood ~= nil and blood >= 0 then
						fleshimpact:SetColor(blood)
						util.Effect("BloodImpact", fleshimpact)
					end

					targ:EmitSound("npc/zombie/claw_strike" .. math.random(3) .. ".wav")
					self:Infect(targ)

					if SERVER then
						targ:TakeDamageInfo(paininfo)
					end
				end
			elseif HMCD_IsDoor(targ) then
				local mat = targ:GetMaterialType()

				if MaterialTable[mat] ~= nil then
					targ:EmitSound(MaterialTable[mat][1])
				else
					targ:EmitSound("Wood_Panel.ImpactHard")
				end

				if SERVER then
					if not targ.DoorHealth then
						if MaterialTable[mat] ~= nil then
							targ.DoorHealth = MaterialTable[mat][2]
						else
							targ.DoorHealth = math.random(60, 200)
						end
					end

					targ.DoorHealth = targ.DoorHealth - math.random(10, 15)

					if targ.DoorHealth <= 0 then
						HMCD_BlastThatDoor(targ)
						self:GetOwner().BreakingDoor = false
					end
				end
			elseif targ ~= nil then
				self:GetOwner():EmitSound("HitEnemy.BA")
				paininfo = DamageInfo()
				paininfo:SetDamage(pain)
				paininfo:SetDamageType(DMG_SLASH)
				paininfo:SetAttacker(self:GetOwner())
				paininfo:SetInflictor(self.Weapon)
				local RandomForce = math.random(100, 200)
				paininfo:SetDamageForce(slashtrace.Normal * RandomForce)

				if self:GetOwner().HitInLArm == true and self:GetOwner().HitInRArm == true then
					paininfo:ScaleDamage(.1)
				elseif self:GetOwner().HitInLArm == true or self:GetOwner().HitInRArm == true then
					paininfo:ScaleDamage(.5)
				end

				if SERVER then
					targ:TakeDamageInfo(paininfo)
				end
			end
		else
			self:GetOwner():EmitSound("npc/zombie/claw_miss" .. math.random(2) .. ".wav")
		end
	end
end

function SWEP:ChaseFailed()
	self.FailedChase = true
end