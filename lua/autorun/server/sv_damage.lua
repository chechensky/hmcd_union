print("no empty")

-- damage ??

local filterEnt
local function filter(ent)
	return ent == filterEnt
end

local util_TraceLine = util.TraceLine

function GetPhysicsBoneDamageInfo(ent,dmgInfo)
	local pos = dmgInfo:GetDamagePosition()
	local dir = dmgInfo:GetDamageForce():GetNormalized()

	dir:Mul(1024 * 8)

	local tr = {}
	tr.start = pos
	tr.endpos = pos + dir
	tr.filter = filter
	filterEnt = ent
	tr.ignoreworld = true

	local result = util_TraceLine(tr)
	if result.Entity ~= ent then
		tr.endpos = pos - dir

		return util_TraceLine(tr).PhysicsBone
	else
		return result.PhysicsBone
	end
end

local NULLENTITY = Entity(-1)

hook.Add("EntityTakeDamage","ragdamage",function(ent,dmginfo)
	if IsValid(ent:GetPhysicsObject()) and dmginfo:IsDamageType(DMG_BULLET+DMG_BUCKSHOT+DMG_CLUB+DMG_GENERIC+DMG_BLAST) then ent:GetPhysicsObject():ApplyForceOffset(dmginfo:GetDamageForce() / 2,dmginfo:GetDamagePosition()) end
	local ply = RagdollOwner(ent) or ent

	if not ply or not ply:IsPlayer() or not ply:Alive() or ply:HasGodMode() then
		return
	end

	local rag = ply ~= ent and ent

	if rag and dmginfo:IsDamageType(DMG_CRUSH) and att and att:IsRagdoll() then
		dmginfo:SetDamage(0)

		return true
	end
	local physics_bone = GetPhysicsBoneDamageInfo(ent,dmginfo)
	local hitgroup
	local isfall

	local bonename = ent:GetBoneName(ent:TranslatePhysBoneToBone(physics_bone))
	ply.LastHitBoneName = bonename

	if bonetohitgroup[bonename] then hitgroup = bonetohitgroup[bonename] end

	local mul = RagdollDamageBoneMul[hitgroup]

	if rag and mul then dmginfo:ScaleDamage(mul) end

	local entAtt = dmginfo:GetAttacker()
	local att =
		(entAtt:IsPlayer() and entAtt:Alive() and entAtt) or
		(entAtt:GetClass() == "wep" and entAtt:GetOwner())-- or
	att = dmginfo:GetDamageType() ~= DMG_CRUSH and att or ply.LastAttacker

	local Attacker = dmginfo:GetAttacker()

	local rubatPidor = DamageInfo()
	rubatPidor:SetAttacker(Attacker)
	--rubatPidor:SetInflictor(dmginfo:GetInflictor())
	rubatPidor:SetDamage(dmginfo:GetDamage())
	rubatPidor:SetDamageType(dmginfo:GetDamageType())
	rubatPidor:SetDamagePosition(dmginfo:GetDamagePosition())
	rubatPidor:SetDamageForce(dmginfo:GetDamageForce())

	ply.LastDMGInfo = rubatPidor

	dmginfo:ScaleDamage(2)
	hook.Run("HOOK_UNION_Damage",ply,hitgroup,dmginfo,rag)
	dmginfo:ScaleDamage(2)
	if rag then
		if dmginfo:GetDamageType() == DMG_CRUSH then
			dmginfo:ScaleDamage(1 / 40 / 15)
		end

		ply:SetHealth(ply:Health() - dmginfo:GetDamage())

		if ply:Health() <= 0 then ply:Kill() end
	end
end)

--------------------------------------------------------

-- damage you base

