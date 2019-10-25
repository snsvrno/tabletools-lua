-- loads all the parts
local tools = require((...):gsub('%.init$', '') .. '.src.tools')

-- library information
tools._name = "tabletools"
tools._version = "1.1.0"
tools._author = "snsvrno <snsvrno@tuta.io>"


-- will try and load the required dependencies, will error and 
-- let the user know that something is wrong if it can't find them
-- (will be nicer than the standard lua failure one)
local dependencies = {
	{ name = "stringtools", url = "https://github.com/snsvrno/stringtools-lua", version = "1.*" }
}

for _, dep in pairs(dependencies) do
	local name, url = dep.name, dep.url
	-- lets try a couple different permutations of the name, that
	-- we might be expecting.
	local results = { }; for _, nameVariant in pairs {name, name .. "-love", name .. "-lua"} do
		local status, module = pcall(require, nameVariant);
		if status then results[#results + 1] = module end
	end
	-- lets check the results
	if #results == 1 then 
		-- we found something, lets verify that its actually the right library
		if not results[1]._name == name or not results[1]._author == tools._author then
			assert(false, "\nerror loading the library '" .. name .. "'. found something but it doesn't appear to be the right library")
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