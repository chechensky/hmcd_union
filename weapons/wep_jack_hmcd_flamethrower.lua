if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/cw_doi_flamethrower_american")
end

SWEP.IconTexture = "vgui/hud/cw_doi_flamethrower_american"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_jack_hmcd_firearm_base"
SWEP.PrintName = "M2 Flamethrower"
SWEP.Instructions = "This is a dick.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement doesn't count.\nCrouching helps stability.\nBullets cannot ricochet and penetrate."
SWEP.Primary.ClipSize = 600
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/v_flame_m2a3.mdl"
SWEP.WorldModel = "models/weapons/w_flame_m2.mdl"
SWEP.ViewModelFlip = false
SWEP.Primary.Automatic = true
SWEP.ViewModelFOV = 80
SWEP.SprintPos = Vector(10, 0, -3)
SWEP.SprintAng = Angle(-20, 40, -50)
SWEP.AimPos = Vector(-2.3, 2, 2)
SWEP.AimAng = Angle(1.3, 0, 0)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.63, -4, 0.4)
SWEP.ReloadTime = 5.3
SWEP.ReloadRate = .6
SWEP.UseHands = true
SWEP.ReloadSound = ""
SWEP.AmmoType = "AR2"
SWEP.TriggerDelay = .1
SWEP.CycleTime = 0
SWEP.Category="HMCD: Union - Other"
SWEP.Recoil = .5
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_flamethrower"
SWEP.FuckedWorldModel = true
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "base_draw"
SWEP.FireAnim = "base_dryfire"
SWEP.ReloadAnim = "base_reloadempty"
SWEP.TacticalReloadAnim = "base_reload"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 1
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot = 1
SWEP.HolsterPos = Vector(3, -7, -4)
SWEP.HolsterAng = Angle(160, 10, 180)
SWEP.CarryWeight = 4500
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.NextFireTime = 0

SWEP.MuzzlePos = {30, -5.1, -3.1}

SWEP.ReloadAdd = 2
SWEP.NextFireAnim = 0
SWEP.Shooting = false

function SWEP:ModifiedIgnite(ent, ignitetime)
	local curIgniteTime = 0

	if IsValid(ent.CurrentFire) then
		curIgniteTime = ent.CurrentFire:GetInternalVariable("lifetime") - CurTime()
	end

	ent:Ignite(curIgniteTime + ignitetime)
	local owner = ent

	if owner:IsPlayer() and IsValid(self:GetOwner()) then
		owner.LastIgniter = self:GetOwner()
	end
end

local BurnMuls = {
	[MAT_ANTLION] = 1.3,
	[MAT_BLOODYFLESH] = 0.8,
	[MAT_DIRT] = 0.5,
	[MAT_EGGSHELL] = 0.4,
	[MAT_FLESH] = 1,
	[MAT_ALIENFLESH] = 1.5,
	[MAT_PLASTIC] = 1.2,
	[MAT_FOLIAGE] = 2.5,
	[MAT_COMPUTER] = 1,
	[MAT_GRASS] = 1.2,
	[MAT_WOOD] = 2
}

function SWEP:PrimaryAttack()
	if self:Clip1() > 0 and not self.Shooting and self:GetReady() and self.SprintingWeapon <= 10 then
		if SERVER then
			self.Shooting = true
			self:GetOwner():EmitSound("weapons/flamethrower/flamethrower_start.wav", 70, 100)
			self.NextFlameSound = CurTime() + 0.4

			hook.Add("Think", self, function()
				if not (self:GetOwner():KeyDown(IN_ATTACK) and self:GetReady() and self.SprintingWeapon <= 10) or self:Clip1() == 0 then
					hook.Remove("Think", self)
					self.Shooting = false
					self:GetOwner():StopSound("weapons/flamethrower/flamethrower_loop.wav")
					self:GetOwner():StopSound("weapons/flamethrower/flamethrower_start.wav")
					self:GetOwner():EmitSound("weapons/flamethrower/flamethrower_end.wav", 70, 100)
				else
					if self.NextFireAnim < CurTime() then
						self:DoBFSAnimation(self.FireAnim)
						self.NextFireAnim = CurTime() + 0.2
					end

					if self.NextFlameSound and self.NextFlameSound < CurTime() then
						self.NextFlameSound = nil
						self:GetOwner():EmitSound("weapons/flamethrower/flamethrower_loop.wav", 70, 100)
					end
					--ParticleEffect( "alien_flamethrower_fire_start", self:GetOwner():GetShootPos() + self:GetOwner():EyeAngles():Forward() * 50 + self:GetOwner():EyeAngles():Right() * 7 - self:GetOwner():EyeAngles():Up() * 15, self:GetOwner():EyeAngles(), self )
				end

				local effData = EffectData()
				effData:SetNormal(self:GetOwner():GetAimVector())
				effData:SetEntity(self:GetOwner())
				local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
				effData:SetOrigin(pos + ang:Forward() * 10)
				util.Effect("eff_jack_hmcd_flamethrower", effData)
				local tr = util.QuickTrace(pos + ang:Forward() * 10, self:GetOwner():GetAimVector() * 360, self:GetOwner())

				for i, ent in pairs(ents.GetAll()) do
					local dist = util.DistanceToLine(pos + ang:Forward() * 10, tr.HitPos, ent:GetPos())
					local moveType = ent:GetMoveType()

					if (moveType == MOVETYPE_VPHYSICS or moveType == MOVETYPE_WALK) and dist <= 60 and ent ~= self:GetOwner() and ent:VisibleVec(tr.HitPos) and ent:GetClass() ~= "ent_jack_hmcd_fire" then
						self:ModifiedIgnite(ent, dist / 20)
					end
				end

				if tr.HitWorld and BurnMuls[tr.MatType] and math.random(1, 30 / BurnMuls[tr.MatType]) == 1 then
					local farAway = true

					for i, vec in pairs(GAMEMODE.Fires) do
						if vec:DistToSqr(tr.HitPos) < 40000 then
							farAway = false
							break
						end
					end

					if farAway then
						local Fire = ents.Create("ent_jack_hmcd_fire")
						Fire.Initiator = self:GetOwner()
						Fire.Power = 3
						Fire:SetPos(tr.HitPos)
						Fire:Spawn()
						Fire:Activate()
					end
				end
			end)
		end
	end
end