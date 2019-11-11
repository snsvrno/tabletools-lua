-- loads all the parts
local tools = require((...):gsub('%.init$', '') .. '.src.tools')

-- library information
tools._name = "tabletools"
tools._version = "1.2.0"
tools._author = "snsvrno <snsvrno@tuta.io>"


-- will try and load the required dependencies, will error and
-- let the user know that something is wrong if it can't find them
-- (will be nicer than the standard lua failure one)
local dependencies = {
	{ name = "stringtools", url = "https://github.com/snsvrno/stringtools-lua", version = "1.*" }
}

-- needs to findout what the pre-path stuff you used when calling this library, so
-- it knows what to put in front of the dependencies, so if you call `a.b.c.library` it
-- needs to extract the `a.b.c.` part so it can put it infront of the dependencies to
-- get all dependencies

local prepath; do
    -- the string the user used to `require` this library
    local selfRequirePath = (...):gsub('%.init$', '')
    -- a function to split a string by a "."
    local splitter = function (inputstr)
        -- https://stackoverflow.com/questions/1426954/split-string-in-lua
        local t = {}; for str in string.gmatch(inputstr, "([^".. "." .."]+)") do table.insert(t, str) end
        return t
    end

    -- finds out what section of the path the library name is
    local parts = splitter(selfRequirePath)
    local piece = 0; for j = 1,#parts do
        if string.find(parts[j],tools._name) then
            piece = j - 1; break
    end end

    -- creates the prestring
    assert(piece >= 0,"error processing the library require path")
    local pre = ""; for i = 1,piece do
        pre = pre .. parts[i] .. "."
    end
    prepath = pre
end

for _, dep in pairs(dependencies) do
	local name, url = dep.name, dep.url
	-- lets try a couple different permutations of the name, that
	-- we might be expecting.
	local results = { }; for _, nameVariant in pairs {name, name .. "-love", name .. "-lua"} do
		local status, module = pcall(require, prepath .. nameVariant);
		if status then results[#results + 1] = module end
	end
	-- lets check the results
	if #results == 1 then
		-- we found something, lets verify that its actually the right library
		if not results[1]._name == name or not results[1]._author == tools._author then
			assert(false,
                "\nerror loading the library '" .. name ..
                "'. found something but it doesn't appear to be the right library")
		end
		-- we are ok, lets load it.
		tools["_" .. name] = results[1]
	else
		assert(false,"\ncan't find the library '" .. name ..
			"', are you sure its downloaded?\nput it in the same folder / path as you did this one (" ..
			tools._name .. ")\n\nif you need to download it, get it from the github\npage: '" .. url .. "'")
	end
end


return tools