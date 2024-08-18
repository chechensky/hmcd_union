game.AddDecal("ChBlood1", "decals/checha/ch_blood1")
game.AddDecal("ChBlood2", "decals/checha/ch_blood2")
game.AddDecal("ChBlood3", "decals/checha/ch_blood3")
game.AddDecal("ChBlood4", "decals/checha/ch_blood4")

game.AddDecal("ArBlood1", "decals/checha/ar_blood1")
game.AddDecal("ArBlood2", "decals/checha/ar_blood2")
game.AddDecal("ArBlood3", "decals/checha/ar_blood3")
game.AddDecal("ArBlood4", "decals/checha/ar_blood4")
game.AddDecal("ArBlood5", "decals/checha/ar_blood5")

hook.Add("InitPostEntity", "loh", function() -- Ххахахахахаха
	if game.SinglePlayer() then
		if CLIENT then
			Derma_Query(
				"Дебил поставь мультиплеер",
				"Дебил поставь мультиплеер",
				"Дебил поставь мультиплеер",
				function() RunConsoleCommand("disconnect") end
			)
		else
			print("Дебил поставь мультиплеер")
			PrintMessage(HUD_PRINTTALK, "Дебил поставь мультиплеер")
		end
	end
end)

if game.SinglePlayer() then return end

game.AddParticles("particles/pcfs_jack_muzzleflashes.pcf")
game.AddParticles("particles/swb_muzzle.pcf")
game.AddParticles("particles/pcfs_jack_explosions_incendiary2.pcf")
game.AddParticles("particles/pcfs_jack_explosions_small3.pcf")

function HMCD_WhomILookinAt(ply, cone, dist)
	local CreatureTr, ObjTr, OtherTr = nil, nil, ni

	local Tr = util.QuickTrace(ply:GetShootPos(), ply:GetAimVector() * dist, {ply})

	if Tr.Hit and not Tr.HitSky and Tr.Entity then
		local Ent, Class = Tr.Entity, Tr.Entity:GetClass()

		if Ent:IsPlayer() or Ent:IsNPC() then
			CreatureTr = Tr
		elseif (Class == "prop_physics") or (Class == "prop_physics_multiplayer") or (Class == "prop_ragdoll") or Ent.IsLoot then
			ObjTr = Tr
		else
			OtherTr = Tr
		end
	else
		for i = 1, 150 * cone do
			local Vec = (ply:GetAimVector() + VectorRand() * cone):GetNormalized()

			local Tr = util.QuickTrace(ply:GetShootPos(), Vec * dist, {ply})

			if Tr.Hit and not Tr.HitSky and Tr.Entity then
				local Ent, Class = Tr.Entity, Tr.Entity:GetClass()

				if Ent:IsPlayer() or Ent:IsNPC() then
					CreatureTr = Tr
				elseif (Class == "prop_physics") or (Class == "prop_physics_multiplayer") or (Class == "prop_ragdoll") or Ent.IsLoot then
					ObjTr = Tr
				else
					OtherTr = Tr
				end
			end
		end
	end

	if CreatureTr then return CreatureTr.Entity, CreatureTr.HitPos, CreatureTr.HitNormal, CreatureTr.HitGroup end
	if ObjTr then return ObjTr.Entity, ObjTr.HitPos, ObjTr.HitNormal, ObjTr.HitGroup end
	if OtherTr then return OtherTr.Entity, OtherTr.HitPos, OtherTr.HitNormal, OtherTr.HitGroup end

	return nil, nil, nil
end

function HMCD_BlastThatDoor(ent)
	local Moddel, Pozishun, Ayngul, Muteeriul, Skin = ent:GetModel(), ent:GetPos(), ent:GetAngles(), ent:GetMaterial(), ent:GetSkin()
	sound.Play("Wood_Crate.Break", Pozishun, 60, 100)
	sound.Play("Wood_Furniture.Break", Pozishun, 60, 100)
	ent:Fire("unlock", "", 0)
	ent:Fire("open", "", 0)
	ent:Fire("kill", "", .1)

	if Moddel and Pozishun and Ayngul then
		local Replacement = ents.Create("prop_physics")
		Replacement.HmcdSpawned = true
		Replacement:SetModel(Moddel)
		Replacement:SetPos(Pozishun)
		Replacement:SetAngles(Ayngul)

		if Muteeriul then
			Replacement:SetMaterial(Muteeriul)
		end

		if Skin then
			Replacement:SetSkin(Skin)
		end

		Replacement:Spawn()
		Replacement:Activate()

		timer.Simple(3, function()
			if IsValid(Replacement) then
				Replacement:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
		end)
	end
end

