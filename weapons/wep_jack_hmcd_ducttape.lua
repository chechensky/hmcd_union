--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_ducttape.lua
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
	SWEP.SlotPos = 5
	killicon.AddFont("wep_jack_hmcd_ducttape", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
		local Go, TrOne, TrTwo = self:FindObjects()

		if Go then
			local Rand = math.random(100, 200)
			surface.DrawCircle(ScrW() / 2, ScrH() / 2, 50, Color(Rand, Rand, Rand, 200))
			surface.DrawCircle(ScrW() / 2, ScrH() / 2, 49, Color(Rand, Rand, Rand, 200))
			surface.DrawCircle(ScrW() / 2, ScrH() / 2, 48, Color(Rand, Rand, Rand, 200))
		end
	end
end

SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/props_phx/wheels/drugster_front.mdl"
SWEP.WorldModel = "models/props_phx/wheels/drugster_front.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ducttape")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_ducttape"
SWEP.PrintName = "Duct Tape"
SWEP.Instructions = "This is a roll of normal aluminum-colored waterproof polyethylene-coated vinyl-cloth adhesive tape. Use it to stick things together.\n\nLMB to stick.\nYou can only put tape on a seam or close gap between two objects."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Category="HMCD: Union - Other"
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
SWEP.ENT = "ent_jack_hmcd_ducttape"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CanAmmoShow = false

SWEP.UnTapeables = {MAT_SAND, MAT_SLOSH, MAT_SNOW}

SWEP.CarryWeight = 400

function SWEP:Initialize()
	self:SetHoldType("slam")
	self.DownAmt = 20
end

function SWEP:SetupDataTables()
end

--
function SWEP:FindObjects()
	local Pos, Vec, GotOne, Tries, TrOne, TrTwo = self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector(), false, 0, nil, nil

	while not GotOne and (Tries < 100) do
		local Tr = util.QuickTrace(Pos, Vec * 60 + VectorRand() * 2, {self:GetOwner()})

		if Tr.Hit and not Tr.HitSky and not table.HasValue(self.UnTapeables, Tr.MatType) then
			GotOne = true
			TrOne = Tr
		end

		Tries = Tries + 1
	end

	if GotOne then
		GotOne = false
		Tries = 0

		while not GotOne and (Tries < 100) do
			local Tr = util.QuickTrace(Pos, Vec * 60 + VectorRand() * 2, {self:GetOwner()})

			if Tr.Hit and not Tr.HitSky and not table.HasValue(self.UnTapeables, Tr.MatType) and not (Tr.Entity == TrOne.Entity and Tr.PhysicsBone == TrOne.PhysicsBone) then
				GotOne = true
				TrTwo = Tr
			end

			Tries = Tries + 1
		end
	end

	if TrOne and TrTwo then
		return true, TrOne, TrTwo
	else
		return false, nil, nil
	end
end

