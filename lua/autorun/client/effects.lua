-- просто хмгд эффекты боли и крови... -_- поцан! -_- --_-- ---_---
hook.Add("RenderScreenspaceEffects","Effects", function()
	local ply = LocalPlayer()
	local bloodlevel = ply:GetNWFloat("Blood",5200)
	local painlevel = ply:GetNWFloat("pain",0)
	local fraction = math.Clamp(1-((bloodlevel-3200)/((5000-1400)-2000)),0,1)

	local alpha = math.Clamp(255 - (ply:Health() / 150) * 255, 0, 255)

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
end)