local sights={
    [1]=Material( "models/weapons/tfa_ins2/optics/kobra_dot", "noclamp nocull smooth"),
    [2]=Material( "models/weapons/tfa_ins2/optics/eotech_reticule", "noclamp nocull smooth"),
    [3]=Material( "scope/aimpoint", "noclamp nocull smooth"),
	[4]=Material( "scope/aimpoint", "noclamp nocull smooth")
}

local sightRight = {
	["wep_jack_hmcd_mp7"] = {
		[1] = 20,
		[2] = 0,
		[3] = 0
	},
	["wep_jack_hmcd_glock17"] = {
		[4] = -5
	}
}

local sightUp = {
	["wep_jack_hmcd_akm"] = {
		[1] = -100,
		[2] = -120,
		[3] = -100
	},
	["wep_jack_hmcd_glock17"] = {
		[4] = -20
	}
}

local size = {
	[1] = 230,
	[2] = 200,
	[3] = 200,
	[4] = 350
}

function DepthedWHO(mdl)
    local eyedist = WorldToLocal(mdl:GetPos(), mdl:GetAngles(), EyePos(), EyeAngles()).x
    render.DepthRange(0, 0.0093 + (0.0005 * eyedist / 20))
end

function SWEP:DrawSight(wep, sightnum, model,vm)
    model.sight3 = Material("models/weapons/tfa_ins2/optics/eotech_lense")
    model.sight3:SetTexture("$basetexture","empty")

    model.sight2 = Material("models/weapons/tfa_ins2/optics/aimpoint_lense")
    model.sight2:SetTexture("$basetexture","empty")

    local material = sights[sightnum]

    render.UpdateScreenEffectTexture()
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_REPLACE)
    render.SetStencilWriteMask(255)
    render.SetStencilTestMask(255)

    render.SetBlend(0)

    render.SetStencilReferenceValue(255)

    model:DrawModel()

    render.SetBlend(1)

    render.SetStencilPassOperation(STENCIL_KEEP)
    render.SetStencilCompareFunction(STENCIL_EQUAL)

	if wep:GetClass() == "wep_jack_hmcd_assaultrifle" then DepthedWHO(model) end

    render.SetMaterial(material)

	local sight_upped
	local sight_righited
	if sightUp[wep:GetClass()] then sight_upped = sightUp[wep:GetClass()][sightnum] else	sight_upped = 0 end
	if sightRight[wep:GetClass()] then sight_righited = sightRight[wep:GetClass()][sightnum] else sight_righited = 0 end

	local size = size[sightnum]

	local pos = LocalPlayer():EyePos()
    local up = model:GetAngles():Up()
    local right = model:GetAngles():Right()
	pos = pos + model:GetAngles():Forward() * 4200 + model:GetAngles():Up() * sight_upped + model:GetAngles():Right() * sight_righited
    render.DrawQuad(pos + (up * size / 2) - (right * size / 2), pos + (up * size / 2) + (right * size / 2), pos - (up * size / 2) + (right * size / 2), pos - (up * size / 2) - (right * size / 2), Color(255,255,255,255))

	if wep:GetClass() == "wep_jack_hmcd_assaultrifle" then render.DepthRange(0, 1) end

    render.SetStencilEnable(false)
end