-- просто хмгд эффекты боли и крови... -_- поцан! -_- --_-- ---_---
hook.Add("RenderScreenspaceEffects","Effects", function()
	local ply = LocalPlayer()
	if ply:GetNWBool("Spectating", false) == true then return end
	local bloodlevel = ply:GetNWFloat("Blood",5200)
	local painlevel = ply:GetNWFloat("pain",0)
	local fraction = math.Clamp(1-((bloodlevel-3200)/((5000-1400)-2000)),0,1)

	local alpha = math.Clamp(255 - (ply:Health() / 150) * 255, 0, 255)
	
		local hpeff = {
		    ["$pp_colour_addr"] = 0,
		    ["$pp_colour_addg"] = 0,
		    ["$pp_colour_addb"] = 0,
		    ["$pp_colour_brightness"] = 0,
		    ["$pp_colour_contrast"] = 1,
    		["$pp_colour_colour"] = 1 - (alpha / 255),
    		["$pp_colour_mulr"] = 0,
    		["$pp_colour_mulg"] = 0,
    		["$pp_colour_mulb"] = 0
    	}
    	DrawColorModify( hpeff )

	DrawToyTown(fraction*8,ScrH()*fraction*1.5)
	
	if fraction>0.93 then
		DrawMotionBlur( 0.2, 0.9, 0.03 )
		local painlevel = ply:GetNWFloat("pain", 0)
		local fraction1 = math.Clamp(1-(painlevel/250),0.25,1)

		local tab = {
		    ["$pp_colour_addr"] = 0,
		    ["$pp_colour_addg"] = 0,
		    ["$pp_colour_addb"] = 0,
		    ["$pp_colour_brightness"] = 0,
		    ["$pp_colour_contrast"] = fraction1,
    		["$pp_colour_colour"] = 1,
    		["$pp_colour_mulr"] = 0,
    		["$pp_colour_mulg"] = 0,
    		["$pp_colour_mulb"] = 0
    	}
    	DrawColorModify( tab )
    end
end)