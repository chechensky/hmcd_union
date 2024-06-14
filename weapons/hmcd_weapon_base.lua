SWEP.Author = "кет"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.PrintName = "BASE"
SWEP.Instructions = "This is your trusty 9x19mm pistol. Use it as you see fit.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_smallpistol")
	SWEP.BounceWeaponIcon = false
end

SWEP.ViewModelFOV = 80
SWEP.ViewModelFlip = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.ViewModel = "models/weapons/v_pist_jivejeven.mdl" --"models/weapons/v_pist_jeagle.mdl"	--"models/weapons/v_pist_jivejeven.mdl"	
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.DangerLevel = 70 -- How fast police will react to you holding this thing in hands?
SWEP.Primary.ClipSize = 13 -- Size of a clip
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2 -- Default number of bullets in a clip
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.Ammo = "Pistol"
SWEP.Damage = 39 -- Damage number 1
SWEP.DamageVar = 42 -- How much damage will vary. If set to 0 => only default damage numbers will engage
SWEP.DamageForce = nil -- Force applied to phys objects then damaged by weapon. Pass nil to calculate automatically
SWEP.Shots = 1 -- Amount of shots per trigger pull
SWEP.Cone = 0.07 -- Your shot spread
SWEP.AimCone = 0.005 -- Your shot spread if you aiming
SWEP.Spread = 0.00 -- Spread from the direction, that calculates from values above. Uses in shotguns
SWEP.Delay = 0.19 -- Delay between shots(quick formula for RPM: 60/RPM)
SWEP.IronPos = Vector(1.73, 0, 1.15)
SWEP.SprintAngle = Angle(-15, 0, 0)
SWEP.SprintPos = Vector(0, 0, 1.2)
SWEP.DeathDroppable = false
SWEP.CanAmmoShow = true
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.ENT = "ent_jack_hmcd_smallpistol"

SWEP.MuzzlePos = {6.9, -2.1, 1.6}

SWEP.BarrelLength = 1
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
--SWEP.AimAdd					= 0.06	
SWEP.AimAddMul = 70 -- How fast you gonna aim(1 second should ~~ 100 units)
--SWEP.SprintAdd				= 8	
SWEP.SprintAddMul = 70 -- How fast you gonna stop shooting(1 second should ~~ 100 units)

-- Recoil force, obviously(y,x)
SWEP.RecoilForce = {1, 1}

-- Recoil while you flying across the map(y,x)
SWEP.InAirRecoilForce = {0.3, 0.0}

SWEP.ReloadMul = 1
SWEP.ReloadSpeedTime = 4 -- Speed of reload in seconds
SWEP.TacticalReloadTime = 3.7
SWEP.DeploySpeedTime = 2 -- Speed of deploy in seconds
SWEP.RealDeploySpeedTime = 1.6 -- Speed of readiness in seconds
SWEP.IndividualLoadTime = 1 -- Time of loading individual shells in "individual" ReloadType
SWEP.IndividualLoadStartTime = 1 -- Time of start
SWEP.IndividualLoadEndTime = 1.4 -- Time of end
SWEP.RealIndividualLoadEndTime = 1.0
SWEP.AllowAdditionalShot = 1 -- You want charge your gun with more than 13 shots?(It is a number value)
SWEP.BobScale = 0.6 -- The scale of the viewmodel bob (viewmodel movement from left to right when walking around)
SWEP.SwayScale = 0.4 -- The scale of the viewmodel sway (viewmodel position lerp when looking around)
SWEP.InertiaScale = 0.0 -- For now. If set to 0, completely disables inertia	 
SWEP.CarryWeight = 785 -- Carry weight. Used in inertia and other systems
SWEP.Instabillity = 10 -- Instabillity while aiming
SWEP.FireSound = "snd_jack_hmcd_smp_close.wav"
SWEP.FarFireSound = "snd_jack_hmcd_smp_far.wav"
SWEP.ReloadSound = "snd_jack_hmcd_smp_reload.wav"
SWEP.DeploySound = "snd_jack_hmcd_pistoldraw.wav"
SWEP.IndividualLoadSound = "snd_jack_shotguninsert.wav"
SWEP.CycleSound = "snd_jack_hmcd_shotpump.wav"
--If passed a string, will find matching sequence--
SWEP.WReloadACT = PLAYER_RELOAD
SWEP.ReloadACT = ACT_VM_RELOAD
SWEP.TacticalReloadACT = "reload_charged"
SWEP.DeployACT = ACT_VM_DRAW
SWEP.VShootACT = ACT_VM_PRIMARYATTACK
SWEP.WShootACT = PLAYER_ATTACK1
SWEP.VLastShootACT = ACT_VM_PRIMARYATTACK
SWEP.IndividualLoadVACT = "insert"
SWEP.IndividualLoadStartVACT = "start_reload"
SWEP.IndividualLoadEndVACT = "after_reload"
SWEP.IndividualLoadSoundTime = 0.1
SWEP.EndOfLoadCycleSoundTime = 0.1
SWEP.CycleSoundTime = 0.1
SWEP.VIdleACT = ACT_VM_IDLE
--												 --
SWEP.HoldAnim = "pistol"
SWEP.HoldAimAnim = "revolver"
SWEP.PassiveHoldAnim = "normal"
SWEP.MuzzleEffect = "pcf_jack_mf_spistol"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.SmokeEffect = "pcf_jack_mf_barrelsmoke"
--Stop giving ammo--
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

