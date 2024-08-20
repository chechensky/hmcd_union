include("shared.lua")
resource.AddSingleFile("resource/fonts/homicidefont.ttf")

surface.CreateFont("DefaultFont",{
    font = "Coolvetica",
    size = math.ceil(ScrW() / 38),
    weight = 500,
    antialias = true,
    italic = false
})

surface.CreateFont("Role",{
	font = "Coolvetica",
	size = 48,
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("GM",{
	font = "Coolvetica",
	size = 64,
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("TextYou",{
	font = "Coolvetica",
	size = 30,
	weight = 1100,
    antialias = true,
    italic = false
})


surface.CreateFont("FontTargetP",{
	font = "Coolvetica",
	size = 48,
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("FontBigger",{
	font = "Coolvetica",
	size = 36,
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("FontBig",{
	font = "Coolvetica",
	size = 25,
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("FontRadialMenu",{
	font = "Coolvetica",
	size = 26,
	weight = 1100,
	antialias = true,
	italic = false
})

surface.CreateFont("FontLarge",{
	font = "Coolvetica",
	size = ScreenScale(30),
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("FontSmall",{
	font = "Coolvetica",
	size = ScreenScale(10),
	weight = 1100,
    antialias = true,
    italic = false
})

surface.CreateFont("MedKitFont",{
	font = "Coolvetica",
	size = ScreenScale(7),
	weight = 150,
    antialias = true,
    italic = false
})

local view = {}

local function Identity(data)
	if not LocalPlayer().ConCommand then return end
	if file.Exists("union_appearance.txt", "DATA") then
		local RawData = string.Split(file.Read("union_appearance.txt", "DATA"), "\n")
		LocalPlayer():ConCommand("customize_manual " .. RawData[1] .. " " .. RawData[2] .. " " .. RawData[3] .. " " .. RawData[4] .. " " .. RawData[5] .. " " .. RawData[6] .. " " .. RawData[7] .. " " .. RawData[8])
	end
end

usermessage.Hook("Skin_Appearance", Identity)

hook.Add("Initialize", "CVarsSet", function() -- Вы че бараны чтоли все поголовно
	--[[RunConsoleCommand( "cl_threaded_client_leaf_system", "1" )
	RunConsoleCommand( "cl_smooth", "0" )
	RunConsoleCommand( "mat_queue_mode", "2" )
	RunConsoleCommand( "cl_threaded_bone_setup", "1" )
	RunConsoleCommand( "gmod_mcore_test", "1" )
	RunConsoleCommand( "r_threaded_client_shadow_manager", "1" )
	RunConsoleCommand( "r_queued_post_processing", "1" )
	RunConsoleCommand( "r_threaded_renderables", "1" )
	RunConsoleCommand( "r_threaded_particles", "1" )
	RunConsoleCommand( "r_queued_ropes", "1" )
	RunConsoleCommand( "studio_queue_mode", "1" )]]
	RunConsoleCommand( "r_decals", "9999" )
	RunConsoleCommand( "mp_decals", "9999" )
	RunConsoleCommand( "r_queued_decals", "1" )
	RunConsoleCommand( "gm_demo_icon", "0" )
	RunConsoleCommand("sv_alltalk", "2")
	--[[RunConsoleCommand( "r_radiosity", "4" )
	RunConsoleCommand( "cl_cmdrate", "101" )
	RunConsoleCommand( "cl_updaterate", "101" )
	RunConsoleCommand( "cl_interp", "0.07" )
	RunConsoleCommand( "cl_interp_npcs", "0.08" )
	RunConsoleCommand( "cl_timeout", "2400" )
	RunConsoleCommand( "r_flashlightdepthres", "512" )]]
end)

local meta = FindMetaTable("Player")

function meta:HasGodMode() return self:GetNWBool("HasGodMode") end

hook.Add("DrawDeathNotice","NoDrawDeathNotificate",function() return false end)

function GM:RenderAccessories(ply)
	local Mod=ply:GetModel()
	if ply.Accessory == nil or !ply.Accessory then return end
	if ply.Accessory and not ply.Accessory=="none" and not (ply:GetNWString("Helmet") and ply:GetNWString("Mask") and AccessoryListWithoutEmpty[ply.Accessory][5]) then
		local AccInfo=AccessoryListWithoutEmpty[ply.Accessory]
		if AccInfo[1] == nil or AccInfo[1] == "" then return end
		if(ply.AccessoryModel)then
			local PosInfo=nil
			if(ply.ModelSex=="male")then PosInfo=AccInfo[3] elseif(ply.ModelSex=="female")then PosInfo=AccInfo[4] end
			local Pos,Ang=ply:GetBonePosition(ply:LookupBone(AccInfo[2]))
			if((Pos)and(Ang))then
				Pos=Pos+Ang:Right()*PosInfo[1].x+Ang:Forward()*PosInfo[1].y+Ang:Up()*PosInfo[1].z
				Ang:RotateAroundAxis(Ang:Right(),PosInfo[2].p)
				Ang:RotateAroundAxis(Ang:Up(),PosInfo[2].y)
				Ang:RotateAroundAxis(Ang:Forward(),PosInfo[2].r)
				ply.AccessoryModel:SetRenderOrigin(Pos)
				ply.AccessoryModel:SetRenderAngles(Ang)
				local Scale,Matr=nil,Matrix()
				if(ply.ModelSex=="male")then Scale=AccInfo[3][3] elseif(ply.ModelSex=="female")then Scale=AccInfo[4][3] end
				Matr:Scale(Vector(Scale,Scale,Scale))
				ply.AccessoryModel:EnableMatrix("RenderMultiply",Matr)
				ply.AccessoryModel:DrawModel()
			end
		else
			ply.AccessoryModel=ClientsideModel(AccInfo[1])
			ply.AccessoryModel:SetPos(ply:GetPos())
			ply.AccessoryModel:SetParent(ply)
			ply.AccessoryModel:SetSkin(AccInfo[6])
			local Mats=ply.AccessoryModel:GetMaterials()      -- garry, fuck you
			for key,mat in pairs(Mats)do                      -- robotboy, fuck you too
				ply.AccessoryModel:SetSubMaterial(key-1,mat)  -- i shouldn't have to do this
			end                                               -- you stupid bastards
			ply.AccessoryModel:SetNoDraw(true)
		end
	end
	if ply:IsPlayer() then
		local Weps, DrawWep = ply:GetWeapons(), nil
		for key, wep in pairs(Weps) do
			if wep.HolsterSlot and (wep.HolsterSlot == 1) then
				DrawWep = wep
				break
			end
		end

		if DrawWep and (DrawWep ~= ply:GetActiveWeapon()) then
			if ply.HolsterWep and (ply.HolsterWepModelName == DrawWep.WorldModel) then
				local Pos, Ang = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Spine4"))
				if Pos and Ang then
					local Dist = 0
					if ply.ChestArmor and ((ply.ChestArmor == "Level III") or (ply.ChestArmor == "Level IIIA")) then
						Dist = 2
					end

					Pos = Pos + Ang:Right() * (DrawWep.HolsterPos.x + Dist) + Ang:Forward() * DrawWep.HolsterPos.y + Ang:Up() * DrawWep.HolsterPos.z
					Ang:RotateAroundAxis(Ang:Right(), DrawWep.HolsterAng.p)
					Ang:RotateAroundAxis(Ang:Up(), DrawWep.HolsterAng.y)
					Ang:RotateAroundAxis(Ang:Forward(), DrawWep.HolsterAng.r)
					ply.HolsterWep:SetRenderOrigin(Pos)
					ply.HolsterWep:SetRenderAngles(Ang)
					ply.HolsterWep:DrawModel()
				end
			else
				ply.HolsterWep = ClientsideModel(DrawWep.WorldModel)
				ply.HolsterWepModelName = DrawWep.WorldModel
				ply.HolsterWep:SetPos(ply:GetPos())
				ply.HolsterWep:SetParent(ply)
				local Mats = ply.HolsterWep:GetMaterials()
				for key, mat in pairs(Mats) do
					ply.HolsterWep:SetSubMaterial(key - 1, mat)
				end

				ply.HolsterWep:SetNoDraw(true)
			end
		end
	end
end

function GM:RenderArmor(ply)
	local Mod=ply:GetModel()
	
	if ply:GetNWString("Bodyvest", "") == "Level IIIA" or ply:GetNWString("Bodyvest", "") == "Level III" then
		if ply.Bodyvest then
			local Pos, Ang = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Spine4"))
			if Pos and Ang then
				local Dist, Down = 12, 46
				if ply.ModelSex == "male" then
					Dist = 12.5
					Down = 50
				end

				Pos = Pos - Ang:Forward() * Down - Ang:Right() * Dist + Ang:Up() * 0
				ply.Bodyvest:SetRenderOrigin(Pos)
				Ang:RotateAroundAxis(Ang:Up(), 80)
				Ang:RotateAroundAxis(Ang:Forward(), 90)
				ply.Bodyvest:SetRenderAngles(Ang)
				
				if ply:GetNWString("Bodyvest", "") == "Level III" then render.SetColorModulation(.3, .3, .3) end
				ply.Bodyvest:DrawModel()

				local R, G, B = render.GetColorModulation()
				render.SetColorModulation(R, G, B)
			end
		else
			ply.Bodyvest = ClientsideModel("models/sal/acc/armor01.mdl")
			--ply.Bodyvest:SetMaterial("models/mat_jack_hmcd_armor")
			ply.Bodyvest:SetPos(ply:GetPos())
			ply.Bodyvest:SetParent(ply)
			ply.Bodyvest:SetNoDraw(true)
			local Scale = 1
			if ply.ModelSex == "female" then
				Scale = Scale * .8
			else
				Scale = Scale * .9
			end

			ply.Bodyvest:SetModelScale(Scale, 0)
		end
	else
		ply.Bodyvest = nil
	end

	if ply:GetNWString("Helmet", "") == "ACH" then
		if ply.Helmet then
			local Pos, Ang = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1"))
			if Pos and Ang then
				if ply.ModelSex == "male" then
					Dist = 6
				end

				Pos = Pos + Ang:Forward() * 1 + Ang:Right()
				ply.Helmet:SetRenderOrigin(Pos)
				Ang:RotateAroundAxis(Ang:Up(), -80)
				Ang:RotateAroundAxis(Ang:Forward(), -90)
				ply.Helmet:SetRenderAngles(Ang)
				local R, G, B = render.GetColorModulation()
				render.SetColorModulation(.7, .7, .7)
				ply.Helmet:DrawModel()
				render.SetColorModulation(R, G, B)
			end
		else
			ply.Helmet = ClientsideModel("models/barney_helmet.mdl")
			ply.Helmet:SetMaterial("models/mat_jack_hmcd_armor")
			ply.Helmet:SetPos(ply:GetPos())
			ply.Helmet:SetParent(ply)
			ply.Helmet:SetNoDraw(true)
			local Scale = 1
			if ply.ModelSex == "female" then
				Scale = Scale * .9
			end

			ply.Helmet:SetModelScale(Scale, 0)
		end
	else
		ply.Helmet = nil
	end

	if ply:GetNWString("Mask", "") == "NVG" then
		if ply.NVG then
			local Pos, Ang = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1"))
			if Pos and Ang then
				if ply.ModelSex == "male" then
					Dist = 6
				end

				Pos = Pos + Ang:Forward() * 1 + Ang:Right() * 0
				ply.NVG:SetRenderOrigin(Pos)
				if ply:GetNWBool("NVG_Up", false) then
					Ang:RotateAroundAxis(Ang:Up(), -70)
					Ang:RotateAroundAxis(Ang:Forward(), -90)
				else
					Ang:RotateAroundAxis(Ang:Up(), -80)
					Ang:RotateAroundAxis(Ang:Forward(), -90)
				end
				ply.NVG:SetRenderAngles(Ang)
				local R, G, B = render.GetColorModulation()
				render.SetColorModulation(.7, .7, .7)
				ply.NVG:DrawModel()
				render.SetColorModulation(R, G, B)
			end
		else
			ply.NVG = ClientsideModel("models/arctic_nvgs/nvg_gpnvg.mdl")
			ply.NVG:SetPos(ply:GetPos())
			ply.NVG:SetParent(ply)
			ply.NVG:SetNoDraw(true)
			local Scale = 1
			if ply.ModelSex == "female" then
				Scale = Scale * .9
			end

			ply.NVG:SetModelScale(Scale, 0)
		end
	else
		ply.NVG = nil
	end

	if ply:GetNWBool("Headcrab", false) then
		if ply.HeadCrab then
			local Pos, Ang = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1"))
			if Pos and Ang then
				if ply.ModelSex == "male" then
					Dist = 6
				end

				Pos = Pos + Ang:Forward() * 2 + Ang:Right() * 5
				ply.HeadCrab:SetRenderOrigin(Pos)
				Ang:RotateAroundAxis(Ang:Up(), -80)
				Ang:RotateAroundAxis(Ang:Forward(), -90)
				ply.HeadCrab:SetRenderAngles(Ang)
				local R, G, B = render.GetColorModulation()
				render.SetColorModulation(.7, .7, .7)
				ply.HeadCrab:DrawModel()
				render.SetColorModulation(R, G, B)
			end
		else
			ply.HeadCrab = ClientsideModel("models/headcrabclassic.mdl")
			ply.HeadCrab:SetPos(ply:GetPos())
			ply.HeadCrab:SetParent(ply)
			ply.HeadCrab:SetNoDraw(true)
			local Scale = .8
			if ply.ModelSex == "female" then
				Scale = Scale * .7
			end

			ply.HeadCrab:SetModelScale(Scale, 0)
		end
	else
		ply.HeadCrab = nil
	end
end
function GM:PostPlayerDraw(ply)
	if !AccessoryListWithoutEmpty[ply.Accessory] then return end
	if ply:Alive() then
		self:RenderAccessories(ply)
		self:RenderArmor(ply)
	end
end

function GM:PostDrawOpaqueRenderables(drawingDepth, drawingSkybox)
	for key, ply in player.Iterator() do
		if ply ~= LocalPlayer() then
			if !ply:GetNWBool("fake") then
				self:RenderArmor(ply)
			end
		end
	end
end

net.Receive(
	"chattext_msg",
	function(len)
		local msgs = {}
		while true do
			local i = net.ReadUInt(8)
			if i == 0 then break end
			local str = net.ReadString()
			local col = net.ReadVector()
			table.insert(msgs, Color(col.x, col.y, col.z))
			table.insert(msgs, str)
		end

		chat.AddText(unpack(msgs))
	end
)

net.Receive(
	"msg_clients",
	function(len)
		local lines = {}
		while net.ReadUInt(8) ~= 0 do
			local r = net.ReadUInt(8)
			local g = net.ReadUInt(8)
			local b = net.ReadUInt(8)
			local text = net.ReadString()
			table.insert(
				lines,
				{
					color = Color(r, g, b),
					text = text
				}
			)
		end

		for k, line in pairs(lines) do
			MsgC(line.color, line.text)
		end
	end
)

hook.Add("Think", "Effects", function()
	local Time = CurTime()
	local ply, DrawNVGlamp = LocalPlayer(), false

		if ply:Alive() then
			if ply:GetNWString("Mask") == "NVG" and !ply:GetNWBool("NVG_Up") then
				DrawNVGlamp = true
				if not IsValid(ply.NVGLamp) then
					ply.NVGLamp = ProjectedTexture()
					ply.NVGLamp:SetTexture("effects/flashlight001")
					ply.NVGLamp:SetBrightness(.2)
				else
					local Dir = ply:GetAimVector()
					local Ang = Dir:Angle()
					ply.NVGLamp:SetPos(EyePos() + Dir * 120)
					ply.NVGLamp:SetAngles(Ang)
					local FoV = 300
					ply.NVGLamp:SetFOV(FoV)
					ply.NVGLamp:SetFarZ(300)
					ply.NVGLamp:Update()
				end
			end
		end

	if not DrawNVGlamp then
		if IsValid(ply.NVGLamp) then
			ply.NVGLamp:Remove()
		end
	end
end)

hook.Add("RenderScreenspaceEffects", "Effects", function()
	local ply, FT, SelfPos, Time, W, H = LocalPlayer(), FrameTime(), EyePos(), CurTime(), ScrW(), ScrH()	
	if ply:GetNWString("Mask") == "NVG" and !ply:GetNWBool("NVG_Up") then
		if !ply:GetNWBool("NVG_WereOn") then
			ply:EmitSound("snds_jack_gmod/tinycapcharge.wav", 55,100,1,CHAN_AUTO)
			ply:SetNWBool("NVG_WereOn", true)
			GoggleDarkness = 100
		end
		DrawColorModify({
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = .02,
			["$pp_colour_contrast"] = 6.5,
			["$pp_colour_colour"] = 0,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		})

		DrawColorModify({
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = .05,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1,
			["$pp_colour_colour"] = 1,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		})
		if GoggleDarkness > 0 then
			local Alpha = 255 * (GoggleDarkness / 100)
			surface.SetDrawColor(0, 0, 0, Alpha)
			surface.DrawRect(-1, -1, W + 2, H + 2)
			surface.DrawRect(-1, -1, W + 2, H + 2)
			surface.DrawRect(-1, -1, W + 2, H + 2)
			GoggleDarkness = math.Clamp(GoggleDarkness - FT * 100, 0, 100)
		end
	end
end)

hook.Add("HUDPaintBackground", "Effects", function()
	local ply = LocalPlayer()
	if ply:Alive() and ply:GetNWString("Mask") == "NVG" and !ply:GetNWBool("NVG_Up") then
		surface.SetMaterial(Material("mats_jack_gmod_sprites/hard_vignette.png"))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(-1, -1, ScrW() + 2, ScrH() + 2)
		surface.DrawTexturedRect(-1, -1, ScrW() + 2, ScrH() + 2)
		surface.DrawTexturedRect(-1, -1, ScrW() + 2, ScrH() + 2)
	end
end)