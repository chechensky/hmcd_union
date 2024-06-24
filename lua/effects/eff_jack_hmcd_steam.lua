--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_steam.lua

--]]
--[[---------------------------------------------------------
   Init( data table )
---------------------------------------------------------]]
local mat = Material("particle/smokestack")

function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.Entity = data:GetEntity()
	local Pos = self.Position

	if self.Entity == LocalPlayer() then
		Pos = self.Entity:GetShootPos() + self.Entity:GetAimVector() * 3
	end

	self.Emitter = ParticleEmitter(Pos, false)
	local particle = self.Emitter:Add(mat, Pos)
	local dir = vector_origin
	local Vel = Vector(0, 0, math.random(2, 5))

	if IsValid(self.Entity) then
		if self.Entity:IsRagdoll() then
			dir = self.Entity:EyeAngles():Forward()
		else
			dir = self.Entity:GetAimVector()
		end

		Vel = Vel + self.Entity:GetVelocity() / 4 + dir * 5
	end

	particle:SetVelocity(Vel)
	particle:SetGravity(vector_origin)
	particle:SetDieTime(math.Rand(2, 3))
	particle:SetStartAlpha(155)
	particle:SetEndAlpha(0)
	local Size = 10
	particle:SetStartSize(Size / 30)
	particle:SetEndSize(Size)
	particle:SetRoll(0)

	if math.random(1, 2) == 1 then
		particle:SetRollDelta(0)
	else
		particle:SetRollDelta(math.Rand(-1, 1))
	end

	local Amt = math.random(240, 255)
	particle:SetColor(Amt, Amt, Amt)
	particle:SetLighting(false)
	particle:SetCollide(true)
	self.Emitter:Finish()
	self.Emitter = nil
end

--[[---------------------------------------------------------
   THINK
---------------------------------------------------------]]
function EFFECT:Think()
	return false
end

--[[---------------------------------------------------------
   Draw the effect
---------------------------------------------------------]]
function EFFECT:Render()
end
--