# Table Tools
A lua library designed to make working with tables easier.

## Usage
Either get the source and build it with lmake, install it using lmake, or manually download the [Latest Release](https://github.com/snsvrno/tabletools-lua/releases/latest). Look at [Lmake](https://github.com/snsvrno/lmake-rs) for more information how to build.

Once in your project, just 'require' like you would any other source file.

```lua
TT = require 'path.to.tabletools'
``` 

Table tools requires it be assigned to a variable so you can access it globally. Lua doesn't have a metatable for all tables, so there isn't an easy way to have it accessible to all tables as a member.

## Functions

### `.addValues(t1,...)`
Adds values from supplied tables into first table.

***Inputs***
- **`t1`** : *Table* - the table to convert
- **`...`** : *Table* - additional tables to merge into t1, overwrites any values found in t1

***Outputs***
- **`return`** : *nil* - no return, modifies the table in place

### `.clone(t1)`
Creates a complete copy of the table that is not lined to the original in anyway.

***Inputs***
- **`t1`** : *Table* - the table to clone

***Outputs***
- **`return`** : *Table* - a unique copy of the input table.

### `.convertToDotIndex(t,prefix,indexTable)`
Converts a complex nested table into a flat table with the dot index notation as the indices.

The resulting table will only be 1 level.

```lua
table = { a = 1, b = { c = 2, d = 3 } }
tableFlat = TT.convertToDotIndex(table)
tableFlat === { 'a' = 1, 'b.d' = 3, 'b.c' = 2 }
```

***Inputs***
- **`t`** : *Table* - the table to convert
- **`(prefix)`** : *String* - *(optional)* current prefix for the dot key, passed through recursions
- **`(indexTable)`** : *Table<String>* - *(optional)* the returner object, passed through recursions

***Outputs***
- **`return`** : *Table<String>* - new table of dot indexs and their values

### `.insertByDotIndex(t,i,v)`
Inserts a value into a table using a dot index notation.

Dot notation is the same way you would access a value in a table programmatically, but in a string. The benifit to the dot notation is you don't need to check if any of the parents exist yet as the function will initalize these tables if nil, and reuse existing tables if they already are defined.

```lua
-- both of these are the same.
table.a.b.c = "d"
table.insertByDotIndex("a.b.c","d")
```

***Inputs***
- **`t`** : *Table* - the table to add a value, v, to
- **`i`** : *String* - the dot index where to add the value, v
- **`v`** : *T* - the value of any type to insert into the table at i

***Outputs***
- **`return`** : *nil* - no return, modifies the table in place

### `.isArray(t)`
Checks if the table is formatted like an array not a dictionary. 

It does by counting all the indecies and comparing it to the table's `#` length function. It is assuming that `#` only keeps an accurate account if it array etiquette is used, i.e. use number indexes, uninterupted sequence, always add to the next number in the sequence.

***Inputs***
- **`t`** : *Table* - the table to add a value, v, to

***Outputs***
- **`return`** : *Bool* - result

### `.mergeTables(...)`
Merges the supplied together into a new table.

***Inputs***
- **`...`** : *Table* - tables to merge

***Outputs***
- **`return`** : *Table* - resulting table created from the merge of all supplied tables, returns an empty table if no tables are supplied.

### `.toString(t)`
Returns a string representation of the table, used primarily for debugging.

Output returns an unformated single line representation of a table.

```
table = { a = "1", b = { c = "2", d = "3" } }

print(TT.toString(table)) -- will print "{ a = 1, b = { c = 2, d = 3 } }"
```

***Inputs***
- **`t`** : *Table<T>* - any table with any type

***Outputs***
- **`return`** : *String* - returns a string representation of the table