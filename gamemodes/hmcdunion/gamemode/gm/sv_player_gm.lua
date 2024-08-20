local PlayerMeta = FindMetaTable("Player")

concommand.Add("hmcd_droprequest_ammo",function(ply,cmd,args)
	Type,Amount=args[1],tonumber(args[2])
	local Amm=ply:GetAmmoCount(Type)
	if(Amm<Amount)then Amount=Amm end
	if(Amount>0)then
		ply:DropAmmo(Type,Amount)
	end
end)

function PlayerMeta:DropAmmo(type,amt)
	if not(amt)then amt=self:GetAmmoCount(type) end
	if not(amt>0)then return end
	self:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
	self:RemoveAmmo(amt,type)
	local Ammo=ents.Create("ent_jack_hmcd_ammo")
	Ammo.HmcdSpawned=true
	Ammo.AmmoType=type
	Ammo.Rounds=amt
	Ammo:SetPos(self:GetShootPos()+self:GetAimVector()*20)
	Ammo:Spawn();Ammo:Activate()
	Ammo:GetPhysicsObject():SetVelocity(self:GetVelocity()+self:GetAimVector()*100)
end

function GM:PlayerCanHearChatVoice(listener, talker, typ)
	if GetGlobalInt("RoundState", 0) == 0 then return true end
	if not talker:Alive() then 
		return not listener:Alive()
	end
	local ply = listener

	local Wep = talker:GetActiveWeapon()
	if IsValid(Wep) and (Wep:GetClass() == "wep_jack_hmcd_walkietalkie") then
		if ply and ply:Alive() and ply:HasWeapon("wep_jack_hmcd_walkietalkie") then return true end
	end

	local dis, MaxDist = ply:GetPos():Distance(talker:GetPos()), 1300
	if not (talker:Visible(ply) or ply:Visible(talker)) then
		MaxDist = 300
	end

	if dis < MaxDist then return true end

	return false
end

function GM:PlayerCanSeePlayersChat(text, teamOnly, listener, speaker)
	if not IsValid(speaker) then return false end
	local canhear = self:PlayerCanHearChatVoice(listener, speaker)

	return canhear
end

function GM:PlayerSay(ply,text,teem)
	if ply:Team() == 1 and ply:Alive() and GetGlobalInt("RoundState", 0) != 0 then

		local Wep, WalkieTalkie = ply:GetActiveWeapon(), false
		if IsValid(Wep) and (Wep:GetClass() == "wep_jack_hmcd_walkietalkie") then
			WalkieTalkie = true
		end

		local col = ply:GetPlayerColor()
		for k, ply2 in player.Iterator() do
			local can = hook.Call("PlayerCanSeePlayersChat", GAMEMODE, text, teem, ply2, ply)
			if can then
				local ct = ChatText()
				if WalkieTalkie then
					ct:Add("Walkie Talkie", color_white)
				else
					ct:Add(ply:GetNWString("Character_Name"), Color(col.x * 255, col.y * 255, col.z * 255))
				end

				ct:Add(": " .. text, color_white)
				ct:Send(ply2)
				if WalkieTalkie then
					sound.Play("snd_jack_hmcd_walkietalkie.wav", ply2:GetShootPos(), 50, 100)
				end
			end
		end

		return false
	end
	return true
end

function GM:PlayerLeavePlay(ply)
	if ply:HasWeapon("wep_jack_hmcd_smallpistol") then
		ply:DropWeapon(ply:GetWeapon("wep_jack_hmcd_smallpistol"))
	end

	if GetGlobalInt("RoundState", 0) == 1 then
		if ply.Role == "Traitor" then
			GAMEMODE:EndRound(2, ply)
		end
	end
end

function GM:PlayerOnChangeTeam(ply, newTeam, oldTeam)
	if oldTeam == 2 then
		GAMEMODE:PlayerLeavePlay(ply)
	end

	if newteam == 1 then end
	ply:KillSilent()
end