hook.Add("HOOK_UNION_Damage","Hit",function(ply,hitgroup,dmginfo,rag)
    local ent = rag or ply
    local inf = dmginfo:GetInflictor()
    print(rag)
    if dmginfo:IsDamageType(DMG_SLASH+DMG_BULLET+DMG_BUCKSHOT+DMG_SNIPER) then
        for i = 1, 5 do
            --на месте этой строки была фича на прописку эффектов крови(ent:GetPos() + VectorRand(-5,5),VectorRand(-15,15))
        end
    end
    if hitgroup == HITGROUP_HEAD then

        if
            dmginfo:GetDamageType() == DMG_CRUSH and
            dmginfo:GetDamage() >= 6 and
            ent:GetVelocity():Length() > 800
        then
            ply:ChatPrint("Your Neck is broken")
            ent:EmitSound("neck_snap_01.wav",511,100,1,CHAN_ITEM)
            dmginfo:ScaleDamage(300)
            if ply:Alive() then
                Faking(ply)
            end
            return
        end
    end
    if dmginfo:GetDamage() >= 50 or (dmginfo:GetDamageType() == DMG_CRUSH and dmginfo:GetDamage() >= 6 and ent:GetVelocity():Length() > 700) then
        local brokenLeftLeg = hitgroup == HITGROUP_LEFTLEG
        local brokenRightLeg = hitgroup == HITGROUP_RIGHTLEG
        local brokenLeftArm = hitgroup == HITGROUP_LEFTARM
        local brokenRightArm = hitgroup == HITGROUP_RIGHTARM

        local sub = dmginfo:GetDamage() / 120
        if brokenLeftArm and ply.Bones['LeftArm']>=1 then
            ply:ChatPrint("Your Left Arm is broken")
            ply.Bones['LeftArm'] = ply.Bones['LeftArm'] - sub
            if ply.ModelSex == "male" then sound.Play("vo/npc/male01/myarm02.wav", ent:GetPos(), 75, 100) else sound.Play("vo/npc/female01/myarm02.wav", ent:GetPos(), 75, 100) end
            ent:EmitSound("neck_snap_01.wav",70,65,0.4,CHAN_ITEM)
        end

        if brokenRightArm and ply.Bones['RightArm']>=1 then
            ply:ChatPrint("Your Right Arm is broken")
            ply.Bones['RightArm'] = ply.Bones['RightArm'] - sub
            if ply.ModelSex == "male" then sound.Play("vo/npc/male01/myarm01.wav", ent:GetPos(), 75, 100) else sound.Play("vo/npc/female01/myarm01.wav", ent:GetPos(), 75, 100) end
            ent:EmitSound("neck_snap_01.wav",70,65,0.4,CHAN_ITEM)
        end

        if brokenLeftLeg and ply.Bones['LeftLeg']>=1 then
            ply:ChatPrint("Your Left Leg is broken")
            ply.Bones['LeftLeg'] = ply.Bones['LeftLeg'] - sub
            ent:EmitSound("neck_snap_01.wav",70,65,0.4,CHAN_ITEM)
            if ply.ModelSex == "male" then sound.Play("vo/npc/male01/myleg01.wav", ent:GetPos(), 75, 100) else sound.Play("vo/npc/female01/myleg01.wav", ent:GetPos(), 75, 100) end
            
            if ply.Bones['LeftLeg'] < 1 and !ply.fake then
                Faking(ply)
            end
        end

        if brokenRightLeg and ply.Bones['RightLeg']>=1 then
            ply:ChatPrint("Your Right Leg is broken")
            ply.Bones['RightLeg'] = ply.Bones['RightLeg'] - sub
            ent:EmitSound("neck_snap_01.wav",70,65,0.4,CHAN_ITEM)
            if ply.ModelSex == "male" then sound.Play("vo/npc/male01/myleg02.wav", ent:GetPos(), 75, 100) else sound.Play("vo/npc/female01/myleg02.wav", ent:GetPos(), 75, 100) end
            
            if ply.Bones['RightLeg'] < 1 and !ply.fake then
                Faking(ply)
            end
        end
    end

    local penetration = dmginfo:GetDamageForce()
    if dmginfo:IsDamageType(DMG_BULLET + DMG_SLASH) then
        penetration:Mul(3)
    else
        penetration:Mul(0.004)
    end
    if not rag or (rag and not dmginfo:IsDamageType(DMG_CRUSH)) then
        local dmg = dmginfo:GetDamage()

        local dmgpos = dmginfo:GetDamagePosition()

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine2'))
        local huy = util.IntersectRayWithOBB(dmgpos,penetration,pos,ang,Vector(-1,0,-6),Vector(10,6,6))
        
        if huy then
            if !ply.Hit['lungs'] then
                ply.Hit['lungs'] = true
            end
        end

        if brainluti then
            if dmginfo:IsDamageType(DMG_BULLET) and not inf.RubberBullets then
                ply.Hit["brain"] = true
            end
        end

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Head1'))
        local huy = util.IntersectRayWithOBB(dmgpos,penetration,pos,ang,Vector(-1,-5,-3),Vector(2,1,3))

        if huy then
            if ply.Bones['Jaw']>0 and dmginfo:IsDamageType(DMG_BULLET+DMG_CLUB) and not inf.RubberBullets then
                ply.Bones['Jaw']=ply.Bones['Jaw']-math.Rand(0.3,1)
                if ply.Bones['Jaw'] <= 0.6 then
                    if !ply.fake then
                        Faking(ply)
                    end
                end
                if ply.Bones['Jaw'] <= 0.4 then
                    ply.mutejaw = true
                end
            end
        end

        --brain
        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine1'))
        local huy = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-4,-1,-6),Vector(2,5,-1))

        if huy then --ply:ChatPrint("You were hit in the liver.")
            if ply.Hit['liver']!=true and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['liver'] = true
            end
        end
        --liver

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine1'))
        local huy = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-4,-1,-1),Vector(2,5,6))
        
        if huy then --ply:ChatPrint("You were hit in the stomach.")
            if ply.Hit['stomach'] != true and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['stomach'] = true
            end
        end
        --stomach

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine'))
        local huy = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-4,-1,-6),Vector(1,5,6))
        
        if huy then --ply:ChatPrint("You were hit in the intestines.")
            if ply.Hit['intestines']!=true and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['intestines'] = true
            end
        end

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine2'))
        local huy = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(1,0,-1),Vector(5,4,3))
        
        if huy then --ply:ChatPrint("You were hit in the heart.")
            if !ply.Hit['heart'] and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['heart'] = true
            end
        end
        --heart
        if IsValid(dmginfo:GetAttacker()) and dmginfo:IsDamageType(DMG_BULLET+DMG_SLASH+DMG_BLAST+DMG_ENERGYBEAM+DMG_NEVERGIB+DMG_ALWAYSGIB+DMG_PLASMA+DMG_AIRBOAT+DMG_SNIPER+DMG_BUCKSHOT) then 
            local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Head1'))
            local huy = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-3,-2,-2), Vector(0,-1,-1))
            local huy2 = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-3,-2,1), Vector(0,-1,2))

            if huy or huy2 then --ply:ChatPrint("You were hit in the artery.")
                if !ply.Hit['neck_artery'] and !dmginfo:IsDamageType(DMG_CLUB) then
                    ply.Hit['neck_artery']=true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_L_Forearm'))
            local handart = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-1,-2), Vector(10,0,-1))
            if handart and !dmginfo:IsDamageType(DMG_CLUB) then
                if !ply.Hit["lh_artery"] then
                    ply.Hit["lh_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_R_Forearm'))
            local handartr = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-2,1), Vector(10,0,2))
            if handartr and !dmginfo:IsDamageType(DMG_CLUB) then
                if !ply.Hit["rh_artery"] then
                    ply.Hit["rh_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_L_Calf'))
            local legcalf = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-1,-2), Vector(10,0,-1))
            if legcalf then
                if !ply.Hit["ll_artery"] then
                    ply.Hit["ll_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_R_Calf'))
            local rightcalf = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-2,1), Vector(10,0,2))
            if rightcalf then
                if !ply.Hit["rl_artery"] then
                    ply.Hit["rl_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end
        end
        --coronary artery
        local matrix = ent:GetBoneMatrix(ent:LookupBone('ValveBiped.Bip01_Spine4'))
        local ang = matrix:GetAngles()
        local pos = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine4'))
        -- up spine
        local huy = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-8,-1,-1),Vector(2,0,1))
        local matrix = ent:GetBoneMatrix(ent:LookupBone('ValveBiped.Bip01_Spine1'))
        local ang = matrix:GetAngles()
        local pos = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine1'))
        local huy2 = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-8,-3,-1),Vector(2,-2,1))
        if (huy2) and !ply.Hit['spine'] and !dmginfo:IsDamageType(DMG_CLUB) then
            ply.Hit['spine']=true
            timer.Simple(0.01,function()
                if !ply.fake then
                    Faking(ply)
                end
            end)
            ply:ChatPrint("Your Spine is broken")
            ent:EmitSound("neck_snap_01.wav",70,125,0.7,CHAN_ITEM)
        end
    end
