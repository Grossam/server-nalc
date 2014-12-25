-- Dirt Monster

mobs:register_mob("mobs:dirt_monster", {
	type = "monster",
	hp_min = 25,
	hp_max = 30,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.x",
	--textures = {"mobs_dirt_monster.png"},
	available_textures = {
		total = 1,
		texture_1 = {"mobs_dirt_monster.png"},
	},
	visual_size = {x=3, y=2.6},
	makes_footstep_sound = true,
	view_range = 16,
	walk_velocity = 3,
	run_velocity = 5,
	damage = 4,
	drops = {
		{name = "default:dirt",
		chance = 1,
		min = 3,
		max = 5,},
		{name = "maptools:copper_coin",
		chance = 2,
		min = 2,
		max = 8,},
	},
	armor = 90,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
	sounds = {
		random = {"mobs_dirtmonster_random01", "mobs_dirtmonster_random02"},
	},
	jump = true,
	step = 1,
	blood_texture = "default_dirt.png",
})
mobs:register_spawn("mobs:dirt_monster", {"default:dirt_with_grass"}, 3, -1, 7000, 1, 31000)
