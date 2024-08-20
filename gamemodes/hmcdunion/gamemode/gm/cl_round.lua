--
function GM:StartNewRound()
    local ply = LocalPlayer()
	local startsound

	if GetGlobalInt("RoundType", 2) != 0 then
		startsound = HMCD_RoundStartSound[GetGlobalInt("RoundType", 2)]
	else
		startsound = RoundStartSound[GetGlobalString("RoundName", "homicide")]
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
	print(ply:GetNWString("RoleShow"))
	local RoundLabel = Label(ply:GetNWString("RoleShow"),Panel)
	RoundLabel:SetFont("DefaultFont")
	RoundLabel:SizeToContents()
	RoundLabel:Center()
	RoundLabel:SetColor(Color(ply:GetNWInt("RoleColor_R"),ply:GetNWInt("RoleColor_G"),ply:GetNWInt("RoleColor_B"),255))

	if ply:GetNWString("RoleShow", "") == "Gunman" and GetGlobalInt("RoundType", 2) != 5 then
		local Instructions = Label( (GetGlobalInt("RoundType", 2) == 2 and "with a large weapon") or "with a lawful concealed firearm", Panel)
		Instructions:SetFont("FontSmall")
		Instructions:SizeToContents()
		Instructions:Center()
		Instructions:SetPos(Instructions:GetX(),Instructions:GetY()+textHeight*1.5)	
		Instructions:SetColor(Color(121,61,244))		
	end

	local probel
	if GetGlobalString("RoundName", "homicide") == "homicide" then
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
	
	local RoundLabel = Label( RoundsNormalise[GetGlobalString("RoundName", "homicide")] .. probel .. HMCD_RoundsTypeNormalise[GetGlobalInt("RoundType", 2)], Panel)
	RoundLabel:SetFont("FontSmall")
	RoundLabel:SizeToContents()
	RoundLabel:CenterHorizontal()
	RoundLabel:SetPos(RoundLabel:GetX(),50)	
		
end

surface.CreateFont( "BigEndRound" , {
	font = "coolvetica",
	size = math.ceil(ScrW() / 24),
	weight = 500,
	antialias = true,
	italic = false
})

