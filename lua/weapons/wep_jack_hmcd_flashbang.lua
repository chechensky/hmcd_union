--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_flashbang.lua
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
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_molotov", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/v_m84.mdl"
SWEP.WorldModel = "models/weapons/w_m84.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_flashbang")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_flashbang"
SWEP.PrintName = "M84 Flashbang"
SWEP.Instructions = "This is a non-lethal, low hazard, non-shrapnel producing explosive device intended to confuse, disorient or momentarily distract potential threat personnel.\n\nLMB to arm and throw."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.UseHands = true
SWEP.InsHands = true
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Category="HMCD: Union - Explosives"
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
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.ENT = "ent_jack_hmcd_flashbang"
SWEP.CarryWeight = 1200
SWEP.SpoonOut = false
SWEP.PinOut = false
SWEP.SpawnedSpoon = false

function SWEP:Initialize()
	self:SetHoldType("grenade")
	self:SetTimeLeft(2)
	self.Thrown = false
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "TimeLeft")
end

function SWEP:Holster(newWep)
	self.PinOut = false

	return true
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self:DoBFSAnimation("pullbackhigh")

	--self.DownAmt=60
	timer.Simple(0.5, function()
		self:EmitSound("weapons/m67/m67_pullpin.wav")
	end)

	timer.Simple(1, function()
		self.PinOut = true

		if not self:GetOwner():KeyDown(IN_ATTACK) then
			self:EmitSound("weapons/m67/m67_throw_01.wav")
		end
	end)

	self:SetNextPrimaryFire(CurTime() + 1.5)
	self:SetNextSecondaryFire(CurTime() + 1.5)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	self:DoBFSAnimation("base_draw")
	self.DownAmt = 10
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	return true
end

function SWEP:ThrowGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_flashbang")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 1)
	Grenade.Owner = self:GetOwner()

	if timer.Exists(tostring(self:GetOwner()) .. "ExplodeTimer") then
		Grenade.TimeLeft = timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer")
	else
		Grenade.TimeLeft = 2
	end

	Grenade.SpawnedSpoon = self.SpawnedSpoon
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 750)
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
	local Grenade = ents.Create("ent_jack_hmcd_flashbang")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
	Grenade.Owner = self:GetOwner()
	Grenade.SpoonOut = self.SpawnedSpoon

	if timer.Exists(tostring(self:GetOwner()) .. "ExplodeTimer") then
		Grenade.TimeLeft = timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer")
	else
		Grenade.TimeLeft = 2
	end

	Grenade.SpawnedSpoon = self.SpawnedSpoon
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
					if timer.Exists(tostring(self:GetOwner()) .. "ExplodeTimer") then
						self:SetTimeLeft(timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer"))
					else
						self:SetTimeLeft(2)
					end

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
			Spoon:SetColor(Color(50, 40, 0))
			Spoon.Huy = false
			Spoon:Spawn()
			Spoon:Activate()
		end

		timer.Create(tostring(self:GetOwner()) .. "ExplodeTimer", 2, 1, function()
			if IsValid(self) then
				if CLIENT then return end
				self:GetOwner():SetLagCompensated(true)
				local Grenade = ents.Create("ent_jack_hmcd_flashbang")
				Grenade.HmcdSpawned = self.HmcdSpawned
				Grenade:SetAngles(VectorRand():Angle())
				Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
				Grenade.Owner = self:GetOwner()
				Grenade.SpoonOut = self.SpawnedSpoon
				Grenade:Detonate()
				--Grenade:Spawn()
				Grenade:Activate()
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

function SWEP:Reload()
end

--
function SWEP:DoBFSAnimation(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) and not self:GetOwner():KeyDown(IN_ATTACK) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 10)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 60)
		end

		pos = pos - ang:Up() * (self.DownAmt + 1) + ang:Forward() * 0 - ang:Right() * 0
		ang:RotateAroundAxis(ang:Up(), -10)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 3.5 + Ang:Right() * 2 - Ang:Up() * 1)
				Ang:RotateAroundAxis(Ang:Right(), 180)
				--Ang:RotateAroundAxis(Ang:Right(),90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/weapons/w_m84.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			--self.DatWorldModel:SetModelScale(1,0)
		end
	end
end