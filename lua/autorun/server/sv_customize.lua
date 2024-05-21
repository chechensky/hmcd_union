
util.AddNetworkString("open_appmenu")

function OpenAppMenu(ply, cmd, args)
	net.Start("open_appmenu")
	net.Send(ply)
end

concommand.Add("customize", OpenAppMenu)

local function ManualIdentity(ply, name, args)
	local Maudel, R, G, B, ProperName, Clothes, Vosemnot, Rost, Accs = args[1], tonumber(args[2]), tonumber(args[3]), tonumber(args[4]), "", args[5], args[6], args[7], args[8]
	if not (Maudel and R and B and G and Clothes and Vosemnot and Rost and Accs) then
		ply:PrintMessage(HUD_PRINTTALK, "чо какая то ашибка!")
		return
	end
	if not table.HasValue(Models_Customize, Maudel) then
		ply:PrintMessage(HUD_PRINTTALK, "Не верная модель персонажа.")
		return
	end
	if not (((R >= 0) and (R <= 1)) and ((G >= 0) and (G <= 1)) and ((B >= 0) and (B <= 1))) then
		ply:PrintMessage(HUD_PRINTTALK, "Установите верный цвет.")

		return
	end
	if not table.HasValue(Clothes_Customize, Clothes) then
		ply:PrintMessage(HUD_PRINTTALK, "Не верная одежда.")
		return
	end

	if Accs == "Accessory" then
		ply:PrintMessage(HUD_PRINTTALK, "Аксессуары ну типа выбери.")
		return
	end

	ply.CustomModel = Maudel
	ply.CustomColor = Vector(R, G, B)
	ply.CustomClothes = Clothes
	ply.CustomAccessory = Accs
	ply.CustomName = Vosemnot
	ply.Rost = Rost
	local cl_playermodel, playerModel = ply:GetInfo("cl_playermodel"), table.Random(PlayerModelInfoTable)
	for key, maudhayle in pairs(PlayerModelInfoTable) do
		if maudhayle.model == ply.CustomModel then
			playerModel = maudhayle
			break
		end
	end
end
concommand.Add("customize_manual", ManualIdentity)