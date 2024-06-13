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
		["AR2"]=surface.GetTextureID("vgui/hud/hmcd_round_4630"),
		["SMG1"]=surface.GetTextureID("vgui/hud/hmcd_round_76239"),
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