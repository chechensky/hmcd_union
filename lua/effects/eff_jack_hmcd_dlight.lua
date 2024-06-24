--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_dlight.lua

--]]
--[[---------------------------------------------------------
   Init( data table )
---------------------------------------------------------]]
function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	local Pos = self.Position
	self.smokeparticles = {}
	--self.Emitter = ParticleEmitter( Pos )
	local spawnpos = Pos
	local Scayul = data:GetScale()
	self.Scayul = Scayul
	local dlight = DynamicLight(self:EntIndex())

	if dlight then
		dlight.Pos = Pos
		dlight.r = 255
		dlight.g = 200
		dlight.b = 175
		dlight.Brightness = 1 * Scayul
		dlight.Size = 600 * Scayul
		dlight.Decay = 5000
		dlight.DieTime = CurTime() + .5
		dlight.Style = 0
	end
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