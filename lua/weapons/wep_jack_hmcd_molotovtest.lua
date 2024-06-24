--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_molotovtest.lua
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
SWEP.ViewModel = "models/weapons/v_molotov.mdl"
SWEP.WorldModel = "models/weapons/w_molotov.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/inventory/weapon_molotov")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/inventory/weapon_molotov"
SWEP.PrintName = "Molotov Cocktail"
SWEP.Instructions = "This improvised incendiary device is a glass bottle filled with a motor-oil/gasoline mixture and stopped with a rag. When lit and thrown, the glass will shatter on a hard surface and spread burning mixture abroad.\n\nLMB to light and throw."
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
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.ENT = "ent_jack_hmcd_molotovtest"
SWEP.DrawAnim = "base_draw"
SWEP.CarryWeight = 1000
--models/w_models/weapons/w_eq_pipebomb.mdl
--models/w_models/weapons/w_eq_painpills.mdl
SWEP.UseHands = true
SWEP.InsHands = true
SWEP.IgniteAnim = "pullback_high"
SWEP.ThrowAnim = "throw"

function SWEP:Initialize()
	self:SetHoldType("grenade")
	self.Thrown = false
	self:SetRagIgnited(false)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "RagIgnited")
end

function SWEP:Holster(newWep)
	self.StartedIgnition = false

	return true
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self:DoBFSAnimation(self.IgniteAnim)

	timer.Simple(.2, function()
		self:EmitSound("weapons/molotov/handling/molotov_lighter_open.wav")
	end)

	timer.Simple(.55, function()
		self:EmitSound("weapons/molotov/handling/molotov_lighter_strike.wav")
		self:SetRagIgnited(true)

		if CLIENT then
			ParticleEffectAttach("molotov_lighter", PATTACH_ABSORIGIN_FOLLOW, self, 1)
		end
	end)

	timer.Simple(.9, function()
		self:EmitSound("weapons/molotov/handling/molotov_ignite.wav")
	end)

	timer.Simple(1.85, function()
		self.StartedIgnition = true
	end)

	--[[timer.Simple(1.85,function()
		if(IsValid(self) and self:GetOwner():KeyDown(IN_ATTACK))then
			self.StartedIgnition=false
			self:GetOwner():ViewPunch(Angle(-10,-5,0))
			self:EmitSound("snd_jack_hmcd_throw.wav")
			self:DoBFSAnimation(self.ThrowAnim)
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		else
			return
		end
	end)
	timer.Simple(2.15,function()
		if(IsValid(self)) and not(self:GetOwner():KeyDown(IN_ATTACK) and self.StartedIgnition) then
			self.StartedIgnition=false
			self:GetOwner():ViewPunch(Angle(20,10,0))
			self:ThrowGrenade()
		end
	end)]]
	self:SetNextPrimaryFire(CurTime() + 5)
	self:SetNextSecondaryFire(CurTime() + 5)
end

function SWEP:DoBFSAnimation(anim)
	if self:GetOwner() and self:GetOwner().GetViewModel then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	end
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	self:DoBFSAnimation(self.DrawAnim)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	return true
end

function SWEP:ThrowGrenade()
	self:SetRagIgnited(false)
	if CLIENT then return end
	self.CommandDroppable = false
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_molotovtest")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 1)
	Grenade.Owner = self:GetOwner()
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 750)
	Grenade:Light()
	self:GetOwner():SetLagCompensated(false)

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
	if self.StartedIgnition and not self:GetOwner():KeyDown(IN_ATTACK) then
		if SERVER then
			self.StartedIgnition = false
			self:GetOwner():ViewPunch(Angle(-10, -5, 0))
			sound.Play("weapons/m67/m67_throw_01.wav", self:GetPos(), 100, 100)
			self:DoBFSAnimation(self.ThrowAnim)

			timer.Simple(.3, function()
				self:GetOwner():ViewPunch(Angle(20, 10, 0))
				self:ThrowGrenade()
			end)
		end

		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
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

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) and not self:GetRagIgnited() then
			self.DownAmt = math.Clamp(self.DownAmt + .1, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .15, 0, 60)
		end

		pos = pos - ang:Up() * self.DownAmt
		ang:RotateAroundAxis(ang:Up(), 0)

		return pos, ang
	end

	local NextEffectTime = 0

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
			self.DatWorldModel = ClientsideModel(self.WorldModel)
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			--self.DatWorldModel:SetModelScale(1,0)
		end

		if self.DatWorldModel2 then
			if Pos and Ang then
				self.DatWorldModel2:SetRenderOrigin(Pos + Ang:Forward() * -2.5 + Ang:Right() * 0.75 - Ang:Up() * -7)
				self.DatWorldModel2:SetRenderAngles(Ang)
				self.DatWorldModel2:DrawModel()

				if self:GetRagIgnited() then
					if NextEffectTime < CurTime() then
						self.DatWorldModel2.Particles = self.DatWorldModel2:CreateParticleEffect("molotov_trail", 1)
						NextEffectTime = CurTime() + 5
					end
				else
					if self.DatWorldModel2.Particles then
						self.DatWorldModel2.Particles:StopEmission(false, true)
					end
				end
			end
		else
			self.DatWorldModel2 = ClientsideModel(self.WorldModel)
			self.DatWorldModel2:SetPos(self:GetPos())
			self.DatWorldModel2:SetParent(self)
			self.DatWorldModel2:SetNoDraw(true)
			self.DatWorldModel2:SetMaterial("models/hands/hands_color")
			--self.DatWorldModel2:SetModelScale(1,0)
		end
	end
end