-- просто хмгд эффекты боли и крови... -_- поцан! -_- --_-- ---_---
hook.Add("RenderScreenspaceEffects","Effects", function()
	local ply = LocalPlayer()
<<<<<<< HEAD
	return
=======
	local bloodlevel, painlevel = ply:GetNWFloat("Blood",5200), ply:GetNWFloat("pain",0)
	local fraction, hp = math.Clamp(1-((bloodlevel-3200)/((5000-1400)-2000)),0,1), ply:Health() / ply:GetMaxHealth()

	local alpha = math.Clamp(255 - hp * 255, 0, 255)

	DrawToyTown(fraction*8,ScrH()*fraction*1.5)
	local tab = {
	    ["$pp_colour_addr"] = 0,
	    ["$pp_colour_addg"] = 0,
	    ["$pp_colour_addb"] = 0,
	    ["$pp_colour_brightness"] = 2,
	    ["$pp_colour_contrast"] = 1,
    	["$pp_colour_colour"] = 1 - (alpha / 255),
    	["$pp_colour_mulr"] = 0,
    	["$pp_colour_mulg"] = 0,
    	["$pp_colour_mulb"] = 0
    }
    DrawColorModify( tab )
>>>>>>> d44a84bc83d3f2e5937a97c3d003dfa74263fa66
end)