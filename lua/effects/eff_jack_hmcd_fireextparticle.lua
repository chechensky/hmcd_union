--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_fireextparticle.lua

--]]
function EFFECT:Init(data)
	self.Vec = data:GetNormal()
	self.StartPos = self:GetTracerShootPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	self.Emitter = ParticleEmitter(self.StartPos)

	for parts = 1, 5 do
		local p = self.Emitter:Add("particle/smokestack", self.StartPos)
		p:SetDieTime(math.Rand(0.1, 0.4))
		p:SetStartSize(5)
		p:SetVelocity(self.Vec * 600)
		p:SetEndSize(math.Rand(5, 25))
		p:SetStartAlpha(15)
		p:SetEndAlpha(0)
		p:SetColor(255, 255, 255)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end