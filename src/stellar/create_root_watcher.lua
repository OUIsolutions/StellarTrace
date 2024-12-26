stellar.create_root_watcher = function(output_file)
    local selfobj = {}
    selfobj.trace = {}
    selfobj.point = 1
    selfobj.min_plotage = 1
    selfobj.max_plotage = -1


    local file = stellar.required_functions.open(output_file, "w")
    if not file then
        stellar.required_functions.error("impossible to open the file " .. output_file)
    end
    file = stellar.required_functions.open(output_file, "a+")



    local function stream(data)
        if not file then
            file = stellar.required_functions.open(output_file, "a+")
        end
        if not file then
            stellar.required_functions.error("impossible to open the file " .. output_file)
            return
        end
        file:write(data)
    end


    local function get_trace_path()
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
            selfobj.point = selfobj.point + 1
            stream("point: " .. selfobj.point .. " ")
            selfobj.trace[#selfobj.trace + 1] = name
            stream("trace change:")
            stream(get_trace_path() .. "\n")
            local result = callback(...)
            selfobj.trace[#selfobj.trace] = nil
            stream("trace change:")
            stream(get_trace_path() .. "\n")
            stream("\n")
            return result
        end
    end

    selfobj.plotage_point = function(name, callback)
        selfobj.point = selfobj.point + 1
        stream("point: " .. selfobj.point .. " ")
        selfobj.trace[#selfobj.trace + 1] = name
        stream("plotage point:")
        stream(get_trace_path() .. "\n")
        selfobj.trace[#selfobj.trace] = nil
        callback()
        stream("\n")
    end

    selfobj.plot_var = function(name, value)
        private_steallar_functions.plot_var(name, value, stream)
    end
    return selfobj
end
