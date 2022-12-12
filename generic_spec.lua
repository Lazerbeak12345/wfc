-- This would be so much better if lua had property testing.... Plz @ me.
local describe, it = describe, it -- Supid workaround for a stupid LSP server.
local solver = require"generic"
describe("_full_queue", function ()
	it("returns an empty list on zero", function ()
		assert.equals(#solver:_full_queue({}, 0), 0)
	end)
end)
