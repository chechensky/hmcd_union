--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_plasmaarc.lua

--]]
local Beamtwo = CreateMaterial("xeno/beamgauss", "UnlitGeneric", {
	["$basetexture"] = "sprites/spotlight",
	["$additive"] = "1",
	["$vertexcolor"] = "1",
	["$vertexalpha"] = "1",
})

function EFFECT:Init(data)
	self.StartPos = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.Scayul = data:GetScale() ^ 0.5
	self.Delay = math.Clamp(0.06 * data:GetScale(), 0.025, 0.06)
	self.EndTime = CurTime() + self.Delay
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	local dlightend = DynamicLight(0)
	dlightend.Pos = self.EndPos
	dlightend.Size = 1000 * self.Scayul
	dlightend.Decay = 2000
	dlightend.R = 100
	dlightend.G = 150
	dlightend.B = 255
	dlightend.Brightness = 5 * self.Scayul
	dlightend.DieTime = CurTime() + self.Delay
end

function EFFECT:Think()
	if self.EndTime < CurTime() then
		return false
	else
		return true
	end
end

function EFFECT:Render()
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	render.SetMaterial(Beamtwo)
	render.DrawBeam(self.StartPos, self.EndPos, Lerp((self.EndTime - CurTime()) / self.Delay, 0, 18 * self.Scayul), 0, 0, Color(100, 150, 255, 254))
	render.DrawBeam(self.StartPos, self.EndPos, Lerp((self.EndTime - CurTime()) / self.Delay, 0, 12 * self.Scayul), 0, 0, Color(100, 150, 255, 254))
	render.DrawBeam(self.StartPos, self.EndPos, Lerp((self.EndTime - CurTime()) / self.Delay, 0, 6 * self.Scayul), 0, 0, Color(100, 150, 255, 254))
end