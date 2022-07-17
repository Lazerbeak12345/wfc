local minetest, vector, dump = minetest, vector, dump

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local do_example = false  -- Don't load the example code
do_example = true -- Load it

wfc = {}
local v = vector.new
local metatable = {__index = wfc}
function wfc.new(def)
	local self = {
		constraints = {}, -- Unordered Iterable of constraints
		extent = {
			max = v(0,0,0),
			min = v(0,0,0),
		},
		isMapgen = false, -- TODO enable when in magen thread automatically
	}
	self = setmetatable(self, metatable)
	for key, value in pairs(def) do
		self:addBlock(key,value)
	end
	self:update_hitbox_extent()
	-- TODO relationships should be asserted to be mutual
	return self
end
function wfc:addBlock(name, constraints)
	local id = minetest.get_content_id(name)
	local newC = {}
	for _, constraint in ipairs(constraints) do
		newC[#newC+1] = self.prepareConstraint(constraint)
	end
	self.constraints[id] = newC
end
function wfc:update_hitbox_extent()
	local xMax, xMin, yMax, yMin, zMax, zMin = 0,0,0,0,0,0
	for _, constraint in pairs(self.constraints) do
		for _, value in ipairs(constraint) do
			local location = value[1]
			if location.x > xMax then xMax = location.x end
			if location.y > yMax then yMax = location.y end
			if location.z > zMax then zMax = location.z end
			if location.x < xMin then xMin = location.x end
			if location.y < yMin then yMin = location.y end
			if location.z < zMin then zMin = location.z end
		end
	end
	self.extent.max = v(xMax, yMax, zMax)
	self.extent.min = v(xMin, yMin, zMin)
end
function wfc.prepareConstraint(constraint)
	local vec = constraint[1]
	local bundle = {}
	for _, value in ipairs(constraint[2]) do
		bundle[#bundle+1] = minetest.get_content_id(value)
	end
	return { vec, bundle }
end
local function getInitialBlocks(self, pointA, pointB)
	local vm = self.isMapgen and minetest.get_mapgen_object("voxelmanip") or minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(pointA, pointB)
	minetest.log("error", "TODO getInitialBlocks " .. dump(emin))
	return {}, {}
end
local function calculateInitalEntropy(blockSuperpositions)
	minetest.log("error", "TODO calculateInitalEntropy")
	return 1, {}
end
local function collapseLowest(lowest_entropy, entropy, blockSuperpositions, constraints)
	minetest.log("error", "TODO collapseLowest")
	return 1
end
local function processBlocks(blockSuperpositions, realBlocks)
	minetest.log("error", "TODO processBlocks")
end
function wfc:generate_at(pointA, pointB)
	local blockSuperpositions, realBlocks = getInitialBlocks(self, pointA, pointB)
	local lowest_entropy, entropy = calculateInitalEntropy(blockSuperpositions)
	while lowest_entropy > 1 do
		lowest_entropy = collapseLowest(lowest_entropy, entropy, blockSuperpositions, self.constraints)
	end
	-- TODO how does it handle entropy of zero?
	processBlocks(blockSuperpositions, realBlocks)
end
--[[
-- For now, superpositions will just be lists of numbers. Might make them into bitfields later.
-- Even better approach is a list of booleans, or a sparse list of booleans. Could have a key to indicate the entropy?
local function superposition_to_entropy(s)
	return #s
end
function wfc:generate_at(pointA, pointB)
	--[[local vm = minetest.get_voxel_manip(pointA, pointB)
	minetest.log("error", "vm " .. dump(vm))]
	-- - Prepare a space to store the array of block superpositions
	--   - Extend the array as needed
	local blocks = {}
	-- - Prepare a space to store the locations of each block's "entropy"
	--   - An array with the index being entropy remaining, value being array of vector block locations.
	local lowest_entropy = nil
	local entropy = {}
	local function removeOldEntropyFor(vec)
		local oldE_val = superposition_to_entropy(blocks[vec.x][vec.y][vec.z]) -- ~~lol eval is bad amirite~~
		local oldE_list = entropy[oldE_val] -- Gotta love the `oldE`s
		if oldE_list == nil then return end -- TODO log?
		local newE_list = {}
		for _, value in ipairs(oldE_list) do
			if not vector.equals(value, vec) then
				newE_list[#newE_list+1] = value
			end
		end
		entropy[oldE_val] = newE_list
	end
	local function calculateSuperpositions(x,y,z)
		minetest.log("error","TODO calculateSuperpositions " .. x .. "," .. y .. "," .. z)
		return { nil, nil, nil, nil, nil, nil, nil, nil }
	end
	local function update_entropy_for(x,y,z)
		local vec = v(x,y,z)
		if blocks[x][y][z] ~= nil then
			removeOldEntropyFor(vec)
		end
		local superpositions = calculateSuperpositions(x,y,z)
		blocks[x][y][z] = superpositions
		local entropy_val = superposition_to_entropy(superpositions)
		if entropy_val == 1 then
			minetest.log("error", "block complete at " .. x .. "," .. y .. "," .. z)
		else
			if entropy[entropy_val] == nil then
				entropy[entropy_val] = {}
			end
			entropy[entropy_val][#entropy[entropy_val] + 1] = vec
			if lowest_entropy == nil or lowest_entropy > entropy_val then
				lowest_entropy = entropy_val
			end
		end
		-- Use tail recursion to update all remaining entropy values?
		return entropy_val
	end
	for x=pointA.x,pointB.x do
		blocks[x] = {}
		for y=pointA.y,pointB.y do
			blocks[x][y] = {}
			for z=pointA.z,pointA.z do
				update_entropy_for(x,y,z)
			end
		end
	end
	-- Work on the lowest entropy while there are still unfinished blocks.
	-- TODO handle case where block has zero possibilities (slect nearby neigbhor and pick a possible block that this could be)
	while #entropy > 0 do
		for key, value in ipairs(entropy) do
			minetest.log("error","entropy list index" .. key .. " len " .. #value .. " value " .. dump(value))
		end
	end
	minetest.log("error", "TODO generate_at")
end]]
if do_example then
	dofile(modpath.."/example.lua")
end
