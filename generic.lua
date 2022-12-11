local solver = {}
function solver.new(init)
	local self = {
		get_hitbox = init.get_hitbox,
		bits = {
			band = init.bits.band,
			empty = init.bits.empty
		},
		set = init.set
	}
	setmetatable(self, solver)
	return self
end
function solver:_full_queue(size)
	local index = 1
	local output = self.set.new()
	while index < size do
		output = output:add(index)
	end
	return output
end
function solver:get_possible_states(state, location)
	local nearby = self:get_hitbox(location)
	local vals = state[location] -- old value
	for _, l2 in ipairs(nearby) do
		vals = self.bits["and"](vals, state[l2])
	end
	return vals, nearby
end
function solver:reduce(state, location)
	local possible, nearby = self:get_possible_states(
		state,
		location
		)
	local new_states = self.bits["and"](
		state[location],
		possible
		)
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
