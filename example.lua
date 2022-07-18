--[[
local v = vector.new
local generator = wfc.new{
	["default:dirt_with_grass"] = {
		{ v( 0, -1, 0 ), { "default:dirt" } },
		{ v( 0, 1, 0 ), { "air" } },
	},
	["default:dirt"] = {
		{ v( 0, 1, 0 ), { "default:dirt_with_grass" } },
		{ v( 0, -1, 0 ), { "air" } },
		{ v( 0, -2, 0 ), { "air" } },
		{ v( 0, -3, 0 ), { "default:dirt", "default:dirt_with_grass" } },
	},
	["air"] = {
		{ v( 0, -1, 0 ), { "default:dirt_with_grass" } },
		{ v( 0, 1, 0 ), { "default:dirt" } },
		{ v( 0, 2, 0 ), { "default:dirt" } },
	},
}
-- minetest.log("error","TODO remove this " .. dump(generator))
generator:generate_at(v(0, 0, 0), v(10, 100, 10))
]]
--minetest.log("error", dump(_VERSION) .. dump(bit32))
minetest.register_biome({
	name = "dead_city",
	node_top = "default:stone_block",
	depth_top = 5,
	node_filler = "default:gravel",
	depth_filler = 3,
	y_max = 1000,
	y_min = -3,
	vertical_blend = 8,
	heat_point = 50,
	humidity_point = 50,
})
-- TODO use that thingy to make the thingy spawned and somehow get a VM from all that


-- -- TODO use bit.* to make a bitfield