local menu
function GM:DisplayEndRoundBoard(data)
	if IsValid(menu) then
		menu:Close()
	end
	local Showin,Dude=false,GAMEMODE.MVP
	if Dude and GetGlobalString("RoundName", "homicide") == "homicide" then Showin=true end
	menu = vgui.Create("DFrame")
	menu:SetSize(ScrW() * 0.8, ScrH() * 0.8)
	menu:Center()
	if Showin then
		menu:SetSize(ScrW()*.45,ScrH()*.9)
		menu:SetPos(ScrW()*.525,ScrH()*.05)
	end
	menu:SetTitle("")
	menu:MakePopup()
	menu:SetKeyboardInputEnabled(false)
	

	function menu:Paint()
		surface.SetDrawColor(Color(40,40,40,255))
		surface.DrawRect(0, 0, menu:GetWide(), menu:GetTall())
	end

	local winnerPnl = vgui.Create("DPanel", menu)
	winnerPnl:DockPadding(24,24,24,24)
	winnerPnl:Dock(TOP)
	function winnerPnl:PerformLayout()
		self:SizeToChildren(false, true)
	end
	function winnerPnl:Paint(w, h) 
		surface.SetDrawColor(Color(50,50,50,255))
		surface.DrawRect(2, 2, w - 4, h - 4)
	end

	local winner = vgui.Create("DLabel", winnerPnl)
	winner:Dock(TOP)
	winner:SetFont("BigEndRound")
	winner:SetAutoStretchVertical(true)
	winner:SetTextColor(Color(255,255,255))
	if data.reason==1 then
		winner:SetText("The traitor wins!")
		winner:SetTextColor(Color(190, 20, 20))
	elseif data.reason==2 then
		winner:SetText("Innocents win!")
		winner:SetTextColor(Color(20, 120, 255))
	elseif data.reason==3 then
		winner:SetText("Draw!")
		winner:SetTextColor(Color(223, 223, 223))
	elseif data.reason==4 then
		winner:SetText("Combines win!")
		winner:SetTextColor(Color(32, 98, 185))
	elseif data.reason==5 then
		winner:SetText("Rebels win!")
		winner:SetTextColor(Color(178, 119, 17))
	elseif data.reason==6 then
		winner:SetText(data.survived  .. " survived.")
		winner:SetTextColor(Color(178, 119, 17))
	end
	local murdererPnl = vgui.Create("DPanel", winnerPnl)
	murdererPnl:Dock(TOP)
	murdererPnl:SetTall(draw.GetFontHeight("FontSmall"))
	function murdererPnl:Paint()
		--
	end

	if data.murdererName and GetGlobalString("RoundName", "homicide") == "homicide" and data.reason != 3 then
		local col = data.murdererColor
		local msgs={}
		msgs.text="The traitor was"
		msgs.color=Color(col.x * 255, col.y * 255, col.z * 255)
		local was = vgui.Create("DLabel", murdererPnl)
		was:Dock(LEFT)
		was:SetText(msgs.text)
		was:SetFont("FontSmall")
		was:SetTextColor(color_white)
		was:SetAutoStretchVertical(true)
		was:SizeToContentsX()
		local name=vgui.Create("DLabel", murdererPnl)
		name:Dock(LEFT)
		name:SetText(" "..data.murdererName)
		name:SetTextColor(msgs.color or color_white)
		name:SetFont("FontSmall")
		name:SizeToContentsX()
	end

	local lootPnl = vgui.Create("DPanel", menu)
	lootPnl:Dock(FILL)
	lootPnl:DockPadding(24,24,24,24)
	function lootPnl:Paint(w, h) 
		surface.SetDrawColor(Color(50,50,50,255))
		surface.DrawRect(2, 2, w - 4, h - 4)
	end
	
	local desc = vgui.Create("DLabel", lootPnl)
	desc:Dock(TOP)
	desc:SetFont("DefaultFont")
	desc:SetAutoStretchVertical(true)
	desc:SetText("Players")
	desc:SetTextColor(color_white)
	local lootList = vgui.Create("DPanelList", lootPnl)
	lootList:Dock(FILL)
	for k,v in pairs(team.GetPlayers(1)) do

		local pnl = vgui.Create("DPanel")
		pnl:SetTall(draw.GetFontHeight("FontSmall"))
		function pnl:Paint(w, h)
		end

		--
		function pnl:PerformLayout()
			if self.NamePnl then
				self.NamePnl:SetWidth(self:GetWide() * 0.4)
			end
			if self.BNamePnl then
				self.BNamePnl:SetWidth(self:GetWide() * 0.3)
			end
			if self.SNamePnl then
				self.SNamePnl:SetWidth(self:GetWide() * 0.4)
			end
			self:SizeToChildren(false, true)
		end

		local name = vgui.Create("DButton", pnl)
		pnl.NamePnl = name
		name:Dock(LEFT)
		name:SetAutoStretchVertical(true)
		name:SetText(v:Nick().." - "..v:GetNWString("Role", ""))
		name:SetFont("FontSmall")
		name:SetTextColor(Color(v:GetNWInt("RoleColor_R", 255), v:GetNWInt("RoleColor_G", 255), v:GetNWInt("RoleColor_B", 255)))
		name:SetContentAlignment(4)
		function name:Paint()
		end

		function name:DoClick()
			if IsValid(v) then
				GAMEMODE:DoScoreboardActionPopup(v)
			end
		end

		local bname = vgui.Create("DButton", pnl)
		pnl.BNamePnl = bname
		bname:Dock(LEFT)
		bname:SetAutoStretchVertical(true)
		local col
		if(v.MurdererIdentityHidden)then
			bname:SetText(v.TrueIdentity[5])
			col=v.TrueIdentity[7]
		else
			bname:SetText(v:GetNWString("Character_Name", ""))
			col=v:GetPlayerColor()
		end
		bname:SetFont("FontSmall")
		bname:SetTextColor(Color(col.x * 255, col.y * 255, col.z * 255))
		bname:SetContentAlignment(4)
		function bname:Paint() end
		bname.DoClick = name.DoClick

		lootList:AddItem(pnl)

	end
	
	if Showin then
		local Top,Bottom
		--[[Top=vgui.Create("DFrame")
		function Top:Paint()
			surface.SetDrawColor(Color(40,40,40,255))
			surface.DrawRect(0,0,Top:GetWide(),Top:GetTall())
		end
		Top:ShowCloseButton(false)
		Top:SetPos(ScrW()*.05,ScrH()*.05)
		Top:SetSize(600,60)
		Top:SetTitle("")
		Top:SetKeyboardInputEnabled(false)
		Top:SetDeleteOnClose(false)
		Top:MakePopup()
		local Pnl1=vgui.Create("DPanel",Top)
		Pnl1:Dock(FILL)
		Pnl1:DockPadding(24,24,24,24)
		function Pnl1:Paint(w,h) 
			surface.SetDrawColor(Color(50,50,50,255))
			surface.DrawRect(0,0,w,h)
		end
		local title=vgui.Create("DLabel",Top)
		title:SetFont("MersRadialBig")
		title:SetText("Winner: ")
		title:SetSize(300,50)
		title:SetTextColor(Color(255,255,255,255))
		title:SetPos(10,6) 
		local wew=vgui.Create("DLabel",Top)
		wew:SetFont("MersRadialBig")
		wew:SetText(Dude:GetNWString("bystanderName"))
		local Col=Dude:GetPlayerColor()
		wew:SetTextColor(Color(Col.r*255,Col.g*255,Col.b*255,255))
		wew:SetPos(180,6)
		wew:SetSize(430,50)]]
		Bottom=vgui.Create("DFrame")
		function Bottom:Paint()
			surface.SetDrawColor(Color(40,40,40,255))
			surface.DrawRect(0,0,Bottom:GetWide(),Bottom:GetTall())
		end
		--
		if (Dude) then
			Bottom:ShowCloseButton(false)
			Bottom:SetSize(600,75)
			Bottom:SetPos(ScrW()*.05,ScrH()*.05)
			Bottom:SetTitle("                         MVP: "..Dude:GetNWString("Character_Name"))
			Bottom:MakePopup()
			Bottom:SetKeyboardInputEnabled(false)
			Bottom:SetDeleteOnClose(false)
			local Pnl2=vgui.Create("DPanel",Bottom)
			Pnl2:Dock(FILL)
			Pnl2:DockPadding(24,24,24,24)
			--
			function Pnl2:Paint(w,h) 
				surface.SetDrawColor(Color(50,50,50,255))
				surface.DrawRect(0,0,w,h)
			end
			local av=vgui.Create("AvatarImage",Bottom)
			av:SetSize(64,64)
			av:SetPos(5,5)
			av:SetPlayer(Dude,64)
			local wow=vgui.Create("DLabel",Bottom)
			wow:SetFont("FontSmall")
			wow:SetText( Dude:GetNWString("Character_Name"))
			wow:SetTextColor(Color(255,255,255,255))
			wow:SetPos(80,100)
			wow:SetSize(530,50)
		end
		
		menu.OnClose=function()
			Bottom:Close()
		end
	end
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
	data.survived = net.ReadString()
	GAMEMODE.MVP = data.murderer
    GAMEMODE:DisplayEndRoundBoard(data)
	local pitch = math.random(80, 120)
	if IsValid(LocalPlayer()) then
		LocalPlayer():EmitSound("ambient/alarms/warningbell1.wav", 100, pitch)
	end
end) 