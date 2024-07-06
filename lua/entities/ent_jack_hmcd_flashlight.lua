--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_flashlight.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Light"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/runaway911/props/item/flashlight.mdl"
ENT.Color = Color(100, 100, 100, 255)
ENT.Scale = .8

if SERVER then
	function ENT:PickUp(ply)
		if (not ply.Equipment[HMCD_EquipmentNames[HMCD_FLASHLIGHT]] or ply.Role == "Traitor") and not (ply.Role == "combine" or IsValid(self:GetParent())) then
			SafeRemoveEntity(self.HMCD_Light)

			if (ply.Role == "Traitor") and ply.Equipment[HMCD_EquipmentNames[HMCD_FLASHLIGHT]] then
				ply:PrintMessage(HUD_PRINTTALK, "You hide the additional flashlight.")
			end

			ply.Equipment[HMCD_EquipmentNames[HMCD_FLASHLIGHT]] = true
			net.Start("hmcd_equipment")
			net.WriteInt(HMCD_FLASHLIGHT, 6)
			net.WriteBit(true)
			net.Send(ply)
			self:EmitSound("snd_jack_hmcd_flashlight.wav", 65, 100)
			self:Remove()
		end
	end

	function ENT:TurnOn()
		if self.Broken then return end
		self.TurnedOn = true
		self.HMCD_Light = ents.Create("env_projectedtexture")
		self.HMCD_Light:SetKeyValue("enableshadows", 1)
		self.HMCD_Light:SetKeyValue("farz", 750)
		self.HMCD_Light:SetKeyValue("nearz", 12)
		self.HMCD_Light:SetKeyValue("lightfov", 60)
		self.HMCD_Light:SetPos(self:GetPos())
		self.HMCD_Light:SetAngles(self:GetAngles())
		self.HMCD_Light:SetParent(self)
		self.HMCD_Light:Spawn()
		self.HMCD_Light:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")

		self:Spawn()
		self:Activate()
	end

	function ENT:TurnOff()
		if self.TurnedOn then
			self.HMCD_Light:Remove()
			self.TurnedOn = false
			net.Start("hmcd_flashlight_light")
			net.WriteEntity(self)
			net.WriteBit(false)
			net.Send(player.GetAll())
		end
	end

	function ENT:OnTakeDamage(dmginfo)
		if not dmginfo:IsDamageType(DMG_SLASH) and self:Health() > 0 then
			self:SetHealth(self:Health() - dmginfo:GetDamage())

			if self:Health() <= 0 then
				self:EmitSound("Glass.BulletImpact")
				self:TurnOff()
				self.Broken = true
			end
		end
	end
elseif CLIENT then
	local matLight = Material("sprites/light_ignorez")

	function ENT:Initialize()
		self.CarLight = IsValid(self:GetParent())
	end

	function ENT:Draw()
		if not self.CarLight then
			self:DrawModel()
		end

		if self.HMCD_Flashlight then
			local pos, ang = self:GetPos(), self:GetAngles()
			local headPos = pos + ang:Forward() * 5 + ang:Right() * -0.75
			local SelfPos = LocalPlayer():EyePos()
			local ToVec = SelfPos - headPos
			local DotProduct = ToVec:GetNormalized():Dot(ang:Forward())

			if DotProduct > 0 then
				local Visible = not util.QuickTrace(SelfPos, -ToVec, {LocalPlayer(), self}).Hit

				if Visible then
					local lightLevel = render.GetLightColor(headPos)
					self.HMCD_Flashlight = LerpVector(FrameTime(), self.HMCD_Flashlight, lightLevel)
					lightLevel = math.max(2 - self.HMCD_Flashlight.x - self.HMCD_Flashlight.y - self.HMCD_Flashlight.z, 0.25)
					render.SetMaterial(matLight)
					render.DrawSprite(headPos, 75 * DotProduct * lightLevel, 75 * DotProduct * lightLevel, Color(255, 255, 255, 150 * DotProduct))
					render.DrawSprite(headPos, 25 * DotProduct * lightLevel, 25 * DotProduct * lightLevel, Color(255, 255, 255, 255 * DotProduct))
				end
			end
		end
	end
end