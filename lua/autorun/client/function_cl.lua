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