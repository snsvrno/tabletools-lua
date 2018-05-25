TABLETOOLS = { }

function TABLETOOLS.insertByDotIndex(t,i,v)
  -----------------------------------------------------
  -- inserts a value into a table using a dot index notation
  --
  -- t : table            table to add value to
  -- i : string           index where to add the value into the table
  -- v : value            value to insert into table
  --
  -- return : nil         does not return anything
  -----------------------------------------------------

  local indexTree = @st.split(i,'.')

  local ci = indexTree[1]   -- current index
  -- the rest of the index
  local ri = ''
  for i=2,#indexTree do
    ri = ri .. indexTree[i]
    if i < #indexTree-1 then ri = ri .. '.' end
  end

  if t[ci] == nil and ri ~= '' then
    t[ci] = { }
    TABLETOOLS.insertByDotIndex(t[ci],ri,v)
  elseif type(t[ci]) == 'table' then
    if ri == '' then 
      t[ci] = v
    else
      TABLETOOLS.insertByDotIndex(t[ci],ri,v)
    end
  else
    t[ci] = v
  end

end

function TABLETOOLS.toString(t)
  -----------------------------------------------------
  -- returns a string version of the table
  --
  -- t : table            table
  --
  -- return : string      stringified table for debug printing
  -----------------------------------------------------

  local printable_string = '{ '
  for i,v in pairs(t) do
    if type(v) == type({}) then printable_string = printable_string .. i .. ' = ' .. TABLETOOLS.toString(v) .. ', '
    else printable_string = printable_string .. i .. ' = ' .. tostring(v) .. ', ' end
  end

  printable_string = printable_string:sub(1,#printable_string-2) .. ' }'
  return printable_string
end


function TABLETOOLS.convertToDotIndex(t,prefix,indexTable)
  -----------------------------------------------------
  -- converts the table to a flat table with dot index notation indices
  --
  -- t : table                table to convert
  -- (prefix : string)        the current prefix for the dot key, passed through recursions
  -- (indexTable : table)     the returner object, passed through recursions
  --
  -- return : table           table where the keys (indices) are in dot formation
  -----------------------------------------------------

  t = t or { }
  prefix = prefix or ''
  indexTable = indexTable or { }

  for i,v in pairs(t) do
    if type(v) == type({}) then 
      if TABLETOOLS.isArray(v) then indexTable[prefix .. i] = v
      else TABLETOOLS.convertToDotIndex(v,prefix .. i .. '.',indexTable) end
    else indexTable[prefix .. i] = v end
  end 

  return indexTable
end

function TABLETOOLS.isArray(t)
  -----------------------------------------------------
  -- checks if a table is formatted like an array
  --
  -- t : table            table to check
  --
  -- return : bool        true or false..
  -----------------------------------------------------
  local len = 0
  for i,v in pairs(t) do len = len + 1 end
  if len == #t then return true else return false end
end

function TABLETOOLS.addValues(t1,...)
  -----------------------------------------------------
  -- adds the values from all other tables supplied into t1, modifies t1
  --
  -- t1 : table           table to add values to
  -- ... : table          tables to take values from and add to t1
  --
  -- return : nil         does not return anything
  -----------------------------------------------------

  for _,t in pairs({...}) do
    local t2Dot = TABLETOOLS.convertToDotIndex(t)
    for i,v in pairs(t2Dot) do 
      TABLETOOLS.insertByDotIndex(t1,i,v)
    end
  end
end

function TABLETOOLS.mergeTables(...)
  -----------------------------------------------------
  -- makes a new table with all the values of
  --
  -- ... : table          tables to combine
  --
  -- return : table       newly made table
  -----------------------------------------------------

  local newTable = { }
  for _,t in pairs({...}) do
    local dot = TABLETOOLS.convertToDotIndex(t)
    for i,v in pairs(dot) do TABLETOOLS.insertByDotIndex(newTable,i,v) end
  end
  return newTable
end

function TABLETOOLS.clone(t1)
  local newTable = { }
  for i,v in pairs(t1) do
    if type(v) == "table" then newTable[i] = TABLETOOLS.clone(v)
    else
      newTable[i] = v
    end 
  end
  return newTable
end

--- PUT INSIDE OF TABLETOOLS
function TABLETOOLS.reverseArray(array)
  local newArray = { }
  for i=#array,1,-1 do
    newArray[#newArray+1] = array[i]
  end
  return newArray
end

return TABLETOOLS