--				  --
SWEP.ReloadSounds = {
	{"weapons/ins2/p80/m9_magout.wav", 0.7, "EmptyOnly"},
	{"weapons/ins2/p80/m9_magin.wav", 1.8, "EmptyOnly"},
	{"weapons/ins2/p80/m9_maghit.wav", 2.3, "EmptyOnly"},
	{"weapons/ins2/p80/m9_boltrelease.wav", 2.85, "EmptyOnly"},
	{"weapons/ins2/p80/m9_magout.wav", 0.6, "FullOnly"},
	{"weapons/ins2/p80/m9_magin.wav", 1.8, "FullOnly"},
	{"weapons/ins2/p80/m9_maghit.wav", 2.2, "FullOnly"}
}

--TODO
-- Make the ammo mass matter(inertia) cause glock is better :(((
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "SuicideAmt")
	self:NetworkVar("Bool", 0, "Suiciding")
end

function SWEP:Initialize()
	self:SetNextPrimaryFire(CurTime() + self.Delay)
	self:SetHoldType(self.HoldAnim)
	self.VDrawnAttachments = {}
	self.WDrawnAttachments = {}
	self.Reloading = false
	self.ReloadTime = nil
	self.DeployTime = nil --Used only for aiming
	--self.Attachments={}
	self.AttachmentsOnGun = {}
	self:SetNWString("Attachments", util.TableToJSON(self.AttachmentsOnGun))
	self.AimPerc = 0
	self.AimStartTime = CurTime()
	self.SprintStartTime = CurTime()
	self.SprintingWeapon = 0

	if self.DamageForce == nil then
		self.DamageForce = self.Damage * 0.05
	end

	self.m_bInitialized = true
	self.DeployTime = self.RealDeploySpeedTime + CurTime()
end

function SWEP:Equip()
	self.UpdateTime = true
	self.DeployTime = self.RealDeploySpeedTime + CurTime()
	--self:SetDeploySpeed(self:GetAnimationMul(self.RealDeploySpeedTime,va))
end

function SWEP:OnDrop()
	if self:GetSuiciding() then
		self.FirstOwner:SetDSP(0)
	end

	timer.Stop(tostring(self:GetOwner()) .. "ReloadTimer")
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())

	if self.Attachments and self.Attachments["Owner"] then
		for attachment, info in pairs(self.Attachments["Owner"]) do
			Ent:SetNWBool(attachment, self:GetNWBool(attachment))
		end
	end

	Ent:Spawn()
	Ent:Activate()
	Ent.RoundsInMag = self:Clip1()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

function SWEP:DrawHUD()
end

--
function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:EmitSound(self.FireSound, 75, 100)
	self:EmitSound(self.FarFireSound, 75 * 100, 100, 1, CHAN_AUTO)

	if self.CycleType == "manual" then
		self.Cycling = true
		self.CycleEndTime = CurTime() + self.Delay

		timer.Simple(self.CycleSoundTime, function()
			if IsValid(self) and self:GetOwner():GetActiveWeapon() == self then
				self.Weapon:EmitSound(self.CycleSound, 65, 100, 1, CHAN_AUTO)
			end
		end)
	end

	local AimPerc = self.AimPerc

	if AimPerc < 0.9 then
		self:ShootBullet(math.random(self.Damage, self.DamageVar), self.Shots, self.Cone, self.Spread, self.Primary.Ammo, self.DamageForce, nil)
	else
		self:ShootBullet(math.random(self.Damage, self.DamageVar), self.Shots, self.AimCone, self.Spread, self.Primary.Ammo, self.DamageForce, nil)
	end

	self:ShootEffects(self.VShootACT, self.WShootACT)
	self:TakePrimaryAmmo(1)

	if SERVER and not self:GetOwner():IsNPC() then
		if self:GetOwner():OnGround() then
			self.Flying = 0
		else
			self.Flying = 1
		end

		local Ang, Rec, AirForce = self:GetOwner():EyeAngles(), self.RecoilForce, self.InAirRecoilForce
		local RecoilY = math.Rand(.015, .03) * Rec[1] + (AirForce[1] * self.Flying)
		local RecoilX = math.Rand(-.03, .05) * Rec[2] + (AirForce[2] * self.Flying)
		self:GetOwner():SetEyeAngles((Ang:Forward() + RecoilY * Ang:Up() + Ang:Right() * RecoilX):Angle())
		self:GetOwner():ViewPunch(Angle(RecoilY * -50 * self.RecoilForce[1], RecoilX * -50 * self.RecoilForce[2], 0))
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanReload()
	local Reloading, Sprinting = self.Reloading, self.SprintingWeapon
	local Ammo = self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType())
	if self.DeployTime ~= nil then return false end

	if not Reloading and Sprinting == 0 then
		if self:Clip1() < self.Primary.ClipSize + self.AllowAdditionalShot and Ammo > 0 then return true end
	end

	return false
