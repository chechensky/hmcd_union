--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_slam.lua
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
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_slam")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_slam"
SWEP.PrintName = "M2 SLAM"
SWEP.Instructions = "This is a multipurpose munition designed to be readily portable and hand-emplaced against lightly armored infantry vehicles, parked aircraft and petroleum storage sites.\n\nLeft click to place on a surface."
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
SWEP.UseHands = true
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
SWEP.CarryWeight = 900

function SWEP:Initialize()
	self:SetHoldType("slam")
	self:SetRigged(false)
	self.Thrown = false
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Rigged")
end

function SWEP:Holster()
	if IsValid(self:GetOwner():GetViewModel()) then
		self:GetOwner():GetViewModel():ManipulateBonePosition(40, Vector(0, 0, 0))
	end

	return true
end

function SWEP:OnRemove()
	if self.Attached == true then
		self:GetOwner():GetViewModel():ManipulateBonePosition(40, Vector(0, 0, 0))
	end
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end


	local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

	if not self:GetRigged() then
		if Tr.Hit then
			self:DoBFSAnimation("tripmine_attach1")

			timer.Simple(.2, function()
				self:DoBFSAnimation("tripmine_attach2")
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end)

			timer.Simple(.4, function()
				self:SetCharge()
			end)
		end
	else
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:DoBFSAnimation("detonator_detonate")

		timer.Simple(.05, function()
			self:EmitSound("c4_click.wav", 75)
		end)

		timer.Simple(.5, function()
			if IsValid(self.Explosive) and not self.Explosive.Broken then
				if SERVER then
					self.Explosive:Detonate()
				end
			end

			if IsValid(self) then
				self:DoBFSAnimation("detonator_holster")
			end

			timer.Simple(.5, function()
				if IsValid(self) and SERVER then
					self:Remove()
				end
			end)
		end)
	end

	self:SetNextPrimaryFire(CurTime() + 2)
	self:SetNextSecondaryFire(CurTime() + 2)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	--for i=0,10 do PrintTable(self:GetOwner():GetViewModel():GetAnimInfo(i)) end
	self.Attached = false

	if not self:GetRigged() then
		self:DoBFSAnimation("tripmine_draw")
	else
		self:DoBFSAnimation("detonator_draw")
	end

	self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	return true
end

function SWEP:SetCharge()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)

	local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

	if Tr.Hit then
		local Grenade = ents.Create("ent_jack_hmcd_slam")
		local Ang = Tr.HitNormal:Angle()
		Ang:RotateAroundAxis(Ang:Right(), -90)
		Grenade.HmcdSpawned = self.HmcdSpawned
		Grenade:SetAngles(Ang)
		Grenade:SetPos(Tr.HitPos + Tr.HitNormal * 1.9)
		Grenade.Owner = self:GetOwner()
		Grenade:Spawn()
		Grenade:Activate()
		Grenade.Constraint = constraint.Weld(Grenade, Tr.Entity, 0, 0, 0, true, false)
		self:SetRigged(true)
		self.Explosive = Grenade

		timer.Simple(.3, function()
			if IsValid(self) then
				self:DoBFSAnimation("detonator_draw")
			end
		end)
	end

	self:GetOwner():SetLagCompensated(false)
end

function SWEP:SecondaryAttack()
end

--print(HMCD_WhomILookinAt(self:GetOwner(),.5,500):GetClass())
--print(self:GetOwner():GetPos())
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
			if not self:GetRigged() then
				if not self.WModel then
					self.WModel = ClientsideModel(self.WorldModel)
					self.WModel:SetPos(self:GetOwner():GetPos())
					self.WModel:SetParent(self:GetOwner())
					self.WModel:SetNoDraw(true)
				else
					local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

					if pos and ang then
						self.WModel:SetRenderOrigin(pos + ang:Right() * 5 + ang:Up() * 0 + ang:Forward() * 3.5)
						ang:RotateAroundAxis(ang:Right(), -60)
						self.WModel:SetRenderAngles(ang)
						self.WModel:DrawModel()
					end
				end
			else
				if self.WModel then
					self.WModel = nil
				end

				if not self.WModel2 then
					self.WModel2 = ClientsideModel("models/weapons/w_c4.mdl")
					self.WModel2:SetPos(self:GetOwner():GetPos())
					self.WModel2:SetParent(self:GetOwner())
					self.WModel2:SetBodygroup(1, 1)
					self.WModel2:SetSubMaterial(0, "models/hands/hands_color")
					self.WModel2:SetNoDraw(true)
				else
					local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

					if pos and ang then
						self.WModel2:SetRenderOrigin(pos + ang:Right() * -0.5 + ang:Up() * -1.5 + ang:Forward() * 3)
						ang:RotateAroundAxis(ang:Forward(), -220)
						ang:RotateAroundAxis(ang:Right(), 150)
						ang:RotateAroundAxis(ang:Up(), -190)
						self.WModel2:SetRenderAngles(ang)
						self.WModel2:DrawModel()
					end
				end
			end
		end
	end
end