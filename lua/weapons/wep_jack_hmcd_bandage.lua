if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 80
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_bandage", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/bandages.mdl"
SWEP.WorldModel = "models/bandages.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_bandage")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_bandage"
SWEP.PrintName = "Small Bandage"
SWEP.Instructions = "This is some cotton cloth that can be wrapped around a wound to help stop bleeding and restore medical stability.\n\nLMB to bandage self\nRMB to bandage another"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.Category="HMCD: Union - Medicines"
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
SWEP.ENT = "ent_jack_hmcd_bandage"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 300
SWEP.Poisonable = true
SWEP.Resource = 40

function SWEP:Initialize()
	self:SetHoldType("slam")
	self.DownAmt = 20
end

function SWEP:SetupDataTables()
end

--
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
	local mbleed = math.random(5, 10)

	if bleed <= 0 then return end
	if self.Resource <= 0 then return end

	StandartHeal(ply)
	ply:ChatPrint("You healing " .. NormaliseKonech[part] .. ".")
	Dude.BleedOuts[part] = Dude.BleedOuts[part] - mbleed
		
	self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	
	local ply = self:GetOwner()
	local part, bleed = findMaxValue(ply.BleedOuts)
	local mbleed = math.random(5, 10)

	if bleed <= 0 then return end
	if self.Resource <= 0 then return end

	StandartHeal(ply)
	ply:ChatPrint("You healing " .. NormaliseKonech[part] .. ".")
	ply.BleedOuts[part] = ply.BleedOuts[part] - mbleed
	local usedmed = ents.Create("prop_physics")
	usedmed:SetModel(self.WorldModel)
	usedmed:SetPos(ply:GetPos())
	usedmed:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	local phys = usedmed:GetPhysicsObject()
	if IsValid(usedmed) then
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

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1)
	self.DownAmt = 20

	return true
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

function SWEP:Reload()
	if IsValid(self:GetOwner().fakeragdoll) and self:GetNextSecondaryFire() < CurTime() then
		self:SecondaryAttack(true)
	end
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent.Resource = self.Resource
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
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

		pos = pos - ang:Up() * (self.DownAmt + 10) + ang:Forward() * 30 + ang:Right() * 7
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), -10)
		ang:RotateAroundAxis(ang:Forward(), -10)

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
			self.DatWorldModel = ClientsideModel("models/bandages.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
		end
	end
end