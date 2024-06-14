--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_grenade.lua
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
SWEP.ViewModel = "models/weapons/c_grenade_h.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_grenade")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_grenade"
SWEP.PrintName = "M83 Frag Grenade"
SWEP.Instructions = "This is an offensive hand grenade manufactured by the combine.\n\nLeft click to arm and throw."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Category="HMCD: Union - Explosives"
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
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 1000
SWEP.Hidden = 100
SWEP.SpoonOut = false
SWEP.PinOut = false
SWEP.SpawnedSpoon = false
SWEP.NextBeep = 0
SWEP.NextTime = 1.5
SWEP.TickAmount = 0
SWEP.Stackable = true
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.ENT = "ent_jack_hmcd_grenade"

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Spoon")
	self:NetworkVar("Float", 0, "Beeping")
	self:NetworkVar("Float", 1, "NextTime")
	self:NetworkVar("Int", 0, "Amount")
end

function SWEP:Holster(newWep)
	self.PinOut = false

	return true
end

function SWEP:Initialize()
	self:SetSpoon(false)
	self:SetBeeping(0)
	self:SetNextTime(1.5)
	self:SetAmount(3)
	self:SetHoldType("grenade")
	self.Thrown = false
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos() + Vector(0, 0, 40))
	Ent:SetAngles(self:GetAngles())
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetOwner():GetAimVector() * 165 + self:GetVelocity() / 2)
	self:SetAmount(self:GetAmount() - 1)

	if self:GetAmount() == 0 then
		self:Remove()
	end
end

function SWEP:SecondaryAttack()
end

--
function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self.Hidden = 0

	if IsValid(self) then
		self:DoBFSAnimation("draw")

		timer.Simple(1, function()
			self:DoBFSAnimation("drawbackhigh")
		end)

		self:GetOwner():GetViewModel():SetPlaybackRate(.75)

		timer.Simple(.57, function()
			if IsValid(self) then
				self:EmitSound("weapons/m67/m67_pullpin.wav")
			end
		end)
	end

	timer.Simple(1.5, function()
		self.PinOut = true

		if not self:GetOwner():KeyDown(IN_ATTACK) then
			self:EmitSound("weapons/m67/m67_throw_01.wav")
		end
	end)

	self:SetNextPrimaryFire(CurTime() + 4)
	self:SetNextSecondaryFire(CurTime() + 4)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	--for i=0,10 do PrintTable(self:GetOwner():GetViewModel():GetAnimInfo(i)) end
	self.DownAmt = 10
	self.Hidden = 100
	self:SetSpoon(false)
	self:SetBeeping(0)
	self:DoBFSAnimation("deploy")
	self:GetOwner():GetViewModel():SetPlaybackRate(.6)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	return true
end

function SWEP:ThrowGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_grenade")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
	Grenade.Owner = self:GetOwner()
	Grenade.SpawnedSpoon = self.SpoonEntity
	Grenade.TickAmount = self.TickAmount
	Grenade:SetBeeping(self.NextBeep)
	Grenade:SetNextTime(self.NextTime)
	Grenade.CollisionGroup = COLLISION_GROUP_NONE
	Grenade:Arm()
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 1000)
	self:GetOwner():SetLagCompensated(false)
end

function SWEP:DropGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_grenade")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
	Grenade.Owner = self:GetOwner()
	Grenade.SpawnedSpoon = self.SpoonEntity
	Grenade.TickAmount = self.TickAmount
	Grenade:SetBeeping(self.NextBeep)
	Grenade:SetNextTime(self.NextTime)
	Grenade.CollisionGroup = COLLISION_GROUP_NONE
	Grenade:Arm()
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
	self:GetOwner():SetLagCompensated(false)
end

