local solver = {}
function solver.new(init)
	local self = {
		get_hitbox = init.get_hitbox,
		bits = {
			band = init.bits.band,
			bor = init.bits.bor,
			empty = init.bits.empty
		},
		set = init.set,
		table = init.table
	}
	setmetatable(self, solver)
	return self
end
function solver:_full_queue(size)
	local index = 1
	local output = self.set.new()
	while index < size do
		output = output:add(index)
		index = index + 1
	end
	return output
end
function solver:state_to_acceptable(value, vec)
	-- Super slow. Memoize this?
	local acceptable = self.bits.empty()
	for id, relation in ipairs(self.table) do
		if self.bits.index(value, id) and relation[vec] then
			acceptable = self.bits.bor(acceptable, relation[vec])
		end
	end
end
function solver:get_possible_states(state, location)
	local nearby = self:get_hitbox(location)
	local vals = state[location] -- old value
	for _, l2 in ipairs(nearby) do
		vals = self.bits.band(
			vals,
			solver:state_to_acceptable(
				state[l2],
				l2 - location  -- A vector. In 1D. Super easy to scale up to `n` Ds. If youv'e done cellular automata before. Wimps.
			)
		)
	end
	return vals, nearby
end
function solver:reduce(state, location)
	local possible, nearby = self:get_possible_states(state, location)
	local new_states = self.bits.band(state[location], possible)
	state[location] = new_states
	if new_states == state then
		return {}
	end
	return nearby
end
function solver:solve(state)
	local queue = self:_full_queue(#state)
	while #queue > 0 do
		local location = queue:pop()
		queue = self._queue_join(
			queue,
			self:reduce(state, location)
		)
	end
end
return solver
