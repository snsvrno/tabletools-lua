-- this test is assuming that this project and it's dependencies
-- are located in the same root folder, like maybe a `libraries`
-- folder or something, that way it can find the correct dependencies
--
-- there is a problem about using different versions though, so we
-- need to make sure the right version is being used ...
for _,v in pairs(arg) do
    if (v ~= '--console') and (v ~= 'embedded boot.lua') and (v:find('.exe') == nil ) then
        package.path = './../?/init.lua;./../?.lua;' .. package.path
    end
end

local T = require 'tabletools-lua' or nil
local convertToDotIndex = T.convertToDotIndex

describe("convertToDotIndex()",function()
    local testTable = { bob = '1', james = '2', linda = { age = 1, name = 'boop'} }
    local dotTable = convertToDotIndex(testTable)

    it("Testing Values",function()
        assert.are.equal(testTable.bob,dotTable['bob'])
        assert.are.equal(testTable.linda.age,dotTable['linda.age'])
        assert.are.equal(testTable.linda.name,dotTable['linda.name'])
    end)
end)