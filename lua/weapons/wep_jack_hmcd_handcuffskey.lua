--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_handcuffskey.lua
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
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_axe", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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

--
SWEP.Base = "weapon_base"
SWEP.ViewModel = ""
SWEP.WorldModel = "models/eu_homicide/handcuff_keys.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_handcuffskey")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_handcuffskey"
SWEP.PrintName = "S&W Handcuff Key"
SWEP.Instructions = "This is a tool designed to aid in unlocking or removing handcuffs.\nLMB to take off the handcuffs."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Category="HMCD: Union - Other"
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.ENT = "ent_jack_hmcd_handcuffskey"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 30
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
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
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 100

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:SetupDataTables()
end

--
function SWEP:PrimaryAttack()
	local Ent, HitPos, HitNorm = HMCD_WhomILookinAt(self:GetOwner(), .5, 80)
	if not IsValid(Ent) then return end
	if not (Ent:IsPlayer() or Ent:GetClass() == "prop_ragdoll") then return end
	if not (Ent.CuffedBehind or Ent.CuffedFront) then return end
	if self:GetOwner().HasCuffs then return end

	self:SetNextPrimaryFire(CurTime() + 6)
	self:SetNextSecondaryFire(CurTime() + 6)

	timer.Simple(.1, function()
		if IsValid(self) then
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		end
	end)

	timer.Simple(.2, function()
		if IsValid(self) then
			timer.Simple(.1, function()
				local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 80, {self:GetOwner()})

				if IsValid(self) and (Tr.Entity and (Tr.Entity:IsPlayer() or Tr.Entity:GetClass() == "prop_ragdoll")) then
					self:Uncuff()
				end
			end)
		end
	end)
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then
		self:DoBFSAnimation("draw")
		self:GetOwner():GetViewModel():SetPlaybackRate(1)

		return
	end

	self:DoBFSAnimation("draw")
	self:GetOwner():GetViewModel():SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + .5)

	return true
end

function SWEP:Think()
	if SERVER then
		if self.Suspect then
			local Ent = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 80, {self:GetOwner()}).Entity

			if not IsValid(Ent) or self.Suspect ~= Ent or self:GetOwner().fake then
				if timer.Exists(tostring(self:GetOwner()) .. "ArrestTimer") then
					self.Suspect = nil
					timer.Remove(tostring(self:GetOwner()) .. "ArrestTimer")
					self:SetNextPrimaryFire(CurTime() + 1)
					self:SetNextSecondaryFire(CurTime() + 1)
				end
			end
		end
	end
end

function SWEP:Uncuff()
	if CLIENT then return end
	self:GetOwner():LagCompensation(true)
	local Ent, HitPos, HitNorm = HMCD_WhomILookinAt(self:GetOwner(), .5, 80)
	local AimVec, Mul = self:GetOwner():GetAimVector(), 1
	sound.Play("weapons/357/357_reload1.wav", self:GetOwner():GetShootPos(), 65, math.random(60, 70))
	self:GetOwner():LagCompensation(false)
	local delay = 5

	if Ent:GetClass() == "prop_ragdoll" then
		delay = 2
	end

	self.Suspect = Ent

	timer.Create(tostring(self:GetOwner()) .. "ArrestTimer", delay, 1, function()
		self.Suspect = nil
		Ent.CuffedBehind = false
		Ent.CuffedFront = false

		if IsValid(Ent.handcuffs) then
			Ent.handcuffs:Remove()
		end

		local owner = Ent

		if owner:IsPlayer() then
			owner:ManipulateBoneAngles(owner:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(0, 0, 0))
			owner:ManipulateBoneAngles(owner:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0, 0, 0))
			owner:ManipulateBoneAngles(owner:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 0))
			owner:ManipulateBoneAngles(owner:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 0, 0))
			owner:ManipulateBoneAngles(owner:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, 0))
			owner:ManipulateBoneAngles(owner:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(0, 0, 0))
		end

		local wep = self:GetOwner():GetWeapon("wep_jack_hmcd_handcuffs")

		if IsValid(wep) then
			wep:SetAmount(wep:GetAmount() + 1)
		else
			self:GetOwner():Give("wep_jack_hmcd_handcuffs")
		end
	end)
end

function SWEP:Reload()
end

--
function SWEP:DoBFSAnimation(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end

function SWEP:Holster()
	if timer.Exists(tostring(self:GetOwner()) .. "ArrestTimer") then
		self.Suspect = nil
		timer.Remove(tostring(self:GetOwner()) .. "ArrestTimer")
	end

	return true
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent.Poisoned = self.Poisoned
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

if CLIENT then
	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 5 + Ang:Right() * 3 + Ang:Up() * -1)
				Ang:RotateAroundAxis(Ang:Up(), -150)
				Ang:RotateAroundAxis(Ang:Right(), 60)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel(self.WorldModel)
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
		end
	end
end