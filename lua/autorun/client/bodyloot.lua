local blackListedWeps = {
	["wep_jack_hmcd_hands"] = true
}

local blackListedAmmo = {
	[8] = true,
	[9] = true,
	[10] = true
}

local RoundTextures={
	["Pistol"]="vgui/hud/hmcd_round_9",
	["357"]="vgui/hud/hmcd_round_38",
	["AlyxGun"]="vgui/hud/hmcd_round_22",
	["Buckshot"]="vgui/hud/hmcd_round_12",
	["AR2"]="vgui/hud/hmcd_round_76239",
	["SMG1"]="vgui/hud/hmcd_round_4630",
	["XBowBolt"]="vgui/hud/hmcd_round_arrow",
	["AirboatGun"]="vgui/hud/hmcd_nail",
	["RPG_Round"]="vgui/hud/hmcd_round_76239"
}

local black = Color(0,0,0,128)
local black2 = Color(64,64,64,128)
local gray = Color(105,105,105,128)

local function getText(text,limitW)
	local newText = {}
	local newText_I = 1
	local curretText = ""

	surface.SetFont("Trebuchet18")

	for i = 1,#text do
		local sumbol = string.sub(text,i,i)
		local w,h = surface.GetTextSize(curretText .. sumbol)

		if w >= limitW then
			newText_I = newText_I + 1
			curretText = sumbol
		else
			curretText = curretText .. sumbol
		end

		newText[newText_I] = curretText
	end

	return newText
end

local bodyvestIcons = {
	[""] = Material("empty"),
	["Level IIIA"] = Material("vgui/icons/armor01"),
	["Level III"] = Material("vgui/icons/armor02")
}

local maskIcons = {
	[""] = Material("empty"),
	["NVG"] = Material("vgui/icons/nvg")
}

local helmetIcons = {
	[""] = Material("empty"),
	["ACH"] = Material("vgui/icons/helmet")
}

