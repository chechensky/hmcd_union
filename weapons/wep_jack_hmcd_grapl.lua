--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_grapl.lua
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
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	killicon.AddFont("wep_jack_hmcd_grapl", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.PrintName = "Grappling Hook"
-- This was imported from BFS2114
--SWEP.Author		= "Jackarunda :3"
SWEP.Instructions = "This is a heavy steel grappling hook with an attached rope. Use it to reach high/far places or safely descend from high places. \n\nLMB to swing/throw.\nLMB to pull rope taut.\nLMB to pull rope in.\nRMB to let rope out.\nR to release rope."
SWEP.Base = "weapon_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_grapl")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_grapl"
SWEP.ViewModel = "models/weapons/c_models/c_grappling_hook/c_grappling_hook.mdl"
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Category="HMCD: Union - Other"
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
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.JustThrew = false
SWEP.ThrowAbility = 1.5
SWEP.ThrowChargeSpeed = .15
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.NextThinkTime = 0
SWEP.Moddable = false
SWEP.DrawTime = .5
SWEP.DesiredDist = 1000
SWEP.Tight = false
SWEP.NextSpinWhooshTime = 0
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.ENT = "ent_jack_hmcd_grapl"
SWEP.CarryWeight = 2500

function SWEP:SetupDataTables()
	self:NetworkVar("String", 0, "CurrentState")
	self:NetworkVar("Float", 0, "Hidden")
	self:NetworkVar("Float", 1, "Back")
	self:NetworkVar("Float", 2, "ThrowPower")
	self:NetworkVar("Float", 3, "Spin")
	self:NetworkVar("Bool", 0, "ShouldHideWorldModel")
end

function SWEP:Initialize()
	self:SetSpin(0)
	self.NextThinkTime = CurTime() + .01
	self:SetHoldType("normal")
	self:SetCurrentState("Hidden")
	self:SetHidden(100)
	self:SetShouldHideWorldModel(false)
end

function SWEP:OnDrop()
	if self:GetCurrentState() ~= "Nothing" then
		local Ent = ents.Create(self.ENT)
		Ent.HmcdSpawned = self.HmcdSpawned
		Ent:SetPos(self:GetPos())
		Ent:SetAngles(self:GetAngles())
		Ent:Spawn()
		Ent:Activate()
		Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	end

	if SERVER then
		self:Remove()
	end
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self.NextSpinWho0shTime = CurTime() + 1

	if self:GetCurrentState() == "Nothing" then
		if IsValid(self.GrapplinHook) then
			if not self.Tight then
				self.Tight = true
				self:PullTaut()
			else
				self.DesiredDist = math.Clamp(self.DesiredDist - 20, 50, 5000)

				local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 60, {self:GetOwner()})

				if Tr.Hit then
					self:GetOwner():SetVelocity(-self:GetOwner():GetAimVector() * 300)
				end
			end

			-- sound.Play("snds_jack_clothmove/"..math.random(1,9)..".wav",self:GetOwner():GetPos(),70,math.random(90,110))
			self:GetOwner():DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND)
			self:GetOwner():ViewPunch(Angle(-1, 0, 0))
		end

		self:SetNextPrimaryFire(CurTime() + .2)
	end
end

function SWEP:PullTaut()
	self.DesiredDist = (self:GetOwner():GetPos() - self.GrapplinHook:GetPos()):Length() + 50
	self.GrapplinHook:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
end

function SWEP:SecondaryAttack()
	if CLIENT then return end

	if self:GetCurrentState() == "Nothing" then
		if IsValid(self.GrapplinHook) then
			self.DesiredDist = math.Clamp(self.DesiredDist + 50, 10, 4000)
			-- sound.Play("snds_jack_clothmove/"..math.random(1,9)..".wav",self:GetOwner():GetPos(),70,math.random(90,110))
			self:GetOwner():ViewPunch(Angle(-1, 0, 0))
		end

		self:SetNextSecondaryFire(CurTime() + .25)
	end
end

function SWEP:Reload()
	if self:GetCurrentState() == "Nothing" then
		self:Deploy()
		self.GrapplinHook = nil

		if self.Rope and self.Rope.Remove and IsValid(self.Rope) and SERVER then
			self.Rope:Remove()
		end

		self.Rope = nil
		self:SetHoldType("normal")

		if SERVER then
			self:Remove()
		end
	end
