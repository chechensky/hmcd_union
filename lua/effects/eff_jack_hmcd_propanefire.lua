--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_propanefire.lua

--]]
--[[---------------------------------------------------------
	EFFECT:Init(data)
---------------------------------------------------------]]
function EFFECT:Init(data)
	local hitpos = data:GetOrigin()
	local ent = data:GetEntity()
	local ang = data:GetAngles()
	self.Entity = ent
	self.Pos = hitpos

	if IsValid(ent) then
		ent.PropaneParticles = CreateParticleSystem(ent, "fire_jet_01_flame", 1, 1, ent:WorldToLocal(hitpos))
	end
end

--[[---------------------------------------------------------
	EFFECT:Think()
---------------------------------------------------------]]
function EFFECT:Think()
	local ent = self.Entity

	if ent.PropaneParticles and ent:GetNWBool("NoPropane") then
		ent.PropaneParticles:StopEmission(false, false)
		ent.PropaneParticles = nil

		return false
	end
	--[[if ent:GetNWBool("HalfPropane") and ent.PropaneParticles then
		ent.PropaneParticles:StopEmission( false, false ) 
		ent.PropaneParticles=nil
		ent.PropaneParticlesNextHalf=CreateParticleSystem( ent,"fire_jet_01_flame", 1, 1, ent:WorldToLocal(self.Pos) )
	end]]

	return true
end

--[[---------------------------------------------------------
	EFFECT:Render()
---------------------------------------------------------]]
function EFFECT:Render()
end
--wat