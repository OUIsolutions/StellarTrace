stellar.required_functions.error = error
stellar.required_functions.type = type
if string then
    stellar.required_functions.format = string.format
end

if table then
    stellar.required_functions.concat = table.concat
end
stellar.required_functions.get_keys_and_index = function(target)
    local data = {}
    for key, val in pairs(target) do
        data[#data + 1] = key
    end
    return data
end
if string then
    stellar.required_functions.sub = string.sub
end
if io then
    stellar.required_functions.open = io.open
end
