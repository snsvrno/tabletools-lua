-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
package.path = './../?/init.lua;./../?.lua;' .. package.path

local T = require 'tabletools-lua' or nil
local merge = T.merge

describe("merge()",function()
    local t1 = { a = 1, b = 2, c = { d = 4, e = 6 }}
    local t2 = { c = { f = 9 }, g = 23 }
    local tm = merge(t1,t2)

    it("Testing Values",function()
        assert.are.equal(tm.g,t2.g)
        assert.are.equal(tm.a,t1.a)
        assert.are.equal(tm.c.d,t1.c.d)
        assert.are.equal(tm.c.f,t2.c.f)
    end)
end)