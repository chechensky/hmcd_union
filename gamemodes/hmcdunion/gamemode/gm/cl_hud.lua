local function drawTextShadow(t,f,x,y,c,px,py)
	draw.SimpleText(t,f,x + 1,y + 1,Color(0,0,0,c.a),px,py)
	draw.SimpleText(t,f,x - 1,y - 1,Color(255,255,255,math.Clamp(c.a*.25,0,255)),px,py)
	draw.SimpleText(t,f,x,y,c,px,py)
end

local healthCol = Color(120,255,20)
function GM:HUDPaint()
	local client = LocalPlayer()
	self:DrawGameHUD(client)
	self:DrawPhraseMenu()
	self:DrawRadialMenu()
	self:Drawmenu_useMenu()
	self:DrawSpectate()
end

function GM:DrawSpectate()
	local ply = LocalPlayer()
	local plyselect = ply:GetNWEntity("SelectPlayer", Entity(-1))
	if !ply:Alive() and ply:GetNWBool("Spectating", false) then
		drawTextShadow( (ply:GetNWInt("SpectateMode") == 3 and "Noclip") or plyselect:Nick() ,"DefaultFont",950,50,team.GetColor(1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		drawTextShadow("R - Change mode spectate player","FontSmall",930,900,color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		drawTextShadow("LMB - Change player spectate","FontSmall",930,930,color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		drawTextShadow("RMB - Change mode spectate ( noclip / player )","FontSmall",930,960,color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function RagdollOwner(rag)
	if not IsValid(rag) then return end

	local ent = rag:GetNWEntity("RagdollController")
	return IsValid(ent) and ent
end

function GM:DrawGameHUD(ply)
	if !IsValid(ply) then return end
	local health = ply:Health()
	if !IsValid(ply) then return end
	if not(LocalPlayer()==ply)then return end

	local W,H,Vary=ScrW(),ScrH(),math.sin(CurTime()*10)/2+.5
	local Bright=Color(255,255,255,255)

	local tr = ply:GetEyeTraceNoCursor()

	if IsValid(tr.Entity) and tr.HitPos:Distance(tr.StartPos) < 60 then
		if tr.Entity:IsPlayer() or tr.Entity:IsRagdoll() then
			self.LastLooked = (tr.Entity:IsRagdoll()) and RagdollOwner(tr.Entity) or tr.Entity
			self.LastLookedType = (tr.Entity:IsRagdoll()) and "Ragdoll" or "Other"
			self.LookedFade = CurTime()
		end
	end
	if IsValid(self.LastLooked) and self.LookedFade + 1 > CurTime() and self.LastLooked != LocalPlayer() and LocalPlayer():Alive() then
		local type_look = self.LastLookedType
		local name = (type_look == "Ragdoll") and tr.Entity:GetNWString("Character_Name") or self.LastLooked:GetNWString("Character_Name")
		local col = (type_look == "Ragdoll") and tr.Entity:GetNWVector("plycolor") or self.LastLooked:GetPlayerColor() or Vector()
		col = Color(col.x * 255, col.y * 255, col.z * 255)
		col.a = (1 - (CurTime() - self.LookedFade) / 1) * 255
		drawTextShadow(name, "FontTargetP", ScrW() / 2, ScrH() / 2 + 80, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local RoundTextures={
		["Pistol"]=surface.GetTextureID("vgui/hud/hmcd_round_9"),
		["357"]=surface.GetTextureID("vgui/hud/hmcd_round_38"),
		["AlyxGun"]=surface.GetTextureID("vgui/hud/hmcd_round_22"),
		["Buckshot"]=surface.GetTextureID("vgui/hud/hmcd_round_12"),
		["AR2"]=surface.GetTextureID("vgui/hud/hmcd_round_76239"),
		["SMG1"]=surface.GetTextureID("vgui/hud/hmcd_round_4630"),
		["XBowBolt"]=surface.GetTextureID("vgui/hud/hmcd_round_arrow"),
		["AirboatGun"]=surface.GetTextureID("vgui/hud/hmcd_nail"),
		["RPG_Round"]=surface.GetTextureID("vgui/hud/hmcd_round_76239")
	}
	if ply.AmmoShow and ply.AmmoShow>CurTime() and ply:GetActiveWeapon().AmmoType != nil then
		local Wep,TimeLeft,Opacity=ply:GetActiveWeapon(),ply.AmmoShow-CurTime(),255
		if TimeLeft < 1 then Opacity=150 end
		surface.SetTexture(RoundTextures[Wep.AmmoType])
		surface.SetDrawColor(Color(255,255,255,Opacity))
		surface.DrawTexturedRect(W*.7+20,H*.825,128,128)
		local Mag,Message,Cnt=Wep:Clip1(),"",ply:GetAmmoCount(Wep.AmmoType)
		if Mag >= 0 then
			Message=tostring(Mag)
			if Cnt > 0 then Message=Message.." + "..tostring(Cnt) end
		else
			Message=tostring(Cnt)
		end
		drawTextShadow(Message,"FontSmall",W*.7+30,H*.8+45,Color(255,255,255,Opacity),0,TEXT_ALIGN_TOP)
	end
end

local function ShowAmmo(data)
	LocalPlayer().AmmoShow=CurTime()+2
end
usermessage.Hook("HMCD_AmmoShow",ShowAmmo)

local tex = surface.GetTextureID("SGM/playercircle")
local gradR = surface.GetTextureID("gui/gradient")

local function colorDif(col1, col2)
	local x = col1.x - col2.x
	local y = col1.y - col2.y
	local z = col1.z - col2.z
	x = x > 0 and x or -x
	y = y > 0 and y or -y
	z = z > 0 and z or -z
	return x + y + z
end
local Health,Stamina,PersonTex,StamTex,HelTex,BGTex=0,0,surface.GetTextureID("vgui/hud/hmcd_person"),surface.GetTextureID("vgui/hud/hmcd_stamina"),surface.GetTextureID("vgui/hud/hmcd_health"),surface.GetTextureID("vgui/hud/hmcd_background")

function GM:GUIMousePressed(code, vector)
	--
end

local WHOTBackTab={
	["$pp_colour_addr"]=0,
	["$pp_colour_addg"]=0,
	["$pp_colour_addb"]=0,
	["$pp_colour_brightness"]=-.05,
	["$pp_colour_contrast"]=1,
	["$pp_colour_colour"]=0,
	["$pp_colour_mulr"]=0,
	["$pp_colour_mulg"]=0,
	["$pp_colour_mulb"]=0
}
local RedVision={
	["$pp_colour_addr"]=0,
	["$pp_colour_addg"]=0,
	["$pp_colour_addb"]=0,
	["$pp_colour_brightness"]=0,
	["$pp_colour_contrast"]=1,
	["$pp_colour_colour"]=1,
	["$pp_colour_mulr"]=0,
	["$pp_colour_mulg"]=0,
	["$pp_colour_mulb"]=0
}

function GM:GUIMousePressed(code, vector)
	LocalPlayer():ConCommand("-phrase")
	LocalPlayer():ConCommand("-menu_use")
	LocalPlayer():ConCommand("-menu_context")
end

function GM:OpenAmmoDropMenu()
	local Ply,AmmoType,AmmoAmt,Ammos=LocalPlayer(),"Pistol",1,{}
	for key,name in pairs(HMCD_AmmoNames)do
		local Amownt=Ply:GetAmmoCount(key)
		if(Amownt>0)then Ammos[key]=Amownt end
	end
	
	if(#table.GetKeys(Ammos)<=0)then
		Ply:ChatPrint("You have no ammo!")
		return
	end
	
	AmmoType=table.GetKeys(Ammos)[1]
	AmmoAmt=Ammos[AmmoType]

	local DermaPanel=vgui.Create("DFrame")
	DermaPanel:SetPos(40,80)
	DermaPanel:SetSize(300,300)
	DermaPanel:SetTitle("Drop Ammo")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(true)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:MakePopup()
	DermaPanel:Center()

	local MainPanel=vgui.Create("DPanel",DermaPanel)
	MainPanel:SetPos(5,25)
	MainPanel:SetSize(290,270)
	MainPanel.Paint=function()
		surface.SetDrawColor(0,20,40,255)
		surface.DrawRect(0,0,MainPanel:GetWide(),MainPanel:GetTall()+3)
	end
	
	local SecondPanel=vgui.Create("DPanel",MainPanel)
	SecondPanel:SetPos(100,177)
	SecondPanel:SetSize(180,20)
	SecondPanel.Paint=function()
		surface.SetDrawColor(100,100,100,255)
		surface.DrawRect(0,0,SecondPanel:GetWide(),SecondPanel:GetTall()+3)
	end
	
	local amtselect=vgui.Create("DNumSlider",MainPanel)
	amtselect:SetPos(10,170)
	amtselect:SetWide(290)
	amtselect:SetText("Amount")
	amtselect:SetMin(1)
	amtselect:SetMax(AmmoAmt)
	amtselect:SetDecimals(0)
	amtselect:SetValue(AmmoAmt)
	amtselect.OnValueChanged=function(panel,val)
		AmmoAmt=math.Round(val)
	end
	
	local AmmoList=vgui.Create("DListView",MainPanel)
	AmmoList:SetMultiSelect(false)
	AmmoList:AddColumn("Type")
	for key,amm in pairs(Ammos)do
		AmmoList:AddLine(HMCD_AmmoNames[key]).Type=key
	end
	AmmoList:SetPos(5,5)
	AmmoList:SetSize(280,150)
	AmmoList.OnRowSelected=function(panel,ind,row)
		AmmoType=row.Type
		AmmoAmt=Ammos[AmmoType]
		amtselect:SetMax(AmmoAmt)
		amtselect:SetValue(AmmoAmt)
	end
	AmmoList:SelectFirstItem()
	
	local gobutton=vgui.Create("Button",MainPanel)
	gobutton:SetSize(270,40)
	gobutton:SetPos(10,220)
	gobutton:SetText("Drop")
	gobutton:SetVisible(true)
	gobutton.DoClick=function()
		DermaPanel:Close()
		RunConsoleCommand("hmcd_droprequest_ammo",AmmoType,tostring(AmmoAmt))
	end
end

concommand.Add("open_ammo_drop_menu", function()
    GAMEMODE:OpenAmmoDropMenu()
end)

function GM:OpenEquipmentDropMenu()
	local ply,eqType=LocalPlayer(),""
	if(table.Count(ply.Equipment)<=0)then
		ply:ChatPrint("You have no equipment!")
		return
	end
	local size=ScrW()/8.5
	local DermaPanel=vgui.Create("DFrame")
	DermaPanel:SetSize(size,size)
	DermaPanel:SetTitle("Drop Equipment")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(true)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:MakePopup()
	DermaPanel:Center()

	local MainPanel=vgui.Create("DPanel",DermaPanel)
	MainPanel:SetPos(5,25)
	MainPanel:SetSize(size*0.96,size*0.9)
	MainPanel.Paint=function()
		surface.SetDrawColor(0,20,40,255)
		surface.DrawRect(0,0,MainPanel:GetWide(),MainPanel:GetTall())
	end

	local amtselect=vgui.Create("DNumSlider",MainPanel)

	local EquipmentList=vgui.Create("DListView",MainPanel)
	EquipmentList:SetMultiSelect(false)
	EquipmentList:AddColumn("Type")
	for key,amm in pairs(ply.Equipment)do
		EquipmentList:AddLine(key).Type=table.KeyFromValue(HMCD_EquipmentNames,key)
	end
	EquipmentList:SetPos(5,5)
	EquipmentList:SetSize(size*0.93,size*0.5)
	EquipmentList.OnRowSelected=function(panel,ind,row)
		eqType=row.Type
	end
	EquipmentList:SelectFirstItem()

	local gobutton=vgui.Create("Button",MainPanel)
	gobutton:SetSize(size*0.9,size*0.15)
	gobutton:SetPos(size/30,size*0.73)
	gobutton:SetText("Drop")
	gobutton:SetVisible(true)
	gobutton.DoClick=function()
		DermaPanel:Close()
		ply.Equipment[HMCD_EquipmentNames[eqType]]=nil
		RunConsoleCommand("hmcd_dropequipment",eqType)
	end
end

function OpenAttachmentMenu()
	local ply,Wep,attType=LocalPlayer(),LocalPlayer():GetActiveWeapon(),0
	local List={}
	if IsValid(Wep) then
		local atts={}
		if Wep.Attachments and Wep.Attachments["Owner"] then
			for attachment,info in pairs(Wep.Attachments["Owner"]) do
				if info.num then
					if Wep:GetNWBool(attachment) then
						table.insert(List,info.num)
					end
					table.insert(atts,info.num)
				end
			end
		end
		if ply.Equipment then
			for i,attachment in pairs(atts) do
				if(ply.Equipment[HMCD_EquipmentNames[attachment]])then
					table.insert(List,attachment)
				end
			end
		end
	end
	local size=ScrW()/8.5

	local DermaPanel=vgui.Create("DFrame")
	DermaPanel:SetPos(40,80)
	DermaPanel:SetSize(size,size)
	DermaPanel:SetTitle("Customize your weapon")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(true)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:MakePopup()
	DermaPanel:Center()

	local MainPanel=vgui.Create("DPanel",DermaPanel)
	MainPanel:SetPos(5,25)
	MainPanel:SetSize(size*0.96,size*0.9)
	MainPanel.Paint=function()
		surface.SetDrawColor(0,20,40,255)
		surface.DrawRect(0,0,MainPanel:GetWide(),MainPanel:GetTall()+3)
	end

	local amtselect=vgui.Create("DNumSlider",MainPanel)

	local AttachmentList=vgui.Create("DListView",MainPanel)
	AttachmentList:SetMultiSelect(false)
	AttachmentList:AddColumn("Type")
	for i,att in pairs(List)do
		AttachmentList:AddLine(HMCD_EquipmentNames[List[i]]).Type=att
	end
	AttachmentList:SetPos(5,5)
	AttachmentList:SetSize(size*0.93,size*0.5)
	AttachmentList.OnRowSelected=function(panel,ind,row)
		attType=row.Type
	end
	AttachmentList:SelectFirstItem()
	local gobutton=vgui.Create("Button",MainPanel)
	gobutton:SetSize(size*0.9,size*0.15)
	gobutton:SetPos(size/30,size*0.73)
	gobutton:SetText("Attach")
	gobutton:SetVisible(true)
	gobutton.DoClick=function()
		DermaPanel:Close()
		RunConsoleCommand("hmcd_attachrequest",attType)
	end
end

concommand.Add("attachmentsmenu", OpenAttachmentMenu)

local menu

surface.CreateFont( "ScoreboardPlayer" , {
	font = "coolvetica",
	size = 32,
	weight = 500,
	antialias = true,
	italic = false
})

local muted = Material("icon32/muted.png")
local admin = Material("icon32/wand.png")

local function addPlayerItem(self, mlist, ply, pteam)

	local but = vgui.Create("DButton")
	but.player = ply
	but.ctime = CurTime()
	but:SetTall(40)
	but:SetText("")
	local show_charactername
	function but:Paint(w, h)
		local showAdmins = false

		if IsValid(ply) && showAdmins && ply:IsAdmin() then
			surface.SetDrawColor(Color(150,50,50))
		else
			surface.SetDrawColor(team.GetColor(pteam))
		end
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(255,255,255,10)
		surface.DrawRect(0, 0, w, h * 0.45 )

		surface.SetDrawColor(color_black)
		surface.DrawOutlinedRect(0, 0, w, h)
		if IsValid(ply) && ply:IsPlayer() then
			local s = 0

			if showAdmins && ply:IsAdmin() then
				surface.SetMaterial(admin)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(s + 4, h / 2 - 16, 32, 32)
				s = s + 32
			end

			if ply:IsMuted() then
				surface.SetMaterial(muted)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(s + 4, h / 2 - 16, 32, 32)
				s = s + 32
			end

			if GAMEMODE.RoundState == 0 then
				show_charactername = ply:GetNWString("Character_Name", "")
			else
				show_charactername = ""
			end
			draw.DrawText(ply:Ping(), "ScoreboardPlayer", w - 9, 9, color_black, 2)
			draw.DrawText(ply:Ping(), "ScoreboardPlayer", w - 10, 8, color_white, 2)
			draw.DrawText(ply:Nick() .. " " .. show_charactername, "ScoreboardPlayer", s + 11, 9, color_black, 0)
			draw.DrawText(ply:Nick() .. " " .. show_charactername, "ScoreboardPlayer", s + 10, 8, color_white, 0)

			
		end
	end
	function but:DoClick()
		GAMEMODE:DoScoreboardActionPopup(ply)
	end

	mlist:AddItem(but)
end

function GM:DoScoreboardActionPopup(ply)
	if not((ply)and(IsValid(ply))and(ply:IsPlayer()))then return end
	local actions = DermaMenu()

	--if ply:IsAdmin() then
	--	local admin = actions:AddOption(translate.scoreboardActionAdmin)
	--	admin:SetIcon("icon16/shield.png")
	--end

	if ply != LocalPlayer() then
		local t = "Mute"
		if ply:IsMuted() then
			t = "Unmute"
		end
		local mute = actions:AddOption( t )
		mute:SetIcon("icon16/sound_mute.png")
		function mute:DoClick()
			if IsValid(ply) then
				ply:SetMuted(!ply:IsMuted())
			end
		end
	end
	
	--[[
	if IsValid(LocalPlayer()) && LocalPlayer():IsAdmin() then
		actions:AddSpacer()

		if ply:Team() == 2 then
			local spectate = actions:AddOption( Translator:QuickVar(translate.adminMoveToSpectate, "spectate", team.GetName(1)) )
			spectate:SetIcon( "icon16/status_busy.png" )
			function spectate:DoClick()
				RunConsoleCommand("hmcd_movetospectate", ply:EntIndex())
			end

			--local force = actions:AddOption( translate.adminMurdererForce )
			--force:SetIcon( "icon16/delete.png" )
			--function force:DoClick()
			--	RunConsoleCommand("mu_forcenextmurderer", ply:EntIndex())
			--end

			if ply:Alive() then
				local specateThem = actions:AddOption( translate.adminSpectate )
				specateThem:SetIcon( "icon16/status_online.png" )
				function specateThem:DoClick()
					RunConsoleCommand("mu_spectate", ply:EntIndex())
				end
			end
		end
	end
	--]]

	actions:Open()
end

local function doPlayerItems(self, mlist, pteam)

	for k, ply in pairs(team.GetPlayers(pteam)) do
		local found = false

		for t,v in pairs(mlist:GetCanvas():GetChildren()) do
			if v.player == ply then
				found = true
				v.ctime = CurTime()
			end
		end

		if !found then
			addPlayerItem(self, mlist, ply, pteam)
		end
	end
	local del = false

	for t,v in pairs(mlist:GetCanvas():GetChildren()) do
		if v.ctime != CurTime() then
			v:Remove()
			del = true
		end
	end
	// make sure the rest of the elements are moved up
	if del then
		timer.Simple(0, function() mlist:GetCanvas():InvalidateLayout() end)
	end
end

local function makeTeamList(parent, pteam)
	local mlist
	local chaos
	local pnl = vgui.Create("DPanel", parent)
	pnl:DockPadding(8,8,8,8)
	function pnl:Paint(w, h) 
		surface.SetDrawColor(Color(50,50,50,255))
		surface.DrawRect(2, 2, w - 4, h - 4)
	end

	function pnl:Think()
		if !self.RefreshWait || self.RefreshWait < CurTime() then
			self.RefreshWait = CurTime() + 0.1
			doPlayerItems(self, mlist, pteam)
		end
	end

	local headp = vgui.Create("DPanel", pnl)
	headp:DockMargin(0,0,0,4)
	-- headp:DockPadding(4,0,4,0)
	headp:Dock(TOP)
	function headp:Paint() end

	local but = vgui.Create("DButton", headp)
	but:Dock(RIGHT)
	but:SetText("Join")
	but:SetTextColor(color_white)
	but:SetFont("Trebuchet18")
	function but:Paint(w, h)
		surface.SetDrawColor(team.GetColor(pteam))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(255,255,255,10)
		surface.DrawRect(0, 0, w, h * 0.45 )

		surface.SetDrawColor(color_black)
		surface.DrawOutlinedRect(0, 0, w, h)

		if self:IsDown() then
			surface.SetDrawColor(50,50,50,120)
			surface.DrawRect(1, 1, w - 2, h - 2)
		elseif self:IsHovered() then
			surface.SetDrawColor(255,255,255,30)
			surface.DrawRect(1, 1, w - 2, h - 2)
		end
	end

	-- chaos = vgui.Create("DLabel", headp)
	-- chaos:Dock(RIGHT)
	-- chaos:DockMargin(0,0,10,0)
	-- if pteam == 2 then
	-- 	-- chaos:SetText("Control: " .. GAMEMODE:GetControl())
	-- else
	-- 	-- chaos:SetText("Chaos: " .. GAMEMODE:GetChaos())
	-- end
	-- function chaos:PerformLayout()
	-- 	self:ApplySchemeSettings()
	-- 	self:SizeToContentsX()
	-- 	if ( self.m_bAutoStretchVertical ) then
	-- 		self:SizeToContentsY()
	-- 	end
	-- end
	-- chaos:SetFont("Trebuchet24")
	-- chaos:SetTextColor(team.GetColor(pteam))

	local head = vgui.Create("DLabel", headp)
	head:SetText(team.GetName(pteam))
	head:SetFont("Trebuchet24")
	head:SetTextColor(team.GetColor(pteam))
	head:Dock(FILL)


	mlist = vgui.Create("DScrollPanel", pnl)
	mlist:Dock(FILL)

	// child positioning
	local canvas = mlist:GetCanvas()
	function canvas:OnChildAdded( child )
		child:Dock( TOP )
		child:DockMargin( 0,0,0,4 )
	end

	return pnl
end


function GM:ScoreboardShow()
	if IsValid(menu) then
		menu:SetVisible(true)
	else
		menu = vgui.Create("DFrame")
		menu:SetSize(ScrW() * 0.8, ScrH() * 0.8)
		menu:Center()
		menu:MakePopup()
		menu:SetKeyboardInputEnabled(false)
		--menu:SetDeleteOnClose(false)
		menu:SetDraggable(false)
		menu:ShowCloseButton(false)
		menu:SetTitle("")
		menu:DockPadding(4,4,4,4)

		function menu:Paint()
			surface.SetDrawColor(Color(40,40,40,255))
			surface.DrawRect(0, 0, menu:GetWide(), menu:GetTall())
		end

		menu.Credits = vgui.Create("DPanel", menu)
		menu.Credits:Dock(TOP)
		menu.Credits:DockPadding(8,6,8,0)
		function menu.Credits:Paint() end

		local name = Label(GAMEMODE.Name or "derp errors", menu.Credits)
		name:Dock(LEFT)
		name:SetFont("DefaultFont")
		name:SetTextColor(team.GetColor(2))
		function name:PerformLayout()
			surface.SetFont(self:GetFont())
			local w,h = surface.GetTextSize(self:GetText())
			self:SetSize(w,h)
		end

		local lab = Label("by checha; Mannytko; quezkaly. Version " .. tostring(GAMEMODE.Version or "error"), menu.Credits)
		lab:Dock(RIGHT)
		lab:SetFont("FontSmall")
		lab.PerformLayout = name.PerformLayout
		lab:SetTextColor(team.GetColor(1))

		function menu.Credits:PerformLayout()
			surface.SetFont(name:GetFont())
			local w,h = surface.GetTextSize(name:GetText())
			self:SetTall(h)
		end
		menu.Players = makeTeamList(menu, 1)
		menu.Players:Dock(LEFT)
		
		menu.Spectators = makeTeamList(menu, 2)
		menu.Spectators:Dock(FILL)

		function menu:PerformLayout()
			menu.Players:SetWidth(self:GetWide() * 0.5)
		end
	end
end
function GM:ScoreboardHide()
	if IsValid(menu) then
		menu:Close()
	end
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
	if Dude then Showin=true end
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
	end
	local murdererPnl = vgui.Create("DPanel", winnerPnl)
	murdererPnl:Dock(TOP)
	murdererPnl:SetTall(draw.GetFontHeight("FontSmall"))
	function murdererPnl:Paint()
		--
	end

	if data.murdererName then
		print(data.murdererName)
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
		if Dude then
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
			wow:SetFont("BigEndRound")
			wow:SetText(Dude:Nick())
			local Col=Dude:GetPlayerColor()
			wow:SetTextColor(Color(255,255,255,255))
			wow:SetPos(80,100)
			wow:SetSize(530,50)
		end
		
		menu.OnClose=function()
			Bottom:Close()
		end
	end
end

function GM:HUDDrawScoreBoard()
end

