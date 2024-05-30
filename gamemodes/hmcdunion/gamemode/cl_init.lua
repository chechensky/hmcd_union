include("shared.lua")
resource.AddSingleFile("resource/fonts/homicidefont.ttf")

surface.CreateFont("DefaultFont",{
	font = "Coolvetica Rg",
	size = 18,
	weight = 1100,
	outline = false
})

surface.CreateFont("Role",{
	font = "Coolvetica Rg",
	size = 48,
	weight = 1100,
	outline = false,
	shadow = true
})

surface.CreateFont("GM",{
	font = "Coolvetica Rg",
	size = 64,
	weight = 1100,
	outline = false,
	shadow = true
})

surface.CreateFont("TextYou",{
	font = "Coolvetica Rg",
	size = 30,
	weight = 1100,
	outline = false,
	shadow = true
})


surface.CreateFont("FontTargetP",{
	font = "Coolvetica Rg",
	size = 48,
	weight = 1100,
	outline = false,
	shadow = true
})

surface.CreateFont("FontBigger",{
	font = "Coolvetica Rg",
	size = 36,
	weight = 1100,
	outline = false,
	shadow = true
})

surface.CreateFont("FontBig",{
	font = "Coolvetica Rg",
	size = 25,
	weight = 1100,
	outline = false,
	shadow = true
})

surface.CreateFont("FontRadialMenu",{
	font = "Coolvetica Rg",
	size = 26,
	weight = 1100,
	antialias = true,
	italic = false
})

surface.CreateFont("FontLarge",{
	font = "Coolvetica Rg",
	size = ScreenScale(30),
	weight = 1100,
	outline = false
})

surface.CreateFont("FontSmall",{
	font = "Coolvetica Rg",
	size = ScreenScale(10),
	weight = 1100,
	outline = false
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

hook.Add("Initialize","CVarsSet", function()
	RunConsoleCommand( "cl_threaded_client_leaf_system", "1" )
	RunConsoleCommand( "cl_smooth", "0" )
	RunConsoleCommand( "mat_queue_mode", "2" )
	RunConsoleCommand( "cl_threaded_bone_setup", "1" )
	RunConsoleCommand( "gmod_mcore_test", "1" )
	RunConsoleCommand( "r_threaded_client_shadow_manager", "1" )
	RunConsoleCommand( "r_queued_post_processing", "1" )
	RunConsoleCommand( "r_threaded_renderables", "1" )
	RunConsoleCommand( "r_threaded_particles", "1" )
	RunConsoleCommand( "r_queued_ropes", "1" )
	RunConsoleCommand( "studio_queue_mode", "1" )
	RunConsoleCommand( "r_decals", "9999" )
	RunConsoleCommand( "mp_decals", "9999" )
	RunConsoleCommand( "r_queued_decals", "1" )
	RunConsoleCommand( "gm_demo_icon", "0" )
	RunConsoleCommand( "r_radiosity", "4" )
	RunConsoleCommand( "cl_cmdrate", "101" )
	RunConsoleCommand( "cl_updaterate", "101" )
	RunConsoleCommand( "cl_interp", "0.07" )
	RunConsoleCommand( "cl_interp_npcs", "0.08" )
	RunConsoleCommand( "cl_timeout", "2400" )
	RunConsoleCommand( "r_flashlightdepthres", "512" )
end)

local meta = FindMetaTable("Player")

function meta:HasGodMode() return self:GetNWBool("HasGodMode") end

hook.Add("DrawDeathNotice","NoDrawDeathNotificate",function() return false end)

function GM:RenderAccessories(ply)
	local Mod=ply:GetModel()
	if ply.Accessory == nil or !ply.Accessory then return end
	if((ply.Accessory)and not(ply.Accessory=="none")and not((ply.HeadArmor)and(ply.HeadArmor=="ACH")and(AccessoryListWithoutEmpty[ply.Accessory][5])))then
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
end

function GM:PostPlayerDraw(ply)
	if !AccessoryListWithoutEmpty[ply.Accessory] then return end
	if ply:Alive() then
		self:RenderAccessories(ply)
	end
end