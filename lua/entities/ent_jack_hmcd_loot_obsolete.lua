--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_loot_obsolete.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Loot"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

if SERVER then
	local ModelTable = {"models/gml/gold_jar.mdl", "models/gml/gold_jar_large.mdl", "models/gml/jrail.mdl", "models/pyroteknik/stack.mdl", "models/pyroteknik/money_sack_nobreak.mdl"}

	--"models/props/cs_assault/Dollar.mdl",
	--"models/props/cs_assault/Money.mdl",
	for key, mod in pairs(ModelTable) do
		util.PrecacheModel(mod)
	end

	function ENT:Initialize()
		local Maudell = table.Random(ModelTable)
		--print(Maudell)
		self.Entity:SetModel(Maudell)

		if string.find(Maudell, "gml") then
			self.Entity:SetSkin(math.random(0, 2))
		end

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(20)
			phys:Wake()
			phys:EnableMotion(true)
		end

		self.Stillness = 0
		self.RemoveTime = CurTime() + 100
	end

	function ENT:Use(ply)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:EnableMotion(true)
		end

		hook.Call("PlayerPickupLoot", GAMEMODE, ply, self)
	end

	function ENT:Think()
		local Speed = self:GetPhysicsObject():GetVelocity():Length()

		if Speed > 50 then
			self.Stillness = 0
		else
			self.Stillness = self.Stillness + 1
		end

		if self.Stillness >= 3 then
			self:GetPhysicsObject():Sleep()
		end

		for key, near in pairs(ents.FindInSphere(self:GetPos(), 250)) do
			if near:IsPlayer() and near:Alive() then
				self.RemoveTime = CurTime() + 10
				break
			end
		end

		self:NextThink(CurTime() + 1)

		if self.RemoveTime < CurTime() then
			self:Remove()
		end

		return true
	end
elseif CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end