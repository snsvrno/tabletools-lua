-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
package.path = './../?/init.lua;./../?.lua;' .. package.path

local T = require 'tabletools-lua' or nil
local clone = T.clone

describe("cloning a table",function()
    local t1 = { x = { y = "z" } }
    local t2 = clone(t1)

    it("Testing if the clone is the same",function()
        assert.are.equal(t1.x.y,t2.x.y)
    end)

    it ("Testing that tables are different objects", function()
        t2.x.y = "a"
        assert.are.equal(t1.x.y == t2.x.y, false)
    end)

end)