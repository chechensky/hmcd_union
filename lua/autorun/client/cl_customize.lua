local matindex = {
	["male01"] = 3,
	["male02"] = 2,
	["male03"] = 4,
	["male04"] = 4,
	["male05"] = 4,
	["male06"] = 0,
	["male07"] = 4,
	["male08"] = 0,
	["male09"] = 2,
	["female01"] = 2,
	["female02"] = 3,
	["female03"] = 3,
	["female04"] = 1,
	["female05"] = 2,
	["female06"] = 4,
}

local sex = {
	["male01"] = "male",
	["male02"] = "male",
	["male03"] = "male",
	["male04"] = "male",
	["male05"] = "male",
	["male06"] = "male",
	["male07"] = "male",
	["male08"] = "male",
	["male09"] = "male",
	["female01"] = "female",
	["female02"] = "female",
	["female03"] = "female",
	["female04"] = "female",
	["female05"] = "female",
	["female06"] = "female"
}

local acc_cords = {
	["Зелёный шарф"]=Vector(0,300,0),
	["Большой красный рюкзак"]=Vector(50,0,0)
}

net.Receive("lutiiikol",function()
	local ply = net.ReadEntity()
	ply.ModelSex = net.ReadString()
	ply.Accessory = net.ReadString()
	ply.AccessoryModel = nil 
end)

