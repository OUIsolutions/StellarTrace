darwin.add_lua_code("local stellar = {}")
darwin.add_lua_code("local private_steallar_functions = {}")

darwin.add_lua_code("stellar.required_functions = {}")

local concat_path = true
local src_files = dtw.list_files_recursively("src", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_file(current)
end
darwin.add_lua_file("types.lua")

darwin.add_lua_code("return stellar")

darwin.generate_lua_output({
    output_name = "stellar.lua"
})
