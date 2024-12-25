stellar.create_root_watcher = function(output_file)
    local selfobj = {}
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
    return selfobj
end
