-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
package.path = './../?/init.lua;./../?.lua;' .. package.path

local T = require 'tabletools-lua' or nil
local insertByDotIndex = T.insertByDotIndex

describe("insertByDotIndex()",function()
    local testTable = { }
    it("complex value, 1",function()
        insertByDotIndex(testTable,'test.this',true)
        assert.are.equal(testTable.test.this,true)
    end)

    it("simple value",function()
        insertByDotIndex(testTable,'otherspot',34)
        assert.are.equal(testTable.otherspot,34)
    end)

    it("complex value, 2",function()
        insertByDotIndex(testTable,'test.that','green')
        assert.are.equal(testTable.test.that,'green')
        assert.are.equal(testTable.test.this,true)
    end)
end)
