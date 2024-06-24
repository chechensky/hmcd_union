--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_m67.lua
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
SWEP.ViewModel = "models/weapons/tfa_ins2/v_m67.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_m67.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_m67")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_m67"
SWEP.PrintName = "M67 Grenade"
SWEP.Instructions = "This is a grenade with a spheroidal steel body that contains 6.5 oz (180 g) of composition B explosive.\n\nLeft click to arm and throw.\nHold LMB to delay the throw.\nRight click while holding LMB to remove the safety handle."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Category="HMCD: Union - Explosives"
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
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 1000
SWEP.SpoonOut = false
SWEP.PinOut = false
SWEP.SpawnedSpoon = false
SWEP.UseHands = true
SWEP.InsHands = true

function SWEP:Initialize()
	self:SetHoldType("grenade")
	self.Thrown = false
end

function SWEP:SetupDataTables()
end

--
function SWEP:Holster(newWep)
	self.PinOut = false

	return true
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end


	if IsValid(self) then
		self:DoBFSAnimation("pullbackhigh")

		timer.Simple(.6, function()
			if IsValid(self) then
				self:EmitSound("weapons/m67/m67_pullpin.wav")
			end
		end)

		timer.Simple(1.2, function()
			if not self:GetOwner():KeyDown(IN_ATTACK) then
				self:EmitSound("weapons/m67/m67_throw_01.wav")
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end

			self.PinOut = true
		end)
	end

	self:SetNextPrimaryFire(CurTime() + 4)
	self:SetNextSecondaryFire(CurTime() + 4)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	--for i=0,10 do PrintTable(self:GetOwner():GetViewModel():GetAnimInfo(i)) end
	self:DoBFSAnimation("draw")
	self:GetOwner():GetViewModel():SetPlaybackRate(.6)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	return true
end

function SWEP:ThrowGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_m67")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
	Grenade.Owner = self:GetOwner()
	Grenade.SpoonOut = self.SpawnedSpoon
	Grenade.TimeLeft = timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer")
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 1000)
	Grenade:Arm()
	self:GetOwner():SetLagCompensated(false)
	self.NotLoot = true

	timer.Simple(.1, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end

function SWEP:DropGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_m67")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
	Grenade.Owner = self:GetOwner()
	Grenade.SpoonOut = self.SpawnedSpoon
	Grenade.TimeLeft = timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer")
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
	Grenade:Arm()
	self:GetOwner():SetLagCompensated(false)
	self.NotLoot = true

	timer.Simple(.1, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end

function SWEP:SecondaryAttack()
end

--
function SWEP:Think()
	if self.PinOut and self:GetOwner():KeyDown(IN_ATTACK) and self:GetOwner():KeyDown(IN_ATTACK2) and self.SpawnedSpoon ~= true then
		self.SpoonOut = true
	end

	if self.PinOut then
		if not self:GetOwner():KeyDown(IN_ATTACK) then
			self.PinOut = false
			self:DoBFSAnimation("throw")
			self:EmitSound("weapons/m67/m67_throw_01.wav")
			self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			self:GetOwner():ViewPunch(Angle(-10, -5, 0))

			timer.Simple(0.15, function()
				if IsValid(self) then
					self:GetOwner():ViewPunch(Angle(20, 10, 0))
				end
			end)

			timer.Simple(0.35, function()
				if IsValid(self) then
					self:ThrowGrenade()
				end
			end)
		end
	end

	if self.SpoonOut then
		self.SpoonOut = false
		self.SpawnedSpoon = true

		if SERVER then
			sound.Play("weapons/m67/m67_spooneject.wav", self:GetPos(), 65, 100)
			local Spoon = ents.Create("prop_physics")
			Spoon.HmcdSpawned = self.HmcdSpawned
			Spoon:SetModel("models/codww2/equipment/mk,ii hand grenade spoon.mdl")
			Spoon:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			Spoon:SetPos(self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand")))
			Spoon:SetAngles(self:GetOwner():GetAngles())
			Spoon:SetMaterial("models/shiny")
			Spoon:SetColor(Color(76, 76, 0))
			Spoon.Huy = false
			Spoon:Spawn()
			Spoon:Activate()
		end

		timer.Create(tostring(self:GetOwner()) .. "ExplodeTimer", math.Rand(4, 5), 1, function()
			if IsValid(self) then
				if CLIENT then return end
				self:GetOwner():SetLagCompensated(true)
				local Grenade = ents.Create("ent_jack_hmcd_m67")
				Grenade.HmcdSpawned = self.HmcdSpawned
				Grenade:SetAngles(VectorRand():Angle())
				Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
				Grenade.Owner = self:GetOwner()
				Grenade.SpoonOut = self.SpawnedSpoon
				Grenade.TimeLeft = timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer")
				Grenade:Spawn()
				Grenade:Activate()
				Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
				Grenade:Arm()
				self:GetOwner():SetLagCompensated(false)

				timer.Simple(.1, function()
					if IsValid(self) then
						self:Remove()
					end
				end)
			end
		end)
	end

	if SERVER then
		local HoldType = "grenade"

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

		if self:GetOwner():KeyDown(IN_SPEED) and not self:GetOwner():KeyDown(IN_ATTACK) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * self.DownAmt + ang:Forward() * -1 + ang:Right()

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			self:DrawModel()
		end
	end
end