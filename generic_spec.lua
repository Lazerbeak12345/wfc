-- Supid workaround for a stupid LSP server.
local describe, it = describe, it
-- This full file would be so much better if lua had property testing.... Plz @ me.
local solver = require"generic"
describe("_full_queue", function ()
	local things = {}
	things["returns an empty set on zero"] = 0
	things["one"] = 1
	things["two"] = 2
	things["two hundred"] = 200
	for key, value in pairs(things) do
		it(key, function ()
			local setc = 0
			local addc = 0
			local set = {}
			function set.new()
				setc = setc + 1
				return set
			end
			function set:add()
				addc = addc + 1
				return self
			end
			assert.same(set, solver._full_queue({ set = set }, value), "Don't change the instance manually")
			assert.equal(1, setc, "call set construction once")
			assert.equal(math.max(0, value - 1), addc, "call add many times")
		end)
	end
end)
