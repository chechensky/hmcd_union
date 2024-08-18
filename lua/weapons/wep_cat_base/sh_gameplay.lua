if SERVER then
	concommand.Add("suicide", function(ply, cmd, args)
		if not (ply or IsValid(ply) or ply:Alive()) then return end
		if ply.suiciding then
			ply.suiciding = false
		else
			ply.suiciding = true
		end
		local wep = ply:GetActiveWeapon()
		if not (wep.SuicidePos and wep.SuicideAng) or wep:GetNWBool("GhostSuiciding") or not wep:GetReady() then return end
		if IsValid(wep) and wep.GetSuiciding then
			if wep:GetSuiciding() then
				wep:SetSuiciding(false)
				ply:SetDSP(0)
			else
				if not (wep:GetNWBool("Suppressor") and wep.SuicideType == "Rifle") then
					wep:SetSuiciding(true)
					ply:SetDSP(130)
				else
					ply:ChatPrint("Your weapon is too long. Take the suppressor off.")
				end
			end
		end
	end)
end