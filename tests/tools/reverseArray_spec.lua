-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
package.path = './../?/init.lua;./../?.lua;' .. package.path

local T = require 'tabletools-lua' or nil
local reverseArray = T.reverseArray


describe("reverseArray()",function()
    local a1 = { 1,2,3,4,5 }
    local a1r = reverseArray(a1)

    it("actually reverses it", function()
        assert.are.equal(a1[1],a1r[5])
        assert.are.equal(a1[2],a1r[4])
        assert.are.equal(a1[3],a1r[3])
        assert.are.equal(a1[4],a1r[2])
        assert.are.equal(a1[5],a1r[1])
    end)

    it("trying to reverse a table", function()
        local t = { x = 1, y = 2 }

        assert.has.errors(function() reverseArray(t) end)
    end)
end)