end

function SWEP:ReloadWeapon(VA, WA)
	if not self:CanReload() then return end

	if self.ReloadType == "magazine" then
		local Speed = self.ReloadSpeedTime
		local RealSpeed = self.RealReloadTime

		if self:Clip1() > 0 then
			VA = self.TacticalReloadACT
			Speed = self.TacticalReloadTime
			RealSpeed = self.RealTacticalReloadTime
		end

		self.Reloading = true
		self.ReloadTime = CurTime() + Speed
		local va = self:Animate(VA, 1, false)
		local va = self:Animate(VA, self:GetAnimationMul(Speed, va))
		local vm = self:GetOwner():GetViewModel()
		vm:SetPlaybackRate(self:GetAnimationMul(Speed))
		self:GetOwner():SetAnimation(WA)
		--self:EmitSound(self.ReloadSound,65,100,1,CHAN_AUTO)
		local Mul = 1

		if self.ReloadSounds then
			for i, sound in pairs(self.ReloadSounds) do
				timer.Simple(self.ReloadSounds[i][2] * Mul, function()
					if IsValid(self) and self:GetOwner():GetActiveWeapon() == self and (self.ReloadSounds[i][3] == "Both" or (self.ReloadSounds[i][3] == "EmptyOnly" and not TacticalReload) or (self.ReloadSounds[i][3] == "FullOnly" and TacticalReload)) then
						self.Weapon:EmitSound(self.ReloadSounds[i][1], 65, 100)
					end
				end)
			end
		end
	end

	if self.ReloadType == "individual" then
		self.CancelLoading = false
		self.Reloading = true
		self.NextIndividualLoadTime = self.IndividualLoadTime + CurTime()
		self.InitialIndividualLoad = true
		local va = self:Animate(self.IndividualLoadStartVACT, 1, false)
		local va = self:Animate(self.IndividualLoadStartVACT, self:GetAnimationMul(self.IndividualLoadStartTime, va))
		local vm = self:GetOwner():GetViewModel()
		vm:SetPlaybackRate(self:GetAnimationMul(self.IndividualLoadStartTime))
	end
end

function SWEP:Reload()
	if self:GetOwner():KeyPressed(IN_RELOAD) and self:Clip1() < self.Primary.ClipSize + self.AllowAdditionalShot then
		self:ReloadWeapon(self.ReloadACT, self.WReloadACT)
	end
end