local panel
net.Receive("inventory",function()
	local lply = LocalPlayer()

	if IsValid(panel) then panel.override = true panel:Remove() end

	local lootEnt = net.ReadEntity()
	local success,items = pcall(net.ReadTable)
	local nickname = lootEnt:IsPlayer() and lootEnt:Name() or lootEnt:GetNWString("Character_Name") or ""
	if not success or not lootEnt then return end
	
	if items[lootEnt.curweapon] then items[lootEnt.curweapon] = nil end

	local items_ammo = net.ReadTable()

	items.weapon_hands = nil
	armor = vgui.Create("DFrame")
	armor:SetAlpha(255)
	armor:SetSize(500, 200)
	armor:SetPos(ScrW()*.396, ScrH()*.13)
	armor:SetDraggable(false)
	armor:MakePopup()
	armor:SetTitle( nickname.. "'s armor")

	panel = vgui.Create("DFrame")
	panel:SetAlpha(255)
	panel:SetSize(600, 400)
	panel:Center()
	panel:SetDraggable(true)
	panel:MakePopup()
	panel:SetTitle( nickname.. "'s body")

	function panel:OnKeyCodePressed(key)
		if key == KEY_W or key == KEY_S or key == KEY_A or key == KEY_D or key == KEY_SPACE or key == KEY_BACKSPACE then self:Remove() end
	end
	
	function panel:OnRemove()
		if self.override then return end

		net.Start("inventory")
		net.WriteEntity(lootEnt)
		net.SendToServer()
		armor:Remove()
	end

	function armor:OnRemove()
		panel:Remove()
	end

	panel.Paint = function(self, w, h)
		if not IsValid(lootEnt) or not LocalPlayer():Alive() then panel:Remove() return end

		draw.RoundedBox(0,0,0,w,h,black)
		surface.SetDrawColor(0,0,0,0)
		surface.DrawOutlinedRect(1,1,w - 2,h - 2)

		draw.SimpleText("","Trebuchet18",6,6,color_white)
	end

	armor.Paint = function(self, w, h)
		if not IsValid(lootEnt) or not LocalPlayer():Alive() then panel:Remove() return end

		draw.RoundedBox(0,0,0,w,h,black)
		surface.SetDrawColor(0,0,0,0)
		surface.DrawOutlinedRect(1,1,w - 2,h - 2)

		draw.SimpleText("","Trebuchet18",6,6,color_white)
	end

	local x,y = 5,20

	local corner = 6

	if lootEnt:IsPlayer() then

		--bodyvest
		local bodyvest = vgui.Create("DButton",armor)
		bodyvest:SetPos(5,40)
		bodyvest:SetSize(150,150)
		bodyvest.Armor = lootEnt:GetNWString("Bodyvest", "")
		bodyvest:SetText("")
		bodyvest.Paint = function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,self:IsHovered() and black2 or Color(0,0,0,0))
			surface.SetDrawColor(0,0,0,0)
			surface.DrawOutlinedRect(1,1,w - 2,h - 2)
			surface.SetMaterial(bodyvestIcons[bodyvest.Armor])
			if bodyvest.Armor != "" then
				surface.SetDrawColor(255,255,255,255)
			else surface.SetDrawColor(255,255,255,0) end
			surface.DrawTexturedRect(2,2,w - 4,h - 4)
		end

		--helmet
		local helmet = vgui.Create("DButton",armor)
		helmet:SetPos(160,100)
		helmet:SetSize(90,90)
		helmet.Armor = lootEnt:GetNWString("Helmet", "")
		helmet:SetText("")

		helmet.Paint = function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,self:IsHovered() and black2 or Color(0,0,0,0))
			surface.SetDrawColor(0,0,0,0)
			surface.DrawOutlinedRect(1,1,w - 2,h - 2)
			--surface.SetMaterial(Material(helmetIcons[lootEnt:GetNWString("Helmet", "")]))
			surface.SetMaterial(helmetIcons[helmet.Armor])
			if helmet.Armor != "" then
				surface.SetDrawColor(255,255,255,255)
			else surface.SetDrawColor(255,255,255,0) end		
			surface.DrawTexturedRect(2,2,w - 4,h - 4)
		end

		--mask
		local mask = vgui.Create("DButton",armor)
		mask:SetPos(255,100)
		mask:SetSize(90,90)
		mask.Armor = lootEnt:GetNWString("Mask", "")
		mask:SetText("")

		mask.Paint = function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,self:IsHovered() and black2 or Color(0,0,0,0))
			surface.SetDrawColor(0,0,0,0)
			surface.DrawOutlinedRect(1,1,w - 2,h - 2)
			--surface.SetMaterial(Material(helmetIcons[lootEnt:GetNWString("Helmet", "")]))
			surface.SetMaterial(maskIcons[mask.Armor])
			if mask.Armor != "" then
				surface.SetDrawColor(255,255,255,255)
			else surface.SetDrawColor(255,255,255,0) end		
			surface.DrawTexturedRect(2,2,w - 4,h - 4)
		end

		bodyvest.DoClick = function()
			if bodyvest.Armor != "" then
				net.Start("ply_take_armor")
				net.WriteEntity(lootEnt)
				net.WriteString("Bodyvest")
				net.WriteString(tostring(bodyvest.Armor))
				net.SendToServer()
				panel:Remove()
			else end
		end

		helmet.DoClick = function()
			if helmet.Armor != "" then
				net.Start("ply_take_armor")
				net.WriteEntity(lootEnt)
				net.WriteString("Helmet")
				net.WriteString(tostring(helmet.Armor))
				net.SendToServer()
				panel:Remove()
			else end
		end

		mask.DoClick = function()
			if mask.Armor != "" then
				net.Start("ply_take_armor")
				net.WriteEntity(lootEnt)
				net.WriteString("Mask")
				net.WriteString(tostring(mask.Armor))
				net.SendToServer()
				panel:Remove()
			else end
		end

	end

	for wep in pairs(items) do
		print(wep)
		local wepTbl = weapons.Get(wep) or WeaponByModel[wep] or wep
		local CarryWeight
		if wepTbl.CarryWeight then
			CarryWeight = wepTbl.CarryWeight
		else
			CarryWeight = 0
		end
		local button = vgui.Create("DButton",panel)
		button:SetPos(x,y)
		button:SetSize((CarryWeight >= 3000 and 50*4) or 65,(CarryWeight >= 3000 and 50*2) or 50)

		x = x + button:GetWide() + 6
		if x + button:GetWide() >= panel:GetWide() then
			x = 5
			y = y + button:GetTall() + 6
		end

		button:SetText("")

		local text = type(wepTbl) == "table" and wepTbl.PrintName or wep
		text = getText(text,button:GetWide() - corner * 2)

		local cameraPos = Vector(20,20,20)

		button.Paint = function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,self:IsHovered() and black2 or black)
			surface.SetDrawColor(0,0,0,0)
			surface.DrawOutlinedRect(1,1,w - 2,h - 2)
			surface.SetMaterial(Material(wepTbl.IconTexture))
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRect(2,2,w - 4,h - 4)
		end

		function button:OnRemove() if IsValid(model) then model:Remove() end end

		button.DoRightClick = function()
			local action = DermaMenu()
			local take = action:AddOption("Take")
			local drop = action:AddOption("Drop")
			take:SetIcon("icon16/box.png")
			drop:SetIcon("icon16/brick.png")
			function take:DoClick()
				net.Start("ply_take_item")
				net.WriteEntity(lootEnt)
				net.WriteString(tostring(wep))
				net.SendToServer()
			end
			function drop:DoClick()
				net.Start("ply_drop_item")
				net.WriteEntity(lootEnt)
				net.WriteString(tostring(wep))
				net.SendToServer()
			end
			action:Open()
		end

		button.DoClick = function()
			local action = DermaMenu()
			local take = action:AddOption("Take")
			local drop = action:AddOption("Drop")
			take:SetIcon("icon16/box.png")
			drop:SetIcon("icon16/brick.png")
			function take:DoClick()
				net.Start("ply_take_item")
				net.WriteEntity(lootEnt)
				net.WriteString(tostring(wep))
				net.SendToServer()
			end
			function drop:DoClick()
				net.Start("ply_drop_item")
				net.WriteEntity(lootEnt)
				net.WriteString(tostring(wep))
				net.SendToServer()
			end
			action:Open()
		end
	end

	for ammo,amt in pairs(items_ammo) do
		if blackListedAmmo[ammo] then continue end
		local button = vgui.Create("DButton",panel)
		button:SetPos(x,y)
		button:SetSize(50,50)

		x = x + button:GetWide() + 6
		if x + button:GetWide() >= panel:GetWide() then
			x = 40
			y = y + button:GetTall() + 6
		end

		button:SetText('')
		local text = game.GetAmmoName(ammo)
		text = getText(text,button:GetWide() - corner * 2)

		button.Paint = function(self, w, h)
			draw.RoundedBox(0,0,0,w,h,self:IsHovered() and black2 or black)
			surface.SetDrawColor(0,0,0,0)
			surface.DrawOutlinedRect(1,1,w - 2,h - 2)
			local round = Material(RoundTextures[game.GetAmmoName(ammo)],"noclamp smooth")
			surface.SetMaterial(round)
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRect(2,2,w - 4,h - 4)

			for i,text in pairs(text) do
				draw.SimpleText(amt,"Trebuchet18",corner+28,corner + 24 + (i - 1) * 3,color_white)
			end
		end
		button.DoRightClick = function()
			local action = DermaMenu()
			local take = action:AddOption("Take")
			local drop = action:AddOption("Drop")
			take:SetIcon("icon16/box.png")
			drop:SetIcon("icon16/brick.png")
			function take:DoClick()
				net.Start("ply_take_ammo")
				net.WriteEntity(lootEnt)
				net.WriteFloat(tonumber(ammo))
				net.SendToServer()
			end
			function drop:DoClick()
				net.Start("ply_drop_ammo")
				net.WriteEntity(lootEnt)
				net.WriteFloat(tonumber(ammo))
				net.SendToServer()
			end
			action:Open()
		end
		button.DoClick = function()
			local action = DermaMenu()
			local take = action:AddOption("Take")
			local drop = action:AddOption("Drop")
			take:SetIcon("icon16/box.png")
			drop:SetIcon("icon16/brick.png")
			function take:DoClick()
				net.Start("ply_take_ammo")
				net.WriteEntity(lootEnt)
				net.WriteFloat(tonumber(ammo))
				net.SendToServer()
			end
			function drop:DoClick()
				net.Start("ply_drop_ammo")
				net.WriteEntity(lootEnt)
				net.WriteFloat(tonumber(ammo))
				net.SendToServer()
			end
			action:Open()
		end
		button.DoRightClick = button.DoClick
	end
end)
