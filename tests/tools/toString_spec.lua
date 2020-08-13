-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
package.path = './../?/init.lua;./../?.lua;' .. package.path

local T = require 'tabletools-lua' or nil
local toString = T.toString

describe("toString()",function()

	it("simple array",function()
		local testTable = { 1,2,3,4 }
		assert.are.equal(toString(testTable),"{ 1, 2, 3, 4 }")
	end)

	it("simple array, with nested array",function()
		local testTable = { 1,2,3,4,{5,6,7} }
		assert.are.equal(toString(testTable),"{ 1, 2, 3, 4, { 5, 6, 7 } }")
	end)

	it("simple array, with nested table",function()
		local testTable = { 1,2,3,4,{x=4, y="asd"} }
		-- i don't know if this will always be right since the order is random when
		-- using pairs???
		assert.are.equal(toString(testTable),"{ 1, 2, 3, 4, { y = \"asd\", x = 4 } }")
	end)

	it("simple table",function()
		local testTable = { x=4, y="asd" }
		-- i don't know if this will always be right since the order is random when
		-- using pairs???
		assert.are.equal(toString(testTable),"{ y = \"asd\", x = 4 }")
	end)

	it("simple table and an array",function()
		local testTable = { x=4, y="asd",z = {1,2,"3"} }
		-- i don't know if this will always be right since the order is random when
		-- using pairs???
		assert.are.equal(toString(testTable),"{ y = \"asd\", x = 4, z = { 1, 2, \"3\" } }")
	end)
end)