function HMCD_BindObjects(ent1, pos1, ent2, pos2, power, bone1, bone2, wep)
	local Strength, CheckEnt, OtherEnt, class = 1, ent1, ent2, wep:GetClass()
	local b1, b2 = bone1, bone2
	if ent1:IsPlayer() or ent2:IsPlayer() then return end

	if b1 == nil then
		b1 = 0
	end

	if b2 == nil then
		b2 = 0
	end

	if CheckEnt:IsWorld() then
		CheckEnt = ent2
		OtherEnt = ent1
	end

	if not power then
		power = 1
	end

	for key, tab in pairs(constraint.FindConstraints(CheckEnt, "Rope")) do
		if (tab.Ent1 == OtherEnt) or (tab.Ent2 == OtherEnt) then
			Strength = Strength + 1
		end
	end

	local Rope

	if b1 == 0 and b2 == 0 then
		Rope = constraint.Rope(ent1, ent2, b1, b2, ent1:WorldToLocal(pos1), ent2:WorldToLocal(pos2), (pos1 - pos2):Length(), -.1, (500 + Strength * 100) * power, 0, "", false) -- welding is better for limbs
	else
		local strengthadd = 10
		Rope = constraint.Weld(ent1, ent2, b1, b2, 0, false, false)

		--if isbool(Rope) then return Strength end
		if class == "wep_jack_hmcd_hammer" then
			Rope.isNail = true
		else
			Rope.isTape = true
			strengthadd = 5
		end

		if b1 ~= 0 then
			if not ent1.Nails then
				ent1.Nails = {}
			end

			if not ent1.Nails[b1 - 1] then
				ent1.Nails[b1 - 1] = strengthadd
			else
				ent1.Nails[b1 - 1] = ent1.Nails[b1 - 1] + strengthadd
			end
		end

		if b2 ~= 0 then
			if not ent2.Nails then
				ent2.Nails = {}
			end

			if not ent2.Nails[b2 - 1] then
				ent2.Nails[b2 - 1] = strengthadd
			else
				ent2.Nails[b2 - 1] = ent2.Nails[b2 - 1] + strengthadd
			end
		end
	end

	return Strength
end

local ChangedTable = {}

function IsChanged(val, id, meta)
	if meta == nil then
		meta = ChangedTable
	end

	if meta.ChangedTable == nil then
		meta['ChangedTable'] = {}
	end

	if meta.ChangedTable[id] == val then return false end
	meta.ChangedTable[id] = val

	return true
end

local FragMats = {"canister", "chain", "combine_metal", "floating_metal_barrel", "grenade", "metal", "metal_barrel", "metal_bouncy", "Metal_Box", "metal_seafloorcar", "metalgrate", "metalpanel", "metalvent", "metalvehicle", "paintcan", "roller", "slipperymetal", "solidmetal", "weapon", "glass", "combine_glass", "chainlink", "computer"}

HMCD_DamageTypes = {
	[DMG_SLASH] = "slashed",
	[DMG_CLUB] = "beaten",
	[DMG_BURN] = "immolated",
	[DMG_DIRECT] = "burned",
	[DMG_CRUSH] = "thwacked",
	[DMG_GENERIC] = "damaged",
	[DMG_SHOCK] = "electrocuted",
	[DMG_BULLET] = "shot",
	[DMG_BUCKSHOT] = "blast-fragment shredded",
	[DMG_POISON] = "poisoned",
	[DMG_BLAST] = "blasted",
	[DMG_DROWN] = "asphyxiated",
	[DMG_DISSOLVE] = "moleculary disassembled",
	[DMG_DROWNRECOVER] = "backblasted",
	[DMG_SNIPER] = "poisoned"
}

HMCD_FlammableModels = {
	["models/props_c17/canister01a.mdl"] = true,
	["models/props_c17/canister02a.mdl"] = true,
	["models/props_c17/oildrum001_explosive.mdl"] = true,
	["models/props_junk/gascan001a.mdl"] = true,
	["models/props_junk/metalgascan.mdl"] = true,
	["models/props_junk/propane_tank001a.mdl"] = true,
	["models/props_junk/propanecanister001a.mdl"] = true,
	["models/props_c17/canister_propane01a_fixed.mdl"] = true,
	["models/fire_equipment/w_weldtank2.mdl"] = true,
	["models/fire_equipment/w_weldtank.mdl"] = true
}

HMCD_SurfaceHardness = {
	[MAT_METAL] = .95,
	[MAT_COMPUTER] = .95,
	[MAT_VENT] = .95,
	[MAT_GRATE] = .05,
	[MAT_FLESH] = .5,
	[MAT_ALIENFLESH] = .3,
	[MAT_SAND] = .1,
	[MAT_DIRT] = .3,
	[74] = .1,
	[85] = .2,
	[MAT_WOOD] = .5,
	[MAT_FOLIAGE] = .5,
	[MAT_CONCRETE] = .9,
	[MAT_TILE] = .8,
	[MAT_SLOSH] = .05,
	[MAT_PLASTIC] = .3,
	[MAT_GLASS] = .6
}

function HMCD_ExplosiveType(self)
	-- 1 = inert (default HE), 2 = fragmentary, 3 = incendiary
	if not IsValid(self) then return 1 end
	local Phys = self:GetPhysicsObject()
	--print(Phys:GetMaterial())

	if IsValid(Phys) then
		if HMCD_FlammableModels[string.lower(self:GetModel())] and not self:GetNWBool("NoPropane") then return 3 end
		local Mass, Volume, Mat, MassRequirement = Phys:GetMass(), Phys:GetVolume(), Phys:GetMaterial(), 5

		if (Mat == "weapon") or (Mat == "computer") then
			MassRequirement = 20
		end

		local Density = Mass / self:OBBMaxs():Length()
		if table.HasValue(FragMats, Mat) then return 2 end
	end

	return 1
end

function HMCD_IsSoft(ent)
	return ent:IsPlayer() or ent:IsNPC()
end

function HMCD_IsDoor(ent)
	local Class = ent:GetClass()

	return (Class == "prop_door") or (Class == "prop_door_rotating") or (Class == "func_door") or (Class == "func_door_rotating") or (Class == "func_breakable")
