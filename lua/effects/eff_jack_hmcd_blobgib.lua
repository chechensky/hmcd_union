--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_blobgib.lua

--]]
function EFFECT:Init(data)
	self.Vec = data:GetNormal()
	self.StartPos = self:GetTracerShootPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	self.Emitter = ParticleEmitter(self.StartPos)

	for i = 1, 15 do
		local p = self.Emitter:Add("noxctf/sprite_bloodspray" .. math.random(8), self.StartPos)
		p:SetDieTime(2)
		p:SetStartSize(1)
		local vec = VectorRand()
		vec.z = math.abs(vec.z)
		p:SetVelocity(vec * math.random(200, 300))
		p:SetGravity(Vector(0, 0, math.random(-600, -900)))
		p:SetEndSize(math.Rand(25, 35))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetColor(105, 0, 0)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)

		p:SetCollideCallback(function(part, hitpos, hitnormal)
			sound.Play("Flesh_Bloody.ImpactHard", hitpos, 75, math.random(90, 110))
			util.Decal("Blood", hitpos - hitnormal, hitpos + hitnormal)
			p:SetDieTime(0)
		end)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end