end

function SWEP:Think()
	local Time = CurTime()

	if self.NextThinkTime <= Time then
		self.NextThinkTime = Time + .025
		local State = self:GetCurrentState()

		if not (State == "Nothing") then
			local Sprintin = self:GetOwner():KeyDown(IN_SPEED)
			local HiddenAmt = self:GetHidden()
			local BackAmt = self:GetBack()

			if State == "Idling" then
				if self:GetOwner():KeyDown(IN_ATTACK) then
					self:Windup()
				end
			elseif State == "Hidden" then
				if math.random(1, 19) == 18 then
					self:GetOwner():ViewPunch(Angle(1, 0, 0))
					-- local Nam,Vol,Pit="snds_jack_clothmove/"..math.random(1,9)..".wav",65,math.random(90,110)
					-- self.Weapon:EmitSound(Nam,Vol,Pit)
				end
			elseif State == "Drawing" then
				self:SetHidden(math.Clamp(HiddenAmt - 10 / self.DrawTime, 0, 100))

				if HiddenAmt <= 0 then
					self:SetCurrentState("Idling")
				end
			elseif (State == "Winding") and not self.JustThrew then
				self:SetHoldType("Grenade")

				if not self:GetOwner():KeyDown(IN_ATTACK) then
					if self:GetThrowPower() > 5 then
						self:SetCurrentState("Drawing")
						self:SetHidden(100)
						self:SetBack(0)
						self:Throw()

						return
					end
				end

				self:SetBack(math.Clamp(BackAmt + 15, 0, 100))
				self:SetThrowPower(math.Clamp(self:GetThrowPower() + 9 * self.ThrowChargeSpeed, 1, 130))
			end
		end

		self:CustomThink(State, Sprintin, HiddenAmt, BackAmt)
	end

	self:NextThink(Time + .025)

	return true
end

function SWEP:Windup()
	if self:GetCurrentState() == "Winding" then return end
	self.NotLoot = true
	self:SetCurrentState("Winding")
	self:SetThrowPower(1)
	self.JustThrew = false
	--self:SetHoldType("grenade")
	self:CustomWindup()
end

function SWEP:Throw()
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	if CLIENT then return end
	self.JustThrew = true
	self:SetCurrentState("Nothing")
	self:SetShouldHideWorldModel(true)
	self.DesiredDist = 2000
	self.Tight = false
	local Vec = self:GetOwner():GetAimVector()
	local Pos = self:GetOwner():GetShootPos()
	local ThrowPos = Pos + Vec * 30

	local Tr = util.QuickTrace(Pos, Vec * 35, {self:GetOwner()})

	if Tr.Hit then
		ThrowPos = Pos + Vec * 10
	end

	sound.Play("weapons/slam/throw.wav", self:GetPos(), 75, 80)
	sound.Play("weapons/slam/throw.wav", self:GetPos(), 70, 80)
	sound.Play("weapons/slam/throw.wav", self:GetPos(), 65, 80)
	local Gr = ents.Create("ent_jack_hmcd_grapl")
	Gr.HmcdSpawned = self.HmcdSpawned
	Gr:SetPos(ThrowPos)
	Gr.Owner = self:GetOwner()
	Gr:SetAngles(VectorRand():Angle())
	Gr:Spawn()
	Gr:Activate()
	Gr.Rope = self
	self.GrapplinHook = Gr
	-- JIBFS.CloakPenalize(self:GetOwner())
	Gr:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + Vec * self:GetThrowPower() * 6 * self.ThrowAbility)
	Gr:SetPhysicsAttacker(self:GetOwner())

	timer.Simple(.5, function()
		if IsValid(self) then
			self:SetHoldType("melee2")
		end
	end)

	if self.Rope and self.Rope.Remove and SERVER then
		self.Rope:Remove()
	end

	self.Rope = self:CollisionlessKeyFrameRope(self:GetOwner(), self.GrapplinHook, Vector(0, 0, 10), Vector(0, 0, 0), 1000, 2, "cable/rope")
end

