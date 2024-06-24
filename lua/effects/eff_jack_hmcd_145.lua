--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_145.lua

--]]
EFFECT.Models = {}
EFFECT.Models[3] = Model("models/shells/fhell_556.mdl")
EFFECT.Sounds = {}

EFFECT.Sounds[3] = {
	Pitch = 90,
	Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}
}

function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then
		self.Entity:SetModel("models/shells/fhell_556.mdl")
		self.RemoveMe = true

		return
	end

	local bullettype = math.Clamp(data:GetScale() or 3, 3, 3)
	local angle, pos = self.Entity:GetBulletEjectPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	local direction = -angle:Forward()
	self.Entity:SetPos(pos)
	self.Entity:SetModel(self.Models[bullettype] or "models/shells/fhell_556.mdl")
	self.Entity:PhysicsInitBox(Vector(-1, -1, -1), Vector(1, 1, 1))
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.Entity:SetModelScale(2, 0)
	self.Entity:SetCollisionBounds(Vector(-128 - 128, -128), Vector(128, 128, 128))
	local phys = self.Entity:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:SetDamping(0, 15)
		phys:AddAngleVelocity(VectorRand() * 25000)
		phys:SetMaterial("gmod_silent")
	end

	timer.Simple(.5, function()
		if IsValid(self) then
			ParticleEffectAttach("pcf_jack_mf_barrelsmoke", PATTACH_POINT_FOLLOW, self, 1)
		end
	end)

	self.Entity:SetAngles(angle)
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
			local pos, ang = ViewModel:GetBonePosition(ViewModel:LookupBone("zatvor"))

			return ang, pos + ang:Up() * 10
		end
		-- Shoot from the world model
	else
		return Ent:GetAngles(), Ent:GetPos()
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