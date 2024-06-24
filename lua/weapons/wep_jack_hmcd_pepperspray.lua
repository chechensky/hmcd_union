--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_pepperspray.lua
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
	SWEP.Slot = 3
	SWEP.SlotPos = 4
	killicon.AddFont("wep_jack_hmcd_pepperspray", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.IconTexture = "vgui/wep_jack_hmcd_pepperspray"
SWEP.ViewModel = "models/weapons/custom/v_pepperspray.mdl"
SWEP.WorldModel = "models/weapons/custom/pepperspray.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_pepperspray")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "SR Pepper Spray"
SWEP.Instructions = "This is an aerosol spray which contains a compound that irritates the eyes to cause a burning sensation, pain, and temporary blindness.\n\nLMB to spray."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Category="HMCD: Union - Other"
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
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
SWEP.ENT = "ent_jack_hmcd_pepperspray"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 450
SWEP.DrawAnim = "draw"
SWEP.UseHands = true
SWEP.SafetyOn = false
SWEP.NextSafetySwitch = 0
SWEP.SafetyOffAnim = "safetyoff"
SWEP.SafetyOnAnim = "safetyon"
SWEP.FireAnim = "startsh"
SWEP.FireAnimStop = "stopsh"
SWEP.DoStopAnimation = true
SWEP.DoStartAnimation = true

function SWEP:Initialize()
	self:SetHoldType("pistol")
	self.DownAmt = 20
	self:SetAmount(1000)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "Amount")
end

function SWEP:DoBFSAnimation(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then
		self:DoBFSAnimation(self.DrawAnim)
		self:GetOwner():GetViewModel():SetPlaybackRate(.1)

		return
	end

	self:DoBFSAnimation(self.DrawAnim)

	return true
end

function SWEP:Reload()

	if self.NextSafetySwitch > CurTime() then return end
	if self:GetOwner():KeyDown(IN_ATTACK) then return end
	--[[self.NextSafetySwitch=CurTime()+1
	if self.SafetyOn then
		self.SafetyOn=false
		self:DoBFSAnimation(self.SafetyOffAnim)
	else
		self.SafetyOn=true
		self:DoBFSAnimation(self.SafetyOnAnim)
	end]]
end

function SWEP:CanSprayEyes(ent)
	if ent:IsRagdoll() then return true end
	local entPos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1"))
	local TrueVec = (self:GetOwner():GetShootPos() - entPos):GetNormalized()
	local LookVec

	if ent.GetAimVector then
		LookVec = ent:GetAimVector()
	else
		LookVec = ent:EyeAngles():Forward()
	end

	local DotProduct = LookVec:DotProduct(TrueVec)
	local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90
	if ApproachAngle <= 90 then
		return true
	else
		return false
	end
end

function SWEP:Holster(newWep)
	self:StopSound("spray.wav")

	return true
end

function SWEP:Think()
	if SERVER then
		local HoldType = "pistol"

		if self:GetOwner():KeyDown(IN_SPEED) then
			self:StopSound("spray.wav")
			HoldType = "normal"
		end

		self:SetHoldType(HoldType)

		if self.SafetyOn == false then
			if (self:GetOwner():KeyDown(IN_ATTACK) and not self:GetOwner():KeyDown(IN_SPEED)) and not self:GetOwner().fake then
				if self:GetAmount() > 0 then
					self:SetAmount(self:GetAmount() - 1)

					local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 100, {self:GetOwner()})

					util.Decal("PepperSpray_" .. math.random(1, 3), Tr.HitPos - Tr.HitNormal, Tr.HitPos + Tr.HitNormal)
					local owner = (Tr.Entity:IsRagdoll() and RagdollOwner(Tr.Entity)) or Tr.Entity
					if IsValid(owner) and owner:IsPlayer() or owner:IsRagdoll() then
						if owner:GetNWString("Helmet") ~= "Motorcycle" and owner:GetNWString("Mask") ~= "Gas Mask" and not (string.find(owner:GetNWString("Bodyvest"), "Combine") or owner:GetNWString("Helmet") == "RiotHelm") and self:CanSprayEyes(Tr.Entity) then
							owner.capsicum = owner.capsicum + 0.1
						end
					end
				else
					self:StopSound("spray.wav")
				end

				if self.DoStartAnimation then
					self:DoBFSAnimation(self.FireAnim)
					self.DoStopAnimation = true
					self.DoStartAnimation = false
				end
			else
				if self.DoStopAnimation then
					self:StopSound("spray.wav")
					self.DoStartAnimation = true
					self.DoStopAnimation = false
					self:DoBFSAnimation(self.FireAnimStop)
				end
			end
		end
	end
end

function SWEP:OnRemove()
	self:StopSound("spray.wav")
end

function SWEP:PrimaryAttack()


	if not self.SafetyOn and self:GetAmount() ~= 0 then
		local effectdata = EffectData()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
		effectdata:SetEntity(self.Weapon)
		effectdata:SetNormal(self:GetOwner():GetAimVector())
		effectdata:SetOrigin(Pos + Ang:Forward() * 3 + Ang:Right() * 2.3 + Ang:Up() * -4)
		effectdata:SetAttachment(1)
		util.Effect("eff_jack_hmcd_pepperparticle", effectdata)
		self:EmitSound("spray.wav", 60, 120)
	end
end

function SWEP:SecondaryAttack()
end

--
function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent.PepperSprayAmount = self:GetAmount()
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

if CLIENT then

	function SWEP:DrawWorldModel()
		if 1 then
			self:DrawModel()
		end
	end
end

function SWEP:DrawWorldModel()
	local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

	if self.DatWorldModel then
		if Pos and Ang then
			self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 3 + Ang:Right() * 1.3)
			Ang:RotateAroundAxis(Ang:Right(), 180)
			Ang:RotateAroundAxis(Ang:Up(), -90)
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