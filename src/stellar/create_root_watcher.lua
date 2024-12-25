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
            return "[global]"
        end
        local trace = ""
        for i = 1, #selfobj.trace do
            trace = trace .. "[" .. selfobj.trace[i] .. "]"
        end
        return trace
    end
    selfobj.create_function = function(name, callback)
        return function(...)
            selfobj.trace[#selfobj.trace + 1] = name
            selfobj.stream("trace change:")
            selfobj.stream(selfobj.get_trace_path() .. "\n")
            local result = callback(...)
            selfobj.trace[#selfobj.trace] = nil
            selfobj.stream("trace change:")
            selfobj.stream(selfobj.get_trace_path() .. "\n")
            return result
        end
    end

    selfobj.plotage_point = function(name, callback)
        local current_trace = selfobj.get_trace_path()
        local point_trace = current_trace .. "[" .. name .. "]"
        selfobj.stream("plotage point:" .. point_trace .. "\n")
        callback()
    end

    selfobj.plot_var = function(name, value)
        private_steallar_functions.plot_var(name, value, selfobj.stream)
    end
    return selfobj
end
