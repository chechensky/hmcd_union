--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_fiberwire.lua
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
	SWEP.ViewModelFOV = 85
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	killicon.AddFont("wep_zac_hmcd_policebaton", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.Base = "wep_jack_hmcd_melee_base"
SWEP.ViewModel = "models/hmc/weapons/v_fibrewire.mdl"
SWEP.WorldModel = "models/hmc/weapons/w_fibrewire.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_fibrewire")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_fibrewire"
SWEP.PrintName = "Fiber Wire"
SWEP.Instructions = "This is a single cylindrical, flexible strand of metal connected to two ergonomic grips made of carbon fibre and metal. Use it to strange people.\n\nLMB to swing.\nWhen strangling, press LMB to stop strangling."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.AttackSlowDown = .75
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 5000
SWEP.Primary.DefaultClip = -1
SWEP.Category="HMCD: Union - Traitor"
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
SWEP.ENT = "ent_jack_hmcd_baton"
SWEP.DrawAnim = "draw"
SWEP.IdleAnim = "idle_1"
SWEP.UseHands = true
SWEP.NextStatusChange = 0
SWEP.IsDown = true
SWEP.CanUpdateIdle = true
SWEP.HoldType = "slam"
SWEP.Hidden = 2

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Strangling")
	self:NetworkVar("Bool", 1, "Charging")
end

function SWEP:PrimaryAttack()
	if not (self.ChargeTime or self.StrangleRag) then
		self:SetCharging(true)

		if self.IsDown then
			self:DoBFSAnimation("Idle1_To_Charge")
			self.IsDown = false
		else
			self:DoBFSAnimation("Idle2_To_Charge")
		end

		self.ChargeTime = CurTime() + self:GetOwner():GetViewModel():SequenceDuration("Idle1_To_Charge")
		self:SetHoldType("duel")
	else
		if self.StrangleRag then
			self.ChargeTime = nil
			self.StrangleRag.Strangler = nil
			self.StrangleRag = nil
			self.PassOutTime = nil
			self:SetCharging(false)
			self:SetStrangling(false)
			self:DoBFSAnimation("strangle_end")
			self.IdleAnim = "idle_1"
			self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
			self:SetHoldType("slam")
		end
	end
end

function SWEP:SecondaryAttack()
end

--
function SWEP:IsFromBehind(npc)
	local pos1 = self:GetOwner():GetShootPos()
	local pos2 = npc:GetShootPos()
	if pos1:Distance(pos2) > 50 then return end
	local forward = self:GetOwner():GetAimVector()
	local dir = npc:GetForward()
	local dot = dir:Dot(forward) >= math.cos(math.rad(180 / 2)) --/ entVector:Length()

	return dot
end

function SWEP:Deploy()
	self:DoBFSAnimation(self.DrawAnim)

	if self.CanUpdateIdle then
		self.NextIdle = CurTime() + self:GetOwner():GetViewModel():SequenceDuration() / self:GetOwner():GetViewModel():GetPlaybackRate()
	end

	self:SetNextPrimaryFire(CurTime() + self.DrawDelay)
	self.IsDown = true
	self.IdleAnim = "idle_1"
	self.ChargeTime = nil
	self.StrangleRag = nil
	self.PassOutTime = nil
	self:SetStrangling(false)
	self:SetCharging(false)

	return true
end

local punchshit = 0
local punchshit2 = 0

function SWEP:Holster(newWep)
	if IsValid(self.StrangleRag) then
		self.StrangleRag.Strangler = nil
	end

	return true
end

function SWEP:Think()
	if CLIENT then return end
	local Time = CurTime()

	if self.ChargeTime and self.ChargeTime < Time then
		self.IdleAnim = "charge_idle"

		if not self:GetOwner():KeyDown(IN_ATTACK) then
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			self.IdleAnim = "idle_2"
			self.ChargeTime = nil
			self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

			local tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

			local hitGroup = tr.HitGroup

			if IsValid(tr.Entity) and tr.Entity:IsRagdoll() then
				hitGroup = HMCD_GetRagdollHitgroup(tr.Entity, tr.PhysicsBone)
			end

			if (hitGroup == 1 or hitGroup == 2) and (not tr.Entity:IsPlayer() or self:IsFromBehind(tr.Entity)) then
				self.StrangleStart = CurTime() + self:SequenceDuration() - 0.5
				local rag = tr.Entity

				if tr.Entity:IsPlayer() then
					tr.Entity.lastRagdollEndTime = nil
					Faking(tr.Entity)
				end

				self.StrangleRag = rag
				self:DoBFSAnimation("strangle_start")
				self.IdleAnim = "strangle_loop"
				self.PassOutTime = CurTime() + 11
				self:SetStrangling(true)
			else
				self:DoBFSAnimation("Swing")
			end
		end
	end

	if self.CanUpdateIdle then
		if self.NextIdle < Time then
			self:DoBFSAnimation(self.IdleAnim)
			self:UpdateNextIdle()
		end
	end
end

if CLIENT then
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
			if self:GetCharging() then
				self:SetModel("models/hmc/weapons/w_fibrewire2.mdl")
			end

			self:DrawModel()
		end
	end

	function SWEP:PreDrawViewModel(vm, wep, ply)
		if self:GetStrangling() then
			--render.SetScissorRect( 0, 0, 512, 512, true )
			render.SetStencilWriteMask(0xFF)
			render.SetStencilTestMask(0xFF)
			render.SetStencilReferenceValue(0)
			render.SetStencilCompareFunction(STENCIL_ALWAYS)
			render.SetStencilPassOperation(STENCIL_KEEP)
			render.SetStencilFailOperation(STENCIL_KEEP)
			render.SetStencilZFailOperation(STENCIL_KEEP)
			render.ClearStencil()
			-- Enable stencils
			render.SetStencilEnable(true)
			-- Set the reference value to 1. This is what the compare function tests against
			render.SetStencilReferenceValue(1)
			render.SetStencilCompareFunction(STENCIL_GREATER)
			local w, h = ScrW() / 7, ScrH() / 1.5
			local x_start, y_start = ScrW() / 2 - w / 4, h
			local x_end, y_end = x_start + w * 3 / 4, y_start + h
			render.ClearStencilBufferRectangle(x_start, y_start, x_end, y_end, 1)
		end
	end
end