--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_beanbag.lua

--]]
EFFECT.Models = {}
EFFECT.Models[3] = Model("models/kali/weapons/black_ops/magazines/ammunition/12 gauge shotgun shell.mdl")
EFFECT.Sounds = {}

EFFECT.Sounds[3] = {
	Pitch = 90,
	Wavs = {"weapons/fx/tink/shotgun_shell1.wav"}
}

function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then
		self.Entity:SetModel("models/kali/weapons/black_ops/magazines/ammunition/12 gauge shotgun shell.mdl")
		self.RemoveMe = true

		return
	end

	local bullettype = math.Clamp(data:GetScale() or 3, 3, 3)
	local angle, pos = self.Entity:GetBulletEjectPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	direction = angle:Forward()
	local ang = LocalPlayer():GetAimVector():Angle()

	if string.find(data:GetEntity():GetClass(), "ent_jack") then
		local ang = data:GetEntity():GetAngles()
		direction = ang:Forward() * data:GetEntity().BulletEjectDir[1] + ang:Right() * data:GetEntity().BulletEjectDir[2] + ang:Up() * data:GetEntity().BulletEjectDir[3]
	elseif not (data:GetEntity():IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer()) then
		ang:RotateAroundAxis(ang:Right(), 180)
	else
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Right(), 180)
	end

	self.Entity:SetPos(pos)
	self.Entity:SetModel(self.Models[bullettype] or "models/kali/weapons/black_ops/magazines/ammunition/12 gauge shotgun shell.mdl")
	self.Entity:SetMaterial("models/kali/weapons/bo/beretta682/beanbag")
	self.Entity:PhysicsInitBox(Vector(-1, -1, -1), Vector(1, 1, 1))
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.Entity:SetCollisionBounds(Vector(-128 - 128, -128), Vector(128, 128, 128))
	self.Entity:SetBodygroup(1, 1)
	local phys = self.Entity:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:SetDamping(0, 15)
		phys:SetVelocity(direction * math.random(150, 300))
		phys:AddAngleVelocity(VectorRand() * 25000)
		phys:SetMaterial("gmod_silent")
	end

	self.Entity:SetAngles(ang)
	self.HitSound = table.Random(self.Sounds[bullettype].Wavs)
	self.HitPitch = self.Sounds[bullettype].Pitch + math.random(-10, 10)
	self.SoundTime = CurTime() + math.Rand(0.5, 0.75)
	self.LifeTime = CurTime() + 60
	self.Alpha = 255
end

function EFFECT:GetBulletEjectPos(Position, Ent, Attachment)
	if not Ent:IsValid() then return Angle(), Position end
	if not Ent:IsWeapon() then return Angle(), Position end

	-- Shoot from the viewmodel
	if Ent:IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then
		local ViewModel = LocalPlayer():GetViewModel()

		if ViewModel:IsValid() then
			local att = ViewModel:GetAttachment(Attachment)
			if att then return att.Ang, att.Pos end
		end
		-- Shoot from the world model
	else
		local att = Ent:GetAttachment(2)
		if att then return att.Ang, att.Pos + att.Ang:Right() * -5 end
	end

	return Angle(), Position
end

function EFFECT:Think()
	if self.RemoveMe then return false end

	if self.SoundTime and self.SoundTime < CurTime() then
		self.SoundTime = nil
		sound.Play(self.HitSound, self.Entity:GetPos(), 75, self.HitPitch)
	end

	if self.LifeTime < CurTime() then
		self.Alpha = (self.Alpha or 255) - 2
		self.Entity:SetColor(Color(255, 255, 255, self.Alpha))
	end

	return self.Alpha > 2
end

function EFFECT:Render()
	self.Entity:DrawModel()
end