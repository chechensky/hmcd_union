--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_zipline.lua
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
SWEP.PrintName = "Rappelling Tool"
-- This was imported from BFS2114
SWEP.Instructions = "This is a steel fastener with an attached rope. Use it to safely descend from high places.\n\nLMB to attach the hook to a surface.\nR to release rope."
SWEP.Base = "weapon_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_zipline")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_zipline"
SWEP.ViewModel = "models/weapons/c_models/c_grappling_hook/c_grappling_hook.mdl"
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.Category="HMCD: Union - Other"
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
SWEP.CommandDroppable = false
SWEP.ENT = "ent_jack_hmcd_zipline"
SWEP.CarryWeight = 2500
SWEP.NextDownTime = 0
SWEP.NextSoundPlay = 0
SWEP.StartedDescending = false
SWEP.Descended = false

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
	self:Throw()

	if self:GetCurrentState() == "Nothing" then
		if IsValid(self.GrapplinHook) and not self.Descended then
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
		end

		self:SetNextPrimaryFire(CurTime() + .2)
	end
end

function SWEP:PullTaut()
	self.DesiredDist = (self:GetOwner():GetPos() - self.GrapplinHook:GetPos()):Length() + 50
	self.GrapplinHook:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
end

function SWEP:SecondaryAttack()
end

--
function SWEP:Reload()
	if self:GetCurrentState() == "Nothing" then
		self:Deploy()

		if self.Rope and self.Rope.Remove and IsValid(self.Rope) and SERVER then
			self.Rope:Remove()
		end

		self.Rope = nil
		self:SetHoldType("normal")
		self.StartedDescending = false
		self.Descended = true
		if CLIENT then return end
		local GrEnd = ents.Create("ent_jack_hmcd_zipline")
		GrEnd:SetPos(self:GetOwner():GetPos() + self:GetOwner():GetAngles():Up() * 10)
		GrEnd:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		GrEnd:Spawn()
		GrEnd:Activate()
		--self.Rope2=self:CollisionlessKeyFrameRope(GrEnd,self.GrapplinHook,Vector(0,0,10),Vector(0,0,0),1000,2,"cable/rope_shadowdepth")
		--self.Rope2:Fire("SetLength",GrEnd:GetPos():Distance(self.GrapplinHook:GetPos()))
		local Rope = constraint.Rope(GrEnd, self.GrapplinHook, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), (self.GrapplinHook:GetPos() - GrEnd:GetPos()):Length(), -.1, 0, 2, "cable/rope_shadowdepth", false)

		if SERVER then
			self:Remove()
		end
	end
end

function SWEP:IsNearGround()
	return util.QuickTrace(self:GetOwner():GetPos(), -vector_up * 75, {self:GetOwner(), self:GetOwner().fakeragdoll}).Hit
end

