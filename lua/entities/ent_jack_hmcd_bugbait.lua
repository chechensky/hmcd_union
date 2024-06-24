--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_bugbait.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.Model = "models/weapons/w_bugbait.mdl"
ENT.Mass = 1
ENT.ImpactSound = "player/footsteps/snow6.wav"

if SERVER then
	function ENT:PhysicsCollide(data, phys)
		local rand = 1

		if math.random(1, 2) == 1 then
			rand = 3
		end

		self:EmitSound("weapons/bugbait/bugbait_impact" .. rand .. ".wav")

		for i, npc in pairs(ents.FindByClass("npc_antlion")) do
			local dist = npc:GetPos():DistToSqr(self:GetPos())

			if dist < 250000 then
				npc:AddRelationship("player D_LI 99")

				if not npc.SatisfactionEndTime then
					hook.Add("Think", npc, function()
						if npc.SatisfactionEndTime < CurTime() then
							npc:AddRelationship("player D_HT 99")
							npc.SatisfactionEndTime = nil
							hook.Remove("Think", npc)
						end
					end)
				end

				npc:EmitSound("npc/antlion/distract1.wav", 100, math.random(80, 110))
				npc:SetLastPosition(self:GetPos())
				npc:SetSchedule(SCHED_FORCED_GO_RUN)
				npc.SatisfactionEndTime = CurTime() + 60

				for i, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
					if ent ~= self.Owner and npc:Visible(ent) then
						npc:AddEntityRelationship(ent, D_HT, 99)
					end
				end
			end
		end

		util.Decal("BeerSplash", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
		self:Remove()
	end
end