end

local EntityMeta = FindMetaTable("Entity")

function EntityMeta:NearGround()
	return util.QuickTrace(self:GetPos() + vector_up * 10, -vector_up * 50, {self}).Hit
end

function EntityMeta:CanSee(ent)
	local pos, filterent = ent, nil

	if (type(ent) == "Entity") or (type(ent) == "Player") then
		pos = ent:LocalToWorld(ent:OBBCenter())
		filterent = ent
	end

	local Tr = {
		start = self:LocalToWorld(self:OBBCenter()),
		endpos = pos,
		filter = {self, filterent}
	}

	return not Tr.Hit
end

local function RicochetOrPenetrate(initialTrace, ent)
	local AVec, IPos, TNorm, SMul = initialTrace.Normal, initialTrace.HitPos, initialTrace.HitNormal, HMCD_SurfaceHardness[initialTrace.MatType]

	if not SMul then
		SMul = .5
	end

	local ApproachAngle = -math.deg(math.asin(TNorm:DotProduct(AVec)))
	local MaxRicAngle = 60 * SMul

	-- all the way through
	if ApproachAngle > (MaxRicAngle * 1.25) then
		local MaxDist, SearchPos, SearchDist, Penetrated = (30 / SMul) * .15, IPos, 5, false

		while (not Penetrated) and (SearchDist < MaxDist) do
			SearchPos = IPos + AVec * SearchDist
			local PeneTrace = util.QuickTrace(SearchPos, -AVec * SearchDist)

			if (not PeneTrace.StartSolid) and PeneTrace.Hit then
				Penetrated = true
			else
				SearchDist = SearchDist + 5
			end
		end

		if Penetrated then
			ent:FireBullets({
				Attacker = ent.IEDAttacker,
				Damage = 1,
				Force = 1,
				Num = 1,
				Tracer = 0,
				TracerName = "",
				Dir = -AVec,
				Spread = vector_origin,
				Src = SearchPos + AVec
			})

			ent:FireBullets({
				Attacker = ent.IEDAttacker,
				Damage = 9,
				Force = 0.2,
				Num = 1,
				Tracer = 0,
				TracerName = "",
				Dir = AVec,
				Spread = vector_origin,
				Src = SearchPos + AVec
			})
		end
	elseif ApproachAngle < (MaxRicAngle * .75) then
		-- ping whiiiizzzz
		sound.Play("snd_jack_hmcd_ricochet_" .. math.random(1, 2) .. ".wav", IPos, 70, math.random(90, 100))
		local NewVec = AVec:Angle()
		NewVec:RotateAroundAxis(TNorm, 180)
		local AngDiffNormal = math.deg(math.acos(NewVec:Forward():Dot(TNorm))) - 90
		NewVec:RotateAroundAxis(NewVec:Right(), AngDiffNormal * .7) -- bullets actually don't ricochet elastically
		NewVec = NewVec:Forward()

		ent:FireBullets({
			Attacker = ent.IEDAttacker,
			Damage = 9,
			Force = 0.2,
			Num = 1,
			Tracer = 0,
			TracerName = "",
			Dir = -NewVec,
			Spread = vector_origin,
			Src = IPos + TNorm
		})
	end
end

