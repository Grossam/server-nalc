
-- Dungeon Master (This one spits out fireballs at you)

-- Node which cannot be destroyed by DungeonMasters' fireballs
local excluded = {"nether:netherrack","default:obsidian_glass","maptools:cobble",
			"maptools:sand", "maptools:desert_sand"
	}

mobs:register_mob("mobs:dungeon_master", {
	type = "monster",
	hp_min = 50,
	hp_max = 60,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "mobs_dungeon_master.x",
	--textures = {"mobs_dungeon_master.png"},
	available_textures = {
		total = 3,
		texture_1 = {"mobs_dungeon_master.png"},
		texture_2 = {"mobs_dungeon_master_cobblestone.png"},
		texture_3 = {"mobs_dungeon_master_strangewhite.png"},
	},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 16,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 13,
	drops = {
		{name = "default:mese_crystal_fragment",
		chance = 1,
		min = 1,
		max = 3,},
		{name = "default:diamond",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "default:mese_crystal",
		chance = 2,
		min = 1,
		max = 3,},
		{name = "default:diamond_block",
		chance = 30,
		min = 1,
		max = 1,},
		{name = "maptools:gold_coin",
		chance = 15,
		min = 1,
		max = 2,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 2,
		max = 10,},
	},
	armor = 60,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "mobs:fireball",
	shoot_interval = 2.5,
	sounds = {
		attack = "mobs_fireball",
	},
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
	sounds = {
		random = "mobs_dungeonmaster",
	},
	jump = true,
	step = 0.5,
	shoot_offset = 0,
	blood_texture = "mobs_blood.png",
})
mobs:register_spawn("mobs:dungeon_master", {"default:stone, nether:netherrack"}, 20, -1, 7000, 1, -100)
mobs:register_egg("mobs:dungeon_master", "Dungeon Master", "fire_basic_flame.png", 1)

-- Fireball (weapon)

mobs:register_arrow("mobs:fireball", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"mobs_fireball.png"},
	velocity = 5,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=13},
		}, 0) -- {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z})
	end,

	-- node hit, bursts into flame (cannot blast through obsidian)
	hit_node = function(self, pos, node)

		for dx=-1,1 do
			for dy=-1,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.get_node(p).name
					local excluding = minetest.registered_nodes[n].groups["unbreakable"] ~= nil
						or n:split(":")[1] == "nether"
					for _,i in ipairs(excluded) do
						if i == n then including = true end
					end
					
					--if p.y < -19600 and including and n:split(":")[1] == "nether" then
					if excluding then
						return
					end
					if n ~= "default:obsidian"
					and n ~= "default:obsidianbrick"
					and not n:find("protector:") then
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
						minetest.set_node(p, {name="fire:basic_flame"})
					else
						minetest.set_node(p, {name="air"})
					end
					end
				end
			end
		end
	end
})
