stellar.create_root_watcher = function(output_file)
    local selfobj = {}
    selfobj.trace = {}
    selfobj.point = 0
    selfobj.min_plotage = 1
    selfobj.max_plotage = -1
    selfobj.unplot_functions = {}


    local file = stellar.required_functions.open(output_file, "w")
    if not file then
        stellar.required_functions.error("impossible to open the file " .. output_file)
    end
    file = stellar.required_functions.open(output_file, "a+")

    local function plot_point()
        if selfobj.point < selfobj.min_plotage then
            return false
        end
        if selfobj.point > selfobj.max_plotage and selfobj.max_plotage ~= -1 then
            return false
        end
        if private_steallar_functions.is_inside(selfobj.unplot_functions, selfobj.func_name) then
            return false
        end
        return true
    end

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
            selfobj.trace[#selfobj.trace + 1] = name
            local old_func_name = selfobj.func_name
            selfobj.func_name = name
            if not plot_point() then
                local result = callback(...)
                selfobj.trace[#selfobj.trace] = nil
                selfobj.func_name = old_func_name
                return result
            end

            stream("point: " .. selfobj.point .. " ")
            stream("trace change:")
            stream(get_trace_path() .. "\n")
            local result = callback(...)
            selfobj.func_name = old_func_name
            selfobj.trace[#selfobj.trace] = nil
            stream("trace change:")
            stream(get_trace_path() .. "\n")
            stream("\n")
            return result
        end
    end

    selfobj.plotage_point = function(name, callback)
        selfobj.point = selfobj.point + 1
        selfobj.plot_name = name
        selfobj.trace[#selfobj.trace + 1] = name
        if not plot_point() then
            selfobj.trace[#selfobj.trace] = nil
            return
        end
        stream("point: " .. selfobj.point .. " ")
        stream("plotage point:")
        stream(get_trace_path() .. "\n")
        selfobj.trace[#selfobj.trace] = nil
        if callback then
            callback()
            stream("\n")
        end
    end

    selfobj.plot_var = function(name, value)
        private_steallar_functions.plot_var(name, value, stream)
    end
    return selfobj
end
