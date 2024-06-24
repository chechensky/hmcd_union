function SWEP:ViewModelDrawn(vm)
	if self.Attachments and self.Attachments["Owner"] then
		for attachment, info in pairs(self.Attachments["Owner"]) do
			if self:GetNWBool(attachment) then
				if not self.DrawnAttachments[attachment] then
					self.DrawnAttachments[attachment] = ClientsideModel(info.model)
					self.DrawnAttachments[attachment]:SetPos(vm:GetPos())
	    			self.DrawnAttachments[attachment]:SetParent(vm)
					self.DrawnAttachments[attachment]:SetNoDraw(true)
					if info.scale then self.DrawnAttachments[attachment]:SetModelScale(info.scale, 0) end
					if info.material then self.DrawnAttachments[attachment]:SetMaterial(info.material) end
					if info.aimpos then self.AttAimPos = info.aimpos end
					if info.sightpos then if not self.SightInfo then self.SightInfo = {14 - info.num, self.DrawnAttachments[attachment]} end end
					if info.bipodpos then self.AttBipodPos = info.bipodpos end
				else
					local matr = vm:GetBoneMatrix(vm:LookupBone(info.bone))
					if matr then
						local pos, ang = matr:GetTranslation(), matr:GetAngles()
						if info.reverseangle then ang.r = -ang.r end
						self.DrawnAttachments[attachment]:SetRenderOrigin(pos + ang:Right() * info.pos.right + ang:Forward() * info.pos.forward + ang:Up() * info.pos.up)
						if info.sightang then
							local angCopy = matr:GetAngles()
							if info.sightang.up then angCopy:RotateAroundAxis(angCopy:Up(), info.sightang.up) end
							if info.sightang.forward then angCopy:RotateAroundAxis(angCopy:Forward(), info.sightang.forward) end
							if info.sightang.right then angCopy:RotateAroundAxis(angCopy:Right(), info.sightang.right) end
							self.ScopeDotAngle = angCopy
							self.ScopeDotPosition = pos + angCopy:Right() * info.sightpos.right + angCopy:Forward() * info.sightpos.forward + angCopy:Up() * info.sightpos.up
						end
						if info.ang then
							if info.ang.up then ang:RotateAroundAxis(ang:Up(), info.ang.up) end
							if info.ang.forward then ang:RotateAroundAxis(ang:Forward(), info.ang.forward) end
							if info.ang.right then ang:RotateAroundAxis(ang:Right(), info.ang.right) end
						end
						self.DrawnAttachments[attachment]:SetRenderAngles(ang)
						self.DrawnAttachments[attachment]:DrawModel()
					end
				end
			else
				if self.DrawnAttachments[attachment] then
					self.DrawnAttachments[attachment] = nil
					if info.aimpos then self.AttAimPos = nil end
					if info.sightang then self.SightInfo = nil end
					if info.bipodpos then self.AttBipodPos = nil end
				end
			end
		end
	end
	if self.SightInfo then 
		self:DrawSight(self, self.SightInfo[1], self.SightInfo[2], vm) 
		print("1")
	end
end

function SWEP:DrawWorldModel()
	if self.Attachments and self.Attachments["Viewer"] then
		if IsValid(self:GetOwner()) then
			if self.FuckedWorldModel then
				if not self.WModel then
					self.WModel = ClientsideModel(self.WorldModel)
					self.WModel:SetPos(self:GetOwner():GetPos())
					self.WModel:SetParent(self:GetOwner())
					self.WModel:SetNoDraw(true)
					if self.Attachments["Viewer"]["Weapon"].bodygroups then
						for i, val in pairs(self.Attachments["Viewer"]["Weapon"].bodygroups) do
							self.WModel:SetBodygroup(i, val)
						end
					end
				else
					local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
					if pos and ang then
						local info = self.Attachments["Viewer"]["Weapon"]
						self.WModel:SetRenderOrigin(pos + ang:Right() * info.pos.right + ang:Forward() * info.pos.forward + ang:Up() * info.pos.up)
						local angList = {
							["forward"] = ang:Forward(),
							["right"] = ang:Right(),
							["up"] = ang:Up()
						}
						for i, rot in pairs(info.ang) do
							if not info.ang[1] then
								ang:RotateAroundAxis(angList[i], rot)
							else
								ang:RotateAroundAxis(angList[rot[1]], rot[2])
							end
							angList = {
								["forward"] = ang:Forward(),
								["right"] = ang:Right(),
								["up"] = ang:Up()
							}
						end
						self:GetOwner():SetNWEntity("E2", self.WModel)
						self.WModel:SetRenderAngles(ang)
						self.WModel:DrawModel()
					end
				end
			else
				self:DrawModel()
			end
			for attachment, info in pairs(self.Attachments["Viewer"]) do
				if self:GetNWBool(attachment) then
					if not self.WDrawnAttachments[attachment] then
						self.WDrawnAttachments[attachment] = ClientsideModel(info.model)
						self.WDrawnAttachments[attachment]:SetPos(self:GetOwner():GetPos())
						self.WDrawnAttachments[attachment]:SetParent(self:GetOwner())
						self.WDrawnAttachments[attachment]:SetNoDraw(true)
						if info.scale then self.WDrawnAttachments[attachment]:SetModelScale(info.scale, 0) end
						if info.material then self.WDrawnAttachments[attachment]:SetMaterial(info.material) end
					else
						if attachment == "Laser" then self:DrawLaser() end
						local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
						self.WDrawnAttachments[attachment]:SetRenderOrigin(pos + ang:Right() * info.pos.right + ang:Forward() * info.pos.forward + ang:Up() * info.pos.up)
						local angList = {
							["forward"] = ang:Forward(),
							["right"] = ang:Right(),
							["up"] = ang:Up()
						}
						for i, rot in pairs(info.ang) do
							ang:RotateAroundAxis(angList[i], rot)
							angList = {
								["forward"] = ang:Forward(),
								["right"] = ang:Right(),
								["up"] = ang:Up()
							}
						end
						self.WDrawnAttachments[attachment]:SetRenderAngles(ang)
						self.WDrawnAttachments[attachment]:DrawModel()
					end
				else
					if self.WDrawnAttachments[attachment] then self.WDrawnAttachments[attachment] = nil end
				end
			end
		end
	end
end