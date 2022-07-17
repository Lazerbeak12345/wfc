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
-- TODO register biome
-- -- TODO use bit.* to make a bitfield
