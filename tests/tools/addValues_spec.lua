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
local addValues = T.addValues

describe("adding values to tables",function()
    local t1 = { x = 1, y = 2, z = { 5,6,7,8 } }
    local t2 = { w = 102, z = { 9,10,11,12 } }
    addValues(t1,t2)
    it("Testing Values",function()
        assert.are.equal(t1.w,102)
        assert.are.equal(t1.z[1],9)
        assert.are.equal(t1.z[2],10)
        assert.are.equal(t1.z[3],11)
        assert.are.equal(t1.z[4],12)
    end)
end)