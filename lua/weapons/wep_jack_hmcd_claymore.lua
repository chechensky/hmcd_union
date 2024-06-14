--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_claymore.lua
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
SWEP.ViewModel = "models/weapons/v_c4_sec.mdl"
SWEP.WorldModel = "models/hoff/weapons/seal6_claymore/w_claymore.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_claymore")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_claymore"
SWEP.PrintName = "M18A1"
SWEP.Instructions = "This is a directional anti-personnel mine containing 700 steel spheres (10.5 grains) and 1-1/2 pound layer of composition C-4 explosive.\nLMB to deploy."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Category="HMCD: Union - Other"
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
SWEP.CommandDroppable = false
SWEP.CarryWeight = 1000
SWEP.ENT = "ent_jack_hmcd_claymore"
SWEP.UseHands = false
SWEP.InsHands = true

function SWEP:Initialize()
	self:SetHoldType("slam")
	self:SetRigged(false)
	self.Thrown = false
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Rigged")
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end


	if not self:GetRigged() then
		local tr = util.TraceLine({
			start = self:GetOwner():GetShootPos(),
			endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 100,
			filter = self:GetOwner()
		})

		if tr.HitWorld then
			local dot = vector_up:Dot(tr.HitNormal)
			if not (dot > 0.55 and dot <= 1) then return end
		end

		self:RigGrenade()
		self.UseHands = true
	else
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:DoBFSAnimation("det_detonate")

		timer.Simple(.25, function()
			self:EmitSound("c4_click.wav", 75)
		end)

		if SERVER then
			timer.Simple(.5, function()
				if IsValid(self) then
					self:DoBFSAnimation("det_holster")
				end

				if IsValid(self.Explosive) and self.Explosive.Rigged then
					self.Explosive:Detonate()
				end

				timer.Simple(.5, function()
					if IsValid(self) then
						self:Remove()
					end
				end)
			end)
		end
	end

	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	--for i=0,10 do PrintTable(self:GetOwner():GetViewModel():GetAnimInfo(i)) end
	self.DownAmt = 10
	self:DoBFSAnimation("det_draw")
	self:GetOwner():GetViewModel():SetPlaybackRate(.6)
	self:SetNextPrimaryFire(CurTime() + 0.3)
	self:SetNextSecondaryFire(CurTime() + 0.3)
	self.UseHands = self:GetRigged()

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

function SWEP:RigGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)

	local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

	if IsValid(Tr.Entity) and Tr.Entity:GetClass() == "player" then return end

	if Tr.Hit then
		local Grenade = ents.Create("ent_jack_hmcd_claymore")
		Grenade.HmcdSpawned = self.HmcdSpawned
		Grenade:SetPos(Tr.HitPos + Tr.HitNormal * 2)
		Grenade:SetAngles(Angle(0, self:GetOwner():GetAngles().y, self:GetOwner():GetAngles().z) + Angle(0, -90, 0))
		Grenade.Owner = self:GetOwner()
		Grenade.Rigged = true
		Grenade.Armed = true
		Grenade:Spawn()
		Grenade:Activate()
		--Grenade:SetModelScale(0.5,0)
		--Grenade:PhysicsInit( SOLID_VPHYSICS )
		--Grenade:SetSolid( SOLID_VPHYSICS )
		Grenade.Constraint = constraint.Weld(Grenade, Tr.Entity, 0, 0, 3000000, true, false)
		self:SetRigged(true)
		self:DoBFSAnimation("det_draw")
		self.Explosive = Grenade
		self:GetOwner():GetViewModel():SetPlaybackRate(.6)
	end

	self:GetOwner():SetLagCompensated(false)
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

		local up, forward, right, angUp = 20, 25, 22, -90

		if self:GetRigged() then
			up = 0
			forward = 0
			right = 0
			angUp = 0
		end

		pos = pos - ang:Up() * (self.DownAmt + up) + ang:Forward() * forward + ang:Right() * right
		ang:RotateAroundAxis(ang:Up(), angUp)

		return pos, ang
	end

	function SWEP:ViewModelDrawn(vm)
		if not self.Claymore then
			self.Claymore = ClientsideModel("models/hoff/weapons/seal6_claymore/w_claymore.mdl")
			self.Claymore:SetPos(vm:GetPos())
			self.Claymore:SetParent(vm)
			self.Claymore:SetNoDraw(true)
		else
			local matr = vm:GetBoneMatrix(vm:LookupBone("SECEXP"))
			local pos, ang = matr:GetTranslation(), matr:GetAngles()
			self.Claymore:SetRenderOrigin(pos - ang:Right() * 0.2 + ang:Forward() * 4.3 - ang:Up() * 20)
			ang:RotateAroundAxis(ang:Up(), -90)
			ang:RotateAroundAxis(ang:Forward(), 180)
			ang:RotateAroundAxis(ang:Right(), 0)
			self.Claymore:SetRenderAngles(ang)
			self.Claymore:DrawModel()
		end
		--self.Claymore=nil
	end

	function SWEP:DrawWorldModel()
		if 1 then
			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if not self:GetRigged() then
				if not self.WModel then
					self.WModel = ClientsideModel(self.WorldModel)
					self.WModel:SetPos(self:GetOwner():GetPos())
					self.WModel:SetParent(self:GetOwner())
					self.WModel:SetNoDraw(true)
					self.WModel:SetModelScale(0.5, 0)
				else
					if pos and ang then
						self.WModel:SetRenderOrigin(pos + ang:Right() * 4 + ang:Up() * 2 + ang:Forward() * 4)
						ang:RotateAroundAxis(ang:Forward(), 180)
						ang:RotateAroundAxis(ang:Right(), 10)
						ang:RotateAroundAxis(ang:Up(), -90)
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