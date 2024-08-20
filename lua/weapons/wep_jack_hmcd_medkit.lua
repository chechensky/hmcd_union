--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_medkit.lua
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
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_medkit", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/w_models/weapons/w_eq_medkit.mdl"
SWEP.WorldModel = "models/w_models/weapons/w_eq_medkit.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_medkit")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_medkit"
SWEP.PrintName = "First-Aid Kit"
SWEP.Instructions = "This is a civilian-grade first-aid kit containing hemostatic agents, bandages, antibiotics, disinfectants, pain relievers and some basic rations.\n\nLMB to fix self\nRMB to fix another"
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
SWEP.Category="HMCD: Union - Medicines"
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
SWEP.ENT = "ent_jack_hmcd_medkit"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 1800
SWEP.Poisonable = true

SWEP.Resource = 100

function SWEP:Initialize()
	self:SetHoldType("slam")
	self.DownAmt = 20
	self:SetAmount(1)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "Amount")
end

local alpha = 0
local faded_black = Color(0, 0, 0, 200)
local healmenuopen = nil

--[[function SWEP:Reload()

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	if CLIENT then

		if !healmenuopen then
			local ply = LocalPlayer()
			healmenuopen = true
			Frame = vgui.Create("DFrame")
			Frame:SetSize(500, 400)
			Frame:SetPos(700,350)
			Frame:SetTitle("")
			Frame:SetDraggable(false)
			Frame:ShowCloseButton(true)
			Frame:MakePopup()
			Frame.Paint = function(self, w, h)
				alpha = Lerp(0.1, alpha, 220)
				draw.RoundedBoxEx(11, 2, 0, w, h, Color(0,0,0,alpha), true, true, true, true)
			end

			function Frame:OnClose()
				healmenuopen = nil
			end
			
			local info = vgui.Create("DLabel", Frame)
			info:SetText("RMB - Information\nLMB - Heal")
			info:SetFont("MedKitFont")
			info:SetColor(Color(255, 255, 255))
			info:SizeToContents() 
			info:SetPos(10, 30) 
			info:SetMouseInputEnabled(false)
			
			local playerModelPanel = vgui.Create("DModelPanel", Frame)
			playerModelPanel:SetSize(530, 530)
			playerModelPanel:SetPos(-20, -70)
			playerModelPanel:SetModel( ply:GetModel() )
			playerModelPanel:SetMouseInputEnabled(false)
			function playerModelPanel:LayoutEntity(ent)
    			ent:SetAngles(Angle(0, 40, 0))
			end
			local LeftArm = vgui.Create("DButton", Frame)
			LeftArm:SetText("")
			LeftArm:SetSize(100, 20)
			LeftArm:SetPos(280, 150)
			LeftArm.Paint = function(self, w, h)
				local bgColor = self:IsHovered() and Color(100, 149, 237, 255) or Color(144, 27, 27, 255)
    			surface.SetDrawColor(50, 50, 50, 255)
    			surface.DrawRect(0, 0, w, h)
    
    			surface.SetDrawColor(bgColor)
    			surface.DrawRect(2, 2, w - 4, h - 4)
    
    			draw.SimpleText("Left Arm", "MedKitFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			LeftArm.DoClick = function()
    			net.Start("MK_LeftArm")
				net.WriteEntity(ply)
				net.SendToServer()
			end
			LeftArm.DoRightClick = function()
    			net.Start("MK_CheckLeftArm")
				net.WriteEntity(ply)
				net.SendToServer()
			end

			local RightArm = vgui.Create("DButton", Frame)
			RightArm:SetText("")
			RightArm:SetSize(100, 20)
			RightArm:SetPos(100, 150)
			RightArm.Paint = function(self, w, h)
				local bgColor = self:IsHovered() and Color(100, 149, 237, 255) or Color(144, 27, 27, 255)
    			surface.SetDrawColor(50, 50, 50, 255)
    			surface.DrawRect(0, 0, w, h)
    
    			surface.SetDrawColor(bgColor)
    			surface.DrawRect(2, 2, w - 4, h - 4)
    
    			draw.SimpleText("Right Arm", "MedKitFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			RightArm.DoClick = function()
    			net.Start("MK_RightArm")
				net.WriteEntity(ply)
				net.SendToServer()
			end
			RightArm.DoRightClick = function()
    			net.Start("MK_CheckRightArm")
				net.WriteEntity(ply)
				net.SendToServer()
			end

			local Stomach = vgui.Create("DButton", Frame)
			Stomach:SetText("")
			Stomach:SetSize(70, 20)
			Stomach:SetPos(200, 180)
			Stomach.Paint = function(self, w, h)
				local bgColor = self:IsHovered() and Color(100, 149, 237, 255) or Color(144, 27, 27, 255)
    			surface.SetDrawColor(50, 50, 50, 255)
    			surface.DrawRect(0, 0, w, h)
    
    			surface.SetDrawColor(bgColor)
    			surface.DrawRect(2, 2, w - 4, h - 4)
    
    			draw.SimpleText("Stomach", "MedKitFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			Stomach.DoClick = function()
    			net.Start("MK_Stomach")
				net.WriteEntity(ply)
				net.SendToServer()
			end
			Stomach.DoRightClick = function()
    			net.Start("MK_CheckStomach")
				net.WriteEntity(ply)
				net.SendToServer()
			end

			local Chest = vgui.Create("DButton", Frame)
			Chest:SetText("")
			Chest:SetSize(70, 20)
			Chest:SetPos(200, 100)
			Chest.Paint = function(self, w, h)
				local bgColor = self:IsHovered() and Color(100, 149, 237, 255) or Color(144, 27, 27, 255)
    			surface.SetDrawColor(50, 50, 50, 255)
    			surface.DrawRect(0, 0, w, h)
    
    			surface.SetDrawColor(bgColor)
    			surface.DrawRect(2, 2, w - 4, h - 4)
    
    			draw.SimpleText("Chest", "MedKitFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			Chest.DoClick = function()
    			net.Start("MK_Chest")
				net.WriteEntity(ply)
				net.SendToServer()
			end
			Chest.DoRightClick = function()
    			net.Start("MK_CheckChest")
				net.WriteEntity(ply)
				net.SendToServer()
			end

			-------
			local RightLeg = vgui.Create("DButton", Frame)
			RightLeg:SetText("")
			RightLeg:SetSize(80, 20)
			RightLeg:SetPos(150, 280)
			RightLeg.Paint = function(self, w, h)
				local bgColor = self:IsHovered() and Color(100, 149, 237, 255) or Color(144, 27, 27, 255)
    			surface.SetDrawColor(50, 50, 50, 255)
    			surface.DrawRect(0, 0, w, h)
    
    			surface.SetDrawColor(bgColor)
    			surface.DrawRect(2, 2, w - 4, h - 4)
    
    			draw.SimpleText("Right Leg", "MedKitFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			RightLeg.DoClick = function()
    			net.Start("MK_RightLeg")
				net.WriteEntity(ply)
				net.SendToServer()
			end
			RightLeg.DoRightClick = function()
    			net.Start("MK_CheckRightLeg")
				net.WriteEntity(ply)
				net.SendToServer()
			end

			local LeftLeg = vgui.Create("DButton", Frame)
			LeftLeg:SetText("")
			LeftLeg:SetSize(80, 20)
			LeftLeg:SetPos(260, 280)
			LeftLeg.Paint = function(self, w, h)
				local bgColor = self:IsHovered() and Color(100, 149, 237, 255) or Color(144, 27, 27, 255)
    			surface.SetDrawColor(50, 50, 50, 255)
    			surface.DrawRect(0, 0, w, h)
    
    			surface.SetDrawColor(bgColor)
    			surface.DrawRect(2, 2, w - 4, h - 4)
    
    			draw.SimpleText("Left Leg", "MedKitFont", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			LeftLeg.DoClick = function()
    			net.Start("MK_LeftLeg")
				net.WriteEntity(ply)
				net.SendToServer()
			end
			LeftLeg.DoRightClick = function()
    			net.Start("MK_CheckLeftLeg")
				net.WriteEntity(ply)
				net.SendToServer()
			end
		end

	end
	--if SERVER then
	--	if self:GetOwner():Health() < 150 or checkAllBleedOuts_bolshe(self:GetOwner(), 0) then
	--		self.ok = true
	--		sound.Play("snd_jack_hmcd_bandage.wav", self:GetOwner():GetShootPos(), 60, math.random(90, 110))
	--		self:GetOwner():ViewPunch(Angle(-10, 0, 0))
	--		self:GetOwner():RemoveAllDecals()
	--		self:SetAmount(self:GetAmount() - 1)
	--
	--		self:SetNextPrimaryFire(CurTime() + 2)
	--		self:SetNextSecondaryFire(CurTime() + 2)
	--
	--		if self:GetAmount() == 0 then
	--			self:Remove()
	--		end
	--	end
	--end
end]]--

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1)
	self.DownAmt = 20

	return true
end

function SWEP:SecondaryAttack()
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	if CLIENT then return end

	local startPos
	local filter = self:GetOwner()

	if IsValid(self:GetOwner().fakeragdoll) then
		filter = {self:GetOwner(), self:GetOwner().fakeragdoll}
		startPos = self:GetOwner().fakeragdoll:GetBonePosition(self:GetOwner().fakeragdoll:LookupBone("ValveBiped.Bip01_R_Hand"))
	else
		startPos = self:GetOwner():GetShootPos()
	end

	local tr = util.QuickTrace(startPos, self:GetOwner():GetAimVector() * 50, filter)
	local Dude, Pos = (tr.Entity:IsRagdoll() and RagdollOwner(tr.Entity)) or tr.Entity, tr.HitPos
	local canHeal = false
	if not IsValid(Dude) then return end
	if tr.Entity:GetNWBool("Dead", false) == true then return end
		
	local ply = self:GetOwner()
	local part, bleed = findMaxValue(Dude.BleedOuts)
	local mbleed = math.random(15, 30) + self.Resource / 10

	if bleed <= 0 then return end
	if self.Resource <= 0 then return end

	StandartHeal(ply)
	ply:ChatPrint("You healing " .. NormaliseKonech[part] .. ".")
	Dude.BleedOuts[part] = Dude.BleedOuts[part] - mbleed
	Dude.pain = Dude.pain - 100
		
	self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	
	local ply = self:GetOwner()
	local part, bleed = findMaxValue(ply.BleedOuts)
	local mbleed = math.random(15, 30) + self.Resource / 10

	if ply:Health() < 150 then 
		ply:SetHealth(ply:Health() + 30)
	end

	if bleed <= 0 then return end
	if self.Resource <= 0 then return end

	StandartHeal(ply)
	ply:ChatPrint("You healing " .. NormaliseKonech[part] .. ".")
	ply.BleedOuts[part] = ply.BleedOuts[part] - mbleed
	ply.pain = ply.pain - 100

	local usedmed = ents.Create("prop_physics")
	usedmed:SetModel(self.WorldModel)
	usedmed:SetPos(ply:GetPos())
	usedmed:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	local phys = usedmed:GetPhysicsObject()
	if IsValid(usedmed and ply) then
    	usedmed:ApplyForceCenter(ply:GetForward() * 500)
	end
	timer.Simple(30, function()
    	if IsValid(usedmed) then
        	usedmed:Remove()
    	end
	end)
	usedmed:Spawn()

	self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:Think()
	if SERVER then
		local HoldType = "slam"

		if self:GetOwner():KeyDown(IN_SPEED) then
			HoldType = "normal"
		end

		self:SetHoldType(HoldType)
	end
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent.Amount = self:GetAmount()
	Ent.Resource = self.Resource
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

if CLIENT then
	function SWEP:PreDrawViewModel(vm, ply, wep)
	end

	--
	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * (self.DownAmt + 8) + ang:Forward() * 25 + ang:Right() * 12
		ang:RotateAroundAxis(ang:Forward(), -90)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 3)
				Ang:RotateAroundAxis(Ang:Up(), 90)
				Ang:RotateAroundAxis(Ang:Right(), 90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/w_models/weapons/w_eq_medkit.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
		end
	end
end