--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_matchbox.lua
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
	SWEP.SlotPos = 2
	killicon.AddFont("wep_jack_hmcd_adrenaline", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/gleb/c_firematch.mdl"
SWEP.WorldModel = "models/weapons/gleb/w_firematch.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_matchbox")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_matchbox"
SWEP.PrintName = "Match Box"
SWEP.Instructions = "This is a box made of cardboard with matches inside. It has a coarse striking surface on one edge for lighting the matches contained inside.\nLMB to ignite a match.\nRMB to throw away the ignited match."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 2
SWEP.SwayScale = 2
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Category="HMCD: Union - Other"
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
SWEP.UseHands = true
SWEP.ENT = "ent_jack_hmcd_matchbox"
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.HomicideSWEP = true
SWEP.Matches = 5

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:SetupDataTables()
end

--
function SWEP:SetAmount(amt)
	self.Matches = amt

	if amt > 0 then
		timer.Simple(.1, function()
			if IsValid(self) then
				for i = 1, 5 - amt do
					self:GetOwner():GetViewModel():SetBodygroup(5 - i, 1)
				end
			end
		end)
	end
end

function SWEP:GetAmount()
	return self.Matches
end

function SWEP:DoBFSAnimation(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end

function SWEP:PrimaryAttack()
	if self:GetOwner():KeyDown(IN_SPEED) or self.Lit or self.Matches < 1 or CLIENT then return end
	self:DoBFSAnimation("light")
	self:SetNWBool("HoldingMatch", true)

	timer.Simple(2.25, function()
		if IsValid(self) and self == self:GetOwner():GetActiveWeapon() then
			ParticleEffectAttach("match_flame", PATTACH_POINT_FOLLOW, self:GetOwner():GetViewModel(), 1)
			self:GetOwner():EmitSound("f_firematch_strike.wav", 30)
			self:SetNWBool("Lit", true)
			self.Lit = true
			self.LitTime = CurTime()
			self:SetAmount(self.Matches - 1)
		end
	end)

	self:SetNextPrimaryFire(CurTime() + 3)
	self:SetNextSecondaryFire(CurTime() + 4)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	self:DoBFSAnimation("draw")
	self:SetNextPrimaryFire(CurTime() + 1)

	if SERVER then
		self:SetAmount(self.Matches)
	end

	return true
end

function SWEP:Holster(newWep)
	if self:GetNWBool("Lit") then return end

	return true
end

function SWEP:OnRemove()
end

--
function SWEP:CreateMatch()
	local m = ents.Create("ent_jack_hmcd_match")
	m:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 10)
	m:SetNWBool("Lit", self.LitTime and self.LitTime + 40 >= CurTime())
	m.LitTime = self.LitTime
	m.Owner = self:GetOwner()
	m:Spawn()
	m:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 100)
	self.Lit = false
	self.LitTime = nil
	self:SetNWBool("HoldingMatch", false)
	self:SetNWBool("Lit", false)
	self:GetOwner():GetViewModel():StopParticles()
end

function SWEP:SecondaryAttack()
	if not self.Lit or CLIENT then return end
	self:DoBFSAnimation("throw")

	timer.Simple(.75, function()
		if IsValid(self) and self == self:GetOwner():GetActiveWeapon() then
			self:CreateMatch()
		end
	end)

	timer.Simple(1.5, function()
		if IsValid(self) and self == self:GetOwner():GetActiveWeapon() then
			self:DoBFSAnimation("draw")
		end
	end)

	self:SetNextPrimaryFire(CurTime() + 2)
	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:Think()
	if self.LitTime and (self.LitTime + 40 < CurTime() or self:GetOwner():WaterLevel() > 1) then
		self.LitTime = nil
		self:SetNWBool("Lit", false)
		self:GetOwner():GetViewModel():StopParticles()
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
	Ent.Matches = self.Matches
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)

	if self:GetNWBool("HoldingMatch") then
		self:CreateMatch()
	end

	self:Remove()
end

if CLIENT then
	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 8
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .1, 0, 16)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .1, 0, 8)
		end

		local NewPos = pos + ang:Forward() * -6 - ang:Up() * (3 + self.DownAmt) + ang:Right() * 1
		ang:RotateAroundAxis(ang:Right(), 0)

		return NewPos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_L_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 3 - Ang:Up() * 0 + Ang:Right() * 1.25)
				Ang:RotateAroundAxis(Ang:Right(), -30)
				Ang:RotateAroundAxis(Ang:Forward(), 90)
				Ang:RotateAroundAxis(Ang:Up(), 10)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel(self.WorldModel)
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
		end

		if self:GetNWBool("Lit") then
			local dlight = DynamicLight(self:GetOwner():EntIndex())

			if dlight then
				dlight.Pos = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
				dlight.r = 255
				dlight.g = 90
				dlight.b = 0
				dlight.brightness = 1
				dlight.Decay = 256
				dlight.Size = math.min(256, 100)
				dlight.DieTime = CurTime() + 1
			end
		end

		if self:GetNWBool("HoldingMatch") then
			if self.Match then
				Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

				if Pos and Ang then
					self.Match:SetRenderOrigin(Pos + Ang:Forward() * 3 - Ang:Up() * 1.2 + Ang:Right() * 0.75)
					Ang:RotateAroundAxis(Ang:Right(), 180)
					Ang:RotateAroundAxis(Ang:Forward(), 0)
					Ang:RotateAroundAxis(Ang:Up(), 10)
					self.Match:SetRenderAngles(Ang)
					self.Match:DrawModel()
				end
			else
				self.Match = ClientsideModel("models/weapons/gleb/matchhead.mdl")
				self.Match:SetModelScale(.19, 0)
				self.Match:SetPos(self:GetPos())
				self.Match:SetParent(self)
				self.Match:SetNoDraw(true)
			end
		end
	end

	function SWEP:ViewModelDrawn(vm)
		if self:GetNWBool("Lit") then
			local dlight = DynamicLight(self:GetOwner():EntIndex())

			if dlight then
				dlight.Pos = vm:GetBonePosition(23)
				dlight.r = 255
				dlight.g = 90
				dlight.b = 0
				dlight.brightness = 1
				dlight.Decay = 256
				dlight.Size = math.min(256, 100)
				dlight.DieTime = CurTime() + 1
			end
		end
	end
end