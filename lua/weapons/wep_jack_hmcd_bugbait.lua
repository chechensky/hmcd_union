--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_bugbait.lua
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
SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/weapons/w_bugbait.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_snowball")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_snowball"
SWEP.PrintName = "Bug Bait"
SWEP.Instructions = "This is a cock.\n\nLMB to throw."
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
SWEP.Category="HMCD: Union - WTF"
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
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.DrawAnim = "draw"
SWEP.CarryWeight = 100
--models/w_models/weapons/w_eq_pipebomb.mdl
--models/w_models/weapons/w_eq_painpills.mdl
SWEP.UseHands = true
SWEP.HoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.IdleAnim = "idle"
SWEP.PrepareAnim = "drawback"
SWEP.ThrowAnim = "throw"

function SWEP:PreDrawViewModel(vm, wep, ply)
	if IsValid(self:GetOwner():GetNWEntity("Ragdoll")) then return true end
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then
		self:DoBFSAnimation(self.DrawAnim)

		return
	end

	if self.DownAmt then
		self.DownAmt = 20
	end

	self:DoBFSAnimation(self.DrawAnim)

	return true
end

function SWEP:DoBFSAnimation(anim)
	if self:GetOwner() and self:GetOwner().GetViewModel then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
		self.NextIdle = CurTime() + vm:SequenceDuration() * vm:GetPlaybackRate()
	end
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:ThrowGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	self.CommandDroppable = false
	local Grenade = ents.Create("ent_jack_hmcd_bugbait")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 40)
	Grenade.Owner = self:GetOwner()
	Grenade.CollisionGroup = COLLISION_GROUP_NONE
	Grenade:Spawn()
	Grenade:Activate()
	Grenade.InitialDir = self:GetOwner():GetAimVector()
	Grenade:SetLocalAngularVelocity(Angle(math.random(0, 360), math.random(0, 360), math.random(0, 360)))
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 750)
	self:GetOwner():SetLagCompensated(false)

	timer.Simple(.1, function()
		if IsValid(self) then
			self:DoBFSAnimation(self.DrawAnim)
		end
	end)
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self:DoBFSAnimation(self.PrepareAnim)
	self:GetOwner():GetViewModel():SetPlaybackRate(.5)

	timer.Simple(.3, function()
		self.Prepared = true
	end)

	self:SetNextPrimaryFire(CurTime() + 1.5)
	self:SetNextSecondaryFire(CurTime() + 1.5)
end

function SWEP:SecondaryAttack()


	if SERVER then
		self:DoBFSAnimation("squeeze")
		self:GetOwner():EmitSound("weapons/bugbait/bugbait_squeeze" .. math.random(1, 3) .. ".wav")

		for i, npc in pairs(ents.FindByClass("npc_antlion")) do
			local dist = npc:GetPos():DistToSqr(self:GetPos())

			if dist < 250000 then
				for i, ply in player.Iterator() do
					npc:AddEntityRelationship(ply, D_LI, 99)
				end

				if not npc.SatisfactionEndTime then
					hook.Add("Think", npc, function()
						if npc.SatisfactionEndTime < CurTime() then
							npc:AddRelationship("player D_HT 99")
							npc.SatisfactionEndTime = nil
							hook.Remove("Think", npc)
						end
					end)
				end

				npc:EmitSound("npc/antlion/distract1.wav", 100, math.random(80, 110))
				npc:SetLastPosition(self:GetOwner():GetPos())
				npc:SetSchedule(SCHED_FORCED_GO_RUN)
				npc.SatisfactionEndTime = CurTime() + 60
			end
		end

		self:SetNextPrimaryFire(CurTime() + 1)
		self:SetNextSecondaryFire(CurTime() + 1)
	end
end

function SWEP:Think()
	if self.Prepared and not self:GetOwner():KeyDown(IN_ATTACK) then
		if SERVER then
			self.Prepared = false
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
		local HoldType = self.HoldType

		if self:GetOwner():KeyDown(IN_SPEED) then
			HoldType = self.RunHoldType
		end

		self:SetHoldType(HoldType)

		if self.NextAttackFront and self.NextAttackFront < CurTime() then
			self:AttackFront()
		end
	end
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .1, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .15, 0, 60)
		end

		pos = pos - ang:Up() * self.DownAmt + ang:Forward() * -10

		return pos, ang
	end
end