local faded_black = Color(0, 0, 0, 200)
local AppearanceMenuOpen, Frame, Fon = false, nil
local function OpenMenu(ply)
	if AppearanceMenuOpen then return end
	local ply = LocalPlayer()
	AppearanceMenuOpen = true
	Fon = vgui.Create("DPanel")
	Fon:SetSize(1920,1080)
	Fon:Center()
	local alpha = 0

	local ClothesW = {"normal", "striped", "plaid", "casual", "formal", "young", "cold"}
	local Type = table.Random(ClothesW)

	Fon.Paint = function(self,w,h)
		alpha = Lerp(0.1, alpha, 200)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alpha))
	end

	Frame = vgui.Create("DFrame")
	Frame:SetSize(300, 430)
	Frame:SetPos(600,350)
	Frame:SetTitle("")
	Frame:SetDraggable(false)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()

	Frame.Paint = function(self, w, h)
		alpha = Lerp(0.01, alpha, 210)
	    draw.RoundedBox(2, 0, 0, w, h, Color(0,0,0, alpha))
	    draw.SimpleText("Customize Menu", "FontBig", 100, 5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	Frame.OnClose = function()
		AppearanceMenuOpen = false
		Fon:DisableLerp()
		Fon:Clear()
		Fon:Hide()
		Fon:SetDisabled(true)
	end

-- FRAMESW
local playerModelPanel = vgui.Create("DModelPanel", Fon)
local CSelect = vgui.Create("DComboBox", Frame)
local Namey=vgui.Create("DTextEntry",Frame)
local FonText = vgui.Create("DLabel", Fon)
local MdlSelect = vgui.Create("DComboBox", Frame)
local Mixer = vgui.Create("DColorMixer", Frame)
local NamePers = vgui.Create("DLabel", Fon)
local CLabel = vgui.Create("DLabel", Frame)
local ASelect = vgui.Create("DComboBox", Frame)
local DermaButton = vgui.Create("DButton", Frame)
local accsselect = vgui.Create("DModelPanel", Fon)
-----------------

	local SlideModel = vgui.Create("DNumSlider", Fon)
	SlideModel:SetPos(1045, 820)
	SlideModel:SetSize(230, 20)
	SlideModel:SetText("Вращение модели")
	SlideModel:SetMin(-360)
	SlideModel:SetMax(360)
	SlideModel:SetDecimals(1)
	SlideModel:SetValue(-320)
	SlideModel.Label:SizeToContents()
	SlideModel.Label:SetTextColor(Color(255, 255, 255))
	SlideModel.TextArea:SetTextColor(Color(255, 255, 255))
	SlideModel.Slider.Paint = function(self, w, h)
    	draw.RoundedBox(4, 0, h * 0.5 - 4, w, 8, Color(255, 255, 255))
	end

	local SistemaRostaModel = vgui.Create("DNumSlider", Fon)
	SistemaRostaModel:SetPos(1045, 860)
	SistemaRostaModel:SetSize(230, 20)
	SistemaRostaModel:SetText("Рост")
	SistemaRostaModel:SetMin(-10)
	SistemaRostaModel:SetMax(30)
	SistemaRostaModel:SetDecimals(0)
	SistemaRostaModel:SetValue(0)
	SistemaRostaModel.Label:SizeToContents()
	SistemaRostaModel.Label:SetTextColor(Color(255, 255, 255))
	SistemaRostaModel.TextArea:SetTextColor(Color(255, 255, 255))
	SistemaRostaModel.Slider.Paint = function(self, w, h)
    	draw.RoundedBox(4, 0, h * 0.5 - 4, w, 8, Color(255, 255, 255))
	end

	function playerModelPanel:LayoutEntity(ent)
    	ent:SetAngles(Angle(0, SlideModel:GetValue(), 0))
	end


	--[[if not(acc) then acc="none" end
	local AccInfo=HMCD_Accessories[acc]
	local modelPanelAcc = Frame:Add( "DModelPanel" )
	modelPanelAcc:SetPos( 0, 0 )
	modelPanelAcc:SetSize( 300, 450 )
	if acc!="none" then
		modelPanelAcc:SetModel( AccInfo[1] )
		local Mats=modelPanelAcc.Entity:GetMaterials()
		for key,mat in pairs(Mats)do
			modelPanelAcc.Entity:SetSubMaterial(key-1,mat)
		end
		modelPanelAcc.Entity:SetSkin(AccInfo[6])	
	end
	hook.Add("Think","AccInfo", function()
		if IsValid(modelPanel.Entity) and acc!=nil and acc!="none" and string.find(modelPanel:GetModel(),"male",1)!=nil then
			local Scale,Matr=nil,Matrix()
			if(modelsex=="male")then Scale=AccInfo[3][3] else Scale=AccInfo[4][3] end
			Matr:Scale(Vector(Scale,Scale,Scale))
			modelPanelAcc.Entity:EnableMatrix("RenderMultiply",Matr)
			local PosInfo
			if(modelsex=="male")then PosInfo=AccInfo[3] else PosInfo=AccInfo[4] end
			local Pos,Ang=modelPanel.Entity:GetBonePosition(modelPanel.Entity:LookupBone(AccInfo[2]))
			Pos=Pos+Ang:Right()*PosInfo[1].x+Ang:Forward()*PosInfo[1].y+Ang:Up()*PosInfo[1].z
			Ang:RotateAroundAxis(Ang:Right(),PosInfo[2].p)
			Ang:RotateAroundAxis(Ang:Up(),PosInfo[2].y)
			Ang:RotateAroundAxis(Ang:Forward(),PosInfo[2].r)
			modelPanelAcc.Entity:SetPos(Pos)
			modelPanelAcc.Entity:SetAngles(Ang)
		end
	end)]]
	
	Namey:SetPos(10,55)
	Namey:SetSize(200,20)
	Namey:SetText(ply:GetNWString("Character_Name"))

	FonText:SetPos(1050,170)
	FonText:SetSize(250,150)
	FonText:SetText("Your character")
	FonText:SetFont("FontBigger")

	NamePers:SetPos(1030,130)
	NamePers:SetSize(900,150)
	NamePers:SetText(Namey:GetValue())
	NamePers:SetFont("FontBigger")

	MdlSelect:SetPos(10, 80)
	MdlSelect:SetSize(150, 20)
	MdlSelect:SetValue("Model")
	for k, v in pairs(Models_Customize) do
		MdlSelect:AddChoice(v)
	end
	MdlSelect.OnSelect = function(panel, index, value) 
		local kek2 = player_manager.TranslatePlayerModel(MdlSelect:GetValue())
		util.PrecacheModel(kek2)
		playerModelPanel:SetModel(kek2)
		if CSelect:GetValue() != "Style Clothes" then playerModelPanel.Entity:SetSubMaterial(matindex[MdlSelect:GetValue()], "models/humans/" .. sex[MdlSelect:GetValue()] .. "/group01/" .. CSelect:GetValue()) end
	end

	CSelect:SetPos(10, 110)
	CSelect:SetSize(150, 20)
	CSelect:SetValue("Style Clothes")
	for k, v in pairs(Clothes_Customize) do
		CSelect:AddChoice(v)
	end
	function CSelect:OnSelect(index,value,data)
		if MdlSelect:GetValue() != "Model" then playerModelPanel.Entity:SetSubMaterial(matindex[MdlSelect:GetValue()], "models/humans/" .. sex[MdlSelect:GetValue()] .. "/group01/" .. value) end
	end

	CLabel:SetPos(10, 150)
	CLabel:SetSize(100, 40)
	CLabel:SetColor(Color(Mixer:GetColor().r, Mixer:GetColor().g, Mixer:GetColor().b, 254))
	CLabel:SetText("Color Clothes")

	ASelect:SetPos(10, 140)
	ASelect:SetSize(150, 20)
	ASelect:SetValue("Accessory")

	for k,v in pairs(AccessoryList)do ASelect:AddChoice(k) end
	function ASelect:OnSelect(index,value,data)
		accsselect:SetModel(AccessoryList[ASelect:GetValue()][1])
	end

	DermaButton:SetText("Change model")
	DermaButton:SetPos(5, 350)
	DermaButton:SetSize(200, 40)
	if file.Exists("union_appearance.txt", "DATA") then
		local vartxt = string.Split(file.Read("union_appearance.txt", "DATA"), "\n")
		MdlSelect:SetValue(tostring(vartxt[1]))
		Mixer:SetColor(Color(vartxt[2] * 255, vartxt[3] * 255, vartxt[4] * 255, 255))
		CSelect:SetValue(tostring(vartxt[5]))
		Namey:SetValue(tostring(vartxt[6]))
		SistemaRostaModel:SetValue(tostring(vartxt[7]))
		ASelect:SetValue(tostring(vartxt[8]))
	end

	local kek2 = player_manager.TranslatePlayerModel(MdlSelect:GetValue())
	util.PrecacheModel(kek2)
	playerModelPanel:SetSize(700, 700)
	playerModelPanel:SetPos(800, 180)
	playerModelPanel:SetModel( kek2 )
	playerModelPanel:SetSkin( ply:GetSkin() )
	if CSelect:GetValue() != "Style Clothes" then playerModelPanel.Entity:SetSubMaterial(matindex[MdlSelect:GetValue()], "models/humans/" .. sex[MdlSelect:GetValue()] .. "/group01/" .. CSelect:GetValue()) end

	accsselect:SetPos(600, 40)
	accsselect:SetSize(300, 300)

	if ASelect:GetValue() != "Accessory" then accsselect:SetModel(AccessoryList[ASelect:GetValue()][1]) end
	accsselect:SetFOV(110)
	if acc_cords[ASelect:GetValue()] then
		accsselect:SetCamPos(acc_cords[ASelect:GetValue()])
	else
		accsselect:SetCamPos(Vector(10,10,10))
	end
	accsselect:SetLookAt(Vector(0, 0, 0))

	Mixer:SetPos(10, 190)
	Mixer:SetSize(200, 100)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(false)

	function Mixer:ValueChanged(col)
		local vector = Vector(Mixer:GetColor().r/255,Mixer:GetColor().g/255,Mixer:GetColor().b/255)
		function playerModelPanel.Entity:GetPlayerColor() return vector end
	end
	local vector = Vector(Mixer:GetColor().r/255,Mixer:GetColor().g/255,Mixer:GetColor().b/255)
	function playerModelPanel.Entity:GetPlayerColor() return vector end
	DermaButton.DoClick = function()
		local Maudel, R, G, B, Clothes, BystName, rost, Accs = MdlSelect:GetValue(), Mixer:GetColor().r / 255, Mixer:GetColor().g / 255, Mixer:GetColor().b / 255, CSelect:GetValue(), Namey:GetValue(), SistemaRostaModel:GetValue(), ASelect:GetValue()
		RunConsoleCommand("customize_manual", Maudel, R, G, B, Clothes, BystName, rost, Accs)
		local RawData = tostring(Maudel) .. "\n" .. tostring(R) .. "\n" .. tostring(G) .. "\n" .. tostring(B) .. "\n" .. tostring(Clothes) .. "\n" .. tostring(BystName) .. "\n" .. tostring(rost) .. "\n" .. tostring(Accs)
		file.Write("union_appearance.txt", RawData)
		Frame:Close()
		AppearanceMenuOpen = false
	end
end

net.Receive("open_appmenu",function()
	OpenMenu(ply)
end)