end)

hook.Add("HOOK_UNION_Damage","BurnDamage",function(ply,hitgroup,dmginfo) 
    if dmginfo:IsDamageType( DMG_BURN ) then
        dmginfo:ScaleDamage( 5 )
    end
end)

-------------------------------------------------------------------------------

hook.Add("ScalePlayerDamage", "PainWork", function(ply,hit,dmg)
    dmg_d = dmg:GetDamage()
    if dmg:IsDamageType(DMG_BULLET+DMG_BUCKSHOT+DMG_SNIPER) then
        dmg_d = dmg_d * 5
    elseif dmg:IsDamageType(DMG_SLASH+DMG_CLUB+DMG_BLAST+DMG_CRUSH) then
        dmg_d = dmg_d * 3
    end

    local force_hit = dmg:GetDamage() / math.random(2.1, 3.2)
    ply.bullet_force = ply.bullet_force + force_hit
    ply.pain = ply.pain + force_hit


    if hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
        if ply.bullet_force > 20 or ply.pain > 100 then
            if !ply.fake then
                timer.Simple(.1,function() Faking(ply) end)
            end
        end
    end

    if hit == HITGROUP_STOMACH or hit == HITGROUP_CHEST then
        if ply.bullet_force > 14 or ply.pain > 120 then
            if !ply.fake then
                timer.Simple(.1,function() Faking(ply) end)
            end
        end
    end
end)

local hook_run = hook.Run

timer.Create("PlayerTimerCall",1,0,function()
    for _, ply in player.Iterator() do
        hook_run("PlayerTimer", ply)
    end
end)

hook.Add("PlayerTimer", "MinusInts", function(ply)
    if ply.pain > 0 then
        ply.pain = ply.pain - ply.bullet_force / 1.2
    end
    if ply.bullet_force > 0 then
        ply.bullet_force = ply.bullet_force - 3
    end
end)