function SWEP:PrimaryAttack()


	if SERVER then
		local Go, TrOne, TrTwo = self:FindObjects()

		if Go then
			local ent1, ent2 = TrOne.Entity, TrTwo.Entity

			local lefthand, righthand = {5, 4, 3}, {7, 6, 2}

			local tyinghands = ((table.HasValue(lefthand, TrOne.PhysicsBone) and table.HasValue(righthand, TrTwo.PhysicsBone)) or (table.HasValue(righthand, TrOne.PhysicsBone) and table.HasValue(lefthand, TrTwo.PhysicsBone))) and ent1 == ent2 and ent1:GetClass() == "prop_ragdoll"

			if tyinghands then
				local posspine, angspine = ent1:GetBonePosition(ent1:LookupBone("ValveBiped.Bip01_Spine4"))
				local position = WorldToLocal(TrOne.HitPos, self:GetOwner():EyeAngles(), posspine, angspine)
				local front = position.y > 5
				local ent = ent1
				ent.MovedHands = false

				if front then
					ent.TiedFront = true
				else
					ent.TiedBehind = true
				end

				local sets = 0
				local dir = 7

				if ent.CuffedFront or ent.TiedFront then
					dir = -10
				end

				local pos, ang = ent:GetBonePosition(ent.spine_bone)
				local hand2 = ent:GetPhysicsObjectNum(ent:TranslateBoneToPhysBone(ent.lhand_bone))
				local hand1 = ent:GetPhysicsObjectNum(ent:TranslateBoneToPhysBone(ent.rhand_bone))
				hand1:Wake()
				hand2:Wake()

				hook.Add("Think", self:GetOwner():EntIndex() .. "Uncuff", function()
					hand1:SetPos(pos + ang:Right() * dir)
					hand2:SetPos(pos + ang:Right() * dir)
				end)

				local ownerInd = self:GetOwner():EntIndex()

				timer.Simple(.1, function()
					hook.Remove("Think", ownerInd .. "Uncuff")

					if IsValid(ent1) then
						ent1.handcuffs = constraint.Weld(ent1, ent1, 7, 5, 0, false, false)
					end
				end)

				if ent:IsPlayer() then
					if front then
						ent.TiedFront = true
					else
						ent.TiedBehind = true
					end

					net.Start("hmcd_cuffed")
					net.WriteBit(true)
					net.Send(ent)
					local add = 0

					if front then
						add = 30
					end

					ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(20 - add, 8.8 - add, 0))
					ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(15, 0 - add, 0))
					ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0 - add, 75))
					ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(-15, 0 - add, 0))
					ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0 - add, -75))
					ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-20 + add * 0.5, 16.6 - add, 0))
					ent:SelectWeapon("wep_jack_hmcd_hands")
				end
			end

			local DoorSealed = HMCD_IsDoor(ent1) or HMCD_IsDoor(ent2)

			if DoorSealed then
				if not self.TapeAmount then
					self.TapeAmount = 100
				end

				if self.TapeAmount < 70 then
					self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Not enough tape!")
				else
					if HMCD_IsDoor(ent1) then
						DoorSealed = true
						ent1:Fire("lock", "", 0)

						if not ent1.Tapes then
							ent1.Tapes = {}
						end

						table.insert(ent1.Tapes, ent1:WorldToLocal(TrOne.HitPos))
					end

					if HMCD_IsDoor(ent2) then
						DoorSealed = true
						ent2:Fire("lock", "", 0)

						if not ent2.Tapes then
							ent2.Tapes = {}
						end

						table.insert(ent2.Tapes, ent2:WorldToLocal(TrTwo.HitPos))
					end

					self.TapeAmount = self.TapeAmount - 70
					sound.Play("snd_jack_hmcd_ducttape.wav", TrOne.HitPos, 65, math.random(80, 120))
					self:GetOwner():SetAnimation(PLAYER_ATTACK1)
					self:GetOwner():ViewPunch(Angle(3, 0, 0))
					self:SprayDecals()
					self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Door Sealed")

					timer.Simple(.1, function()
						if self.TapeAmount <= 0 then
							self:Remove()
						end
					end)
				end
			else
				local Strength

				if tyinghands then
					Strength = 1
				else
					Strength = HMCD_BindObjects(ent1, TrOne.HitPos, ent2, TrTwo.HitPos, 1, TrOne.PhysicsBone, TrTwo.PhysicsBone, self)
				end

				if not Strength then return end

				if not self.TapeAmount then
					self.TapeAmount = 100
				end

				self.TapeAmount = self.TapeAmount - 10
				sound.Play("snd_jack_hmcd_ducttape.wav", TrOne.HitPos, 65, math.random(80, 120))
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
				self:GetOwner():ViewPunch(Angle(3, 0, 0))
				util.Decal("hmcd_jackatape", TrOne.HitPos + TrOne.HitNormal, TrOne.HitPos - TrOne.HitNormal)
				util.Decal("hmcd_jackatape", TrTwo.HitPos + TrTwo.HitNormal, TrTwo.HitPos - TrTwo.HitNormal)
				self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Bond strength: " .. tostring(Strength))

				timer.Simple(.1, function()
					if self.TapeAmount <= 0 then
						self:Remove()
					end
				end)
			end
		end
	end

	self:SetNextPrimaryFire(CurTime() + 2.5)
end

local traces = {Vector(0, 0, 0), Vector(0, 0, .15), Vector(0, 0, -.15), Vector(0, .15, 0), Vector(0, -.15, 0), Vector(.15, 0, 0), Vector(-.15, 0, 0)}

function SWEP:SprayDecals()
	for i, trace in pairs(traces) do
		local tr = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + trace) * 70, {self:GetOwner()})

		util.Decal("hmcd_jackatape", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	end
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1)
	self.DownAmt = 60

	return true
end

function SWEP:Holster()
	self:OnRemove()

	return true
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
	if SERVER then
		self:GetOwner():PrintMessage(HUD_PRINTCENTER, tostring(self.TapeAmount or 100) .. "% of roll remaining")
	end
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())

	if self.TapeAmount then
		Ent.TapeAmount = self.TapeAmount
	end

	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

function SWEP:OnRemove()
	if IsValid(self:GetOwner()) and CLIENT and self:GetOwner():IsPlayer() then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			vm:SetMaterial("")
			vm:SetColor(Color(255, 255, 255, 255))
		end
	end
end

if CLIENT then
	function SWEP:PreDrawViewModel(vm, ply, wep)
		vm:SetMaterial("models/shiny")
		vm:SetColor(Color(100, 100, 100, 255))
	end

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + 1, 0, 60)
		else
			self.DownAmt = math.Clamp(self.DownAmt - 1, 0, 60)
		end

		pos = pos - ang:Up() * (self.DownAmt + 30) + ang:Forward() * 100 + ang:Right() * 50
		--ang:RotateAroundAxis(ang:Up(),0)
		ang:RotateAroundAxis(ang:Right(), 90)
		ang:RotateAroundAxis(ang:Forward(), -90)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 3.5 + Ang:Right() * 5 - Ang:Up() * -1)
				Ang:RotateAroundAxis(Ang:Right(), 180)
				--Ang:RotateAroundAxis(Ang:Right(),90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/props_phx/wheels/drugster_front.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(.2, 0)
			self.DatWorldModel:SetMaterial("models/shiny")
			self.DatWorldModel:SetColor(Color(100, 100, 100, 255))
		end
	end
end