function SWEP:Think()
	--sys=SysTime()
	if not self.m_bInitialized then
		self:Initialize()
	end

	self:EnforceFrontBlock()

	if self.DeployTime ~= nil and self.DeployTime <= CurTime() then
		self.DeployTime = nil
	end

	if self.DeployTime ~= nil then return end

	---------------EVERYTHING PAST THIS LINE WILL NOT WORK WHILE DEPLOYING--------------
	if self.BarrelMustSmoke then
		if math.random(1, 25) == 4 then
			self:BarrelSmoke()
			self.BarrelMustSmoke = false
		end
	end

	if self.UpdateTime then
		self.UpdateTime = false
		self.AimStartTime = CurTime()
		self.SprintStartTime = CurTime()
	end

	local AimPerc = self.AimPerc
	local Reloading, Sprinting, Blocked = self.Reloading, self.SprintingWeapon, tobool(self.FrontBlocked or 0)
	local AimChanged = IsChanged(self:GetOwner():KeyDown(IN_ATTACK2), "aimin", self)
	local SprintChanged = IsChanged(self:GetOwner():KeyDown(IN_SPEED), "sprint", self)
	local BlockedChanged = IsChanged(Blocked, "frontblocked", self)
	local DeployTimeChanged = self.DeployTime ~= nil and IsChanged(self.DeployTime <= CurTime(), "deploy", self)
	local Cycling = self.Cycling or false
	local Attack2Hold = self:GetOwner():KeyDown(IN_ATTACK2)
	local SprintHold = self:GetOwner():KeyDown(IN_SPEED)
	self.changed = IsChanged(self:GetOwner():OnGround(), "grounded", self) or BlockedChanged or DeployTimeChanged or IsChanged(self.Reloading, "reload", self) or IsChanged(Cycling, "cycling", self)

	if ((SprintHold and (SprintChanged or self.changed)) or (BlockedChanged and Blocked)) and not Reloading then
		self:SetHoldType(self.PassiveHoldAnim)
	elseif (not SprintHold and SprintChanged and not Blocked) or (BlockedChanged and not Blocked) then
		self:SetHoldType(self.HoldAnim)
	end

	if Attack2Hold and not SprintHold and not Blocked and not Reloading and not Cycling and (AimChanged or SprintChanged or BlockedChanged or self.changed) then
		self:SetHoldType(self.HoldAimAnim)
		--self:GetOwner():ChatPrint("Aiming")
	elseif not Attack2Hold and not SprintHold and not Blocked and (AimChanged or SprintChanged or self.changed) then
		self:SetHoldType(self.HoldAnim)
	end

	--self:GetOwner():ChatPrint("Stopped Aiming")
	--Long as duck
	if self:GetOwner():KeyPressed(IN_ATTACK2) or self:GetOwner():KeyReleased(IN_ATTACK2) or self:GetOwner():KeyPressed(IN_SPEED) or self:GetOwner():KeyReleased(IN_SPEED) or self.changed then
		self.AimStartTime = CurTime() --Fuck the time!
		self.SprintStartTime = CurTime() --Looks bad 
		self.changed = false
	end

	if self:GetOwner():KeyDown(IN_ATTACK2) and not Reloading and not Blocked and not Cycling and Sprinting < 60 and self:GetOwner():OnGround() then
		if not (AimPerc >= 100) then
			self.AimPerc = math.Clamp(self.AimPerc + (CurTime() - self.AimStartTime) * self.AimAddMul, 0, 100)
		end
	elseif not (AimPerc <= 0) then
		self.AimPerc = math.Clamp(self.AimPerc - (CurTime() - self.AimStartTime) * self.AimAddMul, 0, 100)
	end

	if self:GetOwner():KeyDown(IN_SPEED) and not Reloading and not Cycling then
		if Sprinting ~= 100 then
			self.SprintingWeapon = math.Clamp(self.SprintingWeapon + (CurTime() - self.SprintStartTime) * self.SprintAddMul, 0, 100)
		end
	elseif Sprinting ~= 0 then
		self.SprintingWeapon = math.Clamp(self.SprintingWeapon - (CurTime() - self.SprintStartTime) * self.SprintAddMul, 0, 100)
	end

	--[[
		if(self.VIEWLastAngGotten==nil)then  self.VIEWLastAngGotten=Angle(0,0,0) self.VIEWAngMul=0 end
		 self.VIEWAngMul=math.Clamp(self.InertiaScale,0,1)
		if(self.VIEWLastAngEyeGotten==self:GetOwner():EyeAngles() and self.VIEWAngMul==1)then self.VIEWAngMul=0 end
		self.VIEWAngGotten		=			LerpAngle(self.VIEWAngMul,self.VIEWLastAngGotten,self:GetOwner():EyeAngles())
		 self.VIEWLastAngEyeGotten		=		self:GetOwner():EyeAngles()
		 self.VIEWLastAngGotten		=	self.VIEWAngGotten
		self.VIEWAng		=		self.VIEWAngGotten	
		]]
	self:EnforceReloadRules()

	if self.NextIdleTime == nil then
		self.NextIdleTime = CurTime() + 100
	end

	if self.NextIdleTime <= CurTime() then
		self:Animate(self.VIdleACT)
	end

	if SERVER then
		if self.InertiaScale ~= 0 then
			self.angl = self:GetOwner():GetViewModel():GetAngles()

			if self.oldAng == nil then
				self.oldAng = self.angl
			end

			if self.angDiff == nil then
				self.angDiff = self.angl
			end

			self.sensitivity, self.strength = self.CarryWeight / 714, self.CarryWeight / 1000
			self.angDiff = LerpAngle(math.Clamp(0.5, 0, 1), self.angDiff, self.angl - self.oldAng)
			self.oldAng = self.angl
			self.angl = self.angl - self.angDiff * self.sensitivity
		end
	end
	--print(SysTime()-sys)	
end

function SWEP:UpdateNextIdle(Mul)
	if Mul == nil then
		Mul = 1
	end

	local vm = self:GetOwner():GetViewModel()
	self.NextIdleTime = CurTime() + vm:SequenceDuration() / Mul
end

function SWEP:GetAnimationMul(Mul, Anim)
	if Mul == nil then
		Mul = 1
	end

	local vm = self:GetOwner():GetViewModel()
	local PreMul = 0

	if Anim ~= nil and Anim ~= -1 then
		Anim = vm:SelectWeightedSequence(Anim)
		PreMul = vm:SequenceDuration(Anim) / Mul
	else
		PreMul = vm:SequenceDuration() / Mul
	end

	return PreMul
end

