--
HMCD_SurfaceHardness = {
	[MAT_METAL] = .95,
	[MAT_COMPUTER] = .95,
	[MAT_VENT] = .95,
	[MAT_GRATE] = .95,
	[MAT_FLESH] = 2,
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

function SWEP:BulletCallbackFunc(dmgAmt, ply, tr, dmg, tracer, hard, multi)
	if tr.Entity:IsPlayer() then return end
	if tr.MatType == MAT_FLESH then
		local vPoint = tr.HitPos
		local effectdata = EffectData()
		effectdata:SetOrigin(vPoint)
	end

	if tr.HitSky then return end
	if hard then self:RicochetOrPenetrate(tr) end
end

function SWEP:RicochetOrPenetrate(initialTrace)
	local AVec, IPos, TNorm, SMul = initialTrace.Normal, initialTrace.HitPos, initialTrace.HitNormal, HMCD_SurfaceHardness[initialTrace.MatType]
	if not SMul then SMul = .5 end
	local ApproachAngle = -math.deg(math.asin(TNorm:DotProduct(AVec)))
	local MaxRicAngle = 60 * SMul
	if ApproachAngle > (MaxRicAngle * 1.25) then -- all the way through
		local MaxDist, SearchPos, SearchDist, Penetrated = (self.Damage / SMul) * .15, IPos, 5, false
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
			local StopMul = SearchDist / MaxDist
			self:FireBullets({
				Attacker = self.Owner,
				Damage = 1,
				Force = 1,
				Num = 1,
				Tracer = 0,
				TracerName = "",
				Dir = -AVec,
				Spread = Vector(0, 0, 0),
				Src = SearchPos + AVec
			})

			self:FireBullets({
				Attacker = self.Owner,
				Damage = self.CurrentDamage * math.Clamp((1 - StopMul) * 1.2, 0.01, 1),
				Force = self.Damage / 15,
				Num = 1,
				Tracer = 0,
				TracerName = "",
				Dir = AVec,
				Spread = Vector(0, 0, 0),
				Src = SearchPos + AVec,
				Callback = function(ply, tr)
					local trace = util.QuickTrace(SearchPos + AVec, AVec * 1000000)
					ply:GetActiveWeapon():BulletCallbackFunc(self.CurrentDamage * math.Clamp((1 - StopMul) * 1.2, 0.01, 1), ply, trace, dmg, false, true, false)
				end
			})

			self.CurrentDamage = self.CurrentDamage * math.Clamp((1 - StopMul) * 1.2, 0.01, 1)
		end
	elseif ApproachAngle < (MaxRicAngle * .75) then
		sound.Play("snd_jack_hmcd_ricochet_" .. math.random(1, 2) .. ".wav", IPos, 70, math.random(90, 100))
		local NewVec = AVec:Angle()
		NewVec:RotateAroundAxis(TNorm, 180)
		local AngDiffNormal = math.deg(math.acos(NewVec:Forward():Dot(TNorm))) - 90
		NewVec:RotateAroundAxis(NewVec:Right(), AngDiffNormal * .7) -- bullets actually don't ricochet elastically
		NewVec = NewVec:Forward()
		self:FireBullets({
			Attacker = self.Owner,
			Damage = self.Damage * .5,
			Force = self.Damage / 15,
			Num = 1,
			Tracer = 0,
			TracerName = "",
			Distance = 600,
			Dir = -NewVec,
			Spread = Vector(0, 0, 0),
			Src = IPos + TNorm
		})
	end
end