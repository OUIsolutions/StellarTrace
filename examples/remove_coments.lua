stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")

remove_coments = watcher.create_function("remove_coments", function(code)
    watcher.plotage_point("args", function()
        watcher.plot_var("code", code)
    end)
    local inside_coment = false
    local result = ""
    for i = 1, #code do
        watcher.plotage_point("iteration", function()
            watcher.plot_var("i", i)
            watcher.plot_var("inside_coment", inside_coment)
            watcher.plot_var("result", result)
        end)

        if not inside_coment then
            local possible_start = string.sub(code, i, i + #"--" - 1)
            local is_a_start_comment = possible_start == "--"
            watcher.plotage_point("outside omment", function()
                watcher.plot_var("possible_start", possible_start)
                watcher.plot_var("is_a_start_comment", is_a_start_comment)
            end)

            if is_a_start_comment then
                inside_coment = true
                goto continue
            else
                result = result .. string.sub(code, i, i)
            end
        end

        if inside_coment then
            local possible_end = string.sub(code, i, i)
            local is_end_coment = possible_end == '\n'

            watcher.plotage_point("inside comment", function()
                watcher.plot_var("possible_end", possible_end)
                watcher.plot_var("is_end_coment", is_end_coment)
            end)


            if is_end_coment then
                inside_coment = false
                goto continue
            end
        end

        ::continue::
    end
    return result
end)

local formmated = remove_coments([[


--- makes add
function add (x,y)
    --- gets the result
    local result = x + y
    return result
end

]])
io.open('out.lua', "w"):write(formmated)
