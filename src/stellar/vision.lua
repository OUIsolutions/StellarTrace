private_steallar_functions.plot_var = function(name, value, stream)
    local type_value = stellar.required_functions.type(value)
    stream("\t" .. name .. ":")
    if type_value == "number" then
        stream(value .. "\n")
    elseif type_value == "string" then
        stream(value .. "\n")
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
