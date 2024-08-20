surface.CreateFont( "Radial_QM" , {
	font = "coolvetica",
	size = math.ceil(ScrW() / 38),
	weight = 500,
	antialias = true,
	italic = false
})

surface.CreateFont( "RadialSmall_QM" , {
	font = "coolvetica",
	size = math.ceil(ScrW() / 80),
	weight = 100,
	antialias = true,
	italic = false
})

local ments
local PhraseOpen = false
local prevSelected, prevSelectedVertex
function GM:OpenPhraseMenu(elements)
	if not LocalPlayer():Alive() then return end
	PhraseOpen = true
	LocalPlayer():SetNWBool("Phraseopen", true)
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

function GM:ClosePhraseMenu()
	PhraseOpen = false
	LocalPlayer():SetNWBool("Phraseopen", false)
	gui.EnableScreenClicker(false)
end

local function getSelected()
	local mx, my = gui.MousePos()
	local sw,sh = ScrW(), ScrH()
	local total = #ments
	local w = math.min(sw * 0.45, sh * 0.45)
	local h = w
	local sx, sy = sw / 2, sh / 2
	local x2,y2 = mx - sx, my - sy
	local ang = 0
	local dis = math.sqrt(x2 ^ 2 + y2 ^ 2)
	if dis / w <= 1 then
		if y2 <= 0 && x2 <= 0 then
			ang = math.acos(x2 / dis)
		elseif x2 > 0 && y2 <= 0 then
			ang = -math.asin(y2 / dis)
		elseif x2 <= 0 && y2 > 0 then
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

function GM:PhraseMousePressed(code, vec)
	if PhraseOpen then
		local selected = getSelected()
		if selected and selected > 0 and code == MOUSE_LEFT then
			if selected and ments[selected] then
				RunConsoleCommand("taunt", ments[selected].Code)
			end
		end

		self:ClosePhraseMenu()
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
	"+phrase",
	function(client, com, args, full)
		if client:Alive() then
			local Wep = client:GetActiveWeapon()
			elements = {}
			addElement("Help", "help")
			addElement("Random", "random")
			addElement("Happy", "happy")
			addElement("Morose", "morose")
			addElement("Response", "response")

			if LocalPlayer():GetNWString("Role") == "Traitor" then
				addElement("Villain","villain")
			elseif IsValid(Wep) and Wep:GetClass() == "wep_jack_hmcd_smallpistol" then
				addElement("Hero","hero")
			end

			GAMEMODE:OpenPhraseMenu(elements)
		end
	end
)

concommand.Add(
	"-phrase",
	function(client, com, args, full)
		GAMEMODE:PhraseMousePressed(MOUSE_LEFT)
	end
)

local tex = surface.GetTextureID("VGUI/white.vmt")
local function drawShadow(n,f,x,y,color,pos)
	draw.DrawText(n,f,x + 1,y + 1,color_black,pos)
	draw.DrawText(n,f,x,y,color,pos)
end
local function drawTextShadow(t,f,x,y,c,px,py)
	draw.SimpleText(t,f,x + 1,y + 1,Color(0,0,0,c.a),px,py)
	draw.SimpleText(t,f,x - 1,y - 1,Color(255,255,255,math.Clamp(c.a*.25,0,255)),px,py)
	draw.SimpleText(t,f,x,y,c,px,py)
end

local circleVertex
local fontHeight = draw.GetFontHeight("Radial_QM")
function GM:DrawPhraseMenu()
	if PhraseOpen then
		local sw,sh = ScrW(), ScrH()
		local total = #ments
		local w = math.min(sw * 0.45, sh * 0.45)
		local h = w
		local sx, sy = sw / 2, sh / 2

		local selected = getSelected() or -1


		if !circleVertex then
			circleVertex = {}
			local max = 50
			for i = 0, max do
				local vx, vy = math.cos((math.pi * 2) * i / max), math.sin((math.pi * 2) * i / max)

				table.insert(circleVertex, {x = sx + w* 1 * vx, y= sy + h* 1 * vy})
			end
		end

		surface.SetTexture(tex)
		local defaultTextCol = color_white
		if selected <= 0 || selected ~= selected then
			surface.SetDrawColor(20,20,20,180)
		else
			surface.SetDrawColor(20,20,20,120)
			defaultTextCol = Color(150,150,150)
		end
		surface.DrawPoly(circleVertex)

		local add = math.pi * 1.5 + math.pi / total
		local add2 = math.pi * 1.5 - math.pi / total

		for k,ment in pairs(ments) do
			local x,y = math.cos((k - 1) / total * math.pi * 2 + math.pi * 1.5), math.sin((k - 1) / total * math.pi * 2 + math.pi * 1.5)

			local lx, ly = math.cos((k - 1) / total * math.pi * 2 + add), math.sin((k - 1) / total * math.pi * 2 + add)

			local textCol = defaultTextCol
			if(ment.Code=="villain")then
				textCol=Color(200,10,10,150)
			elseif(ment.Code=="hero")then
				textCol=Color(20,200,255,150)
			end
			if selected == k then
				local vertexes = prevSelectedVertex -- uhh, you mean VERTICES? Dumbass.

				if prevSelected != selected then
					prevSelected = selected
					vertexes = {}
					prevSelectedVertex = vertexes
					local lx2, ly2 = math.cos((k - 1) / total * math.pi * 2 + add2), math.sin((k - 1) / total * math.pi * 2 + add2)

					table.insert(vertexes, {x = sx, y = sy})

					table.insert(vertexes, {x = sx + w* 1 * lx2, y= sy + h* 1 * ly2})

					local max = math.floor(50 / total)
					for i = 0, max do
						local addv = (add - add2) * i / max + add2
						local vx, vy = math.cos((k - 1) / total * math.pi * 2 + addv), math.sin((k - 1) / total * math.pi * 2 + addv)

						table.insert(vertexes, {x = sx + w* 1 * vx, y= sy + h* 1 * vy})
					end

					table.insert(vertexes, {x = sx + w* 1 * lx, y= sy + h* 1 * ly})

				end

				surface.SetTexture(tex)
				surface.SetDrawColor(20,120,255,120)
				if(ment.Code=="villain")then
					textCol=Color(255,50,50,255)
				elseif(ment.Code=="hero")then
					textCol=Color(100,225,255,255)
				end
				surface.DrawPoly(vertexes)
				textCol = color_white
			end
			local ply = LocalPlayer()
			local Main, Sub

			if ment.TransCode == "Hero" then
				Main = "Hero"
				Sub = "save the day"
			elseif ment.TransCode == "Villain" then
				Main = "Villain"
				Sub = "kill 'em all"
			elseif ment.TransCode == "Help" then
				Main = "Help"
				Sub = "scream like a girl"
			elseif ment.TransCode == "Random" then
				Main = "Random"
				Sub = "tell them"
			elseif ment.TransCode == "Morose" then
				Main = "Morose"
				Sub = "feel the sadness"
			elseif ment.TransCode == "Response" then
    			Main = "Response"
    			Sub = "answer them"
			elseif ment.TransCode == "Happy" then
    			Main = "Happy"
    			Sub = "yay"
			else
				Main = "?"
				Sub = "?"
			end
			drawShadow(Main, "Radial_QM", sx + w * 0.6 * x, sy + h * 0.6 * y - fontHeight / 3,textCol, 1)
			drawShadow(Sub, "RadialSmall_QM", sx + w * 0.6 * x, sy + h * 0.6 * y + fontHeight / 2, textCol, 1)
		end
	end
end