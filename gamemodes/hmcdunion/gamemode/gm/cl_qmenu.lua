local ments
local radialOpen = false
local prevSelected, prevSelectedVertex
function GM:OpenRadialMenu(elements)
	if not LocalPlayer():Alive() then return end
	radialOpen = true
	LocalPlayer():SetNWBool("radialopen", true)
	gui.EnableScreenClicker(true)
	ments = elements or {}
	prevSelected = nil
end

local pistol = {
	"9х19 mm Parabellum",
	"9х18 mm",
	".45 Rubber",
	"4.6x30 mm",
	"5.7x28 mm",
	".44 Remington Magnum",
	".50 AE Magnum",
	".45 acp",
	"Pistol"
}

local shotgun = {
   	"12/70 gauge",
   	"12/70 beanbag",
	"Buckshot"
}

local rifle = {
   	"5.56x45 mm",
   	"7.62x51 NATO",
   	"7.62x54 mm",
   	".308 Winchester",
   	".408 Cheyenne Tactical",
   	"12.7x99 mm",
   	"7.62x39 mm",
   	"5.45x39 mm",
	"9x39 mm",
	"AR2",
	"SMG"
}

local other = {
   	"nails"
}

function GM:CloseRadialMenu()
	radialOpen = false
	LocalPlayer():SetNWBool("radialopen", false)
	gui.EnableScreenClicker(false)
end

local function getSelected()
	local mx, my = gui.MousePos()
	local sw, sh = ScrW(), ScrH()
	local total = #ments
	local w = math.min(sw * 0.45, sh * 0.33)
	local sx, sy = sw / 2, sh / 2
	local x2, y2 = mx - sx, my - sy
	local ang = 0
	local dis = math.sqrt(x2 ^ 2 + y2 ^ 2)
	if dis / w <= 1 then
		if y2 <= 0 and x2 <= 0 then
			ang = math.acos(x2 / dis)
		elseif x2 > 0 and y2 <= 0 then
			ang = -math.asin(y2 / dis)
		elseif x2 <= 0 and y2 > 0 then
			ang = math.asin(y2 / dis) + math.pi
		else
			ang = math.pi * 2 - math.acos(x2 / dis)
		end

		return math.floor((1 - (ang - math.pi / 2 - math.pi / total) / (math.pi * 2) % 1) * total) + 1
	end
end

local function hasWeapon(ply, weaponName)
    if not IsValid(ply) or not ply:IsPlayer() then return false end
    
    for _, weapon in pairs(ply:GetWeapons()) do
        if IsValid(weapon) and weapon:GetClass() == weaponName then
            return true
        end
    end
    
    return false 
end

function GM:RadialMousePressed(code, vec)
	if radialOpen then
		local selected = getSelected()
		if selected and selected > 0 and code == MOUSE_LEFT then
			if selected and ments[selected] then
				if ments[selected].Code == "menuammo" then
					RunConsoleCommand("menu_ammo")
				elseif ments[selected].Code == "unloadwep" then
					local lply = LocalPlayer()
        			local wep = lply:GetActiveWeapon()
                	net.Start("Unload")
                	net.WriteEntity(wep)
                	net.SendToServer()
				elseif ments[selected].Code == "drop" then
					local lply = LocalPlayer()
					lply:ConCommand("say *drop")
				elseif ments[selected].Code == "phrase" then
					local lply = LocalPlayer()
					lply:ConCommand("random_phrase")
				end
			end
		end

		self:CloseRadialMenu()
	end
end

local elements
local function addElement(transCode, code)
	local t = {}
	t.TransCode = transCode
	t.Code = code
	table.insert(elements, t)
end

concommand.Add(
	"+menu_context",
	function(client, com, args, full)
		if client:Alive() then
			local Wep = client:GetActiveWeapon()
			elements = {}
			addElement("Ammo Menu","menuammo")
			addElement("RandomPhrase","phrase")
			if IsValid(Wep) then
				if Wep:GetClass() ~= "wep_jack_hmcd_hands" then addElement("Drop", "drop") end
        		if Wep:Clip1() > 0 then
					addElement("UnloadWep", "unloadwep")
				end
			end
			GAMEMODE:OpenRadialMenu(elements)
		end
	end
)

concommand.Add(
	"-menu_context",
	function(client, com, args, full)
		GAMEMODE:RadialMousePressed(MOUSE_LEFT)
	end
)

local tex = surface.GetTextureID("VGUI/white.vmt")
local function drawShadow(n, f, x, y, color, pos)
	draw.DrawText(n, f, x + 1, y + 1, color_black, pos)
	draw.DrawText(n, f, x, y, color, pos)
end

