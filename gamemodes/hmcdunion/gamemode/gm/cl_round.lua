--
function GM:StartNewRound()
    local ply = LocalPlayer()
	print(ply:GetNWString("Round"))
	print(ply:GetNWString("RoundType"))
	print(ply:GetNWString("RoleShow"))
	local startsound

	if ply:GetNWInt("RoundType") != 0 then
		startsound = HMCD_RoundStartSound[ply:GetNWInt("RoundType")]
	else
		startsound = RoundStartSound[ply:GetNWInt("Round")]
	end

	ply:EmitSound(startsound)
	local Panel = vgui.Create("DPanel")
	Panel:SetPos(0, 0)
	Panel:SetSize(ScrW(), ScrH())
	Panel.Paint = function( sel, w, h ) 
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(0, 0, w, h)
	end
	Panel:ParentToHUD()
	Panel:AlphaTo(0,3,9,function() Panel:Remove() end)
	
	
	surface.SetFont("FontSmall")
	local textWidth,textHeight=surface.GetTextSize(ply:GetNWString("Role"))
	local You = Label("You are",Panel)
	You:SetFont("FontSmall")
	You:SetColor(Color(ply:GetNWInt("RoleColor_R"),ply:GetNWInt("RoleColor_G"),ply:GetNWInt("RoleColor_B"),255))
	You:SetPos(0,ScrH()/2-textHeight*1.5)
	You:SizeToContents()
	You:CenterHorizontal()
	local RoundLabel = Label(ply:GetNWString("RoleShow"),Panel)
	RoundLabel:SetFont("DefaultFont")
	RoundLabel:SizeToContents()
	RoundLabel:Center()
	RoundLabel:SetColor(Color(ply:GetNWInt("RoleColor_R"),ply:GetNWInt("RoleColor_G"),ply:GetNWInt("RoleColor_B"),255))

	if ply:GetNWString("RoleShow", "") == "Gunman" and ply:GetNWInt("RoundType") != 5 then
		local Instructions = Label( (ply:GetNWInt("RoundType") == 2 and "with a large weapon") or "with a lawful concealed firearm", Panel)
		Instructions:SetFont("FontSmall")
		Instructions:SizeToContents()
		Instructions:Center()
		Instructions:SetPos(Instructions:GetX(),Instructions:GetY()+textHeight*1.5)	
		Instructions:SetColor(Color(121,61,244))		
	end

	local probel
	if ply:GetNWInt("Round") == "homicide" then
		probel = ": "
	else
		probel = " "
	end

    --help
	local RoundLabel = Label(HMCD_HelpRole[ply:GetNWString("RoleShow", "")],Panel)
	RoundLabel:SetFont("FontSmall")
	RoundLabel:SizeToContents()
	RoundLabel:Center()
	local fontHeight=draw.GetFontHeight("FontSmall")
	RoundLabel:SetPos(RoundLabel:GetX(),ScrH()-fontHeight*2)
	RoundLabel:SetColor(Color(ply:GetNWInt("RoleColor_R"),ply:GetNWInt("RoleColor_G"),ply:GetNWInt("RoleColor_B"),255))
	local RoundLabel = Label( RoundsNormalise[ply:GetNWString("Round")] .. probel .. HMCD_RoundsTypeNormalise[ply:GetNWInt("RoundType")], Panel)
	RoundLabel:SetFont("FontSmall")
	RoundLabel:SizeToContents()
	RoundLabel:CenterHorizontal()
	RoundLabel:SetPos(RoundLabel:GetX(),50)	
		
end

net.Receive("StartRound",function()
	GAMEMODE:StartNewRound()
end)

net.Receive("EndRound",function()
	local data = {}
	data.reason=net.ReadInt(8)
	data.murderer = net.ReadEntity()
	data.murdererColor = net.ReadVector()
	data.murdererName = net.ReadString()
	GAMEMODE.MVP = data.murderer
    GAMEMODE:DisplayEndRoundBoard(data)
	local pitch = math.random(80, 120)
	if IsValid(LocalPlayer()) then
		LocalPlayer():EmitSound("ambient/alarms/warningbell1.wav", 100, pitch)
	end
end) 