function SWEP:Think()
	if self.SpawnedSpoon then
		if self.NextBeep < CurTime() or self.NextBeep == nil then
			self.NextBeep = CurTime() + self.NextTime
			self:EmitSound("weapons/grenade/tick1.wav")
			self.NextTime = self.NextTime / 2

			if self.NextTime < 0.3 then
				self.NextTime = 0.3
			end

			self.TickAmount = self.TickAmount + 1

			if self.TickAmount == 6 then
				self:SetNextPrimaryFire(CurTime() + 4)
				self.PinOut = false
				self:SetAmount(self:GetAmount() - 1)
				self.TickAmount = 0
				self.NextTime = 1.5
				self.NextBeep = 0
				self.SpawnedSpoon = false
				self:SetSpoon(false)
				self:SetBeeping(0)
				self:SetNextTime(1.5)
				self.SpoonEntity = false

				if SERVER then
					self:GetOwner():SetLagCompensated(true)
					local Grenade = ents.Create("ent_jack_hmcd_grenade")
					Grenade.HmcdSpawned = self.HmcdSpawned
					Grenade:SetAngles(VectorRand():Angle())
					Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
					Grenade.Owner = self:GetOwner()
					Grenade.SpawnedSpoon = self.SpoonEntity
					Grenade:Spawn()
					Grenade:Activate()
					Grenade:Detonate()
					Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
					self:GetOwner():SetLagCompensated(false)
				end
			end
		end
	end

	if self.PinOut and self:GetOwner():KeyDown(IN_ATTACK) and self:GetOwner():KeyDown(IN_ATTACK2) and self.SpawnedSpoon ~= true then
		self.SpoonOut = true
	end

	if self.PinOut then
		if not self:GetOwner():KeyDown(IN_ATTACK) then
			self:SetAmount(self:GetAmount() - 1)
			self.SpawnedSpoon = false
			self:SetSpoon(false)
			self:SetBeeping(0)
			self:SetNextTime(1.5)
			self.PinOut = false

			timer.Simple(1, function()
				if IsValid(self) then
					self.TickAmount = 0
					self.NextTime = 1.5
					self.NextBeep = 0
					self.SpoonEntity = false
				end
			end)

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
		self:SetSpoon(true)
		self.SpoonEntity = true

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
	end

	if SERVER then
		local HoldType = "grenade"

		if self:GetOwner():KeyDown(IN_SPEED) then
			HoldType = "normal"
		end

		self:SetHoldType(HoldType)

		if self:GetAmount() == 0 then
			self.NotLoot = true

			timer.Simple(1, function()
				if IsValid(self) then
					self:Remove()
				end
			end)
		end
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

		pos = pos - ang:Up() * (self.DownAmt + self.Hidden) + ang:Forward() * -1 + ang:Right()

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			if self:GetSpoon() then
				if not self.WModel then
					self.WModel = ClientsideModel("models/weapons/w_npcnade.mdl")
					self.WModel:SetPos(self:GetOwner():GetPos())
					self.WModel:SetParent(self:GetOwner())
					self.WModel:SetNoDraw(true)
				end

				local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

				if pos and ang then
					self.WModel:SetRenderOrigin(pos + ang:Forward() * 3 + ang:Right() * 2 + ang:Up() * 0)
					ang:RotateAroundAxis(ang:Forward(), 180)
					ang:RotateAroundAxis(ang:Right(), -15)
					ang:RotateAroundAxis(ang:Up(), 70)
					self.WModel:SetRenderAngles(ang)
					self.WModel:DrawModel()
				end

				if self.NextBeep < CurTime() then
					self.material = Material("sprites/redglow1")
					self.NextBeep = CurTime() + self:GetNextTime()
					self:SetBeeping(self.NextBeep)

					timer.Simple(.1, function()
						self.material = nil
					end)
				end
			else
				if IsValid(self.WModel) then
					self.WModel:Remove()
					self.WModel = nil
				end

				self:DrawModel()
			end

			if self.material then
				local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
				cam.Start3D()
				render.SetMaterial(self.material)
				render.DrawSprite(pos + ang:Up() * -3.7 + ang:Right() * 3 + ang:Forward() * 4, 13, 13, color_white)
				cam.End3D()
			end
		end
	end
end