local function BulletCallbackFunc(dmgAmt, ply, tr, dmg, tracer, hard, multi, ent)
	if tr.HitSky then return end

	if tr.MatType == MAT_FLESH then
		util.Decal("Impact.Flesh", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

		timer.Simple(.05, function()
			local Tr = util.QuickTrace(tr.HitPos + tr.HitNormal, -tr.HitNormal * 10)

			if Tr.Hit then
				util.Decal("Impact.Flesh", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
			end
		end)
	end

	if hard then
		RicochetOrPenetrate(tr, ent)
	end
end

function EntityMeta:ExplodeIED()
	local Pos, Ground, Attacker, SplodeType, Mul = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 5), self:NearGround(), self.IEDAttacker, HMCD_ExplosiveType(self), 1

	if self:IsPlayer() then
		Attacker = self
		SplodeType = 1
		self:Remove()
		SplodeType = 2
	end

	if SplodeType == 3 then
		if Ground then
			ParticleEffect("pcf_jack_incendiary_ground_sm2", Pos, vector_up:Angle())
		else
			ParticleEffect("pcf_jack_incendiary_air_sm2", Pos, VectorRand():Angle())
		end
	else
		if Ground then
			ParticleEffect("pcf_jack_groundsplode_small3", Pos, vector_up:Angle())
		else
			ParticleEffect("pcf_jack_airsplode_small3", Pos, VectorRand():Angle())
		end
	end

	if self.PropaneSound then
		self.PropaneSound:Stop()
	end

	local Foom = EffectData()
	Foom:SetOrigin(Pos)
	util.Effect("explosion", Foom, true, true)
	local Flash = EffectData()
	Flash:SetOrigin(Pos)
	Flash:SetScale(2)
	util.Effect("eff_jack_hmcd_dlight", Flash, true, true)

	timer.Simple(.01, function()
		if not (SplodeType == 3) then
			self:EmitSound("snd_jack_hmcd_explosion_debris.mp3", 85, math.random(90, 110))
			self:EmitSound("iedins/ied_detonate_far_dist_0" .. math.random(1, 3) .. ".wav", 140, 100)
			self:EmitSound("snd_jack_hmcd_debris.mp3", 85, math.random(90, 110))
		end

		if SplodeType == 2 then
			for i = 0, 150 do
				local Tr = util.QuickTrace(self:GetPos(), VectorRand() * math.random(-50, 50), {self})

				local bullet = {}
				bullet.Num = 1
				bullet.Src = Pos
				bullet.Dir = VectorRand()
				bullet.Spread = 0
				bullet.Tracer = 0
				bullet.Force = 10
				bullet.Damage = 100
				bullet.AmmoType = "Buckshot"

				bullet.Callback = function(ply, tr, dmginfo)
					BulletCallbackFunc(100, ply, tr, dmg, false, true, false, self)
					dmginfo:SetDamageType(DMG_BUCKSHOT)
					dmginfo:SetAttacker(Attacker)
					dmginfo:SetDamage(100)
				end

				self:FireBullets(bullet)
				--if(Tr.Hit)then util.Decal("Scorch",Tr.HitPos+Tr.HitNormal,Tr.HitPos-Tr.HitNormal) end
			end
		end
	end)

	timer.Simple(.02, function()
		if SplodeType == 3 then
			self:EmitSound("iedins/ied_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
			self:EmitSound("snd_jack_firebomb.wav", 80, 100)
		else
			self:EmitSound("iedins/ied_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
			--self:EmitSound("iedins/ied_detonate_0"..math.random(1,3)..".wav",Pos+vector_up,80,100)
			--self:EmitSound("iedins/ied_detonate_0"..math.random(1,3)..".wav",Pos-vector_up,80,100)
		end
	end)

	timer.Simple(.03, function()
		if not (SplodeType == 3) then
			if not (SplodeType == 2) then
				for key, ent in pairs(ents.FindInSphere(Pos, 75)) do
					if (ent ~= self) and (ent:GetClass() == "func_breakable") and ent:CanSee(Pos) then
						ent:Fire("break", "", 0)
					elseif (ent ~= self) and HMCD_IsDoor(ent) and not ent:GetNoDraw() and ent:CanSee(Pos) then
						HMCD_BlastThatDoor(ent)
					end
				end
			else
				local Poof = EffectData()
				Poof:SetOrigin(Pos)
				Poof:SetScale(1)
				util.Effect("eff_jack_hmcd_shrapnel", Poof, true, true)
			end
		else
			local Fire = ents.Create("ent_jack_hmcd_fire")
			Fire.HmcdSpawned = true
			Fire.Initiator = Attacker
			Fire.Power = 30
			Fire:SetPos(Pos)
			Fire:Spawn()
			Fire:Activate()
		end
	end)

	timer.Simple(.04, function()
		if not (SplodeType == 3) then
			util.BlastDamage(self, Attacker, Pos, 600 * Mul, 500 * Mul)
			local shake = ents.Create("env_shake")
			shake.HmcdSpawned = true
			shake:SetPos(Pos)
			shake:SetKeyValue("amplitude", tostring(100))
			shake:SetKeyValue("radius", tostring(200))
			shake:SetKeyValue("duration", tostring(1))
			shake:SetKeyValue("frequency", tostring(200))
			shake:SetKeyValue("spawnflags", bit.bor(4, 8, 16))
			shake:Spawn()
			shake:Activate()
			shake:Fire("StartShake", "", 0)
			SafeRemoveEntityDelayed(shake, 2) -- don't clutter up the world
			local shake2 = ents.Create("env_shake")
			shake2.HmcdSpawned = true
			shake2:SetPos(Pos)
			shake2:SetKeyValue("amplitude", tostring(100))
			shake2:SetKeyValue("radius", tostring(400))
			shake2:SetKeyValue("duration", tostring(1))
			shake2:SetKeyValue("frequency", tostring(200))
			shake2:SetKeyValue("spawnflags", bit.bor(4))
			shake2:Spawn()
			shake2:Activate()
			shake2:Fire("StartShake", "", 0)
			SafeRemoveEntityDelayed(shake2, 2) -- don't clutter up the world
			util.BlastDamage(self, Attacker, Pos, 600 * Mul, 400 * Mul)
		end
	end)

	timer.Simple(.05, function()
		if SplodeType == 2 or SplodeType == 3 then
			local Shrap = DamageInfo()
			Shrap:SetAttacker(Attacker)

			if IsValid(self) then
				Shrap:SetInflictor(self)
			else
				Shrap:SetInflictor(game.GetWorld())
			end

			Shrap:SetDamageType(DMG_BUCKSHOT)
			Shrap:SetDamage(600 * Mul)
			util.BlastDamageInfo(Shrap, Pos, 750 * Mul)
		end

		if IsValid(self) and self:GetClass() == "prop_ragdoll" and self:GetRagdollOwner() then
			self:GetRagdollOwner().fake = false
			self:GetRagdollOwner():KillSilent()
		end

		if not self:IsPlayer() then
			SafeRemoveEntity(self)
		end
	end)

	timer.Simple(.1, function()
		for key, rag in pairs(ents.FindInSphere(Pos, 750)) do
			if (rag:GetClass() == "prop_ragdoll") or rag:IsPlayer() then
				for i = 1, 20 do
					local Tr = util.TraceLine({
						start = Pos,
						endpos = rag:GetPos() + VectorRand() * 50
					})

					if Tr.Hit and (Tr.Entity == rag) then
						util.Decal("Blood", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
					end
				end
			end
		end
	end)
end

if CLIENT then
	local function CleanINS2ProxyHands()
		local HandsEnt = INS2_HandsEnt

		if IsValid(HandsEnt) then
			HandsEnt:RemoveEffects(EF_BONEMERGE)
			HandsEnt:RemoveEffects(EF_BONEMERGE_FASTCULL)
			HandsEnt:SetParent(NULL)
			HandsEnt:Remove()
		end
	end

	local function tryParentHands(Hands, ViewModel, Player, Weapon)
		if not IsValid(ViewModel) or not IsValid(Weapon) or not Weapon.InsHands then
			CleanINS2ProxyHands()

			return
		end

		if not IsValid(Hands) then return end

		if ViewModel:LookupBone("R ForeTwist") and not ViewModel:LookupBone("ValveBiped.Bip01_R_Hand") then
			local HandsEnt = INS2_HandsEnt

			if not IsValid(HandsEnt) then
				INS2_HandsEnt = ClientsideModel("models/weapons/tfa_ins2/c_ins2_pmhands.mdl")
				INS2_HandsEnt:SetNoDraw(true)
				HandsEnt = INS2_HandsEnt
			end

			HandsEnt:SetParent(ViewModel)
			HandsEnt:SetPos(ViewModel:GetPos())
			HandsEnt:SetAngles(ViewModel:GetAngles())

			if not HandsEnt:IsEffectActive(EF_BONEMERGE) then
				HandsEnt:AddEffects(EF_BONEMERGE)
				HandsEnt:AddEffects(EF_BONEMERGE_FASTCULL)
			end

			Hands:SetParent(HandsEnt)
		else
			CleanINS2ProxyHands()
		end
	end

	hook.Add("PreDrawPlayerHands", "MuR_INSHandsFuck", tryParentHands)
end

HMCD_AttachmentInfo = {
	["wep_jack_hmcd_akm"] = {
		["Suppressor"] = {Vector(-1.7, -31.3, 7.75), Angle(-15, 170, 0), "models/weapons/upgrades/a_suppressor_ak.mdl", .9},
		["Laser"] = {Vector(2.6, -8, 2.9), Angle(-22, -8.5, 0), "models/cw2/attachments/anpeq15.mdl", 1},
		["Sight1"] = {Vector(2.6, -8, 2.9), Angle(-22, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", 1},
		["Sight2"] = {Vector(2.65, -8, 3), Angle(-22, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", 1},
		["Sight3"] = {Vector(2.65, -8, 3), Angle(-22, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", 1},
		["Rail"] = {Vector(2.5, -8, 1), Angle(-22, -95, 0), "models/wystan/attachments/akrailmount.mdl", 1},
		["DrawPos"] = {Vector(3, -7, -4), Angle(160, 10, 180), "models/btk/w_nam_akm.mdl"}
	},
	["wep_jack_hmcd_assaultrifle"] = {
		["Suppressor"] = {Vector(1.1, -13, -1.9), Angle(-10, -100, -10), "models/cw2/attachments/556suppressor.mdl", 1},
		["Laser"] = {Vector(0.5, -17, 3.9), Angle(-20, -8.5, 0), "models/cw2/attachments/anpeq15.mdl", 1},
		["Sight1"] = {Vector(1.3, -11, 1.7), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", .9},
		["Sight2"] = {Vector(1.3, -10, 1.7), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", .9},
		["Sight3"] = {Vector(1.3, -11, 1.7), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", .9},
		["DrawPos"] = {
			Vector(2, -9, -4), Angle(160, 100, 180), "models/drgordon/weapons/ar-15/m4/colt_m4.mdl", bodygroups = {
				[2] = 1,
				[8] = 2
			}
		}
	},
	["wep_jack_hmcd_mp7"] = {
		["Suppressor"] = {Vector(-0.05, -20, 7.1), Angle(-180, -80, -20), "models/cw2/attachments/9mmsuppressor.mdl", 1},
		["Laser"] = {Vector(2.1, -13, 3.2), Angle(-20, -190, 90), "models/weapons/tfa_ins2/upgrades/laser_pistol.mdl", .9},
		["Sight1"] = {Vector(2.3, -7, 3), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", .9},
		["Sight2"] = {Vector(2.3, -7.5, 3.5), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", .9},
		["Sight3"] = {Vector(2.3, -7.5, 3.5), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", .9},
		["DrawPos"] = {Vector(2.3, -8, 0), Angle(160, 10, 180), "models/weapons/tfa_ins2/w_mp7.mdl"}
	},
	["wep_jack_hmcd_mp5"] = {
		["Suppressor"] = {Vector(-1.02, -25, 11.25), Angle(-180, -80, -20), "models/cw2/attachments/9mmsuppressor.mdl", 1},
		["DrawPos"] = {Vector(2.3, -8, 0), Angle(160, 10, 180), "models/weapons/tfa_ins2/w_mp5a4.mdl"}
	},
	["wep_jack_hmcd_rifle"] = {
		["Suppressor"] = {Vector(1.3, -22.5, 5), Angle(-10, -95, -10), "models/cw2/attachments/556suppressor.mdl", .9},
		["Scope"] = {Vector(3, -4.5, 2.5), Angle(-10, -95, -10), "models/weapons/gleb/optic_scope_hmcd.mdl", 1.1},
		["DrawPos"] = {Vector(3.5, 2, -4), Angle(160, 5, 180), "models/weapons/gleb/w_kar98k.mdl"}
	},
	["wep_jack_hmcd_shotgun"] = {
		["Suppressor"] = {Vector(4.1, -5.2, 4.3), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl", .7},
		["Laser"] = {Vector(2.5, -7.5, 4.5), Angle(-20, -8, 0), "models/cw2/attachments/anpeq15.mdl", 1},
		["Sight1"] = {Vector(2.5, -7, 4.5), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", 1},
		["Sight2"] = {Vector(2.5, -6, 4.5), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", 1},
		["Sight3"] = {Vector(2.5, -6, 4.5), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", 1},
		["DrawPos"] = {Vector(3.5, 0, -4), Angle(160, 5, 180), "models/weapons/w_shot_m3juper90.mdl"}
	},
	["wep_jack_hmcd_spas"] = {
		["Suppressor"] = {Vector(1, -6.35, -1), Angle(40, -190, 180), "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl", .7},
		["DrawPos"] = {Vector(4, -3, 5), Angle(40, -190, 180), "models/weapons/tfa_ins2/w_spas12_bri.mdl"}
	},
	["wep_jack_hmcd_combinesniper"] = {
		["DrawPos"] = {Vector(3, -15, -5), Angle(40, -190, 180), "models/w_models/combine_sniper_test.mdl"}
	},
	["wep_jack_hmcd_sr25"] = {
		["Suppressor"] = {Vector(3, -10, -4.2), Angle(-20, -180, 0), "models/weapons/upgrades/w_sr25_silencer.mdl", 1},
		["Laser"] = {Vector(1.5, -23.5, 5.5), Angle(165, -175, 90), "models/cw2/attachments/anpeq15.mdl", 1},
		["Sight1"] = {Vector(3.2, -8, 1.2), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", 1},
		["Sight2"] = {Vector(3, -8, 1.5), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", 1},
		["Sight3"] = {Vector(3, -8, 1.25), Angle(-20, -185, 0), "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", 1},
		["DrawPos"] = {Vector(3.5, -8, -4), Angle(160, 5, 180), "models/weapons/w_sr25_ins2_eft.mdl"}
	},
	["wep_jack_hmcd_riotshield"] = {
		["DrawPos"] = {Vector(0, -10, 0), Angle(90, 270, 180), "models/bshields/rshield.mdl"}
	},
	["wep_jack_hmcd_bow"] = {
		["DrawPos"] = {Vector(5, -12, -5), Angle(90, 5, 170), "models/weapons/w_snij_awp.mdl"},
		["BowSight"] = {Vector(5, -4.5, 11), Angle(90, 0, 80), "models/bowsight/hunter_sights.mdl", .7}
	},
	["wep_jack_hmcd_ar2"] = {
		["DrawPos"] = {Vector(3, -12, 0), Angle(20, -5, 180), "models/weapons/w_irifle.mdl"}
	},
	["wep_jack_hmcd_crossbow"] = {
		["DrawPos"] = {Vector(1.5, 1, -4), Angle(150, 5, 90), "models/weapons/w_crossbow.mdl"}
	},
	["wep_jack_hmcd_dbarrel"] = {
		["DrawPos"] = {Vector(3.5, 0, -4), Angle(160, 5, 180), "models/weapons/ethereal/w_sawnoff_db.mdl"}
	},
	["wep_jack_hmcd_rpg"] = {
		["DrawPos"] = {
			Vector(3, -10, 0), Angle(160, 5, 180), "models/weapons/tfa_ins2/w_rpg.mdl", func = function(ply)
				if ply:IsPlayer() then
					local wep = ply:GetWeapon("wep_jack_hmcd_rpg")
					local rocket = 0

					if wep:Clip1() < 1 then
						rocket = 1
					end

					ply.RenderedWeapons["wep_jack_hmcd_rpg_DrawPos"]:SetBodygroup(1, rocket)
				elseif ply.Inventory then
					local wep

					for i, item in ipairs(ply.Inventory) do
						if item["Class"] == "wep_jack_hmcd_rpg" then
							wep = item
							break
						end
					end

					local rocket = 0

					if wep["Ammo"] < 1 then
						rocket = 1
					end

					ply.RenderedWeapons["wep_jack_hmcd_rpg_DrawPos"]:SetBodygroup(1, rocket)
				end
			end
		}
	},
	["wep_jack_hmcd_remington"] = {
		["DrawPos"] = {Vector(3.5, 0, -4), Angle(160, 5, 180), "models/weapons/smc/r870/w_remington_m870.mdl"}
	},
	["wep_jack_hmcd_m249"] = {
		["DrawPos"] = {Vector(4, -9, -4), Angle(160, 10, 190), "models/weapons/w_m249.mdl"},
		["Suppressor"] = {Vector(1.1, -13, -1.9), Angle(-10, -100, -10), "models/cw2/attachments/556suppressor.mdl", 1},
		["Laser"] = {Vector(2.5, -11, 2), Angle(-20, -8.5, -10), "models/cw2/attachments/anpeq15.mdl", 1},
		["Sight1"] = {Vector(1.3, -11, 1.7), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", .9},
		["Sight2"] = {Vector(1.3, -10, 1.7), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", .9},
		["Sight3"] = {Vector(1.3, -11, 1.7), Angle(-20, -190, 0), "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", .9}
	},
	["wep_jack_hmcd_ptrd"] = {
		["DrawPos"] = {Vector(6, 5, -8), Angle(160, 10, 190), "models/gleb/w_ptrd.mdl"}
	}
}

HMCD_CSInfo = {
	["Hints"] = {
		["de_dust2"] = {
			{Vector(-1600, 2548, 40), Angle(0, 0, 50)},
			{Vector(-1386, 2587, 60), Angle(0, -90, 60)},
			{Vector(-1410, 2697, 55), Angle(0, 180, 30)},
			{Vector(-1610, 2758, 60), Angle(-90, 0, 0)},
			{Vector(-1460, 2621, 58), Angle(0, 180, -30)},
			{Vector(1134, 2456, 96), Angle(-90, 70, 0)},
			{Vector(1200, 2512, 130), Angle(0, 180, 50)},
			{Vector(1019.5, 2554, 140), Angle(0, 165, -20)},
			{Vector(1072, 2465, 135), Angle(0, 0, -20)},
			{Vector(1230, 2544, 145), Angle(0, 90, -20)}
		},
		["ttt_bank_b13"] = {
			{Vector(4683, 5940, 4370), Angle(0, 0, 30)},
			{Vector(4683, 5910, 4350), Angle(0, 0, -60)},
			{Vector(4683, 5925, 4390), Angle(0, 0, 10)},
			{Vector(4700, 5897, 4385), Angle(0, 0, -10)},
			{Vector(4694, 5865, 4385), Angle(0, 0, -80)}
		},
		["hmcd_helicopterz"] = {
			{Vector(23, 415, 382), Angle(0, 0, 0)},
			{Vector(20, 484, 351), Angle(295, 0, 0)},
			{Vector(55, 404, 385), Angle(-30, 90, 0)},
			{Vector(-43.5, 487, 348), Angle(-25, 180, 0)},
			{Vector(131, 416.5, 359), Angle(0, 67.5, 90)}
		},
		["hmcd_perdej"] = {
			{Vector(23, 415, 382), Angle(0, 0, 0)},
			{Vector(20, 484, 351), Angle(295, 0, 0)},
			{Vector(55, 404, 385), Angle(-30, 90, 0)},
			{Vector(-43.5, 487, 348), Angle(-25, 180, 0)},
			{Vector(131, 416.5, 359), Angle(0, 67.5, 90)}
		},
		["de_inferno"] = {
			{Vector(2084, 423, 160), Angle(-90, 120, -90)},
			{Vector(1911, 182, 213), Angle(0, 90, 30)},
			{Vector(1908, 402, 218), Angle(0, -90, -30)},
			{Vector(1999, 528, 160), Angle(-90, 120, 30)},
			{Vector(1936, 419.5, 216), Angle(0, 90, 80)},
			{Vector(500, 2617, 160), Angle(-90, 120, -90)},
			{Vector(466, 2834, 196), Angle(-90, 120, 0)},
			{Vector(385, 2517, 219), Angle(0, 90, 60)},
			{Vector(460, 2678, 183), Angle(0, -47, 30)},
			{Vector(203, 2980, 189), Angle(0, 0, 30)}
		}
	},
	["BlowSpots"] = {
		["de_dust2"] = {
			[1] = Vector(-1543, 2647, 1),
			[2] = Vector(1128, 2466, 96)
		},
		["ttt_bank_b13"] = {
			[1] = Vector(4700, 5897, 4385)
		},
		["hmcd_helicopterz"] = {
			[1] = Vector(3, 400, 387)
		},
		["hmcd_perdej"] = {
			[1] = Vector(3, 400, 387)
		},
		["de_inferno"] = {
			[1] = Vector(2087, 426, 160),
			[2] = Vector(502, 2615, 160)
		}
	},
	["HostagePositions"] = {
		["cs_office"] = {
			{Vector(1710, 669, -159), Angle(90, 90, 90)},
			{Vector(1420, -582, -159), Angle(90, -90, 100)},
			{Vector(2297, -139, -159), Angle(90, 0, 90)}
		},
		["gm_zabroshka"] = {
			{Vector(1746, 229, 412), Angle(90, 0, 0)},
			{Vector(1746, -229, 412), Angle(90, 90, 0)},
			{Vector(2092, -281, 412), Angle(90, 90, 0)}
		},
		["tdm_postbellum"] = {
			{Vector(-1670, 4905, 880), Angle(90, 0, 0)},
			{Vector(-1670, 4540, 880), Angle(90, 0, 0)}
		},
		["ttt_67thway_v14"] = {
			{Vector(-1642, 5700, 120), Angle(90, 0, 0)},
			{Vector(-1054, 5739, 120), Angle(90, 0, 0)},
			{Vector(-1294, 6073, 280), Angle(90, 0, 0)}
		},
		["zs_shelter"] = {
			{Vector(-55, 568, 190), Angle(90, 0, 0)},
			{Vector(327, 568, 240), Angle(90, 0, 0)},
			{Vector(251, 8, 240), Angle(90, 180, 0)},
			{Vector(-124, 8, 190), Angle(90, 180, 0)}
		},
		["cs_militia"] = {
			{Vector(653, 1009, 15), Angle(90, 0, 0)},
			{Vector(353, 245, 15), Angle(90, 0, 0)},
			{Vector(517, 501, 15), Angle(90, 90, 0)}
		},
		["gm_hram"] = {
			{Vector(245, 990, 112), Angle(90, 90, 0)},
			{Vector(-449, 791, 338), Angle(90, 90, 0)}
		}
	},
	["RescueZones"] = {
		["cs_office"] = {Vector(-1342, -1255, -175), Vector(-105, -2058, -350)},
		["gm_zabroshka"] = {Vector(-2639, 215, 32), Vector(-2201, -217, 296)},
		["tdm_postbellum"] = {Vector(-4217, 4025, 213), Vector(-4096, 4381, 340)},
		["ttt_67thway_v14"] = {Vector(511, 1801, 370), Vector(1515, 1021, 112)},
		["zs_shelter"] = {Vector(616, 1331, -79), Vector(-165, 782, 127)},
		["cs_militia"] = {Vector(574, -2527, -169), Vector(431, -2376, -16)},
		["gm_hram"] = {Vector(4124, 1534, 64), Vector(4576, 2006, 313)}
	}
}

HMCD_AmmoWeights = {
	["AlyxGun"] = 4,
	["Pistol"] = 12,
	["HelicopterGun"] = 30,
	["357"] = 15,
	["AirboatGun"] = 3,
	["Buckshot"] = 60,
	["AR2"] = 50,
	["MP5_Grenade"] = 60,
	["SMG1"] = 18,
	["Gravity"] = 18,
	["SniperRound"] = 20,
	["XBowBolt"] = 22,
	["Thumper"] = 26,
	["StriderMinigun"] = 20,
	["RPG_Round"] = 450,
	["9mmRound"] = 8,
	["Hornet"] = 30,
	["SniperPenetratedRound"] = 20,
	["CombineCannon"] = 200
}

HMCD_AmmoNames = {
	["AlyxGun"] = "5.7x16mm (.22 long rifle)",
	["Pistol"] = "9x19mm (9mm luger/parabellum)",
	["357"] = "9x29mmR (.38 special)",
	["SMG1"] = "5.56x45mm (.223 remington)",
	["Buckshot"] = "18.5x70mmR (12 gauge shotshell)",
	["AR2"] = "7x57mm (7mm mauser)",
	["XBowBolt"] = "6x735mm broadhead hunting arrow",
	["AirboatGun"] = "2x89mm Carpentry Nail",
	["RPG_Round"] = "40mm Rocket",
	["StriderMinigun"] = "7.62x51 NATO",
	["HelicopterGun"] = "4.6x30mm",
	["SniperRound"] = "7.62x39mm",
	["Gravity"] = "Pulse Slug",
	["Thumper"] = "300mm Rebar",
	["MP5_Grenade"] = "Energy Ball",
	["SniperPenetratedRound"] = "X26 Taser Cartridge",
	["9mmRound"] = "9×22mm P.A.",
	["Hornet"] = "Flexible Baton Round",
	["CombineCannon"] = "14.5×114mm (.57 calibre)"
}

HMCD_PersonContainers = {
	["models/props_junk/wood_crate001a.mdl"] = true,
	["models/props_junk/wood_crate001a_damaged.mdl"] = true,
	["models/props_junk/wood_crate001a_damagedmax.mdl"] = true,
	["models/props_junk/wood_crate002a.mdl"] = true,
	["models/props_borealis/bluebarrel001.mdl"] = true,
	["models/props_c17/oildrum001.mdl"] = true,
	["models/props_junk/trashbin01a.mdl"] = true,
	["models/props_c17/furnituredresser001a.mdl"] = true,
	["models/props_c17/woodbarrel001.mdl"] = true,
	["models/props_lab/dogobject_wood_crate001a_damagedmax.mdl"] = true,
	["models/props_wasteland/controlroom_storagecloset001a.mdl"] = true,
	["models/props_wasteland/controlroom_storagecloset001b.mdl"] = true,
	["models/props/cs_assault/dryer_box.mdl"] = true,
	["models/props/cs_assault/dryer_box2.mdl"] = true,
	["models/props/cs_assault/washer_box.mdl"] = true,
	["models/props/cs_assault/washer_box2.mdl"] = true,
	["models/props/cs_militia/crate_extrasmallmill.mdl"] = true,
	["models/props/de_dust/du_crate_64x64.mdl"] = true,
	["models/props/de_dust/du_crate_64x80.mdl"] = true,
	["models/props/de_inferno/wine_barrel.mdl"] = true,
	["models/props/de_nuke/crate_extrasmall.mdl"] = true,
	["models/props/de_nuke/crate_small.mdl"] = true,
	["models/props/de_prodigy/prodcratesb.mdl"] = true,
	["models/props_trainstation/trashcan_indoor001a.mdl"] = true,
	["models/props_wasteland/kitchen_fridge001a.mdl"] = true,
	["models/props_wasteland/laundry_washer001a.mdl"] = true,
	["models/props_c17/furniturefridge001a.mdl"] = true,
	["models/props/griggs/sotbx3.mdl"] = true,
	["models/props/griggs/sotbx4.mdl"] = true,
	["models/props/griggs/sotbx5.mdl"] = true,
	["models/props/griggs/sotbx6.mdl"] = true,
	["models/props/griggs/sotbx7.mdl"] = true,
	["models/props/griggs/sotbx9.mdl"] = true
}