function SWEP:CollisionlessKeyFrameRope(Ent1, Ent2, LPos1, LPos2, length, width, material)
	if width <= 0 then return nil end
	width = math.Clamp(width, 1, 100)
	local rope = ents.Create("keyframe_rope")
	rope:SetPos(Ent1:GetPos())
	rope:SetKeyValue("Width", width)

	if material then
		rope:SetKeyValue("RopeMaterial", material)
	end

	rope:SetEntity("StartEntity", Ent1)
	rope:SetKeyValue("StartOffset", tostring(LPos1))
	rope:SetKeyValue("StartBone", 0)
	rope:SetEntity("EndEntity", Ent2)
	rope:SetKeyValue("EndOffset", tostring(LPos2))
	rope:SetKeyValue("EndBone", 0)

	local kv = {
		Length = length,
		Collide = 0
	}

	for k, v in pairs(kv) do
		rope:SetKeyValue(k, tostring(v))
	end

	rope:Spawn()
	rope:Activate()
	Ent1:DeleteOnRemove(rope)
	Ent2:DeleteOnRemove(rope)

	return rope
end

function SWEP:OnRemove()
	if IsValid(self:GetOwner()) and CLIENT and self:GetOwner():IsPlayer() then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			vm:SetMaterial("")
			vm:SetColor(Color(255, 255, 255, 255))
		end
	end

	if self.Rope and self.Rope.Remove and IsValid(self.Rope) and SERVER then
		self.Rope:Remove()
	end

	if self:GetOwner() and IsValid(self:GetOwner()) and self:GetOwner().SelectWeapon then
		self:GetOwner():SelectWeapon("wep_jack_hmcd_hands")
	end
end

function SWEP:Holster()
	if (self:GetCurrentState() == "Idling") or (self:GetCurrentState() == "Hidden") then
		if IsValid(self:GetOwner()) and CLIENT and self:GetOwner():IsPlayer() then
			local vm = self:GetOwner():GetViewModel()

			if IsValid(vm) then
				vm:SetMaterial("")
				vm:SetColor(Color(255, 255, 255, 255))
			end
		end

		return true
	else
		return false
	end
end

function SWEP:Deploy()
	self:HideThenDraw(self.DrawTime)
	self:SetNextPrimaryFire(CurTime() + self.DrawTime + self:GetOwner():GetViewModel():SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + self.DrawTime + self:GetOwner():GetViewModel():SequenceDuration())
	self:SetShouldHideWorldModel(false)
end

function SWEP:HideThenDraw(num)
	self:SetHidden(100)
	self:SetCurrentState("Hidden")

	-- self.Weapon:EmitSound("snds_jack_equipmentfumble/"..math.random(1,10)..".wav",70,math.random(80,120))
	timer.Simple(num, function()
		if IsValid(self) then
			-- self.Weapon:EmitSound("snds_jack_clothmove/"..math.random(1,9)..".wav",70,math.random(90,110))
			self:SetCurrentState("Drawing")
			self:CustomFinishedDrawing()
		end
	end)
end

function SWEP:CustomFinishedDrawing()
end

-- wat
function SWEP:Fail()
	sound.Play("weapons/slam/throw.wav", self:GetPos(), 75, 110)
	sound.Play("weapons/slam/throw.wav", self:GetPos(), 70, 110)
	sound.Play("weapons/slam/throw.wav", self:GetPos(), 65, 110)
	self:GetOwner():ViewPunch(VectorRand():Angle())
	self:Reload()
end

