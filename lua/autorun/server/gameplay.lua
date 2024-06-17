local CTime = CurTime()
hook.Add("PlayerTick", "Glaza", function (ply)
    ply:SetEyeTarget(ply:GetEyeTrace().HitPos)
end)

hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
	if ply:IsSprinting() and foot == 0 then
		ply:ViewPunch(Angle((ply.Bones["LeftLeg"] < 1 and 3) or 1,0,0))
	elseif ply:IsSprinting() and foot == 1 then
		ply:ViewPunch(Angle((ply.Bones["RightLeg"] < 1 and 3) or 1,0,0))
	end
end)

hook.Add("PropBreak", "SystemLoot", function(ply, prop)
	local pos = prop:GetPos()
    local chance_empty = math.random(1,100)

	local hdrop
	local drop

	if ply:GetNWInt("RoundType", 1) == 5 then
		hdrop = table.Random(HeavyBox_DropGunFreeZone)
		drop = table.Random(Box_DropGunFreeZone)
	else
		hdrop = table.Random(HeavyBox_Drop)
		drop = table.Random(Box_Drop)
	end

	if table.HasValue(HeavyBox_Models, prop:GetModel()) and chance_empty > 60 then
		local heavyloot = ents.Create(hdrop)
		heavyloot:SetPos(pos+Vector(0,0,5))
		heavyloot:Activate()
		heavyloot:Spawn()
	end
	if table.HasValue(Box_Models, prop:GetModel()) then
		local loot = ents.Create(drop)
		loot:SetPos(pos+Vector(0,0,5))
		
		if drop == "ent_jack_hmcd_ammo" then
			loot.HmcdSpawned=true
			loot.AmmoType=table.Random(AmmoType_Drop)
			loot.Rounds=math.random(1,20)
		end

		loot:Activate()
		loot:Spawn()
	end
end)

hook.Add("PlayerPostThink", "CapsicumWork", function(ply)
	ply.capsicumminus = ply.capsicumminus or CTime
	if ply.capsicum < 0 then ply.capsicum = 0 end
	if ply.capsicum > 0.1 then
		ply:ScreenFade(SCREENFADE.IN, color_black, 1, 3)
		if ply.capsicumminus < CTime then
			ply.capsicumminus = ply.capsicumminus + 0.08
			ply.capsicum = ply.capsicum - 0.3
		end
	end
end)

hook.Add("PlayerUse", "RealPropTake", function(ply,prop)
	timer.Simple(4, function()
		ply.click = false
	end)
	if ply.click then return end
	ply.click = true
	if prop:GetModel() == "models/props_junk/CinderBlock01a.mdl" or prop:GetModel() == "models/props_junk/cinderblock01a.mdl" or prop:GetModel() == "models/props/de_inferno/cinderblock.mdl" then
		prop:Remove()
		ply:Give("wep_jack_hmcd_brick")
	end
	if prop:GetModel() == "models/props/de_nuke/cinderblock_stack.mdl" then
		for i = 1, 5 do
			local brick = ents.Create("prop_physics")
			brick:SetModel("models/props_junk/CinderBlock01a.mdl")
			brick:Activate()
			brick:Spawn()
			brick:SetPos(prop:GetPos()+Vector(math.random(-5, 5),math.random(-5, 5),60))
			brick:GetPhysicsObject():ApplyForceCenter(VectorRand())
		end
		prop:Remove()
	end

	local class = prop:GetClass()

	if class == "prop_physics" or class=="prop_physics_multiplayer" or class == "func_physbox" then
		local PhysObj = prop:GetPhysicsObject()
		if PhysObj and PhysObj.GetMass and PhysObj:GetMass() > 100 then return false end
	end

	if ply.fake then return false end
end)

local function WorkOtrub(ply)
	if ply.Blood <= 3100 or ply.pain >= 250 or ply.o2 <= 0.4 then
		ply.Otrub = true
		ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 0.5)
		ply:SetDSP(14)
	else 
		ply.Otrub = false 
		ply:SetDSP(1) 
	end
end

hook.Add("Player Think", "Otrub", function(ply)
	if !ply:Alive() then return end
	if ply.Otrub and !ply.fake then Faking(ply) end
	WorkOtrub(ply)
end)

hook.Add("PlayerPostThink", "Glazkiotrub", function(ply)
	local rag = ply:GetNWEntity("Ragdoll")
	if IsValid(rag) then 
		if ply.Otrub then
			rag:SetFlexWeight(9, 11)
		else
			rag:SetFlexWeight(9, 0)
		end
	end
end)

hook.Add("SpawnMenuOpen", "RestrictSpawnMenu", function()
    local ply = LocalPlayer()
    if not (ply:IsAdmin() or ply:IsSuperAdmin()) then
        return false
    end
end)

hook.Add("PlayerButtonDown", "F1_ShowHelp", function(ply, button)
    if button == KEY_F1 then
        ply:ConCommand("gm_showhelp")
    end
end)

hook.Add("Move", "FakeBecauseHitWall", function(ply,mv)
    --[[local speed = mv:GetVelocity():LengthSqr()
    local need = 75000
    if speed > need then
        local trace = util.TraceLine({
            start = ply:GetPos(),
            endpos = ply:GetPos() + ply:GetForward() * 20 + ply:GetUp() * 4,
            filter = ply
        })

        if trace.Hit then
			if !ply.fake then
				Faking(ply)
			end
        end
    end]]--
end)

hook.Add("Think", "CheckPlayerCollisionSpeed", function()
    --[[for _, ply in ipairs(player.GetAll()) do
        if not IsValid(ply) or not ply:Alive() then continue end

        local pos = ply:GetPos()
        local forward = ply:GetForward()
        local trace = util.TraceHull({
            start = pos,
            endpos = pos + forward * 20 + ply:GetUp() * 8,
            mins = ply:OBBMins(),
            maxs = ply:OBBMaxs(),
            filter = ply
        })

        if trace.Hit then
            local speed = ply:GetVelocity():Length()
			if speed > 300 then
				if !ply.fake then
					Faking(ply)
				end
			end
        end
    end]]--
end)

concommand.Add("hmcd_holdbreath", function(ply)
	if not ply:Alive() then return end
	local breath = ply:GetNWBool("Breath", true)
	if breath then
		ply:SetNWBool("Breath", false)
	else
		ply:SetNWBool("Breath", true)
	end
end)