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

private_steallar_functions.plot_var = function(name, value, stream)
    local type_value = stellar.required_functions.type(value)
    stream("\t" .. name .. ":")
    if type_value == "number" then
        stream(value .. "\n")
    elseif type_value == "string" then
        private_steallar_functions.stream_formmated_str(value, stream)
        stream("\n")
    elseif value == true then
        stream("true\n")
    elseif value == false then
        stream("false\n")
    elseif value == nil then
        stream("nil\n")
    else
        stream(type_value .. "\n")
    end
end
