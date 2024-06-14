--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_beartrap.lua
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

--
SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/stiffy360/beartrap.mdl"
SWEP.WorldModel = "models/stiffy360/beartrap.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_beartrap")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_beartrap"
SWEP.PrintName = "Bear Trap"
SWEP.Instructions = "This is a double spring steel bear trap, designed to remotely catch an animal.\nLMB to deploy."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.ViewModelFlip = false
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
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0
SWEP.Category="HMCD: Union - Traitor"
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.CommandDroppable = false
SWEP.CarryWeight = 1000
SWEP.Poisonable = true
SWEP.ENT = "ent_jack_hmcd_beartrap"

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:SetupDataTables()
end

--
function SWEP:PrimaryAttack()
	local tr = util.TraceLine({
		start = self:GetOwner():GetShootPos(),
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 100,
		filter = self:GetOwner()
	})

	if tr.HitWorld then
		local dot = vector_up:Dot(tr.HitNormal)

		if dot > 0.55 and dot <= 1 then
			self:DeployBearTrap()
		end
	end

	self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:DeployBearTrap()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)

	local tr = util.TraceLine({
		start = self:GetOwner():GetShootPos(),
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 100,
		filter = self:GetOwner()
	})

	local BearTrap = ents.Create("ent_jack_hmcd_beartrap")
	BearTrap:SetPos(tr.HitPos + tr.HitNormal)
	local ang = tr.HitNormal:Angle()
	ang:RotateAroundAxis(ang:Right(), -90)
	BearTrap:SetAngles(ang)
	BearTrap.Attacker = self:GetOwner()

	if self.Poisoned then
		BearTrap.Poisoned = true
	end

	BearTrap:Spawn()
	BearTrap.Constraint = constraint.Weld(BearTrap, tr.Entity, 0, 0, 3000000, true, false)
	BearTrap.Constraint.PickupAble = true
	self:GetOwner():SetLagCompensated(false)

	timer.Simple(.1, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	self:DoBFSAnimation("armtrap")
	self:GetOwner():GetViewModel():SetPlaybackRate(0)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
	self.DownAmt = 100
	self.Ready = false

	return true
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

function SWEP:SecondaryAttack()
end

---HAHAHAHHAHAH
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

		pos = pos - ang:Up() * (self.DownAmt + 6) + ang:Forward() * 10 + ang:Right() * 5

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if not self.WModel then
				self.WModel = ClientsideModel(self.WorldModel)
				self.WModel:SetPos(self:GetOwner():GetPos())
				self.WModel:SetParent(self:GetOwner())
				self.WModel:SetNoDraw(true)
				--self.WModel:SetModelScale(1,0)
			else
				if pos and ang then
					self.WModel:SetRenderOrigin(pos + ang:Right() * 3 + ang:Up() * -3 + ang:Forward() * 5)
					ang:RotateAroundAxis(ang:Forward(), 180)
					ang:RotateAroundAxis(ang:Right(), 10)
					ang:RotateAroundAxis(ang:Up(), 30)
					self.WModel:SetRenderAngles(ang)
					self.WModel:DrawModel()
					--self.WModel:SetModelScale(0.5,0)
				end
			end
		end
	end
end