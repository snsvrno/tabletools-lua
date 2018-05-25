T = require 'bin.tabletools' or nil

describe("Tabletools",function()
  it("Loads the correct library",function()
    assert.are_not.equal(T,nil)
  end)

  describe("checks dotindex",function()
    local testTable = { }
    it("Test Adding Complex Value",function()
      T.insertByDotIndex(testTable,'test.this',true)
      assert.are.equal(testTable.test.this,true)
    end)

    it("Test Adding Simple Value",function()
      T.insertByDotIndex(testTable,'otherspot',34)
      assert.are.equal(testTable.otherspot,34)
    end)

    it("Test Adding Complex Value 2",function()
      T.insertByDotIndex(testTable,'test.that','green')
      assert.are.equal(testTable.test.that,'green')
      assert.are.equal(testTable.test.this,true)
    end)
  end)

  describe("table dot conversion",function()
    local testTable = { bob = '1', james = '2', linda = { age = 1, name = 'boop'} }
    local dotTable = T.convertToDotIndex(testTable)
    it("Testing Values",function()
      assert.are.equal(testTable.bob,dotTable['bob'])
      assert.are.equal(testTable.linda.age,dotTable['linda.age'])
      assert.are.equal(testTable.linda.name,dotTable['linda.name'])
    end)
  end)

  describe("table merging",function()
    local t1 = { a = 1, b = 2, c = { d = 4, e = 6 }}
    local t2 = { c = { f = 9 }, g = 23 }
    local tm = T.mergeTables(t1,t2)
    it("Testing Values",function()
      assert.are.equal(tm.g,t2.g)
      assert.are.equal(tm.a,t1.a)
      assert.are.equal(tm.c.d,t1.c.d)
      assert.are.equal(tm.c.f,t2.c.f)
    end)
  end)

  describe("adding values to tables",function() 
    local t1 = { x = 1, y = 2, z = { 5,6,7,8 } }
    local t2 = { w = 102, z = { 9,10,11,12 } }
    T.addValues(t1,t2)
    it("Testing Values",function()
      assert.are.equal(t1.w,102)
      assert.are.equal(t1.z[1],9)
      assert.are.equal(t1.z[2],10)
      assert.are.equal(t1.z[3],11)
      assert.are.equal(t1.z[4],12)
    end)
  end)

  describe("cloning a table",function() 
    local t1 = { x = { y = "z" } }
    local t2 = T.clone(t1)

    it("Testing if the clone is the same",function() 
      assert.are.equal(t1.x.y,t2.x.y)
    end)

    it ("Testing that tables are different objects", function() 
      t2.x.y = "a"
      assert.are.equal(t1.x.y == t2.x.y, false)
    end)

  end)

  describe("reversing an array",function()
    local a1 = { 1,2,3,4,5 }
    local a1r = T.reverseArray(a1)

    it("Testing it actually reverses it", function()
      assert.are.equal(a1[1],a1r[5])
      assert.are.equal(a1[2],a1r[4])
      assert.are.equal(a1[3],a1r[3])
      assert.are.equal(a1[4],a1r[2])
      assert.are.equal(a1[5],a1r[1])
    end)
  end)

end)