function SWEP:GetViewModelPosition(pos, ang)
	if LastAimGotten == nil then
		LastAimGotten = 0
	end

	if LastSprintGotten == nil then
		LastSprintGotten = 0
		LastAngGotten = self:GetOwner():EyeAngles()
	end

	local Attachments = self:GetNWString("Attachments")
	Attachments = util.JSONToTable(Attachments)
	local FrontBlocked = self.FrontBlocked or 0
	local FrontBlockedPerc = self.FrontBlockedPerc or 0
	local Sprint = math.Clamp(self.SprintingWeapon / 100, 0, 1)
	local AttacmentIronPosEnabled = self.AttacmentIronPosEnabled or 0
	local AimGotten = Lerp(.05, LastAimGotten, self.AimPerc / 100)
	LastAimGotten = AimGotten
	local Aim = AimGotten
	local SprintGotten = Lerp(.05, LastSprintGotten, (self.SprintingWeapon / 100) * (1 - FrontBlocked * (1 - Sprint)) + FrontBlockedPerc * FrontBlocked * (1 - Sprint))
	LastSprintGotten = SprintGotten
	local Sprint = SprintGotten

	--[[
	local AngGotten=LerpAngle(.05,LastAngGotten or Angle(0,0,0),self:GetAngleWeapon() or Angle(0,0,0))	
	LastAngGotten=AngGotten
	local Ang=AngGotten
]]
	--local ang=vm:GetAngles()
	if self.InertiaScale ~= 0 then
		if oldAng == nil then
			oldAng = ang
		end

		if angDiff == nil then
			angDiff = ang
		end

		local sensitivity, strength = self.CarryWeight / 714, self.CarryWeight / 1000
		angDiff = LerpAngle(math.Clamp(FrameTime(), 0, 1), angDiff, ang - oldAng)
		oldAng = ang
		ang = ang - angDiff * sensitivity
		self.AngleWeapon = ang
	end

	ang:RotateAroundAxis(ang:Right(), self.SprintAngle.p * Sprint)
	ang:RotateAroundAxis(ang:Up(), self.SprintAngle.y * Sprint)
	ang:RotateAroundAxis(ang:Forward(), self.SprintAngle.r * Sprint)
	npos = LerpVector(Aim, Vector(0, 0, 0), self.IronPos + (self.AttachmentIronPos or Vector(0, 0, 0)) * AttacmentIronPosEnabled)
	spos = LerpVector(Sprint, Vector(0, 0, 0), self.SprintPos)

	return pos + ang:Right() * (npos[1] + spos[1]) + ang:Forward() * (npos[2] + spos[2]) + ang:Up() * (npos[3] + spos[3]), ang
end

--:CalcViewModelView(vm, pos, ang, p, a )
--:GetViewModelPosition(pos,ang)
function SWEP:ViewModelDrawn(vm)
	local IronPosOverrideCheck = true
	local Attachments = self:GetNWString("Attachments")
	Attachments = util.JSONToTable(Attachments)

	for key, attachment in pairs(Attachments) do
		info = self.Attachments["Owner"][attachment]

		if not isangle(info.ang) then
			info.ang = Angle(info.ang.right or 0, info.ang.forward or 0, info.ang.up or 0)
		end

		if not self.VDrawnAttachments[attachment] then
			self.VDrawnAttachments[attachment] = ClientsideModel(info.model)
			AttachmentEntity = self.VDrawnAttachments[attachment]
			AttachmentEntity:SetPos(vm:GetPos())
			AttachmentEntity:SetParent(vm)
			AttachmentEntity:SetNoDraw(true)

			if info.scale then
				AttachmentEntity:SetModelScale(info.scale, 0)
			end

			if info.material then
				AttachmentEntity:SetMaterial(info.material)
			end
		else
			AttachmentEntity = self.VDrawnAttachments[attachment]

			if key >= #Attachments then
				self.AttachmentIronPos = Vector(0, 0, 0)
			end

			if info.IronPos ~= nil then
				self.AttachmentIronPos = info.IronPos + self.AttachmentIronPos
				self.AttacmentIronPosEnabled = 1
				IronPosOverrideCheck = false
			end

			if info.drawFunction ~= nil then
				info:drawFunction(attachment, vm)
			end

			local matr = vm:GetBoneMatrix(vm:LookupBone(info.bone))
			local pos, ang = matr:GetTranslation(), matr:GetAngles()

			if info.reverseangle then
				ang.r = -ang.r
			end

			AttachmentEntity:SetRenderOrigin(pos + ang:Right() * info.pos.right + ang:Forward() * info.pos.forward + ang:Up() * info.pos.up)

			if info.ang then
				ang:RotateAroundAxis(ang:Up(), info.ang[1])
				ang:RotateAroundAxis(ang:Forward(), info.ang[2])
				ang:RotateAroundAxis(ang:Right(), info.ang[3])
			end

			if info.sightang then
				local angCopy = matr:GetAngles()

				if info.sightang.up then
					angCopy:RotateAroundAxis(angCopy:Up(), info.sightang.up)
				end

				if info.sightang.forward then
					angCopy:RotateAroundAxis(angCopy:Forward(), info.sightang.forward)
				end

				if info.sightang.right then
					angCopy:RotateAroundAxis(angCopy:Right(), info.sightang.right)
				end

				self.ScopeDotAngle = angCopy
				self.ScopeDotPosition = pos + angCopy:Right() * info.sightpos.right + angCopy:Forward() * info.sightpos.forward + angCopy:Up() * info.sightpos.up
			end

			AttachmentEntity:SetRenderAngles(ang)
			AttachmentEntity:DrawModel()
		end
	end

	if IronPosOverrideCheck then
		self.AttacmentIronPosEnabled = 0
		self.AttachmentIronPos = Vector(0, 0, 0)
	end
