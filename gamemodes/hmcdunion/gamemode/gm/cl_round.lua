--
function GM:StartNewRound()
    local ply = LocalPlayer()
	local sound = HMCD_RoundStartSound[GAMEMODE.RoundType]
	if istable(sound) then sound = table.Random(sound) end
	ply:EmitSound(sound)
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
	local RoundLabel = Label(ply:GetNWString("Role"),Panel)
	RoundLabel:SetFont("DefaultFont")
	RoundLabel:SizeToContents()
	RoundLabel:Center()
	RoundLabel:SetColor(Color(ply:GetNWInt("RoleColor_R"),ply:GetNWInt("RoleColor_G"),ply:GetNWInt("RoleColor_B"),255))

	if ply:GetNWString("SecretRole", "") == "Gunman" then
		local Instructions = Label( (GAMEMODE.RoundType == 2 and "with a large weapon") or "with a lawful concealed firearm", Panel)
		Instructions:SetFont("FontSmall")
		Instructions:SizeToContents()
		Instructions:Center()
		Instructions:SetPos(Instructions:GetX(),Instructions:GetY()+textHeight*1.5)	
		Instructions:SetColor(Color(121,61,244))		
	end

    --help
	local RoundLabel = Label(Text,Panel)
	RoundLabel:SetFont("FontSmall")
	RoundLabel:SizeToContents()
	RoundLabel:Center()
	local fontHeight=draw.GetFontHeight("FontSmall")
	RoundLabel:SetPos(RoundLabel:GetX(),ScrH()-fontHeight*2)
	RoundLabel:SetColor(Color(ply:GetNWInt("RoleColor_R"),ply:GetNWInt("RoleColor_G"),ply:GetNWInt("RoleColor_B"),255))
	
	local RoundLabel = Label( RoundsNormalise[GAMEMODE.RoundName] .. (GAMEMODE.RoundName == "homicide" and HMCD_RoundsTypeNormalise[GAMEMODE.RoundType] ) or "", Panel)
	RoundLabel:SetFont("FontSmall")
	RoundLabel:SizeToContents()
	RoundLabel:CenterHorizontal()
	RoundLabel:SetPos(RoundLabel:GetX(),50)	
		
end

net.Receive("StartRound",function()
	GAMEMODE:StartNewRound()
end)

net.Receive("EndRound",function()
	local pitch = math.random(80, 120)
	if IsValid(LocalPlayer()) then
		LocalPlayer():EmitSound("ambient/alarms/warningbell1.wav", 100, pitch)
	end
end) 