function SWEP:CustomThink(State, Sprintin, HiddenAmt, BackAmt)
	if CLIENT then return end

	if IsValid(self.GrapplinHook) then
		local Vec, Vel = self.GrapplinHook:GetPos() - (self:GetOwner():GetPos() + Vector(0, 0, -50)), self:GetOwner():GetVelocity()
		local Dir = Vec:GetNormalized()
		local Dist = Vec:Length()
		local EffDist = Dist - self.DesiredDist
		local RelVel = self.GrapplinHook:GetPhysicsObject():GetVelocity() - Vel

		if EffDist > 0 then
			local LinearVelocity, Ground = Dir:Dot(Vel) * Dir, self:GetOwner():IsOnGround()
			self:GetOwner():SetGroundEntity(nil)
			local ent = self:GetOwner()

			if IsValid(ent.fakeragdoll) then
				ent = ent.fakeragdoll:GetPhysicsObject()
			end

			ent:SetVelocity(Dir * math.Clamp(EffDist * 10, 0, 150) - LinearVelocity / 2)
			self.GrapplinHook:GetPhysicsObject():ApplyForceCenter(-Dir * EffDist * 100 - self.GrapplinHook:GetPhysicsObject():GetVelocity() / 40)

			if (EffDist > 20) and not Ground and (RelVel:Length() > 1200) then
				self:Fail()

				return
			end
		end

		if self.Rope then
			self.Rope:Fire("SetLength", self.DesiredDist + 10)
		end
	elseif State == "Nothing" then
		self:Reload()
	elseif State == "Winding" then
		if self.NextSpinWhooshTime < CurTime() then
			local Pow = self:GetThrowPower()
			self.NextSpinWhooshTime = CurTime() + math.Clamp(10 / Pow, .3, 1.25)
			sound.Play("weapons/slam/throw.wav", self:GetPos(), 65, math.Clamp(Pow, 60, 130))
			self:GetOwner():ViewPunch(Angle(-1, 0, 0))
		end

		if SERVER then
			local Spun = self:GetSpin() + 25

			if Spun > 360 then
				Spun = 0
			end

			self:SetSpin(Spun)
		end
	end
end

function SWEP:CustomWindup()
end

-- no
if CLIENT then
	function SWEP:PreDrawViewModel(vm, ply, wep)
		vm:SetMaterial("models/shiny")
		vm:SetColor(Color(10, 10, 10, 255))
	end

	local DownAmt = 10

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .6, 0, 50)
		else
			DownAmt = math.Clamp(DownAmt - .6, 0, 50)
		end

		if (self:GetCurrentState() == "Nothing") or (self:GetCurrentState() == "Winding") then
			DownAmt = DownAmt + 10
		end

		pos = pos + ang:Forward() * 30 + ang:Right() * 15 - ang:Up() * (15 + DownAmt)

		return pos, ang
	end

	local TheMat = Material("cable/rope")

	function SWEP:DrawWorldModel()
		if not (self:GetCurrentState() == "Nothing") then
			local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if self.DatWorldModel then
				if Pos and Ang then
					local ThePos = Pos + Ang:Forward() * 4 + Ang:Right() - Ang:Up() * 0
					Ang:RotateAroundAxis(Ang:Forward(), 90)

					if self:GetCurrentState() == "Winding" then
						if not self.SpinStart then
							self.CurrentSpin = 0
							self.SpinStart = CurTime()
						end

						Ang:RotateAroundAxis(Ang:Forward(), (CurTime() - self.SpinStart) * 1080 % 360)
						ThePos = ThePos + Ang:Up() * 30
						render.SetMaterial(TheMat)
						local Col = render.GetAmbientLightColor(ThePos)
						render.DrawBeam(Pos, ThePos, 2, 1, 0, Color(Col.r * 255, Col.g * 255, Col.b * 255, 255))
					else
						Ang:RotateAroundAxis(Ang:Forward(), 90)

						if self.SpinStart then
							self.SpinStart = nil
						end
					end

					self.DatWorldModel:SetRenderOrigin(ThePos)
					self.DatWorldModel:SetRenderAngles(Ang)
					--local Mat=Matrix()
					--Mat:Scale(Vector(.9,.4,.9))
					--self.DatWorldModel:EnableMatrix("RenderMultiply",Mat)
					local R, G, B = render.GetColorModulation()
					render.SetColorModulation(.1, .1, .1)
					self.DatWorldModel:DrawModel()
					render.SetColorModulation(R, G, B)
				end
			else
				self.DatWorldModel = ClientsideModel("models/weapons/c_models/c_grappling_hook/c_grappling_hook.mdl")
				self.DatWorldModel:SetMaterial("models/shiny")
				self.DatWorldModel:SetColor(Color(10, 10, 10, 255))
				self.DatWorldModel:SetModelScale(.8, 0)
				self.DatWorldModel:SetPos(self:GetPos())
				self.DatWorldModel:SetParent(self)
				self.DatWorldModel:SetNoDraw(true)
			end
		end
	end
end