end

function SWEP:DrawWorldModel()
	if self.Attachments ~= nil and self.Attachments["Viewer"]["Weapon"] ~= nil then
		if not self.WModel then
			self.WModel = ClientsideModel(self.WorldModel)
			self.WModel:SetPos(self:GetOwner():GetPos())
			self.WModel:SetParent(self:GetOwner())
			self.WModel:SetNoDraw(true)
		end

		local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
		local info = self.Attachments["Viewer"]["Weapon"]

		if not isvector(info.pos) then
			info.pos = Vector(info.pos.right or 0, info.pos.forward or 0, info.pos.up or 0)
		end

		if not isangle(info.ang) then
			info.ang = Angle(info.ang.right or 0, info.ang.forward or 0, info.ang.up or 0)
		end

		if pos and ang then
			self.WModel:SetRenderOrigin(pos + ang:Right() * info.pos[1] + ang:Forward() * info.pos[2] + ang:Up() * info.pos[3])

			if info.ang then
				ang:RotateAroundAxis(ang:Up(), info.ang[1])
				ang:RotateAroundAxis(ang:Forward(), info.ang[2])
				ang:RotateAroundAxis(ang:Right(), info.ang[3])
			end

			self.WModel:SetRenderAngles(ang)
			self.WModel:DrawModel()
		end
	else
		self:DrawModel()
	end

	local Attachments = self:GetNWString("Attachments")
	Attachments = util.JSONToTable(Attachments)

	for key, attachment in pairs(Attachments) do
		local info = self.Attachments["Viewer"][attachment]

		if not isvector(info.pos) then
			info.pos = Vector(info.pos.right or 0, info.pos.forward or 0, info.pos.up or 0)
		end

		if not isangle(info.ang) then
			info.ang = Angle(info.ang.right or 0, info.ang.forward or 0, info.ang.up or 0)
		end

		if not self.WDrawnAttachments[attachment] then
			self.WDrawnAttachments[attachment] = ClientsideModel(info.model)
			AttachmentEntity = self.WDrawnAttachments[attachment]
			AttachmentEntity:SetPos(self:GetOwner():GetPos())
			AttachmentEntity:SetParent(self:GetOwner())
			AttachmentEntity:SetNoDraw(true)

			if info.scale then
				AttachmentEntity:SetModelScale(info.scale, 0)
			end

			if info.material then
				AttachmentEntity:SetMaterial(info.material)
			end
		else
			AttachmentEntity = self.WDrawnAttachments[attachment]

			if info.IronPos ~= nil then
				self.AttachmentIronPos = info.IronPos
				IronPosOverrideCheck = false
			end

			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if info.reverseangle then
				ang.r = -ang.r
			end

			AttachmentEntity:SetRenderOrigin(pos + ang:Right() * info.pos[1] + ang:Forward() * info.pos[2] + ang:Up() * info.pos[3])

			if info.ang then
				ang:RotateAroundAxis(ang:Up(), info.ang[1])
				ang:RotateAroundAxis(ang:Forward(), info.ang[2])
				ang:RotateAroundAxis(ang:Right(), info.ang[3])
			end

			AttachmentEntity:SetRenderAngles(ang)
			AttachmentEntity:DrawModel()
		end
	end
end

function SWEP:Holster(wep)
	self.ReloadTime = nil
	self.DeployTime = nil
	self.Reloading = false

	return true
end

function SWEP:Deploy()
	local va = self:Animate(self.DeployACT, 1, false)
	self.UpdateTime = true

	if va ~= nil then
		self.DeployTime = self.RealDeploySpeedTime + CurTime()
	end

	self.HoldedKey = false
	self:SetHoldType(self.HoldAnim)
	self.AimPerc = 0
	self.SprintingWeapon = 0
	self.NextIdleTime = 0
	self.Reloading = true
	local va = self:Animate(self.DeployACT, 1, false)
	local va = self:Animate(self.DeployACT, self:GetAnimationMul(self.DeploySpeedTime, va))
	local vm = self:GetOwner():GetViewModel()
	vm:SetPlaybackRate(self:GetAnimationMul(self.DeploySpeedTime))
	self.ReloadTime = nil
	self.Reloading = false
	self:EmitSound(self.DeploySound, 65, 100, 1, CHAN_AUTO)

	return true
end

function SWEP:Animate(VA, Mul, shouldplay)
	if shouldplay == nil then
		shouldplay = true
	end

	if Mul == nil then
		Mul = 1
	end

	if isnumber(VA) then
		if shouldplay then
			self:SendWeaponAnim(VA) -- View model animation
			self:UpdateNextIdle(Mul)
		end

		return VA
	else
		local va, vad = self:LookupSequence(VA)
		local vm = self:GetOwner():GetViewModel()

		if shouldplay then
			vm:SendViewModelMatchingSequence(va) --You may use it...
			self:UpdateNextIdle(Mul)
		end

		return va
	end
