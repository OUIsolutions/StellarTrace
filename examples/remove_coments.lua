stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")
watcher.unplot_functions = { "is_str_at_point" }
is_str_at_point = watcher.create_function("is_str_at_point", function(str, i, testcase)
    local possible_start = string.sub(str, i, i + #testcase - 1)
    local is_at_point = possible_start == testcase
    watcher.plotage_point("str_at_point_result", function()
        watcher.plot_var("i", i)
        watcher.plot_var("testcase", testcase)

        watcher.plot_var("possible start", possible_start)
        watcher.plot_var("is_at_point", is_at_point)
    end)
    return is_at_point
end)

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
            if is_str_at_point(code, i, "--") then
                inside_coment = true
                goto continue
            else
                result = result .. string.sub(code, i, i)
            end
        end

        if inside_coment then
            if is_str_at_point(code, i, "\n") then
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