function SWEP:Think()
	local Time = CurTime()

	if self.StartedDescending and self:IsNearGround() then
		self.StartedDescending = false
		self:GetOwner():EmitSound("npc/combine_soldier/vo/zipline/zipline_hitground" .. math.random(1, 2) .. ".wav", 100, 100)
		self.Descended = true
		self.Rope:Remove()
		local GrEnd = ents.Create("ent_jack_hmcd_zipline")
		GrEnd:SetPos(self:GetOwner():GetPos() + self:GetOwner():GetAngles():Up() * 10)
		GrEnd:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		GrEnd:Spawn()
		GrEnd:Activate()
		--self.Rope2=self:CollisionlessKeyFrameRope(GrEnd,self.GrapplinHook,Vector(0,0,10),Vector(0,0,0),1000,2,"cable/rope_shadowdepth")
		--self.Rope2:Fire("SetLength",GrEnd:GetPos():Distance(self.GrapplinHook:GetPos()))
		local Rope = constraint.Rope(GrEnd, self.GrapplinHook, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), (self.GrapplinHook:GetPos() - GrEnd:GetPos()):Length(), -.1, 0, 2, "cable/rope_shadowdepth", false)

		timer.Simple(1, function()
			self:Remove()
		end)
	end

	if self.NextDownTime < Time and not self:IsNearGround() and self:GetOwner():GetVelocity().z < 0 and IsValid(self.GrapplinHook) and not self.Descended and not self:GetOwner():KeyDown(IN_ATTACK) then
		self.NextDownTime = Time + 0.1
		self.DesiredDist = math.Clamp(self.DesiredDist + 30, 10, 4000)
		self.StartedDescending = true

		if self.NextSoundPlay < Time then
			self:GetOwner():EmitSound("npc/combine_soldier/vo/zipline/zipline" .. math.random(1, 2) .. ".wav", 100, 100)
			self.NextSoundPlay = Time + 2
		end
	end

	if self.NextThinkTime <= Time then
		self.NextThinkTime = Time + .025
		local State = self:GetCurrentState()

		if not (State == "Nothing") then
			local Sprintin = self:GetOwner():KeyDown(IN_SPEED)
			local HiddenAmt = self:GetHidden()
			local BackAmt = self:GetBack()

			if State == "Idling" then
			elseif State == "Drawing" then
				--
				self:SetHidden(math.Clamp(HiddenAmt - 10 / self.DrawTime, 0, 100))

				if HiddenAmt <= 0 then
					self:SetCurrentState("Idling")
				end
			elseif (State == "Winding") and not self.JustThrew then
				--
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
	self:SetCurrentState("Winding")
	self:SetThrowPower(1)
	self.JustThrew = false
	--self:SetHoldType("grenade")
	self:CustomWindup()
end

function SWEP:Throw()
	if CLIENT then return end
	if self.JustThrew then return end

	local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

	if Tr.Hit and not (Tr.Entity:GetClass() == "player") then
		self.JustThrew = true
		self:SetCurrentState("Nothing")
		self:SetShouldHideWorldModel(true)
		self.DesiredDist = 2000
		self.Tight = false
		self:GetOwner():ViewPunch(Angle(-5, 0, 0))
		local Gr = ents.Create("ent_jack_hmcd_zipline")
		sound.Play("npc/combine_soldier/vo/zipline/zipline_clip" .. math.random(1, 2) .. ".wav", self:GetPos(), 75, 80)
		Gr.HmcdSpawned = self.HmcdSpawned
		Gr:SetPos(Tr.HitPos + Tr.HitNormal * -1)
		Gr.Owner = self:GetOwner()
		Gr:SetAngles(VectorRand():Angle())
		Gr:Spawn()
		Gr:Activate()
		Gr.Rope = self
		Gr.Constraint = constraint.Weld(Gr, Tr.Entity, 0, 0, 0, true, false)
		self.GrapplinHook = Gr
		Gr:SetPhysicsAttacker(self:GetOwner())

		if self.Rope and self.Rope.Remove and SERVER then
			self.Rope:Remove()
		end

		self.Rope = self:CollisionlessKeyFrameRope(self:GetOwner(), self.GrapplinHook, Vector(0, 0, 10), Vector(0, 0, 0), 1000, 2, "cable/rope_shadowdepth")
	end
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

		if (EffDist > 0) and not self.Descended then
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

		if IsValid(self.Rope) then
			self.Rope:Fire("SetLength", self.DesiredDist + 10)
		end
	elseif State == "Nothing" then
		self:Reload()
	elseif State == "Winding" then
		if self.NextSpinWhooshTime < CurTime() then
			local Pow = self:GetThrowPower()
			self.NextSpinWhooshTime = CurTime() + math.Clamp(10 / Pow, .3, 1.25)
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

	function SWEP:GetViewModelPosition(pos, ang)
		pos = pos + ang:Forward() * 30 + ang:Right() * 15 - ang:Up() * 50

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		self.DatWorldModel = ClientsideModel("models/weapons/c_models/c_grappling_hook/c_grappling_hook.mdl")
		self.DatWorldModel:SetMaterial("models/shiny")
		self.DatWorldModel:SetColor(Color(10, 10, 10, 255))
		self.DatWorldModel:SetModelScale(.8, 0)
		self.DatWorldModel:SetPos(self:GetPos())
		self.DatWorldModel:SetParent(self)
		self.DatWorldModel:SetNoDraw(true)
	end
end