end

function SWEP:ShootEffects(VA, WA)
	self:Animate(VA)
	self:GetOwner():SetAnimation(WA) -- 3rd Person Animation
	local Attachments = self:GetNWString("Attachments")
	Attachments = util.JSONToTable(Attachments)
	local Suppressed = Attachments["Suppressor"]
	local Rightness, Upness = 4, 2

	if self.MuzzleEffect ~= "" then
		if CLIENT then
			if Suppressed then
				ParticleEffect(self.MuzzleEffectSuppressed, self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 20 + self:GetOwner():EyeAngles():Right() * Rightness - self:GetOwner():EyeAngles():Up() * Upness, self:GetOwner():EyeAngles(), self)
			else
				ParticleEffect(self.MuzzleEffect, self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 20 + self:GetOwner():EyeAngles():Right() * Rightness - self:GetOwner():EyeAngles():Up() * Upness, self:GetOwner():EyeAngles(), self)
			end
		end

		if SERVER then
			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
			local owner = self

			if self:GetSuiciding() then
				owner = nil
			end

			local headpos, headang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_Head1"))

			if Suppressed then
				local position = pos + ang:Forward() * (self.MuzzlePos[1] + 6) + ang:Up() * self.MuzzlePos[2] + ang:Right() * self.MuzzlePos[1]

				if self:GetSuiciding() then
					position = headpos
				end

				ParticleEffect(self.MuzzleEffectSuppressed, pos + ang:Forward() * (self.MuzzlePos[1] + 6) + ang:Up() * self.MuzzlePos[2] + ang:Right() * self.MuzzlePos[1], ang, owner)
			else
				local position = pos + ang:Forward() * self.MuzzlePos[1] + ang:Up() * self.MuzzlePos[2] + ang:Right() * self.MuzzlePos[3]

				if self:GetSuiciding() then
					position = headpos
				end

				ParticleEffect(self.MuzzleEffect, position, ang, owner)
			end
		end
	end

	self.BarrelMustSmoke = true
end

function SWEP:BarrelSmoke()
	local ent = self:GetOwner():GetViewModel()

	if ent then
		ParticleEffectAttach(self.SmokeEffect, PATTACH_POINT_FOLLOW, ent, 1)
	end
end

function SWEP:ShootBullet(damage, num_bullets, aimcone, spread, ammo_type, force, tracer)
	--self:GetAngleWeapon():Forward()
	--self:GetOwner():GetAimVector()
	--self.AngleWeapon:Forward()
	if SERVER and self.InertiaScale ~= 0 then
		self.dir = self.angl:Forward()
	end

	if CLIENT and self.InertiaScale ~= 0 then
		self.dir = self.AngleWeapon:Forward()
		--dir=(self:GetOwner():GetAimVector():Angle()-angDiff*7)
	end

	if self.InertiaScale == 0 then
		self.dir = self:GetOwner():GetAimVector()
	end

	self.dir = (self.dir + VectorRand() * aimcone):GetNormalized()
	local bullet = {}
	bullet.Num = num_bullets
	bullet.Src = self:GetOwner():GetShootPos() -- Source
	bullet.Dir = self.dir -- Dir of bullet
	bullet.Spread = Vector(spread, spread, 0) -- Aim Cone
	bullet.Tracer = tracer or 0 -- Show a tracer on every x bullets
	bullet.Force = force or damage * 0.05 -- Amount of force to give to phys objects
	bullet.Damage = damage
	bullet.AmmoType = ammo_type or self.Primary.Ammo
	self:GetOwner():FireBullets(bullet)
end

function SWEP:TakePrimaryAmmo(num)
	-- Doesn"t use clips
	if self:Clip1() <= 0 then
		if self:Ammo1() <= 0 then return end
		self:GetOwner():RemoveAmmo(num, self:GetPrimaryAmmoType())

		return
	end

	self:SetClip1(self:Clip1() - num)
end

function SWEP:TakeSecondaryAmmo(num)
	-- Doesn"t use clips
	if self:Clip2() <= 0 then
		if self:Ammo2() <= 0 then return end
		self:GetOwner():RemoveAmmo(num, self:GetSecondaryAmmoType())

		return
	end

	self:SetClip2(self:Clip2() - num)
end

function SWEP:CanPrimaryAttack()
	local Reloading, Sprinting, Blocked = self.Reloading, self.SprintingWeapon, tobool(self.FrontBlocked or 0)

	if self:Clip1() <= 0 or Sprinting > 10 or Reloading or Blocked or self.DeployTime ~= nil then
		if Sprinting <= 10 and not Reloading and not Blocked and self.DeployTime == nil then
			self:EmitSound("Weapon_Pistol.Empty")
			self:SetNextPrimaryFire(CurTime() + self.Delay)
			--self:Reload()
		end

		self.CancelLoading = true

		return false
	end

	if self:GetNextPrimaryFire() <= CurTime() then
		self:SetNextPrimaryFire(CurTime() + self.Delay)

		return true
	end
