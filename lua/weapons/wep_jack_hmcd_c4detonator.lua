--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_c4detonator.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 80
	SWEP.Slot = 4
	SWEP.SlotPos = 2
	killicon.AddFont("wep_jack_hmcd_oldgrenade", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

	function SWEP:Initialize()
	end

	--wat
	function SWEP:DrawViewModel()
		return false
	end

	function SWEP:DrawWorldModel()
		self:DrawModel()
	end

	function SWEP:DrawHUD()
	end
end

SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/weapons/v_c4_sec.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_c4_detonator")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_c4_detonator"
SWEP.PrintName = "M57 Detonator"
SWEP.Instructions = "This is a device used to trigger an explosive device.\n\nLMB to detonate the charges."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = "Сырое говно"
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.UseHands = true
SWEP.InsHands = true
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Category="HMCD: Union - Other"
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 250

function SWEP:Initialize()
	self:SetHoldType("slam")
	self.Thrown = false
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	--if not HMCD_CSInfo["Hints"][game.GetMap()] then return end
	local plantedBombs = {}

	for j, c4 in pairs(ents.FindByClass("ent_jack_hmcd_c4")) do
		plantedBombs[j] = c4
		break
	end
	local sitesReady = {
		[1] = true,
		[2] = true
	}

	for i = 1, 2 do
		if not plantedBombs[j] then
			sitesReady[1] = false
			break
		end
	end

	for i = 6, 2 do
		if not plantedBombs[j] then
			sitesReady[2] = false
			break
		end
	end

	if not (sitesReady[1] or sitesReady[2]) then
		if SERVER then
			if table.Count(plantedBombs) > 0 then
				self:GetOwner():PrintMessage(HUD_PRINTTALK, "There aren't enough charges planted. The blast won't be powerful enough!")
			else
				self:GetOwner():PrintMessage(HUD_PRINTTALK, "There are no charges planted currently!")
			end
		end

		return
	end

	self:DoBFSAnimation("det_detonate")

	timer.Simple(.25, function()
		if IsValid(self) then
			self:EmitSound("c4_click.wav", 75)

			timer.Simple(.75, function()
				if IsValid(self) and SERVER then
					for i, canBlow in pairs(sitesReady) do
						if canBlow then
							ParticleEffect("pcf_jack_incendiary_ground_sm2", self:GetPos(), vector_up:Angle())
							sound.Play("iedins/ied_detonate_01.wav", self:GetPos(), 500)

							for j, ent in pairs(ents.GetAll()) do
								local dist = ent:GetPos():Distance(self:GetPos())
								local dmg = math.Round(25000 / dist)

								if ent:GetClass() == "ent_jack_hmcd_c4" then
									ent:Ignite(10)
									ent:Remove()
								end

								if dmg > 0 then
									local force = (ent:GetPos() - self:GetPos()):GetNormalized() * dmg * 5

									if dmg > 20 then
										if ent:IsPlayer() and not ent:Alive() then
											ent:Ignite(10)
											ent:Kill()
										elseif HMCD_IsDoor(ent) then
											HMCD_BlastThatDoor(ent, force)
										end
									end

									local dmgInfo = DamageInfo()
									dmgInfo:SetAttacker(self:GetOwner())
									dmgInfo:SetDamage(dmg)
									dmgInfo:SetDamageType(DMG_BLAST)
									dmgInfo:SetDamageForce(force)
									ent:TakeDamageInfo(dmgInfo)
								end
							end
						end
					end
					self:Remove()
				end
			end)
		end
	end)

	self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	--for i=0,10 do PrintTable(self:GetOwner():GetViewModel():GetAnimInfo(i)) end
	self:DoBFSAnimation("det_draw")
	self:SetNextPrimaryFire(CurTime() + 1)

	return true
end

function SWEP:SecondaryAttack()
end

--
function SWEP:Think()
	if SERVER then
		local HoldType = "slam"

		if self:GetOwner():KeyDown(IN_SPEED) then
			HoldType = "normal"
		end

		self:SetHoldType(HoldType)
	end
end

function SWEP:Reload()
end

--
function SWEP:DoBFSAnimation(anim)
	if self:GetOwner() and self:GetOwner().GetViewModel then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	end
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true
end

-- I do all this, bitch
if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * self.DownAmt + ang:Forward() * -1 + ang:Right()

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if not self.WModel then
				self.WModel = ClientsideModel("models/weapons/w_c4.mdl")
				self.WModel:SetPos(self:GetOwner():GetPos())
				self.WModel:SetParent(self:GetOwner())
				self.WModel:SetBodygroup(1, 1)
				self.WModel:SetSubMaterial(0, "models/hands/hands_color")
				self.WModel:SetNoDraw(true)
			else
				if pos and ang then
					self.WModel:SetRenderOrigin(pos + ang:Right() * -0.5 + ang:Up() * -1.5 + ang:Forward() * 3)
					ang:RotateAroundAxis(ang:Forward(), -220)
					ang:RotateAroundAxis(ang:Right(), 150)
					ang:RotateAroundAxis(ang:Up(), -190)
					self.WModel:SetRenderAngles(ang)
					self.WModel:DrawModel()
				end
			end
		end
	end
end