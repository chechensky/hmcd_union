print("noempty")

hook.Add("Think","LipSync",function()
	for i, ply in pairs(player.GetAll()) do
		local ent = IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetNWEntity("Ragdoll") or ply

		local flexes = {
			ent:GetFlexIDByName( "jaw_drop" ),
			ent:GetFlexIDByName( "left_part" ),
			ent:GetFlexIDByName( "right_part" ),
			ent:GetFlexIDByName( "left_mouth_drop" ),
			ent:GetFlexIDByName( "right_mouth_drop" )
		}

		local weight = ply:IsSpeaking() && math.Clamp( ply:VoiceVolume() * 4, 0, 6 ) || 0

		for k, v in pairs( flexes ) do
			ent:SetFlexWeight( v, weight )
			ent:SetFlexWeight( 9, weight/2)
		end
	end
end)

hook.Add("PostDrawOpaqueRenderables", "LaserChecha", function()
	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()

	if weapon.Base != "wep_jack_hmcd_firearm_base" then return end
	if !weapon:GetNWBool("Laser", false) then return end
	if !weapon:GetNWBool("LaserStatus") then return end

	local startPos = ply:GetViewModel():GetAttachment(1).Pos + ply:GetViewModel():GetForward() * (weapon.LaserPos_Forward or 0) + ply:GetViewModel():GetUp() * (weapon.LaserPos_Up or 0) + ply:GetViewModel():GetRight() * (weapon.LaserPos_Right or 0)
	local endPos = startPos + ply:GetViewModel():GetRight() * (weapon.LaserPos_RightCorrect or 0) + ply:GetViewModel():GetForward() * 3000
	local tr = util.TraceLine({
    	start = startPos,
       	endpos = endPos,
    	filter = ply
	}) 

	render.SetMaterial(Material("cable/redlaser"))
	render.DrawBeam(startPos, tr.HitPos, 0.009, 2, 0, Color(255, 0, 0, 255))
    
	render.SetMaterial(Material("sprites/light_glow02_add"))
	render.DrawQuadEasy(tr.HitPos, tr.HitNormal, 10, 10, Color(255, 0, 0, 255), 0)
end)

dev = GetConVar( "developer" )

hook.Add("PostDrawTranslucentRenderables","hitboxs",function()
	if (dev:GetInt() == 1 or dev:GetInt() == 3) and ply:IsAdmin() then
		for _, ent in ipairs(player.GetAll()) do
			local cho = IsValid(ent:GetNWEntity("Ragdoll")) and ent:GetNWEntity("Ragdoll") or ent
        	local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine2'))
       		render.DrawWireframeBox( pos, ang, Vector(-1,0,-6),Vector(10,6,6), Color(200,200,200) )

			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Head1'))
        	render.DrawWireframeBox( pos, ang, Vector(2,-5,-3),Vector(8,3,3), Color(206,199,199) )
        	render.DrawWireframeBox( pos, ang, Vector(3,-3,-2),Vector(6,1,2), Color(228,25,221) )
        	render.DrawWireframeBox( pos, ang, Vector(-1,-5,-3),Vector(2,1,3), Color(9,0,255) )
			
			render.DrawWireframeBox( pos, ang, Vector(-3,-2,-2),Vector(0,-1,-1), Color(206,199,199) )
       		render.DrawWireframeBox( pos, ang, Vector(-3,-2,1),Vector(0,-1,2), Color(206,199,199) )

			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine1'))
       		render.DrawWireframeBox( pos, ang, Vector(-4,-1,-6),Vector(2,5,-1), Color(206,199,199) )
		
			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine1'))
       		render.DrawWireframeBox( pos, ang, Vector(-4,-1,-1),Vector(2,5,6), Color(206,199,199) )
		
			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine'))
       		render.DrawWireframeBox( pos, ang, Vector(-4,-1,-6),Vector(1,5,6), Color(206,199,199) )
		
			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine2'))
		    render.DrawWireframeBox( pos, ang, Vector(1,0,-1),Vector(5,4,3), Color(206,199,199) )
		
			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine4'))
		    render.DrawWireframeBox( pos, ang, Vector(-8,-1,-1),Vector(2,0,1), Color(206,199,199) )

			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine1'))
		    render.DrawWireframeBox( pos, ang, Vector(-8,-3,-1),Vector(2,-2,1), Color(206,199,199) )

			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_L_Forearm'))
		    render.DrawWireframeBox( pos, ang, Vector(-5,-1,-2),Vector(10,0,-1), Color(206,199,199) )

			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_R_Forearm'))
		    render.DrawWireframeBox( pos, ang, Vector(-5,-2,1),Vector(10,0,2), Color(206,199,199) )

			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_L_Calf'))
		    render.DrawWireframeBox( pos, ang, Vector(-5,-1,-2),Vector(10,0,-1), Color(206,199,199) )

			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_R_Calf'))
		    render.DrawWireframeBox( pos, ang, Vector(-5,-2,1),Vector(10,0,2), Color(206,199,199) )
		end
	end
end )