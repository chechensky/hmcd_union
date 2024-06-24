--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_ied.lua
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
	util.AddNetworkString("hmcd_splodetype")
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 80
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	killicon.AddFont("wep_jack_hmcd_ied", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

	function SWEP:DrawViewModel()
		return false
	end

	function SWEP:DrawWorldModel()
		self:DrawModel()
	end

	local function drawTextShadow(t, f, x, y, c, px, py)
		color_black.a = c.a
		draw.SimpleText(t, f, x + 1, y + 1, color_black, px, py)
		draw.SimpleText(t, f, x, y, c, px, py)
		color_black.a = 255
	end

	net.Receive("hmcd_splodetype", function()
		local Ent = net.ReadEntity()
		Ent.SplodeType = net.ReadInt(32)
	end)

	function SWEP:DrawHUD()
		if not self:GetRigged() then
			local Ent, TrPos, TrNorm = HMCD_WhomILookinAt(self:GetOwner(), .2, 55)

			if IsValid(Ent) and ((Ent:GetClass() == "prop_physics") or (Ent:GetClass() == "prop_physics_multiplayer") or (Ent:GetClass() == "prop_ragdoll")) then
				local W, H = ScrW(), ScrH()
				drawTextShadow("[LMB] rig IED", "FontSmall", W / 2, H / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				if Ent.SplodeType then
					if Ent.SplodeType == 2 then
						drawTextShadow("will produce lethal fragments", "FontSmall", W / 2, H / 2 + 25, Color(0, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					elseif Ent.SplodeType == 3 then
						drawTextShadow("will burst into flames", "FontSmall", W / 2, H / 2 + 25, Color(0, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
			end
		end
	end
end

SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/weapons/v_ied_ins.mdl"
SWEP.WorldModel = "models/props_junk/cardboard_jox004a.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ied")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_ied"
SWEP.PrintName = "Ammonal Explosive Kit"
SWEP.Instructions = "This is a tiny box of ammonal, a blasting cap, a battery-powered detonator and RF remote. Use it to create a murderous IED trap.\n\nPress LMB to discreetly hide an explosive charge in/on an object.\nRMB to create a fragile, obvious standalone bomb.\nOnce rigged, press LMB to detonate.\nExplosive will either fragment or blow down doors, depending on choice of prop."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 2
SWEP.SwayScale = 2
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.Category="HMCD: Union - Traitor"
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
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
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.UseHands = true
SWEP.InsHands = true
SWEP.CarryWeight = 2000

function SWEP:Initialize()
	self:SetRigged(false)
	self:SetHoldType("normal")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Rigged")
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	self.DownAmt = 16
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	if self:GetRigged() then
		self:DoBFSAnimation("det_draw")
	end

	return true
end

function SWEP:DoBFSAnimation(anim)
	if self:GetOwner() and self:GetOwner().GetViewModel then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	end
end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
end

--
function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	if self:GetRigged() then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	if CLIENT then return end

	if self:GetRigged() then
		self:SetNextPrimaryFire(CurTime() + 5)

		if self.Explosive then
			self:DoBFSAnimation("det_detonate")
			self:GetOwner():EmitSound("keypad" .. math.random(1, 3) .. ".mp3", 45, 100)

			if IsValid(self.Explosive) then
				sound.Play("nokia.mp3", self.Explosive:GetPos(), 75, 100)
			end

			local Splosive = self.Explosive

			timer.Simple(.5, function()
				if IsValid(self) then
					self:DoBFSAnimation("det_holster")
				end
			end)

			timer.Simple(.5, function()
				if IsValid(Splosive) then
					Splosive:ExplodeIED()
				end
			end)
		end

		timer.Simple(1.5, function()
			if IsValid(self) then
				local Own = self:GetOwner()
				self:SetRigged(false)
				self:Remove()
			end
		end)

		return
	end

	self:SetNextPrimaryFire(CurTime() + .25)
	self:DeployFront(true)

	if self:GetRigged() then
		self:DoBFSAnimation("det_draw")
	end

	self:SetNextSecondaryFire(CurTime() + 1)
	if self:GetRigged() then return end
	self:DeployFront(false)

	if self:GetRigged() then
		self:DoBFSAnimation("det_draw")
	end
end

function SWEP:Think()
	if self:GetRigged() then
		self.UseHands = true
	else
		self.UseHands = false
	end

	if SERVER then
		if not self:GetRigged() then
			local Ent, TrPos, TrNorm = HMCD_WhomILookinAt(self:GetOwner(), .2, 55)

			if Ent and IsValid(Ent) and ((Ent:GetClass() == "prop_physics") or (Ent:GetClass() == "prop_physics_multiplayer") or (Ent:GetClass() == "prop_ragdoll")) then
				local Type = HMCD_ExplosiveType(Ent)
				net.Start("hmcd_splodetype")
				net.WriteEntity(Ent)
				net.WriteInt(Type, 32)
				net.Send(self:GetOwner())
			end
		end
	end

	if self:GetRigged() then
		self:SetHoldType("normal")
	else
		self:SetHoldType("slam")
	end
end

function SWEP:DeployFront(proper)
	if CLIENT then return end
	self:GetOwner():LagCompensation(true)
	local Ply = self:GetOwner()
	local Ent, HitPos, HitNorm = HMCD_WhomILookinAt(self:GetOwner(), .2, 55)
	local AimVec, Obvious, GoodToGo = self:GetOwner():GetAimVector(), nil, false

	if (proper and (self:GetOwner().fakeragdoll ~= Ent) and (IsValid(Ent) and ((Ent:GetClass() == "prop_physics") or (Ent:GetClass() == "prop_physics_multiplayer") or (Ent:GetClass() == "prop_ragdoll")))) and Ent.Huy ~= false then
		Obvious = false
		GoodToGo = true
	elseif not proper then
		local Pos = HitPos or self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 30
		Ent = ents.Create("prop_physics")
		Ent.HmcdSpawned = self.HmcdSpawned
		Ent:SetModel("models/props_junk/cardboard_jox004a.mdl")
		Ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		Ent:SetPos(Ply:GetShootPos() + Ply:GetForward() * 5 + Ply:GetAimVector() * 3)
		Ent:Spawn()
		Ent:SetModelScale(.5, .01)
		Ent:Activate()
		Ent:SetHealth(15)
		Ent:GetPhysicsObject():SetMass(20)
		Ent:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity())
		--Ent:GetPhysicsObject():SetDamping(3,2)
		Obvious = true
		GoodToGo = true
	end

	if Ent and GoodToGo then
		if not HitPos then
			HitPos = Ent:GetPos()
		end

		self:GetOwner():ViewPunch(Angle(1, 0, 0))
		Ent.MurdererExplosive = true
		Ent.IEDAttacker = self:GetOwner()
		self.Explosive = Ent

		if Obvious then
			sound.Play("snd_jack_hmcd_bombrig.wav", HitPos, 60, 100)
		else
			sound.Play("snd_jack_hmcd_bombrig.wav", HitPos, 45, 100)
		end

		self:SetRigged(true)
		self:SetNextPrimaryFire(CurTime() + 1)
	end

	self:GetOwner():LagCompensation(false)
end

function SWEP:Reload()
end

--
if CLIENT then
	local Hidden = 0
	local Huy = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 16
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 16)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 16)
		end

		if self:GetRigged() then
			Hidden = -2
		else
			Hidden = 22
		end

		if self:GetRigged() then
			Huy = 2
		else
			Huy = 5
		end

		local NewPos = pos + ang:Forward() * Huy - ang:Up() * (3 + self.DownAmt + Hidden) + ang:Right() * 5

		return NewPos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self:GetRigged() then
			if self.DatDetModel then
				self.DatDetModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * -0.7 + Ang:Up() * -15)
				Ang:RotateAroundAxis(Ang:Up(), -90)
				Ang:RotateAroundAxis(Ang:Right(), 180)
				self.DatDetModel:SetRenderAngles(Ang)
				self.DatDetModel:DrawModel()
			else
				self.DatDetModel = ClientsideModel("models/saraphines/insurgency explosives/ied/insurgency_ied_phone.mdl")
				self.DatDetModel:SetPos(self:GetPos())
				self.DatDetModel:SetParent(self)
				self.DatDetModel:SetNoDraw(true)
				self.DatDetModel:SetModelScale(1, 0)
			end
		else
			if self.DatWorldModel then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * 4)
				Ang:RotateAroundAxis(Ang:Up(), -30)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			else
				self.DatWorldModel = ClientsideModel("models/props_junk/cardboard_jox004a.mdl")
				self.DatWorldModel:SetPos(self:GetPos())
				self.DatWorldModel:SetParent(self)
				self.DatWorldModel:SetNoDraw(true)
				self.DatWorldModel:SetModelScale(.5, 0)
			end
		end
	end

	function SWEP:PreDrawViewModel(vm, wep, ply)
		local vm = self:GetOwner():GetViewModel()
		--[[if(self:GetRigged()) and GAMEMODE.HL2 then
			vm:ManipulateBonePosition(57,Vector(0.7,1,0))
			vm:ManipulateBonePosition(29,Vector(1,0,1))
			vm:ManipulateBonePosition(30,Vector(1,-1,1))
			vm:ManipulateBoneAngles(35,Angle(0,0,180))
			vm:ManipulateBonePosition(35,Vector(0,-0.3,0))
			vm:ManipulateBonePosition(36,Vector(-1,0.3,0.35))
			vm:ManipulateBoneAngles(37,Angle(0,0,180))
			vm:ManipulateBoneAngles(41,Angle(0,0,180))
			vm:ManipulateBonePosition(41,Vector(0,0.3,0))
			vm:ManipulateBoneAngles(43,Angle(0,0,180))
			vm:ManipulateBonePosition(43,Vector(-1,0,0))
		end]]
	end

	function SWEP:ViewModelDrawn(model)
		local Pos, Ang = model:GetPos(), model:GetAngles()

		if self:GetRigged() == false then
			if self.DatDetViewModel then
				if Pos and Ang then
					self.DatDetViewModel:SetRenderOrigin(Pos + Ang:Up() * 14 + Ang:Forward() * 21 + Ang:Right() * 8)
					Ang:RotateAroundAxis(Ang:Up(), 180)
					Ang:RotateAroundAxis(Ang:Right(), 0)
					self.DatDetViewModel:SetRenderAngles(Ang)
					self.DatDetViewModel:DrawModel()
				end
			else
				self.DatDetViewModel = ClientsideModel("models/props_junk/cardboard_jox004a.mdl")
				self.DatDetViewModel:SetPos(self:GetPos())
				self.DatDetViewModel:SetParent(self)
				self.DatDetViewModel:SetNoDraw(true)
				self.DatDetViewModel:SetModelScale(.5, 0)
			end
		end
	end
end