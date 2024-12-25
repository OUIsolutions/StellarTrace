stellar.create_root_watcher = function(output_file)
    local selfobj = {}
    selfobj.trace = {}
    local file = stellar.required_functions.open(output_file, "w")

    if not file then
        stellar.required_functions.error("impossible to open the file " .. output_file)
    end
    file = stellar.required_functions.open(output_file, "a+")

    selfobj.stream = function(data)
        if not file then
            file = stellar.required_functions.open(output_file, "a+")
        end
        if not file then
            stellar.required_functions.error("impossible to open the file " .. output_file)
            return
        end
        file:write(data)
    end
    selfobj.get_trace_path = function()
        if #selfobj.trace == 0 then
            return "global"
        end
        local trace = ""
        for i = 1, #selfobj.trace do
            trace = trace .. "[" .. selfobj.trace[i] .. "]"
        end
        return trace
    end
    selfobj.create_function = function(name, callback)
        return function(args)
            selfobj.trace[#selfobj.trace + 1] = name
            selfobj.stream("trace change:")
            selfobj.stream(selfobj.get_trace_path() .. "\n")
            local result = callback(args)
            selfobj.trace[#selfobj.trace] = nil
            selfobj.stream("trace change:")
            selfobj.stream(selfobj.get_trace_path() .. "\n")
            return result
        end
    end
    return selfobj
end
