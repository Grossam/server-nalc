local modpath = minetest.get_modpath(minetest.get_current_modname())

-- Custom craftings
dofile(modpath.."/crafting.lua")

-- Custom craftitems
dofile(modpath.."/craftitems.lua")

-- Custom mapgen ore generation
dofile(modpath.."/mapgen.lua")

-- Custom nodes
dofile(modpath.."/nodes.lua")

-- Custom tools
dofile(modpath.."/tools.lua")

local mods = {"witchcraft", "cotton", "technic",
				  "beds", "boats", "bucket",
				  "nyancat", "moreores", "moreblocks",
				  "maptools"
}

for _,mod in ipairs(mods) do
	if minetest.get_modpath(mod) then
		dofile(modpath.."/"..mod..".lua")
	end
end


-- Hide quests HUD by default
if minetest.get_modpath("quests") and quests then
	minetest.register_on_joinplayer(
		function(player)
			if not player then return end

			local playern = player:get_player_name()
			minetest.after(
				2,
				function(playername)
					quests.hud[playername].autohide = false
					quests.hide_hud(playername)
					minetest.log("action", "Quest HUD hidden for player "..playername)
				end, player:get_player_name())
		end)
end
