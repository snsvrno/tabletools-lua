-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
package.path = './../?/init.lua;./../?.lua;' .. package.path

local T = require 'tabletools-lua' or nil
local isArray = T.isArray

describe("isArray()",function()

	it("arrays",function()
		assert.is_true(isArray({1,2,3,4}))
		assert.is_true(isArray({[1]=1,[2]=2,[3]=3,[4]=4}))
		assert.is_true(isArray({1,2,3,"asd",{x=2,y="sd"}}))
		assert.is_true(isArray({}))
	end)

	it("not arrays",function()
		assert.is_false(isArray({1,2,3,x=6}))
		assert.is_false(isArray({[1]=1,[2]=2,[3]=3,[4]=4,[6]=6}))
		assert.is_false(isArray({x = 3}))
	end)
end)
