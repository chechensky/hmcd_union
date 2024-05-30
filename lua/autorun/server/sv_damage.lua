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
    print("ammo", dmginfo:GetAmmoType())

    dmg_d = dmginfo:GetDamage()
    if dmginfo:IsDamageType(DMG_BULLET+DMG_BUCKSHOT+DMG_SNIPER) then
        dmg_d = dmg_d * 3.5
        ply.Bleed = ply.Bleed + math.random(5, 10)
    elseif dmginfo:IsDamageType(DMG_SLASH+DMG_CLUB+DMG_BLAST+DMG_CRUSH) then
        dmg_d = dmg_d * 1.2
    end

    local force_hit = dmg_d / math.random(2.1, 3.2)
    ply.bullet_force = ply.bullet_force + force_hit
    ply.pain = ply.pain + force_hit

    if dmginfo:IsDamageType(DMG_SLASH+DMG_BULLET+DMG_BUCKSHOT+DMG_SNIPER) then
        for i = 1, 5 do
        end
    end

    if hitgroup == HITGROUP_HEAD and dmginfo:GetDamageType() == DMG_CRUSH and dmginfo:GetDamage() >= 6 and ent:GetVelocity():Length() > 200 then
        ply:ChatPrint("Your neck is broken")
        ent:EmitSound("neck_snap_01.wav",511,100,1,CHAN_ITEM)
        ply:Kill()
        return
    end

    if dmginfo:GetDamage() >= 50 or (dmginfo:GetDamageType() == DMG_CRUSH and dmginfo:GetDamage() >= 20 and ent:GetVelocity():Length() > 700) then
        local brokenLeftLeg = hitgroup == HITGROUP_LEFTLEG
        local brokenRightLeg = hitgroup == HITGROUP_RIGHTLEG
        local brokenLeftArm = hitgroup == HITGROUP_LEFTARM
        local brokenRightArm = hitgroup == HITGROUP_RIGHTARM

        local sub = dmginfo:GetDamage() / 120
        if brokenLeftArm and ply.Bones['LeftArm']>=1 then
            ply:ChatPrint("Your left arm is broken")
            ply.pain = ply.pain + 120
            ply.Bones['LeftArm'] = ply.Bones['LeftArm'] - sub
            ent:EmitSound("npc/barnacle/neck_snap2.wav",70,65,0.4,CHAN_ITEM)
        end

        if brokenRightArm and ply.Bones['RightArm']>=1 then
            ply:ChatPrint("Your right arm is broken")
            ply.pain = ply.pain + 120
            ply.Bones['RightArm'] = ply.Bones['RightArm'] - sub
            ent:EmitSound("npc/barnacle/neck_snap1.wav",70,65,0.4,CHAN_ITEM)
        end

        if brokenLeftLeg and ply.Bones['LeftLeg']>=1 then
            ply:ChatPrint("Your left leg is broken")
            ply.pain = ply.pain + 120
            ply.Bones['LeftLeg'] = ply.Bones['LeftLeg'] - sub
            ent:EmitSound("npc/barnacle/neck_snap1.wav",70,65,0.4,CHAN_ITEM)
            
            if ply.Bones['LeftLeg'] < 1 and !ply.fake then
                Faking(ply)
            end
        end

        if brokenRightLeg and ply.Bones['RightLeg']>=1 then
            ply:ChatPrint("Your right leg is broken")
            ply.pain = ply.pain + 120
            ply.Bones['RightLeg'] = ply.Bones['RightLeg'] - sub
            ent:EmitSound("npc/barnacle/neck_snap1.wav",70,65,0.4,CHAN_ITEM)
            
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

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Head1'))
        local brain = util.IntersectRayWithOBB(dmgpos,penetration,pos,ang,Vector(3,-3,-2),Vector(6,1,2))
        local jaw = util.IntersectRayWithOBB(dmgpos,penetration,pos,ang,Vector(-1,-5,-3),Vector(2,1,3))
        local neckartery_1 = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-3,-2,-2), Vector(0,-1,-1))
        local neckartery_2 = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-3,-2,1), Vector(0,-1,2))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine'))
        local intestines = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-4,-1,-6),Vector(1,5,6))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine1'))

        local matrix = ent:GetBoneMatrix(ent:LookupBone('ValveBiped.Bip01_Spine1'))
        local ang_spine_matrix = matrix:GetAngles()
        local pos_spine_matrix = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine1'))

        local liver = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-4,-1,-6),Vector(2,5,-1))
        local stomach = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-4,-1,-1),Vector(2,5,6))
        local spine = util.IntersectRayWithOBB(dmgpos,penetration, pos_spine_matrix, ang_spine_matrix, Vector(-8,-3,-1),Vector(2,-2,1))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_Spine2'))
        local lung = util.IntersectRayWithOBB(dmgpos,penetration,pos,ang,Vector(-1,0,-6),Vector(10,6,6))
        local heart = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(1,0,-1),Vector(5,4,3))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_L_Forearm'))
        local left_hand_artery = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-1,-2), Vector(10,0,-1))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_R_Forearm'))
        local right_hand_artery = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-2,1), Vector(10,0,2))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_L_Calf'))
        local left_leg_artery = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-1,-2), Vector(10,0,-1))

        local pos,ang = ent:GetBonePosition(ent:LookupBone('ValveBiped.Bip01_R_Calf'))
        local right_leg_artery = util.IntersectRayWithOBB(dmgpos,penetration, pos, ang, Vector(-5,-2,1), Vector(10,0,2))

        if lung then
            if !ply.Hit['lungs'] then
                ply.Hit['lungs'] = true
            end
        end

        if brain then
            if dmginfo:IsDamageType(DMG_BULLET) and not inf.RubberBullets then
                ply:Kill()
            end
        end

        if jaw then
            if ply.Bones['Jaw']>0 and dmginfo:IsDamageType(DMG_BULLET+DMG_CLUB) and not inf.RubberBullets then
                ply.Bones['Jaw']=ply.Bones['Jaw']-(dmginfo:GetDamage()/100)
                if ply.Bones['Jaw'] <= 0.6 then
                    ply:ChatPrint("Your jaw has been dislocated")
                    ply.pain = ply.pain + 150
                    if !ply.fake then
                        Faking(ply)
                    end
                end
                if ply.Bones['Jaw'] <= 0.4 then
                    ply:ChatPrint("Your jaw is broken")
                    ply.mutejaw = true
                end
            end
        end

        if liver then
            if ply.Hit['liver']!=true and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['liver'] = true
            end
        end
        
        if stomach then
            if ply.Hit['stomach'] != true and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['stomach'] = true
            end
        end
        
        if intestines then
            if ply.Hit['intestines']!=true and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['intestines'] = true
            end
        end
        
        if heart then
            if !ply.Hit['heart'] and !dmginfo:IsDamageType(DMG_CLUB) then
                ply.Hit['heart'] = true
            end
        end

        if IsValid(dmginfo:GetAttacker()) and dmginfo:IsDamageType(DMG_BULLET+DMG_SLASH+DMG_BLAST+DMG_ENERGYBEAM+DMG_NEVERGIB+DMG_ALWAYSGIB+DMG_PLASMA+DMG_AIRBOAT+DMG_SNIPER+DMG_BUCKSHOT) then 
            if neckartery_1 or neckartery_2 then
                if !ply.Hit['neck_artery'] and !dmginfo:IsDamageType(DMG_CLUB) then
                    ply.Hit['neck_artery']=true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            if left_hand_artery and !dmginfo:IsDamageType(DMG_CLUB) then
                if !ply.Hit["lh_artery"] then
                    ply.Hit["lh_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            if right_hand_artery and !dmginfo:IsDamageType(DMG_CLUB) then
                if !ply.Hit["rh_artery"] then
                    ply.Hit["rh_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            if left_leg_artery then
                if !ply.Hit["ll_artery"] then
                    ply.Hit["ll_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end

            if right_leg_artery then
                if !ply.Hit["rl_artery"] then
                    ply.Hit["rl_artery"] = true
                    sound.Play("bleeding/arteryhit.wav",ent:GetPos(),75,100)
                end
            end
        end

        if (spine) and !ply.Hit['spine'] and dmginfo:IsDamageType(DMG_BULLET+DMG_CRUSH) then
            ply.Hit['spine']=true
            timer.Simple(0.01,function()
                if !ply.fake then
                    Faking(ply)
                end
            end)
            ply:ChatPrint("Your spine is broken")
            ply.pain = ply.pain + 300
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

hook.Add("ScalePlayerDamage","FallPain", function(ply,hit,dmg)
    if hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
        if ply.bullet_force > 20 or ply.pain > 100 then
            if !ply.fake then
                Faking(ply)
            end
        end
    end
    if hit == HITGROUP_STOMACH or hit == HITGROUP_CHEST then
        if ply.bullet_force > 14 or ply.pain > 120 then
            if !ply.fake then
                Faking(ply)
            end
        end
    end
end)

local hook_run = hook.Run

timer.Create("MinusOrganismInt",3,0,function()
    for _, ply in player.Iterator() do
        hook_run("OrganismVars", ply)
    end
end)

timer.Create("PlusStamina",1.5,0,function()
    for _, ply in player.Iterator() do
        hook_run("StaminaVars", ply)
    end
end)

hook.Add("OrganismVars", "MinusOrganismInt", function(ply)
    if ply.pain < 0 then ply.pain = 0 end
    if ply.pain > 0 then
        ply.pain = ply.pain - ply.bullet_force / 5
    end
    if ply.bullet_force > 0 then
        ply.bullet_force = ply.bullet_force - 3
    end
end)

hook.Add("StaminaVars", "PlusStamina", function(ply)
    if ply.stamina['leg'] > 50 then ply.stamina['leg'] = 50 end
    if ply:GetNWFloat("Stamina_Arm", 50) > 50 then ply:SetNWFloat("Stamina_Arm", 50) end

    if ply.stamina['leg'] < 50 and !ply:IsSprinting() then
        ply.stamina['leg'] = ply.stamina['leg'] + 1.3
    end
    if ply:GetNWFloat("Stamina_Arm", 50) < 50 then
        ply:SetNWFloat("Stamina_Arm", ply:GetNWInt("Stamina_Arm") + 1.1)
    end
end)