end

function SWEP:CanSecondaryAttack()
	if self:Clip2() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextSecondaryFire(CurTime() + 0.2)

		return false
	end

	return true
end

function SWEP:EnforceFrontBlock()
	local ShootVec, Ang, ShootPos = self:GetOwner():GetAimVector(), self:GetOwner():GetAngles(), self:GetOwner():GetShootPos()
	local OverallLength = self.BarrelLength + (SupressorLength or 0)
	ShootPos = ShootPos + ShootVec * 15

	local trace = util.TraceLine({
		start = ShootPos - Ang:Forward() * 5,
		endpos = ShootPos + (ShootVec * OverallLength) + Ang:Forward() * 15,
		filter = self:GetOwner()
	})

	if trace.Hit then
		self.FrontBlocked = 1
		self.FrontBlockedPerc = 1 - math.Clamp(trace.Fraction, 0, 1)
	else
		self.FrontBlocked = 0
	end
end

function SWEP:EnforceReloadRules()
	if self.ReloadTime ~= nil and self.ReloadTime <= CurTime() then
		self.ReloadTime = nil
		self.Reloading = false
		local Ammo = self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType())

		if 0 < self:Clip1() and self:Clip1() < self.Primary.ClipSize + self.AllowAdditionalShot then
			local Difference = math.Clamp(self.Primary.ClipSize + self.AllowAdditionalShot - self:Clip1(), 0, Ammo)
			self:SetClip1(self:Clip1() + Difference)
			self:GetOwner():RemoveAmmo(Difference, self:GetPrimaryAmmoType())
		else
			local Difference = math.Clamp(self.Primary.ClipSize - self:Clip1(), 0, Ammo)
			self:SetClip1(self:Clip1() + Difference)
			self:GetOwner():RemoveAmmo(Difference, self:GetPrimaryAmmoType())
		end
	end

	if self.NextIndividualLoadTime ~= nil and self.NextIndividualLoadTime <= CurTime() then
		self.NextIndividualLoadTime = nil
		local Ammo = self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType())

		if self:Clip1() < self.Primary.ClipSize + self.AllowAdditionalShot then
			if not self.InitialIndividualLoad then
				self:SetClip1(self:Clip1() + 1)
				self:GetOwner():RemoveAmmo(1, self:GetPrimaryAmmoType())
			end

			if self:Clip1() < self.Primary.ClipSize + self.AllowAdditionalShot and not self.CancelLoading then
				self.NextIndividualLoadTime = self.IndividualLoadTime + CurTime()
				local va = self:Animate(self.IndividualLoadVACT, 1, false)
				print(va)
				local va = self:Animate(self.IndividualLoadVACT, self:GetAnimationMul(self.IndividualLoadTime, va))
				local vm = self:GetOwner():GetViewModel()
				vm:SetPlaybackRate(self:GetAnimationMul(self.IndividualLoadTime))
				self:GetOwner():SetAnimation(self.WReloadACT)
				self.InitialIndividualLoad = false

				timer.Simple(self.IndividualLoadSoundTime, function()
					if IsValid(self) and self:GetOwner():GetActiveWeapon() == self then
						self.Weapon:EmitSound(self.IndividualLoadSound, 65, 100)
					end
				end)
			else
				self.CancelLoading = false
				local va = self:Animate(self.IndividualLoadEndVACT, 1, false)
				print(va)
				local va = self:Animate(self.IndividualLoadEndVACT, self:GetAnimationMul(self.IndividualLoadEndTime, va))
				local vm = self:GetOwner():GetViewModel()
				vm:SetPlaybackRate(self:GetAnimationMul(self.IndividualLoadEndTime))
				self.EndIndividualLoadTime = self.RealIndividualLoadEndTime + CurTime()

				timer.Simple(self.EndOfLoadCycleSoundTime, function()
					if IsValid(self) and self:GetOwner():GetActiveWeapon() == self then
						self.Weapon:EmitSound(self.CycleSound, 65, 100)
					end
				end)
			end
		end
	end

	if self.EndIndividualLoadTime ~= nil and self.EndIndividualLoadTime <= CurTime() then
		self.EndIndividualLoadTime = nil
		self.Reloading = false
	end

	if self.CycleEndTime ~= nil and self.CycleEndTime <= CurTime() then
		self.CycleEndTime = nil
		self.Cycling = false
	end
end

function SWEP:OnRemove()
end

function SWEP:OwnerChanged()
end

function SWEP:Ammo1()
	return self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType())
end

function SWEP:Ammo2()
	return self:GetOwner():GetAmmoCount(self:GetSecondaryAmmoType())
end

function SWEP:SetDeploySpeed(speed)
	self.m_WeaponDeploySpeed = tonumber(speed)
end

function SWEP:DoImpactEffect(tr, nDamageType)
	return false
end