local function DrawCenteredText(text, font, x, y, color, outlineColor)
    surface.SetFont(font)
    local textWidth, textHeight = surface.GetTextSize(text)
    surface.SetTextColor(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
    surface.SetTextPos(x - textWidth / 2, y - textHeight / 2)
    surface.SetDrawColor(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
    surface.DrawText(text)

    surface.SetTextColor(color.r, color.g, color.b, color.a)
    surface.SetTextPos(x - textWidth / 2 + 1, y - textHeight / 2 + 1)
    surface.DrawText(text)
end

local function DrawAmmoIcon(material, x, y, widght, height)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( material )
    surface.DrawTexturedRect( x, y, widght, height)
end

local circleVertex
local fontHeight = draw.GetFontHeight("FontRadialMenu")
function GM:DrawRadialMenu()
	if radialOpen then
		local sw, sh = ScrW(), ScrH()
		local total = #ments
		local w = math.min(sw * 0.45, sh * 0.33)
		local h = w
		local sx, sy = sw / 2, sh / 2
		local selected = getSelected() or -1
		if not circleVertex then
			circleVertex = {}
			local max = 50
			for i = 0, max do
				local vx, vy = math.cos((math.pi * 2) * i / max), math.sin((math.pi * 2) * i / max)
				table.insert(
					circleVertex,
					{
						x = sx + w * 1 * vx,
						y = sy + h * 1 * vy
					}
				)
			end
		end

		surface.SetTexture(tex)
		local defaultTextCol = color_white
		if selected <= 0 or selected ~= selected then
			surface.SetDrawColor(20, 20, 20, 180)
		else
			surface.SetDrawColor(20, 20, 20, 120)
			defaultTextCol = Color(150, 150, 150)
		end

		surface.DrawPoly(circleVertex)
		local add = math.pi * 1.5 + math.pi / total
		local add2 = math.pi * 1.5 - math.pi / total
		for k, ment in pairs(ments) do
			local x, y = math.cos((k - 1) / total * math.pi * 2 + math.pi * 1.5), math.sin((k - 1) / total * math.pi * 2 + math.pi * 1.5)
			local lx, ly = math.cos((k - 1) / total * math.pi * 2 + add), math.sin((k - 1) / total * math.pi * 2 + add)
			local textCol = defaultTextCol
			if selected == k then
				local vertexes = prevSelectedVertex -- uhh, you mean VERTICES? Dumbass.
				if prevSelected ~= selected then
					prevSelected = selected
					vertexes = {}
					prevSelectedVertex = vertexes
					local lx2, ly2 = math.cos((k - 1) / total * math.pi * 2 + add2), math.sin((k - 1) / total * math.pi * 2 + add2)
					table.insert(
						vertexes,
						{
							x = sx,
							y = sy
						}
					)

					table.insert(
						vertexes,
						{
							x = sx + w * 1 * lx2,
							y = sy + h * 1 * ly2
						}
					)

					local max = math.floor(50 / total)
					for i = 0, max do
						local addv = (add - add2) * i / max + add2
						local vx, vy = math.cos((k - 1) / total * math.pi * 2 + addv), math.sin((k - 1) / total * math.pi * 2 + addv)
						table.insert(
							vertexes,
							{
								x = sx + w * 1 * vx,
								y = sy + h * 1 * vy
							}
						)
					end

					table.insert(
						vertexes,
						{
							x = sx + w * 1 * lx,
							y = sy + h * 1 * ly
						}
					)
				end

				surface.SetTexture(tex)
				surface.SetDrawColor(129, 129, 129, 120)
				if ment.Code == "happy" then
					surface.SetDrawColor(255, 20, 20, 120)
				elseif ment.Code == "burp" then
					surface.SetDrawColor(195, 167, 30, 120)
				elseif ment.Code == "fart" then
					surface.SetDrawColor(111, 94, 8, 120)
				elseif ment.Code == "kurare" then
					surface.SetDrawColor(192, 23, 23, 120)
				end

				surface.DrawPoly(vertexes)
				textCol = color_white
			end
			local ply = LocalPlayer()
			local Main, Sub

			if ment.TransCode == "Ammo Menu" then
				Main = "Ammo Menu"
				Sub = ""
			elseif ment.TransCode == "UnloadWep" then
				Main = "Unload Ammo"
				Sub = ""
			elseif ment.TransCode == "Drop" then
				Main = "Drop Weapon"
				Sub = ""
			elseif ment.TransCode == "RandomPhrase" then
				Main = "Random Phrase"
				Sub = ""
			else
    			Main = "?"
    			Sub = "?"
			end

			drawShadow(Main, "FontRadialMenu", sx + w * 0.6 * x, sy + h * 0.6 * y - 10, textCol, 1)
		end
	end
end