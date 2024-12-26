private_steallar_functions.stream_formmated_str = function(data, stream)
    stream("(")
    if not stellar.required_functions.sub then
        stream(data)
        stream(")")
        return
    end

    for i = 1, #data do
        local current_char = stellar.required_functions.sub(data, i, i)
        if current_char == "\n" then
            stream("\\n")
        elseif current_char == "\t" then
            stream("\\t")
        else
            stream(current_char)
        end
    end
    stream(')')
end
private_steallar_functions.plot_var_table = function(value, stream)
    local keys = stellar.required_functions.get_keys_and_index(value)
    for i = 1, #keys do
        local current_key = keys[i]
        local current_val = value[current_key]
        local type_value = stellar.required_functions.type(current_val)
        stream("[" .. current_key .. "]")
        if type_value == "number" then
            stream(":" .. current_val .. "\n")
        elseif type_value == "string" then
            stream(":")
            private_steallar_functions.stream_formmated_str(current_val, stream)
            stream("\n")
        elseif current_val == true then
            stream(":true\n")
        elseif current_val == false then
            stream(":false\n")
        elseif current_val == nil then
            stream(":nil\n")
        elseif type_value == "table" then
            private_steallar_functions.plot_var_table(current_val, stream)
        else
            stream(":" .. type_value .. "\n")
        end
    end
end
private_steallar_functions.plot_var = function(name, value, stream)
    local type_value = stellar.required_functions.type(value)

    stream("\t" .. name)
    if type_value == "number" then
        stream(":" .. value .. "\n")
    elseif type_value == "string" then
        stream(":")
        private_steallar_functions.stream_formmated_str(value, stream)
        stream("\n")
    elseif value == true then
        stream(":true\n")
    elseif value == false then
        stream(":false\n")
    elseif value == nil then
        stream(":nil\n")
    elseif type_value == "table" then
        private_steallar_functions.plot_var_table(value, stream)
    else
        stream(":" .. type_value .. "\n")
    end
end
